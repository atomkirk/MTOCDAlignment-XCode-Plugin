//
//  MTOCDLine.m
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDLine.h"
#import "MTOCDLine+Protected.h"
#import "MTOCDParagraph.h"
#import "NSString+Regex.h"


@implementation MTOCDLine

+ (instancetype)lineWithContents:(NSString *)contents
{
    MTOCDLine *line   = [self new];
    line.contents     = contents;
    line.originalLine = contents;
    [line convertTabsToSpaces];
    return line;
}

+ (BOOL)lineConforms:(NSString *)line
{
    return YES;
}

+ (Class)paragraphClass
{
    return [MTOCDParagraph class];
}

- (void)parse
{
    [self parseComments];
}

- (NSInteger)length
{
    return [self.contents length];
}

- (void)format
{
}

- (void)postFormat
{
    // append comments
    if ([_comments count] > 0) {
        NSString *padded = [self.contents stringByPaddingToLength:_alignedCommentColumn
                                                       withString:@" "
                                                  startingAtIndex:0];
        self.contents = [NSString stringWithFormat:@"%@    // %@", padded, [self commentsString]];
    }
}

- (NSString *)description
{
    return self.contents;
}



#pragma mark - Protected

+ (NSUInteger)tabAlignedColumnWithColumn:(NSUInteger)column
{
    // TODO: need to get tab size from XCode
    NSUInteger mod = column % 4;
    mod = mod == 0 ? mod : 4 - mod;
    return column + mod;
}

- (NSString *)commentsString
{
    return [_comments componentsJoinedByString:@". "];
}




#pragma mark - Private


- (void)convertTabsToSpaces
{
    while (true) {
        NSRange rangeOfTab = [_contents rangeOfString:@"\t"];
        if (rangeOfTab.location != NSNotFound) {
            // TODO: get tab size from xcode somehow
            NSString *spaces  = [@"" stringByPaddingToLength:4 withString:@" " startingAtIndex:0];
            self.contents = [_contents stringByReplacingCharactersInRange:rangeOfTab withString:spaces];
        }
        else {
            break;
        }
    }
}

- (void)parseComments
{
    // if this line is nothing but a comment, just leave it alone
    if ([self.originalLine matchesPattern:@"^\\s*?\\/\\/"]) return;

    NSMutableArray *comments = [NSMutableArray array];

    // strip off the easy double slash that must be at the end of the line
    NSRange range = [self.originalLine rangeOfPattern:@"\\/\\/"];
    if (range.location != NSNotFound) {
        range.length = [self.originalLine length] - range.location;
        NSString *s = [self.originalLine substringWithRange:range];
        if (s) {
            s = [s stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/ "]];
            [comments addObject:s];
            self.contents = [self.contents stringByReplacingCharactersInRange:range withString:@""];
        }
    }

    // extract /* */ type comments
    NSArray *commentRanges = [self.originalLine rangesOfPattern:@"\\/\\*(.*?)\\*\\/"];
    for (NSTextCheckingResult *result in commentRanges) {
        NSString *s = [self.originalLine substringWithRange:result.range];
        if (s) {
            [comments addObject:s];
            self.contents = [self.contents stringByReplacingCharactersInRange:range withString:@""];
        }
    }

    self.comments = comments;
}



@end
