//
//  main.m
//  12property1
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.

#import "NSObject+_2property2.h"

int main(void)
{
    Creature *a = [[Creature alloc] initWithName:@"Nike"];
    a.hitPoint = 50;
    printf("%s: HP=%d (LV=%d)\n", [a.name UTF8String], a.hitPoint, a.level);
    return 0;
}
