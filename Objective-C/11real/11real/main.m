//
//  main.m
//  11real
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSAutoreleasePool.h>
#import <stdio.h>
#import "RealNumber.h"
#import "NSObject+Fraction.h"
#import "NSObject+NSStringReal.h"
#import "NSObject+RealArray.h"

int main(void)
{
    id pool = [[NSAutoreleasePool alloc] init];
    id array = [NSMutableArray array];
    [array addRealNumber:@".3"];
    [array addRealNumber:@"0.35"];
    [array addRealNumber:@"0.2"];
    [array addRealNumber:[Fraction fractionWithNumerator:1 denominator:3]];
    [array addRealNumber:[Fraction fractionWithNumerator:3 denominator:8]];
    [array addRealNumber:[Fraction fractionWithNumerator:1 denominator:3]];
    [array addRealNumber:[Fraction fractionWithNumerator:3 denominator:2]];
    [array sort];
    printf("%s\n", [[array description] UTF8String]);
    [pool release];
    return 0;
}
