//
//  NSObject+_2property2.m
//  12property1
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import "NSObject+_2property2.h"

@implementation Creature

- (id)initWithName:(NSString *)str

{
    if ((self = [super init]) != nil) {
        name = str;
        hitPoint = magicPoint = 10;
    }
    return self;
}

@synthesize name;
@synthesize hitPoint, magicPoint;

@dynamic level;

- (int)level {
    return (hitPoint + magicPoint) / 10;
}

@end
