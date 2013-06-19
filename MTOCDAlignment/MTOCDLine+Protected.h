//
//  MTOCDLine+Protected.h
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDLine.h"

@interface MTOCDLine ()
@property (nonatomic, retain) NSString *contents;
@property (nonatomic, retain) NSString *originalLine;
@property (nonatomic, retain) NSArray *words;
@property (nonatomic, retain) NSArray *comments;
@property (nonatomic, assign) NSInteger alignedCommentColumn;
- (void)parse;
- (void)format;
- (void)postFormat;
- (NSString *)commentsString;
+ (NSUInteger)tabAlignedColumnWithColumn:(NSUInteger)column;
@end
