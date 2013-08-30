//
//  MTOCDIvarParagraph.m
//  MTOCDAlignment
//
//  Created by Adam Kirk on 8/30/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDDeclarationParagraph.h"
#import "MTOCDDeclarationLine.h"
#import "MTOCDParagraph+Protected.h"
#import "MTOCDLine+Protected.h"

@implementation MTOCDDeclarationParagraph

- (void)processLines
{
    [super processLines];

    NSInteger maxColumn = 0;
    for (MTOCDDeclarationLine *line in self.typeLines) {
        if (line.currentColumn > maxColumn) {
            maxColumn = line.currentColumn;
        }
    }

    if ([self.typeLines count] > 1) {
        maxColumn = [MTOCDLine tabAlignedColumnWithColumn:maxColumn];
    }
    else {
        MTOCDDeclarationLine *singleLine = [self.typeLines lastObject];
        maxColumn = singleLine.currentColumn;
    }

    for (MTOCDDeclarationLine *line in self.typeLines) {
        line.alignmentColumn = maxColumn;
    }
}

@end
