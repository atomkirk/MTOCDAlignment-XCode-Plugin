//
//  MTOCDPropertyLine.h
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDLine.h"


typedef NS_OPTIONS(NSUInteger, MTOCDPropertyLineColumnMask) {
    MTOCDPropertyLineColumnMaskNonatomic    = 1,
    MTOCDPropertyLineColumnMaskReading      = 1 << 1,
    MTOCDPropertyLineColumnMaskStorageType  = 1 << 2,
    MTOCDPropertyLineColumnMaskOutlet       = 1 << 3,
};


@interface MTOCDPropertyLine : MTOCDLine
@property (nonatomic, assign) MTOCDPropertyLineColumnMask columnMask;
@property (nonatomic, assign) MTOCDPropertyLineColumnMask alignedColumnMask;
@property (nonatomic, assign) NSInteger                   storageTypeLength;
@property (nonatomic, assign) NSInteger                   alignedStorageTypeLength;
@property (nonatomic, assign) NSInteger                   propertyTypeLength;
@property (nonatomic, assign) NSInteger                   alignedPropertyTypeLength;
@property (nonatomic, assign) NSInteger                   readingTypeLength;
@property (nonatomic, assign) NSInteger                   alignedReadingTypeLength;
@end
