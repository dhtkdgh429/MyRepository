//
//  main.m
//  type
//
//  Created by Oh Sangho on 2018. 6. 5..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSObject.h>
#import <stdio.h>

@interface A: NSObject
- (void)whoAreYou;
@end

@implementation A
- (void)whoAreYou { printf("I'm A\n"); }
@end

@interface B: A
- (void)whoAreYou;
- (void)sayHello;
@end

@implementation B
- (void)whoAreYou { printf("I'm B\n"); }   // override
- (void)sayHello { printf("Hello\n"); }
@end

@interface C: NSObject
- (void)printName;
@end

@implementation C
- (void)printName { printf("I'm C\n"); }
@end

int main(void)
{
    A *a, *b;
//    C *c;
    id c;
    
    a = [[A alloc] init];
    b = [[B alloc] init];
    c = [[C alloc] init];
    [(B *) a whoAreYou];
    [(B *) b sayHello];
    [c printName];
    return 0;
}
