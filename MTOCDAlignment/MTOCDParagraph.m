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
    [_lines addObject:line];

//    NSLog(@"=====> line class: %@ %@", NSStringFromClass([line class]), line.originalLine);

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
    return [_lines componentsJoinedByString:@"\n"];
}

@end
