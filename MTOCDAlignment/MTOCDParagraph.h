//
//  MTOCDParagraph.h
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDLine.h"


@interface MTOCDParagraph : NSObject
@property (nonatomic, retain, readonly) NSArray *lines;
- (void)addLine:(MTOCDLine *)line;
- (void)processLines;
@end
