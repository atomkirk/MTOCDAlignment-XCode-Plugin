//
//  MTOCDAssignmentLine.m
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDAssignmentLine.h"
#import "MTOCDLine+Protected.h"


@interface MTOCDAssignmentLine ()
@property (nonatomic, retain) NSString *beforeEquals;
@property (nonatomic, retain) NSString *shorthandSymbol;
@property (nonatomic, retain) NSString *afterEquals;
@end


@implementation MTOCDAssignmentLine

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

+ (BOOL)lineConforms:(NSString *)line
{
    return [self line:line matchesRegexPattern:@"\\@property"];
}

- (NSString *)description
{
    [self parse];
    return @"";
}

- (NSInteger)currentColumn
{
    return [self.originalLine rangeOfString:@"="].location;
}



#pragma mark - Protected

- (void)parse
{
    NSArray *parts = [self.originalLine componentsSeparatedByString:@"="];
    if ([parts count] > 0) {
        // before
        _beforeEquals   = parts[0];

        // shortcut symbol
        unichar lastChar = [_beforeEquals characterAtIndex:[_beforeEquals length] - 1];
        if ([[NSCharacterSet symbolCharacterSet] characterIsMember:lastChar]) {
            _shorthandSymbol = [NSString stringWithFormat:@"%c", lastChar];
        }

        // after
        NSArray *after  = [parts objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, [parts count] - 1)]];
        _afterEquals    = [after componentsJoinedByString:@"="];
    }
}

@end
