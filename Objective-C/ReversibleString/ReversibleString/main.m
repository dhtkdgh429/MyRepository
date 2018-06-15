//
//  main.m
//  ReversibleString
//
//  Created by Oh Sangho on 2018. 6. 15..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSString.h>
#import <Foundation/NSMethodSignature.h>
#import <Foundation/NSInvocation.h>
#import <Foundation/NSAutoreleasePool.h>
#import <stdio.h>
#import <stdlib.h>

@interface ReversibleString : NSObject
{
    NSString *content;
}
- (id)initWithString:(NSString *)string;
- (void)dealloc;
- (id)reversedString;
@end

@implementation ReversibleString

- (id)initWithString:(NSString *)string
{
    if ((self = [super init]) != nil)
        content = [string retain];
    return self;
}

- (void)dealloc
{
    [content release];
    [super dealloc];
}

- (id)reversedString
{
    unichar *buffer;
    int length, i, j, tmp;
    id reversed;
    
    if ((length = [content length]) <= 0)
        return @"";
    buffer = (unichar *)malloc(sizeof(unichar) * length);
    [content getCharacters:buffer];
    for (i = 0, j = length-1; i < j; i++, j--)
        tmp = buffer[i], buffer[i] = buffer[j], buffer[j] = tmp;
    reversed = [NSString stringWithCharacters:buffer length:length];
    free((void *)buffer);
    return reversed;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL sel = [anInvocation selector];
    if ([content respondsToSelector:sel])
        [anInvocation invokeWithTarget:content];
    else
        [super forwardInvocation:anInvocation];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([super respondsToSelector:aSelector])
        return YES;
    if ([self methodForSelector:aSelector] != (IMP)NULL)
        return YES;
    if ([content respondsToSelector:aSelector])
        return YES;
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if ([super respondsToSelector:aSelector])
        return [super methodSignatureForSelector:aSelector];
    return [content methodSignatureForSelector:aSelector];
}

@end

int main(void)
{
    char buf[100];
    id s, a, b;
    id pool = [[NSAutoreleasePool alloc]init];
    
    scanf("%s", buf);
    s = [NSString stringWithUTF8String:buf];
    a = [[ReversibleString alloc] initWithString:s];
    b = [[ReversibleString alloc] initWithString:@"Reverse?"];
    printf("%s\n", [a UTF8String]);
    s = [[a reversedString] stringByAppendingString: b];
    printf("%s\n", [s UTF8String]);
    a = [[ReversibleString alloc] initWithString:s];
    s = [b stringByAppendingString: [a reversedString]];
    printf("%s\n", [s UTF8String]);
    [pool release];
    return 0;
}


















