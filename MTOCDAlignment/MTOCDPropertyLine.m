//
//  MTOCDPropertyLine.m
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDPropertyLine.h"
#import "MTOCDLine+Protected.h"
#import "MTOCDPropertyParagraph.h"
#import "NSString+Regex.h"


static inline BOOL isInMask(NSUInteger bitmask, NSUInteger value) { return (bitmask & value) == value; }
static NSString *blockDeclarationPlaceholder = @"<<block>>";


@interface MTOCDPropertyLine ()
@property (nonatomic, assign) BOOL     isPointer;
@property (nonatomic, strong) NSString *readingType;
@property (nonatomic, strong) NSString *storageType;
@property (nonatomic, strong) NSString *propertyType;
@property (nonatomic, strong) NSString *propertyName;
@property (nonatomic, strong) NSString *getterOverride;
@property (nonatomic, strong) NSString *setterOverride;
@property (nonatomic, strong) NSString *blockDeclaration;
@end


@implementation MTOCDPropertyLine

- (id)init
{
    self = [super init];
    if (self) {
        _columnMask        			= 0;
        _alignedColumnMask 			= 0;
        _isPointer         			= 0;
    }
    return self;
}



#pragma mark - Overrides

+ (BOOL)lineConforms:(NSString *)line
{
    return [line matchesPattern:@"^(\\s*?)\\@property"];
}

+ (Class)paragraphClass
{
    return [MTOCDPropertyParagraph class];
}

- (void)format
{
    NSMutableArray *string = [NSMutableArray new];

    [string addObject:@"@property"];

    NSMutableArray *qualifiers = [NSMutableArray new];
    if (isInMask(_alignedColumnMask, MTOCDPropertyLineColumnMaskNonatomic)) {
        [qualifiers addObject:[self nonatomicString]];
    }

    if (isInMask(_alignedColumnMask, MTOCDPropertyLineColumnMaskStorageType)) {
        NSString *s = [[self storageTypeString] stringByPaddingToLength:_alignedStorageTypeLength
                                                             withString:@" "
                                                        startingAtIndex:0];
        [qualifiers addObject:s];
    }

    if (isInMask(_alignedColumnMask, MTOCDPropertyLineColumnMaskReading)) {
        NSString *s = [[self readingTypeString] stringByPaddingToLength:_alignedReadingTypeLength
                                                             withString:@" "
                                                        startingAtIndex:0];
        [qualifiers addObject:s];
    }

    if (isInMask(_alignedColumnMask, MTOCDPropertyLineColumnMaskGetter)) {
        NSString *s = [[self overrideString] stringByPaddingToLength:_alignedOverrideLength
                                                          withString:@" "
                                                     startingAtIndex:0];
        [qualifiers addObject:s];
    }

    NSString *qualifiersString = [qualifiers componentsJoinedByString:@"  "];
    qualifiersString = [NSString stringWithFormat:@"(%@)", qualifiersString];
    qualifiersString = [qualifiersString stringByReplacingPattern:@"([a-z])\\s(\\s*?)([a-z])" withTemplate:@"$1,$2$3"];
    [string addObject:qualifiersString];


    if (isInMask(_alignedColumnMask, MTOCDPropertyLineColumnMaskOutlet)) {
        [string addObject:[self outletString]];
    }


    [string addObject:[self propertyTypeString]];
    [string addObject:[self propertyNameString]];


    self.contents = [NSString stringWithFormat:@"%@;", [string componentsJoinedByString:@" "]];

    if (self.blockDeclaration) {
        self.contents = [self.contents stringByReplacingOccurrencesOfString:blockDeclarationPlaceholder
                                                                 withString:self.blockDeclaration];
    }

    [super format];
}

- (NSString *)description
{
    return self.contents;
}




#pragma mark - Public

- (NSInteger)storageTypeLength
{
    return [_storageType length];
}

- (NSInteger)propertyTypeLength
{
    return [_propertyType length];
}

- (NSInteger)readingTypeLength
{
    return [_readingType length];
}

- (NSInteger)overrideLength
{
    return [[self compiledOverrideString] length];
}




#pragma mark - Protected

- (void)preProcess
{
    // get rid of spaces around "=" in getter/setter overrides
    self.contents = [self.contents stringByReplacingPattern:@"(\\s*?)=(\\s*)" withTemplate:@"="];
}

- (void)parse
{
    [super parse];

    // pull out a block declaration
    NSRange blockRange = [self.contents rangeOfPattern:@"\\(\\^.*?;"];
    if (blockRange.location != NSNotFound) {
        NSCharacterSet *trimCharSet = [NSCharacterSet characterSetWithCharactersInString:@" ;"];
        self.blockDeclaration = [[self.contents substringWithRange:blockRange] stringByTrimmingCharactersInSet:trimCharSet];
        self.contents = [self.contents stringByReplacingCharactersInRange:blockRange withString:blockDeclarationPlaceholder];
    }

    // get the property keywords
    NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:@",@() "];;
    self.words = [self.contents componentsSeparatedByCharactersInSet:charSet];

    NSMutableArray *words = [NSMutableArray array];
    for (NSString *word in self.words) {
        NSCharacterSet *stripCharSet    = [NSCharacterSet characterSetWithCharactersInString:@"* ;"];
        NSString *cleanWord             = [word stringByTrimmingCharactersInSet:stripCharSet];
        [words addObject:cleanWord];
    }

    NSArray *storageTypes = @[@"strong", @"assign", @"weak", @"retain", @"unsafe_unretained", @"copy"];

    // look for keywords
    for (NSString *word in [words copy]) {

        // get rid of whitespace
        if ([word isEqualToString:@""]) {
            [words removeObject:word];
            continue;
        }

        // get rid of property
        if ([word isEqualToString:@"property"]) {
            [words removeObject:word];
            continue;
        }

        // storage type
        if (!self.storageType) {
            for (NSString *st in storageTypes) {
                if ([word isEqualToString:st]) {
                    self.storageType = word;
                    _columnMask |= MTOCDPropertyLineColumnMaskStorageType;
                    break;
                }
            }
            if (self.storageType) {
                [words removeObject:word];
                continue;
            }
        }

        // nonatomic
        if ([word isEqualToString:@"nonatomic"]) {
            _columnMask |= MTOCDPropertyLineColumnMaskNonatomic;
            [words removeObject:word];
            continue;
        }

        // readonly
        if ([word isEqualToString:@"readonly"]) {
            _readingType = word;
            _columnMask |= MTOCDPropertyLineColumnMaskReading;
            [words removeObject:word];
            continue;
        }

        // readwrite
        if ([word isEqualToString:@"readwrite"]) {
            _readingType = word;
            _columnMask |= MTOCDPropertyLineColumnMaskReading;
            [words removeObject:word];
            continue;
        }

        // outlet
        if ([word isEqualToString:@"IBOutlet"]) {
            _columnMask |= MTOCDPropertyLineColumnMaskOutlet;
            [words removeObject:word];
        }

        // getter/setter overrides
        NSArray *sides = [word componentsSeparatedByString:@"="];
        if ([sides count] == 2) {
            if ([sides[0] isEqualToString:@"getter"]) {
                _getterOverride = sides[1];
            }
            else if ([sides[0] isEqualToString:@"setter"]) {
                _setterOverride = sides[1];
            }
            _columnMask |= MTOCDPropertyLineColumnMaskGetter;
            [words removeObject:word];
        }

    }

    // pointer
    if ([self.contents rangeOfString:@"*"].location != NSNotFound) {
        _isPointer = YES;
    }

    if ([words count] > 1) {
        _propertyName      	= [words lastObject];
        [words removeObject:_propertyName];
        _propertyType      	= [words componentsJoinedByString:@" "];
    }
}



#pragma mark - Private

- (NSString *)nonatomicString
{
    NSString *s = @"nonatomic";
    return isInMask(_columnMask, MTOCDPropertyLineColumnMaskNonatomic) ? s : [self emptyStringOfLength:[s length]];
}

- (NSString *)readingTypeString
{
    return isInMask(_columnMask, MTOCDPropertyLineColumnMaskReading) ? _readingType : [self emptyStringOfLength:[_readingType length]];
}

- (NSString *)storageTypeString
{
    return isInMask(_columnMask, MTOCDPropertyLineColumnMaskStorageType) ? _storageType : [self emptyStringOfLength:_alignedStorageTypeLength];
}

- (NSString *)overrideString
{
    NSString *string = [self compiledOverrideString];
    return isInMask(_columnMask, MTOCDPropertyLineColumnMaskGetter) ? string : [self emptyStringOfLength:[string length]];
}

- (NSString *)outletString
{
    NSString *s = @"IBOutlet";
    return isInMask(_columnMask, MTOCDPropertyLineColumnMaskOutlet) ? s : [self emptyStringOfLength:[s length]];
}

- (NSString *)propertyTypeString
{
    return [_propertyType stringByPaddingToLength:_alignedPropertyTypeLength withString:@" " startingAtIndex:0];
}

- (NSString *)propertyNameString
{
    return [NSString stringWithFormat:@"%@%@", (_isPointer ? @"*" : @""), _propertyName];
}


#pragma mark (strings)

- (NSString *)emptyStringOfLength:(NSInteger)length
{
    return [@"" stringByPaddingToLength:length withString:@" " startingAtIndex:0];
}

- (NSString *)compiledOverrideString
{
    NSString *left      = _getterOverride ? @"getter" : @"setter";
    NSString *right     = _getterOverride ? _getterOverride : _setterOverride;
    return [NSString stringWithFormat:@"%@=%@", left, right];
}


@end
