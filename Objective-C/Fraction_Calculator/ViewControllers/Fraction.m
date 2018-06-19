//
//  NSObject+Fraction.m
//  Fraction_Calculator
//
//  Created by Oh Sangho on 2018. 6. 18..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import "Fraction.h"

@implementation Fraction

@synthesize numerator, denominator;

- (void) setTo:(int)n over:(int)d
{
    numerator = n;
    denominator = d;
}

- (void) print
{
    NSLog(@"%i/%i", numerator, denominator);
}

- (double) convertToNum
{
    if (denominator != 0)
        return (double) numerator / denominator;
    else
        return NAN;
}

- (NSString *) convertToString
{
    if (numerator == denominator)
        if (numerator == 0)
            return @"0";
    else
        return @"1";
    else if (denominator == 1)
        return [NSString stringWithFormat: @"%i", numerator];
    else
        return [NSString stringWithFormat: @"%i/%i", numerator, denominator];
}


// 수신자에 Fraction을 더함.

- (Fraction *) add:(Fraction *)f
{
    // 두 분수를 더하려면 아래 식.
    // a/b + c/d = ((a * d) + (b * c)) / (b * d)
    
    // result = 덧셈의 결과.
    Fraction *result = [[Fraction alloc] init];
    
    result.numerator = numerator * f.denominator + denominator * f.numerator;
    result.denominator = denominator * f.denominator;
    
    [result reduce];
    return result;
}

- (Fraction *) subtract:(Fraction *)f
{
    // 두 분수를 빼려면 아래 식.
    // a/b - c/d = ((a * d) - (b * c)) / (b * d)
    
    Fraction *result = [[Fraction alloc] init];
    
    result.numerator = numerator * f.denominator - denominator * f.numerator;
    result.denominator = denominator * f.denominator;
    
    [result reduce];
    return result;
    
}

- (Fraction *) multiply:(Fraction *)f
{
    Fraction *result = [[Fraction alloc] init];
    
    result.numerator = numerator * f.numerator;
    result.denominator = denominator * f.denominator;
    
    [result reduce];
    return result;
}

- (Fraction *) divide:(Fraction *)f
{
    Fraction *result = [[Fraction alloc] init];
    
    result.numerator = numerator * f.denominator;
    result.denominator = denominator * f.numerator;
    
    [result reduce];
    return result;
}

- (void) reduce
{
    int u = numerator;
    int v = denominator;
    int temp;
    
    if (u == 0)
        return;
    else if (u < 0)
        u = -u;
    
    while (v != 0) {
        temp = u % v;
        u = v;
        v = temp;
    }
    
    numerator /= u;
    denominator /= u;
}

@end






















