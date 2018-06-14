//
//  NSObject+BitPattern.m
//  BitPattern
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import "NSObject+BitPattern.h"

@implementation BitPattern

- (id)initWithChar:(char)val
{
    if ((self = [super init]) != nil)
        value = val;
    return self;
}

- (NSUInteger)length
{
    return 8;
}

- (unichar)characterAtIndex:(NSUInteger)index
{
    return (value & (0x80 >> index)) ? '1' : '0';
}

@end
