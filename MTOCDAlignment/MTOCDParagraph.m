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

- (void)preProcessLines
{
    for (MTOCDLine *line in _lines) {
        [line preProcess];
    }
}

- (void)parseLines
{
    for (MTOCDLine *line in _lines) {
        [line parse];
    }
}

- (void)formatLines
{
    for (MTOCDLine *line in _lines) {
        [line format];
    }
}

- (void)postProcessLines
{
    [self calculateCommentColumn];

    for (MTOCDLine *line in _lines) {
        [line postProcess];
    }
}

- (NSString *)description
{
    [self preProcessLines];
    [self parseLines];
    [self formatLines];
    [self postProcessLines];
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


@end
