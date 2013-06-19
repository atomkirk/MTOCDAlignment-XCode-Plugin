//
//  MTOCDAlignmentLineTest.m
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/18/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDAlignmentLineTest.h"
#import "MTOCDAligner.h"


@implementation MTOCDAlignmentLineTest

- (void)testTabBoundaries
{
    NSString *testString = @"\
    NSSting *s = @\"A string\";\n\
    NSSet *s = [NSSet set];";

    MTOCDAligner *aligner = [MTOCDAligner new];
    NSString *result = [aligner alignedString:testString];

    NSString *expectedResult = @"\
    NSSting *s  = @\"A string\";\n\
    NSSet *s    = [NSSet set];";

    STAssertTrue([result isEqualToString:expectedResult], nil);
}

@end
