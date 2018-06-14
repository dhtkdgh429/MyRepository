//
//  NSObject+Rectangle.m
//  Figure
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import "NSObject+Rectangle.h"
#import <Foundation/NSString.h>
#import <stdio.h>
#import <stdlib.h>

@implementation Rectangle


- (void)setSize:(NSSize)newsize {
    size = newsize;
}

- (float)area {
    return size.width * size.height;
}

- (NSString *)figureName {
    return (size.width == size.height) ? @"Square" : @"Rectangle";
}

- (NSString *)stringOfSize {
    return [NSString stringWithFormat: @"size=%.2f x %.2f", size.width, size.height];
}

@end
