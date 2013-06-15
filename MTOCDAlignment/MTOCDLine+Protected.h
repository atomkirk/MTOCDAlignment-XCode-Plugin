//
//  MTOCDLine+Protected.h
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDLine.h"

@interface MTOCDLine ()
@property (nonatomic, retain) NSString *originalLine;
@property (nonatomic, retain) NSArray *words;
- (void)parse;
+ (BOOL)line:(NSString *)line matchesRegexPattern:(NSString *)pattern;
@end