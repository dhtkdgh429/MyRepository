//
//  NSObject+FracRegister.h
//  Fraction
//
//  Created by Oh Sangho on 2018. 6. 7..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSObject.h>
#import "NSObject+Fraction.h"

@interface FracRegister: NSObject
{
    Fraction *current;
    Fraction *prev;
}

- (id)init;
//- (void)dealloc;
- (Fraction *)currentValue;
- (void)setCurrentValue:(Fraction *)val;
- (BOOL)undoCalc;
- (void)calculate:(char)op with:(Fraction *)arg;

@end
