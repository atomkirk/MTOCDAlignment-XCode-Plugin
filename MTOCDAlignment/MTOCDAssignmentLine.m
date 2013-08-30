//
//  MTOCDAssignmentLine.m
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDAssignmentLine.h"
#import "MTOCDLine+Protected.h"
#import "MTOCDAssignmentParagraph.h"
#import "NSString+Regex.h"


@interface MTOCDAssignmentLine ()
@property (nonatomic, retain) NSString *beforeEquals;
@property (nonatomic, retain) NSString *shorthandSymbol;
@property (nonatomic, retain) NSString *afterEquals;
@end


@implementation MTOCDAssignmentLine

+ (BOOL)lineConforms:(NSString *)line
{
    return [line rangeOfPattern:@"^.*?="].location != NSNotFound;
}

+ (Class)paragraphClass
{
    return [MTOCDAssignmentParagraph class];
}

- (void)format
{
    NSInteger length = _shorthandSymbol ? _alignmentColumn - 1 : _alignmentColumn;
    _beforeEquals    = [_beforeEquals stringByPaddingToLength:length withString:@" " startingAtIndex:0];
    self.contents = [NSString stringWithFormat:@"%@%@= %@", _beforeEquals, (_shorthandSymbol ?: @""), _afterEquals];
    [super format];
}

- (NSString *)description
{
    return self.contents;
}

- (NSUInteger)currentColumn
{
    return [_beforeEquals length];
}



#pragma mark - Protected

- (void)parse
{
    [super parse];
    
    NSRange range = [self rangeUpToEquals];
    if (range.location != NSNotFound) {

        // before
        _beforeEquals       = [self.contents substringToIndex:range.length - 1];
        unichar lastChar    = [_beforeEquals characterAtIndex:[_beforeEquals length] - 1];

        // shortcut symbol
        NSCharacterSet *shortcutSymbolsSet = [NSCharacterSet characterSetWithCharactersInString:@"-+^&/*%!|"];
        if ([shortcutSymbolsSet characterIsMember:lastChar]) {
            _shorthandSymbol    = [NSString stringWithFormat:@"%c", lastChar];
            _beforeEquals       = [_beforeEquals stringByReplacingOccurrencesOfString:_shorthandSymbol withString:@" "];
        }
        _beforeEquals = [_beforeEquals stringByReplacingPattern:@"\\s*?$" withTemplate:@""];
        _beforeEquals = [_beforeEquals stringByAppendingString:@" "];

        // after (might have a chained reaction)
        _afterEquals = [self.contents substringFromIndex:range.length];
        _afterEquals = [_afterEquals stringByReplacingPattern:@"^\\s*?(\\S)" withTemplate:@"$1"];
    }
}



#pragma mark - Private

- (NSRange)rangeUpToEquals
{
    return [self.contents rangeOfPattern:@"^[^\\\"]+?="];
}

@end
