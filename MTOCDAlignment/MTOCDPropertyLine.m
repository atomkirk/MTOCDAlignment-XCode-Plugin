//
//  MTOCDPropertyLine.m
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDPropertyLine.h"
#import "MTOCDLine+Protected.h"


@interface MTOCDPropertyLine ()
@property (nonatomic, retain) NSString  *storageType;
@property (nonatomic, assign) BOOL      isNonAtomic;
@property (nonatomic, assign) BOOL      isReadOnly;
@property (nonatomic, assign) BOOL      isReadWrite;
@property (nonatomic, assign) BOOL      isOutlet;
@property (nonatomic, retain) NSString  *propertyType;
@property (nonatomic, assign) BOOL      isPointer;
@property (nonatomic, retain) NSString  *propertyName;
@end


@implementation MTOCDPropertyLine

- (id)init
{
    self = [super init];
    if (self) {
        _isNonAtomic    = NO;
        _isReadOnly     = NO;
        _isReadWrite    = NO;
        _isOutlet       = NO;
        _isPointer      = NO;
    }
    return self;
}

+ (BOOL)lineConforms:(NSString *)line
{
    return [self line:line matchesRegexPattern:@"\\@property"];
}

//- (NSString *)description
//{
//    [self parse];
//    return [NSString stringWithFormat:@"@property (%@) %@ %@%@", @"nonatomic", _propertyType, @"*", _propertyName ];
//}



#pragma mark - Protected

- (void)parse
{
    NSMutableArray *words = [NSMutableArray array];
    for (NSString *word in self.words) {
        NSString *cleanWord = [word stringByTrimmingCharactersInSet:[NSCharacterSet alphanumericCharacterSet]];
        [words addObject:cleanWord];
    }

    NSArray *storageTypes = @[@"strong", @"assign", @"weak", @"retain", @"unsafe_unretained"];

    // look for keywords
    for (NSString *word in [words copy]) {

        // storage type
        if (!self.storageType) {
            for (NSString *st in storageTypes) {
                if ([word isEqualToString:@"strong"]) {
                    self.storageType = word;
                    break;
                }
            }
            if (self.storageType) {
                [words removeObject:word];
                continue;
            }
        }

        // nonatomic
        if (!_isNonAtomic) {
            if ([word isEqualToString:@"nonatomic"]) {
                _isNonAtomic = YES;
                [words removeObject:word];
            }
        }

        // readonly
        if (!_isReadOnly) {
            if ([word isEqualToString:@"readonly"]) {
                _isReadOnly = YES;
                [words removeObject:word];
            }
        }

        // readwrite
        if (!_isReadWrite) {
            if ([word isEqualToString:@"readwrite"]) {
                _isReadWrite = YES;
                [words removeObject:word];
            }
        }

        // outlet
        if (!_isOutlet) {
            if ([word isEqualToString:@"IBOutlet"]) {
                _isOutlet = YES;
                [words removeObject:word];
            }
        }
    }

    // pointer
    if (!_isPointer) {
        if ([self.originalLine rangeOfString:@"*"].location != NSNotFound) {
            _isPointer = YES;
        }
    }

    for (NSString *word in [words copy]) {
        if (![word isEqualToString:@""]) {
            if (!_propertyType) {
                _propertyType = word;
                [words removeObject:word];
            }
            else {
                _propertyName = word;
                [words removeObject:word];
            }
        }
    }
}



#pragma mark - Private

- (NSString *)nonatomicString
{
    return _isNonAtomic ? @"nonatomic" : @"";
}

//- (NSString *)nonatomicString
//{
//    return _isReadOnly ? @", readonly" : @"";
//}


@end
