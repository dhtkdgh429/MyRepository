//
//  main.m
//  prog3
//
//  Created by Oh Sangho on 2018. 6. 8..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSObject.h>
#import <stdio.h>
#if !defined(LOOP)
# define LOOP 3000
#endif

long globalCount = 0;

@interface testObj: NSObject
- (int)testMethod;
@end

@implementation testObj
- (int)testMethod { return globalCount++; }
@end

int main(void)
{
    int i, v;
    int (*f)(id, SEL);
    id obj = [[testObj alloc] init];
    f = (int (*)(id,SEL))[obj methodForSelector:@selector(testMethod)];
    for (i = 0; i < 5000 * LOOP; i++)
        v = (*f)(obj, @selector(testMethod));
    return (v == 0);
}
