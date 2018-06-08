//
//  NSObject+List1.m
//  Chap2
//
//  Created by Oh Sangho on 2018. 6. 4..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import "List1.h"

@implementation List1

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
-(id)test
{
    return nil;
}
@end
