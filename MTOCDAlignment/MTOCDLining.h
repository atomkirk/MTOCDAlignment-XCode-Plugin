//
//  MTOCDLining.h
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MTOCDLining <NSObject>
+ (BOOL)lineConforms:(NSString *)line;
+ (instancetype)lineWithContents:(NSString *)contents;
+ (Class)paragraphClass;
@end
