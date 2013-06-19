//
//  MTOCDAlignmentTests.m
//  MTOCDAlignmentTests
//
//  Created by Adam Kirk on 6/17/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDPropertyLineTests.h"
#import "MTOCDAligner.h"

@implementation MTOCDPropertyLineTests

- (void)testPropertyAlignmentBasic
{
    NSString *testString = @"\
@property (strong, nonatomic) NSString *string;";

    MTOCDAligner *aligner = [MTOCDAligner new];
    NSString *result = [aligner alignedString:testString];

    NSString *expectedResult = @"\
@property (nonatomic, strong) NSString *string;";

    STAssertTrue([result isEqualToString:expectedResult], nil);
}





- (void)testPropertyAlignmentMultiline
{
    NSString *testString = @"\
@property (strong, nonatomic) NSString *string;\n\
@property (assign, nonatomic) NSInteger count;";

    MTOCDAligner *aligner = [MTOCDAligner new];
    NSString *result = [aligner alignedString:testString];

    NSString *expectedResult = @"\
@property (nonatomic, strong) NSString  *string;\n\
@property (nonatomic, assign) NSInteger count;";

    STAssertTrue([result isEqualToString:expectedResult], nil);
}





- (void)testPropertyAlignmentIBOutlet
{
    NSString *testString = @"\
@property (strong, nonatomic) NSString *string;\n\
@property (assign, nonatomic) NSInteger count;\n\
@property (assign, nonatomic) IBOutlet NSInteger count;\n\
@property (assign, nonatomic) NSInteger test;\n\
@property (assign, nonatomic) NSSSet *apples;";

    MTOCDAligner *aligner = [MTOCDAligner new];
    NSString *result = [aligner alignedString:testString];

    NSString *expectedResult = @"\
@property (nonatomic, strong)          NSString  *string;\n\
@property (nonatomic, assign)          NSInteger count;\n\
@property (nonatomic, assign) IBOutlet NSInteger count;\n\
@property (nonatomic, assign)          NSInteger test;\n\
@property (nonatomic, assign)          NSSSet    *apples;";

    STAssertTrue([result isEqualToString:expectedResult], nil);
}





- (void)testPropertyAlignmentReadonly
{
    NSString *testString = @"\
@property (strong, nonatomic) NSString *string;\n\
@property (assign, readonly, nonatomic) NSInteger count;\n\
@property (assign, nonatomic) IBOutlet NSInteger count;\n\
@property (assign, nonatomic) NSInteger test;\n\
@property (assign, nonatomic) NSSSet *apples;";

    MTOCDAligner *aligner = [MTOCDAligner new];
    NSString *result = [aligner alignedString:testString];

    NSString *expectedResult = @"\
@property (nonatomic, strong          )          NSString  *string;\n\
@property (nonatomic, assign, readonly)          NSInteger count;\n\
@property (nonatomic, assign          ) IBOutlet NSInteger count;\n\
@property (nonatomic, assign          )          NSInteger test;\n\
@property (nonatomic, assign          )          NSSSet    *apples;";

    STAssertTrue([result isEqualToString:expectedResult], nil);
}





- (void)testPropertyAlignmentSpacesInBetween
{
    NSString *testString = @"\
@property (strong, nonatomic) NSString *string;\n\
@property (assign, readonly, nonatomic) NSInteger count;\n\
@property (assign, nonatomic) IBOutlet NSInteger count;\n\
\n\
@property (assign, nonatomic) NSInteger test;\n\
@property (assign, nonatomic) NSSSet *apples;";

    MTOCDAligner *aligner = [MTOCDAligner new];
    NSString *result = [aligner alignedString:testString];

    NSString *expectedResult = @"\
@property (nonatomic, strong          )          NSString  *string;\n\
@property (nonatomic, assign, readonly)          NSInteger count;\n\
@property (nonatomic, assign          ) IBOutlet NSInteger count;\n\
\n\
@property (nonatomic, assign          )          NSInteger test;\n\
@property (nonatomic, assign          )          NSSSet    *apples;";

    STAssertTrue([result isEqualToString:expectedResult], nil);
}





- (void)testPropertyAlignmentReadwrite
{
    NSString *testString = @"\
@property (strong, nonatomic) NSString *string;\n\
@property (assign, readwrite, nonatomic) NSInteger count;\n\
@property (assign, nonatomic) IBOutlet NSInteger count;\n\
@property (assign, nonatomic) NSInteger test;\n\
@property (assign, nonatomic) NSSSet *apples;";

    MTOCDAligner *aligner = [MTOCDAligner new];
    NSString *result = [aligner alignedString:testString];

    NSString *expectedResult = @"\
@property (nonatomic, strong           )          NSString  *string;\n\
@property (nonatomic, assign, readwrite)          NSInteger count;\n\
@property (nonatomic, assign           ) IBOutlet NSInteger count;\n\
@property (nonatomic, assign           )          NSInteger test;\n\
@property (nonatomic, assign           )          NSSSet    *apples;";

    STAssertTrue([result isEqualToString:expectedResult], nil);
}





- (void)testPropertyAlignmentReadOnlyAndReadWrite
{
    NSString *testString = @"\
@property (strong, nonatomic) NSString *string;\n\
@property (assign, readwrite, nonatomic) NSInteger count;\n\
@property (assign, nonatomic) IBOutlet NSInteger count;\n\
@property (assign, readonly,nonatomic) NSInteger test;\n\
@property (assign, nonatomic) NSSSet *apples;";

    MTOCDAligner *aligner = [MTOCDAligner new];
    NSString *result = [aligner alignedString:testString];

    NSString *expectedResult = @"\
@property (nonatomic, strong           )          NSString  *string;\n\
@property (nonatomic, assign, readwrite)          NSInteger count;\n\
@property (nonatomic, assign           ) IBOutlet NSInteger count;\n\
@property (nonatomic, assign, readonly )          NSInteger test;\n\
@property (nonatomic, assign           )          NSSSet    *apples;";

    STAssertTrue([result isEqualToString:expectedResult], nil);
}





- (void)testPropertyAlignmentNoStorage
{
    NSString *testString = @"\
@property (strong, nonatomic) NSString *string;\n\
@property (readwrite, nonatomic) NSInteger count;\n\
@property (assign, nonatomic) IBOutlet NSInteger count;\n\
@property (assign, readonly,nonatomic) NSInteger test;\n\
@property (assign, nonatomic) NSSSet *apples;";

    MTOCDAligner *aligner = [MTOCDAligner new];
    NSString *result = [aligner alignedString:testString];

    NSString *expectedResult = @"\
@property (nonatomic, strong           )          NSString  *string;\n\
@property (nonatomic,         readwrite)          NSInteger count;\n\
@property (nonatomic, assign           ) IBOutlet NSInteger count;\n\
@property (nonatomic, assign, readonly )          NSInteger test;\n\
@property (nonatomic, assign           )          NSSSet    *apples;";

    STAssertTrue([result isEqualToString:expectedResult], nil);
}





- (void)testPropertyAlignmentAtomic
{
    NSString *testString = @"\
@property (strong, nonatomic) NSString *string;\n\
@property (readwrite, nonatomic) NSInteger count;\n\
@property (assign) IBOutlet NSInteger count;\n\
@property (assign, readonly,nonatomic) NSInteger test;\n\
@property (assign, nonatomic) NSSSet *apples;";

    MTOCDAligner *aligner = [MTOCDAligner new];
    NSString *result = [aligner alignedString:testString];

    NSString *expectedResult = @"\
@property (nonatomic, strong           )          NSString  *string;\n\
@property (nonatomic,         readwrite)          NSInteger count;\n\
@property (           assign           ) IBOutlet NSInteger count;\n\
@property (nonatomic, assign, readonly )          NSInteger test;\n\
@property (nonatomic, assign           )          NSSSet    *apples;";

    STAssertTrue([result isEqualToString:expectedResult], nil);
}



- (void)testPropertyAlignmentCopy
{
    NSString *testString = @"\
@property (strong, nonatomic) NSString *string;\n\
@property (readwrite, nonatomic) NSInteger count;\n\
@property (assign) IBOutlet NSInteger count;\n\
@property (assign,nonatomic) NSInteger test;\n\
@property (copy, nonatomic) NSSSet *apples;";

    MTOCDAligner *aligner = [MTOCDAligner new];
    NSString *result = [aligner alignedString:testString];

    NSString *expectedResult = @"\
@property (nonatomic, strong           )          NSString  *string;\n\
@property (nonatomic,         readwrite)          NSInteger count;\n\
@property (           assign           ) IBOutlet NSInteger count;\n\
@property (nonatomic, assign           )          NSInteger test;\n\
@property (nonatomic, copy             )          NSSSet    *apples;";

    STAssertTrue([result isEqualToString:expectedResult], nil);
}




- (void)testPropertyAlignmentComments
{
    NSString *testString = @"\
@property (strong, nonatomic) NSString *string;    // a comment \n\
@property (readwrite, nonatomic) NSInteger count;       // another comment\n\
@property (assign) IBOutlet NSInteger count;\n\
@property (assign,nonatomic) NSInteger test; // how about one more\n\
@property (copy, nonatomic) NSSSet *apples;";

    MTOCDAligner *aligner = [MTOCDAligner new];
    NSString *result = [aligner alignedString:testString];

    NSString *expectedResult = @"\
@property (nonatomic, strong           )          NSString  *string;    // a comment\n\
@property (nonatomic,         readwrite)          NSInteger count;      // another comment\n\
@property (           assign           ) IBOutlet NSInteger count;\n\
@property (nonatomic, assign           )          NSInteger test;       // how about one more\n\
@property (nonatomic, copy             )          NSSSet    *apples;";

    STAssertTrue([result isEqualToString:expectedResult], nil);
}

- (void)testPropertyAlignmentCommasAtEndOfQualifiers
{
    NSString *testString = @"\
@property (copy,           nonatomic) NSString        *accessToken;\n\
@property (copy,           nonatomic) NSString        *URLToken;\n\
\n\
@property (copy,           nonatomic) NSString        *firstName;\n\
@property (copy,           nonatomic) NSString        *lastName;\n\
@property (copy,           nonatomic) NSString        *email;\n\
\n\
@property (copy, readonly, nonatomic) NSOrderedSet    *companies;                 // Array of FHCompany objects\n\
@property (strong,         nonatomic) FHCompany       *currentCompany;";

    MTOCDAligner *aligner = [MTOCDAligner new];
    NSString *result = [aligner alignedString:testString];

    NSString *expectedResult = @"\
@property (nonatomic, copy            ) NSString     *accessToken;\n\
@property (nonatomic, copy            ) NSString     *URLToken;\n\
\n\
@property (nonatomic, copy            ) NSString     *firstName;\n\
@property (nonatomic, copy            ) NSString     *lastName;\n\
@property (nonatomic, copy            ) NSString     *email;\n\
\n\
@property (nonatomic, copy,   readonly) NSOrderedSet *companies;            // Array of FHCompany objects\n\
@property (nonatomic, strong          ) FHCompany    *currentCompany;";

    STAssertTrue([result isEqualToString:expectedResult], nil);
}

@end
