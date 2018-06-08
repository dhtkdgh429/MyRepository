//
//  NSObject+Fraction.h
//  Fraction
//
//  Created by Oh Sangho on 2018. 6. 7..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSObject.h>

@class NSString;
@interface Fraction: NSObject
{
    int sgn; // sign
    int num; // numerator
    int den; // denominator
}

+ (id)fractionWithNumerator:(int)n denominator:(int)d;
- (id)initWithNumerator:(int)n denominator:(int)d;
- (Fraction *)add:(Fraction *)obj;
- (Fraction *)sub:(Fraction *)obj;
- (Fraction *)mul:(Fraction *)obj;
- (Fraction *)div:(Fraction *)obj;
- (NSString *)description;

@end
