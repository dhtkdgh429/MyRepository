//
//  NSObject+Calculator.h
//  Fraction_Calculator
//
//  Created by Oh Sangho on 2018. 6. 18..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <UIKit/UIkit.h>
#import "Fraction.h"

@interface Calculator : NSObject

@property (strong, nonatomic) Fraction * operand1, *operand2, *accumulator;

- (Fraction *) performOperation:(char)op;
- (void) clear;

@end
