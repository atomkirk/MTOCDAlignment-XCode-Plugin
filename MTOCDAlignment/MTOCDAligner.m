//
//  MTOCDAligner.m
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDAligner.h"
#import "MTOCDLine.h"
#import "MTOCDPropertyLine.h"


@interface MTOCDAligner ()
@property (nonatomic, strong) NSMutableArray *lines;
@end


@implementation MTOCDAligner

- (NSString *)alignedString:(NSString *)string
{
    NSArray *lines  = [string componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    _lines          = [NSMutableArray new];

    for (NSString *line in lines) {
        for (Class <MTOCDLining>lineClass in [self lineTypes]) {
            if ([lineClass lineConforms:line]) {
                [_lines addObject:[lineClass lineWithContents:line]];
                continue;
            }
            [_lines addObject:[MTOCDLine lineWithContents:line]];
        }
    }

    return [_lines componentsJoinedByString:@"\n"];
}

- (NSArray *)lineTypes
{
    return @[[MTOCDPropertyLine class]];
}

@end
