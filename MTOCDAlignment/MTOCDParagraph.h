//
//  MTOCDParagraph.h
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDLine.h"


@interface MTOCDParagraph : NSObject
@property (nonatomic, strong, readonly) NSArray *lines;
- (void)addLine:(MTOCDLine *)line;
- (void)preProcessLines;
- (void)parseLines;
- (void)formatLines;
- (void)postProcessLines;
@end
