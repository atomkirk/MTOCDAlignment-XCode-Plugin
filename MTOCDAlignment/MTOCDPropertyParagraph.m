//
//  MTOCDPropertyParagraph.m
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDPropertyParagraph.h"
#import "MTOCDParagraph+Protected.h"
#import "MTOCDPropertyLine.h"


@implementation MTOCDPropertyParagraph

- (void)parseLines
{
    [super parseLines];

    MTOCDPropertyLineColumnMask columnMask  = 0;
    NSInteger maxReadingTypeLength          = 0;
    NSInteger maxStorageTypeLength          = 0;
    NSInteger maxPropertyTypeLength         = 0;
    NSInteger maxOverrideTypeLength         = 0;

    for (MTOCDPropertyLine *line in self.typeLines) {
        columnMask |= line.columnMask;
        if (line.readingTypeLength > maxReadingTypeLength) {
            maxReadingTypeLength = line.readingTypeLength;
        }
        if (line.storageTypeLength > maxStorageTypeLength) {
            maxStorageTypeLength = line.storageTypeLength;
        }
        if (line.propertyTypeLength > maxPropertyTypeLength) {
            maxPropertyTypeLength = line.propertyTypeLength;
        }
        if (line.overrideLength > maxOverrideTypeLength) {
            maxOverrideTypeLength = line.overrideLength;
        }
    }

    for (MTOCDPropertyLine *line in self.typeLines) {
        line.alignedColumnMask        	= columnMask;
        line.alignedStorageTypeLength 	= maxStorageTypeLength;
        line.alignedReadingTypeLength   = maxReadingTypeLength;
        line.alignedPropertyTypeLength  = maxPropertyTypeLength;
        line.alignedOverrideLength      = maxOverrideTypeLength;
    }
}

@end
