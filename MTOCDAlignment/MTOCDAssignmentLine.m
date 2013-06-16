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
    return [line rangeOfPattern:@"^[a-zA-Z0-9\\*\\s\\+\\-/|%&!_@\\.]+?="].location != NSNotFound;
}

+ (Class)paragraphClass
{
    return [MTOCDAssignmentParagraph class];
}

- (NSString *)description
{
//    NSLog(@"1paragraph: %@ ------ %@ ------ %@", _beforeEquals, _shorthandSymbol, _afterEquals);
    NSInteger length = _shorthandSymbol ? _alignmentColumn - 1 : _alignmentColumn;
    _beforeEquals    = [_beforeEquals stringByPaddingToLength:length withString:@" " startingAtIndex:0];
//    NSLog(@"2paragraph: %@ ------ %@ ------ %@", _beforeEquals, _shorthandSymbol, _afterEquals);
    return [NSString stringWithFormat:@"%@%@= %@", _beforeEquals, (_shorthandSymbol ?: @""), _afterEquals];
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
//        NSLog(@"orig ========> %@", self.originalLine);
//        NSLog(@"rang ========> %@", NSStringFromRange(range));
        _beforeEquals = [self.originalLine substringToIndex:range.length];
//        NSLog(@"aft1 ========> %@", _beforeEquals);
        _beforeEquals = [_beforeEquals stringByReplacingPattern:@"\\s*?=" withTemplate:@" "];
//        NSLog(@"aft2 ========> %@", _beforeEquals);

        // shortcut symbol
        unichar lastChar = [_beforeEquals characterAtIndex:[_beforeEquals length] - 1];
        if ([[NSCharacterSet symbolCharacterSet] characterIsMember:lastChar]) {
            _shorthandSymbol = [NSString stringWithFormat:@"%c", lastChar];
        }

        // after (might have a chained reaction)
        _afterEquals = [self.originalLine substringFromIndex:range.length];
        _afterEquals = [_afterEquals stringByReplacingPattern:@"^\\s*?(\\S)" withTemplate:@"$1"];
    }
}



#pragma mark - Private

- (NSRange)rangeUpToEquals
{
    return [self.originalLine rangeOfPattern:@"^[^\\\"]+?="];
}

@end
