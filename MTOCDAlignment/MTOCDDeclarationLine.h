//
//  MTOCDIvarLine.h
//  MTOCDAlignment
//
//  Created by Adam Kirk on 8/30/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDLine.h"

@interface MTOCDDeclarationLine : MTOCDLine
@property (nonatomic, assign, readonly) NSUInteger currentColumn;
@property (nonatomic, assign)           NSUInteger alignmentColumn;
@end
