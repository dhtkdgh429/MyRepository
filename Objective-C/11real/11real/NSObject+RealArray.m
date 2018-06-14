//
//  NSObject+RealArray.m
//  11real
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import "NSObject+RealArray.h"

@implementation NSMutableArray (RealArray)

- (void)addRealNumber:(id<RealNumber>)number
{
    [self addObject:number];
}

static int compareReal(id <RealNumber> a, id <RealNumber> b, void *_)
{
    double v = [a realValue] - [b realValue];
    if (v > 0.0) return NSOrderedDescending;
    if (v < 0.0) return NSOrderedAscending;
    return NSOrderedSame;
}

- (void)sort
{
    [self sortUsingFunction: compareReal context:0];
}

@end
