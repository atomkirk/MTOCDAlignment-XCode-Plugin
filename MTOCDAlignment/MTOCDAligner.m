//
//  MTOCDAligner.m
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDAligner.h"
#import "MTOCDPropertyLine.h"
#import "MTOCDPropertyParagraph.h"
#import "MTOCDAssignmentLine.h"
#import "MTOCDAssignmentParagraph.h"


@interface MTOCDAligner ()
@property (nonatomic, strong) NSMutableArray *paragraphs;
@end


@implementation MTOCDAligner

- (NSString *)alignedString:(NSString *)string
{
    NSArray *lines                   = [string componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    _paragraphs                      = [NSMutableArray new];
    NSArray *lineTypes               = [self lineTypes];
    MTOCDParagraph *currentParagraph = nil;

    for (NSString *line in lines) {

        for (Class <MTOCDLining>lineClass in lineTypes) {

            if ([lineClass lineConforms:line]) {

                if (!currentParagraph) {
                    currentParagraph = [[lineClass paragraphClass] new];
                }
                else {
                    BOOL isNewTypeOfParagraph = ![currentParagraph isMemberOfClass:[lineClass paragraphClass]];
                    BOOL isGenericLine        = lineClass == [MTOCDLine class];
                    BOOL startNewParagraph    = isNewTypeOfParagraph && !isGenericLine;

                    if (startNewParagraph) {
                        [_paragraphs addObject:currentParagraph];
                        currentParagraph = [[lineClass paragraphClass] new];
                    }
                }

                MTOCDLine *newLine = [lineClass lineWithContents:line];
                [currentParagraph addLine:newLine];

                break;
            }
        }
    }

    // add the last paragraph, since paragraphs only get added when starting new ones
    if (currentParagraph) {
        [_paragraphs addObject:currentParagraph];
    }

    return [_paragraphs componentsJoinedByString:@"\n"];
}




#pragma mark - Private

- (NSArray *)lineTypes
{
    return @[[MTOCDPropertyLine class],
             [MTOCDAssignmentLine class],
             [MTOCDLine class]]; // this must always be last, cause any line conforms
}

@end
