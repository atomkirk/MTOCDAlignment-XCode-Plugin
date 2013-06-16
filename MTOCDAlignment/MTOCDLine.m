//
//  MTOCDLine.m
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDLine.h"
#import "MTOCDLine+Protected.h"
#import "MTOCDParagraph.h"


@implementation MTOCDLine

+ (instancetype)lineWithContents:(NSString *)contents
{
    MTOCDLine *line   = [self new];
    line.originalLine = contents;
    [line convertTabsToSpaces];
    return line;
}

+ (BOOL)lineConforms:(NSString *)line
{
    return YES;
}

+ (Class)paragraphClass
{
    return [MTOCDParagraph class];
}

- (void)parse
{
}

- (NSString *)description
{
    return self.originalLine;
}



#pragma mark - Private

- (void)convertTabsToSpaces
{
    while (true) {
        NSRange rangeOfTab = [_originalLine rangeOfString:@"\t"];
        if (rangeOfTab.location != NSNotFound) {
            // TODO: get tab size from xcode somehow
            NSString *spaces  = [@"" stringByPaddingToLength:4 withString:@" " startingAtIndex:0];
            self.originalLine = [_originalLine stringByReplacingCharactersInRange:rangeOfTab withString:spaces];
        }
        else {
            break;
        }
    }
}


@end
