//
//  NSString+Regex.m
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "NSString+Regex.h"

@implementation NSString (Regex)

- (NSString *)stringByReplacingPattern:(NSString *)pattern withTemplate:(NSString *)aTemplate
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionAllowCommentsAndWhitespace
                                                                             error:nil];
    return [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:aTemplate];
}

- (BOOL)matchesPattern:(NSString *)pattern
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionAllowCommentsAndWhitespace
                                                                             error:nil];
    return [regex numberOfMatchesInString:self
                                  options:0
                                    range:NSMakeRange(0, [self length])];
}

- (NSRange)rangeOfPattern:(NSString *)pattern
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionAllowCommentsAndWhitespace
                                                                             error:nil];
    return [regex rangeOfFirstMatchInString:self
                                    options:0
                                      range:NSMakeRange(0, [self length])];
}


@end
