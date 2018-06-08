//
//  NSObject+MuteVolumev2.m
//  Volume
//
//  Created by Oh Sangho on 2018. 6. 5..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import "NSObject+MuteVolumev2.h"

@implementation MuteVolumev2

// override
- (id)initWithMin:(int)a max:(int)b step:(int)s;
{
    self = [super initWithMin:a max:b step:s];
    if (self != nil)
        muting = NO;
    return self;
}

// override
- (int)value
{
    return muting ? min : val;
}

- (id)mute
{
//    val = min;
    muting = !muting;
    return self;
}

@end
