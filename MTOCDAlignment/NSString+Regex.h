//
//  NSString+Regex.h
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//


@interface NSString (Regex)
- (NSString *)stringByReplacingPattern:(NSString *)pattern withTemplate:(NSString *)aTemplate;
- (BOOL)matchesPattern:(NSString *)pattern;
- (NSRange)rangeOfPattern:(NSString *)pattern;
- (NSArray *)rangesOfPattern:(NSString *)pattern;
@end
