//
//  MTOCDParagraph.m
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDParagraph.h"
#import "MTOCDParagraph+Protected.h"
#import "MTOCDLine+Protected.h"


@implementation MTOCDParagraph

- (id)init
{
    self = [super init];
    if (self) {
        _lines     = [NSMutableArray new];
        _typeLines = [NSMutableArray new];
    }
    return self;
}

- (void)addLine:(MTOCDLine *)line
{
    line.paragraph = self;
    [(NSMutableArray *)_lines addObject:line];

    // if this is not a generic line
    if (![line isMemberOfClass:[MTOCDLine class]]) {
        [_typeLines addObject:line];
    }
}

- (void)processLines
{
    for (MTOCDLine *line in _lines) {
        [line parse];
    }
}

- (NSString *)description
{
    [self processLines];
    [self formatLines];
    [self postFormatLines];
    return [_lines componentsJoinedByString:@"\n"];
}



#pragma mark - Private

- (void)calculateCommentColumn
{
    NSInteger maxCommentColumn = 0;
    for (MTOCDLine *line in _lines) {
        if ([line length] > maxCommentColumn) {
            maxCommentColumn = [line length];
        }
    }

    maxCommentColumn = [MTOCDLine tabAlignedColumnWithColumn:maxCommentColumn];

    for (MTOCDLine *line in _lines) {
        line.alignedCommentColumn = maxCommentColumn;
    }
}

- (void)formatLines
{
    for (MTOCDLine *line in _lines) {
        [line format];
    }
}

- (void)postFormatLines
{
    [self calculateCommentColumn];

    for (MTOCDLine *line in _lines) {
        [line postFormat];
    }
}

@end
