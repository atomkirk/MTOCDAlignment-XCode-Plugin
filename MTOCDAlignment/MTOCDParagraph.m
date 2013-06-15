//
//  MTOCDParagraph.m
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDParagraph.h"


@interface MTOCDParagraph ()
@property (nonatomic, retain) NSMutableArray *lines;
@end


@implementation MTOCDParagraph

- (void)addLine:(MTOCDLine *)line
{
    [_lines addObject:line];
}

- (NSString *)description
{
    return [_lines componentsJoinedByString:@"\n"];
}

@end
