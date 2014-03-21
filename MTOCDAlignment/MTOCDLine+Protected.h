//
//  MTOCDLine+Protected.h
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDLine.h"

@interface MTOCDLine ()
@property (nonatomic, strong) NSString *contents;
@property (nonatomic, strong) NSString *originalLine;
@property (nonatomic, strong) NSArray *words;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, assign) NSInteger alignedCommentColumn;
- (void)parse;
- (void)format;
- (void)preProcess;
- (void)postProcess;
- (NSString *)commentsString;
+ (NSUInteger)tabAlignedColumnWithColumn:(NSUInteger)column;
@end
