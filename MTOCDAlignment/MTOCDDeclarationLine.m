//
//  MTOCDIvarLine.m
//  MTOCDAlignment
//
//  Created by Adam Kirk on 8/30/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDDeclarationLine.h"
#import "MTOCDLine+Protected.h"
#import "MTOCDDeclarationParagraph.h"
#import "NSString+Regex.h"


@interface MTOCDDeclarationLine ()
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *name;
@end


@implementation MTOCDDeclarationLine

+ (BOOL)lineConforms:(NSString *)line
{
    BOOL containsOnlyValidDeclarationCharacters = [line rangeOfPattern:@"^[\\sA-Za-z0-9_$*;]+?$"].location != NSNotFound;
    BOOL notAnEmptyLine = [line stringByReplacingPattern:@"\\s" withTemplate:@""].length > 0;
    return containsOnlyValidDeclarationCharacters && notAnEmptyLine;
}

+ (Class)paragraphClass
{
    return [MTOCDDeclarationParagraph class];
}

- (void)format
{
    _type           = [_type stringByPaddingToLength:_alignmentColumn withString:@" " startingAtIndex:0];
    self.contents   = [NSString stringWithFormat:@"%@%@", _type, _name];
    [super format];
}

- (NSString *)description
{
    return self.contents;
}

- (NSUInteger)currentColumn
{
    return [_type length];
}



#pragma mark - Protected

- (void)parse
{
    [super parse];

    NSRange range = [self rangeOfName];
    if (range.location != NSNotFound) {

        // type
        _type = [self.contents substringToIndex:range.location];
        _type = [_type stringByReplacingPattern:@"(\\S)\\s*?$" withTemplate:@"$1"];
        _type = [_type stringByAppendingString:@" "];

        _name = [self.contents substringWithRange:range];
        _name = [_name stringByReplacingPattern:@"^\\s*?(\\S)" withTemplate:@"$1"];
    }
}



#pragma mark - Private

- (NSRange)rangeOfName
{
    return [self.contents rangeOfPattern:@"\\s(\\*|)[A-Za-z0-9_$]*?;"];
}

@end
