//
//  MTOCDLine.h
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDLining.h"


@class MTOCDParagraph;


@interface MTOCDLine : NSObject <MTOCDLining>
@property (nonatomic, assign) MTOCDParagraph *paragraph;
- (NSInteger)length;
@end
