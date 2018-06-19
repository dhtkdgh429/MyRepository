//
//  NSObject+Fraction.h
//  Fraction_Calculator
//
//  Created by Oh Sangho on 2018. 6. 18..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fraction : NSObject

@property int numerator, denominator;

- (void) print;
- (void) setTo: (int)n over:(int)d;
- (Fraction *) add:(Fraction *)f;
- (Fraction *) subtract:(Fraction *)f;
- (Fraction *) multiply:(Fraction *)f;
- (Fraction *) divide:(Fraction *)f;
- (void) reduce;
- (double) convertToNum;
- (NSString *) convertToString;

@end
