//
//  MTOCDAlignmentParagraph.m
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDAssignmentParagraph.h"
#import "MTOCDAssignmentLine.h"
#import "MTOCDParagraph+Protected.h"
#import "MTOCDLine+Protected.h"


@implementation MTOCDAssignmentParagraph

- (void)processLines
{
    [super processLines];
    
    NSInteger maxColumn = 0;
    for (MTOCDAssignmentLine *line in self.typeLines) {
        if (line.currentColumn > maxColumn) {
            maxColumn = line.currentColumn;
        }
    }

    maxColumn = [MTOCDLine tabAlignedColumnWithColumn:maxColumn];

    for (MTOCDAssignmentLine *line in self.typeLines) {
        line.alignmentColumn = maxColumn;
    }
}

@end
