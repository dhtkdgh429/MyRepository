//
//  NSObject+Volume.m
//  Volume
//
//  Created by Oh Sangho on 2018. 6. 5..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import "NSObject+Volume.h"

@implementation Volume

- (id)initWithMin:(int)a max:(int)b step:(int)s
{
    self = [super init];
    if (self != nil) {
        val = min = a;
        max = b;
        step = s;
    }
    return self;
}

- (int)value
{
    return val;
}
- (id)up
{
    if ((val += step) > max)
        val = max;
    return self;
}
- (id)down
{
    if ((val -= step) < min)
        val = min;
    return self;
}
@end
