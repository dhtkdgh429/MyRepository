//
//  NSObject+Figure.m
//  Figure
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import "NSObject+Figure.h"
#import <Foundation/NSString.h>
#import <stdio.h>

@implementation Figure

- (void)setLocation:(NSPoint)point {
    location = point;
}

- (void)setSize:(NSSize)newsize { /* virtual */ }
- (float)area { return 0.0; } /* virtual */
- (NSString *)figureName {return nil; } /* virtual */
- (NSString *)stringOfSize {return nil; } /* virtual */

- (NSString *)description
{
    return [NSString stringWithFormat: @"%@: location=(%.2f, %.2f), area=%.2f", [self figureName], location.x, location.y, [self stringOfSize], [self area]];
}

@end
