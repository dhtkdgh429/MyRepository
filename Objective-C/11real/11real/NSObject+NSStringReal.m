//
//  NSObject+NSStringReal.m
//  11real
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import "NSObject+NSStringReal.h"

@implementation NSString (Real)
- (double)realValue
{
    return [self doubleValue];
}
@end
