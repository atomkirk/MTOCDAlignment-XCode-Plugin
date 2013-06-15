//
//  MTOCDLine.m
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDLine.h"
#import "MTOCDLine+Protected.h"


@implementation MTOCDLine

+ (instancetype)lineWithContents:(NSString *)contents
{
    MTOCDLine *line     = [self new];
    line.originalLine   = contents;
    return line;
}

+ (BOOL)lineConforms:(NSString *)line
{
    return YES;
}

- (void)parse
{
    self.words = [self.originalLine componentsSeparatedByString:@" "];
}

- (NSString *)description
{
    return self.originalLine;
}



#pragma mark - Protected

+ (BOOL)line:(NSString *)line matchesRegexPattern:(NSString *)pattern
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionAllowCommentsAndWhitespace
                                                                             error:nil];
    return [regex numberOfMatchesInString:line
                                  options:0
                                    range:NSMakeRange(0, [line length])];
}

@end
