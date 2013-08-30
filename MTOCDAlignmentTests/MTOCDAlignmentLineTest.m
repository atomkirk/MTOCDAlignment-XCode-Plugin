//
//  MTOCDAlignmentLineTest.m
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/18/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MTOCDAligner.h"


@interface MTOCDAlignmentLineTest : XCTestCase
@end


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

    XCTAssertTrue([result isEqualToString:expectedResult]);
}

- (void)testLeftExpressionWithBrackets
{
    NSString *testString = @"\
    NSIndexPath *shiftedIndexPath   = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];\n\
    newVisibleItems[shiftedIndexPath] = _visibleItems[indexPath];";

    MTOCDAligner *aligner = [MTOCDAligner new];
    NSString *result = [aligner alignedString:testString];

    NSString *expectedResult = @"\
    NSIndexPath *shiftedIndexPath       = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];\n\
    newVisibleItems[shiftedIndexPath]   = _visibleItems[indexPath];";


    XCTAssertTrue([result isEqualToString:expectedResult]);
}

- (void)testOneLineIfStatement
{
    NSString *testString = @"\
    NSIndexPath *shiftedIndexPath   = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];\n\
    if (true) s = _visibleItems[indexPath];";

    MTOCDAligner *aligner = [MTOCDAligner new];
    NSString *result = [aligner alignedString:testString];

    NSString *expectedResult = @"\
    NSIndexPath *shiftedIndexPath   = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];\n\
    if (true) s                     = _visibleItems[indexPath];";


    XCTAssertTrue([result isEqualToString:expectedResult]);
}

- (void)testSingleLineEqualsShouldBeJustOneSpace
{
    NSString *testString = @"\
    NSIndexPath *shiftedIndexPath   = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];";

    MTOCDAligner *aligner = [MTOCDAligner new];
    NSString *result = [aligner alignedString:testString];

    NSString *expectedResult = @"\
    NSIndexPath *shiftedIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];";

    XCTAssertTrue([result isEqualToString:expectedResult]);
}

- (void)testShortcutMathAssignments
{
    NSString *testString = @"\
    CGFloat one   /= 2;\n\
    CGFloat two   *= 2;\n\
    CGFloat three   |= 1;\n\
    CGFloat four += 2;\n\
    CGFloat five -=    6;\n\
    CGFloat six &= 7;\n\
    CGFloat seven %= 8;\n\
    CGFloat eight = 9;";

    MTOCDAligner *aligner = [MTOCDAligner new];
    NSString *result = [aligner alignedString:testString];

    NSString *expectedResult = @"\
    CGFloat one    /= 2;\n\
    CGFloat two    *= 2;\n\
    CGFloat three  |= 1;\n\
    CGFloat four   += 2;\n\
    CGFloat five   -= 6;\n\
    CGFloat six    &= 7;\n\
    CGFloat seven  %= 8;\n\
    CGFloat eight   = 9;";

    XCTAssertTrue([result isEqualToString:expectedResult]);
}

@end
