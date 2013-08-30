//
//  MTOCDIvarLineTests.m
//  MTOCDAlignment
//
//  Created by Adam Kirk on 8/30/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MTOCDAligner.h"


@interface MTOCDIvarLineTests : XCTestCase
@end


@implementation MTOCDIvarLineTests

- (void)testPropertyAlignmentBasic
{
    NSString *testString = @"\
    NSArray *_menuItems;\n\
    NSInteger _allCount;\n\
    NSInteger _starCount;\n\
\n\
    CGFloat _logoStartY;\n\
    CGFloat _logoHeight;\n\
    UIView *_logoView;\n\
    DOBlockThrottle *_blockThrottle;\n\
    BOOL _heightAdjusted;\n\
    BOOL _transitioning;\n\
\n\
	IBOutlet UILabel *_todayCount;\n\
	IBOutlet UITableView *_tableView;\n\
    IBOutlet UIView *_headerView;\n\
    IBOutlet UIImageView *_addIcon;\n\
    IBOutlet UIImageView *_cameraIcon;\n\
    IBOutlet UIImageView *_lineDivider;\n\
    IBOutlet TouchView *_touchView;\n\
\n\
    IBOutlet UIView *_loadingBarView;\n\
    IBOutlet UIImageView *_loadingBarBg;\n\
    IBOutlet UIView *_uploadingView;\n\
    IBOutlet UIView *_downloadingView;\n\
    IBOutlet UIImageView *_uploadingArrowView;\n\
    IBOutlet UIImageView *_downloadingArrowView;\n\
    IBOutlet UILabel *_upTitleLabel;\n\
    IBOutlet UILabel *_downTitleLabel;\n\
    IBOutlet UILabel *_uploadingLabel;\n\
    IBOutlet UILabel *_downloadingLabel;\n\
    @property (strong, nonatomic) NSString *string;";

    MTOCDAligner *aligner = [MTOCDAligner new];
    NSString *result = [aligner alignedString:testString];

    NSString *expectedResult = @"\
    NSArray                 *_menuItems;\n\
    NSInteger               _allCount;\n\
    NSInteger               _starCount;\n\
\n\
    CGFloat                 _logoStartY;\n\
    CGFloat                 _logoHeight;\n\
    UIView                  *_logoView;\n\
    DOBlockThrottle         *_blockThrottle;\n\
    BOOL                    _heightAdjusted;\n\
    BOOL                    _transitioning;\n\
\n\
    IBOutlet UILabel        *_todayCount;\n\
    IBOutlet UITableView    *_tableView;\n\
    IBOutlet UIView         *_headerView;\n\
    IBOutlet UIImageView    *_addIcon;\n\
    IBOutlet UIImageView    *_cameraIcon;\n\
    IBOutlet UIImageView    *_lineDivider;\n\
    IBOutlet TouchView      *_touchView;\n\
\n\
    IBOutlet UIView         *_loadingBarView;\n\
    IBOutlet UIImageView    *_loadingBarBg;\n\
    IBOutlet UIView         *_uploadingView;\n\
    IBOutlet UIView         *_downloadingView;\n\
    IBOutlet UIImageView    *_uploadingArrowView;\n\
    IBOutlet UIImageView    *_downloadingArrowView;\n\
    IBOutlet UILabel        *_upTitleLabel;\n\
    IBOutlet UILabel        *_downTitleLabel;\n\
    IBOutlet UILabel        *_uploadingLabel;\n\
    IBOutlet UILabel        *_downloadingLabel;\n\
@property (nonatomic, strong) NSString *string;";

    XCTAssertTrue([result isEqualToString:expectedResult]);
}

@end
