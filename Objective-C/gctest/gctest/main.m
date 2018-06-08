//
//  main.m
//  gctest
//
//  Created by Oh Sangho on 2018. 6. 7..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSObject.h>
#import <Foundation/NSGarbageCollector.h>
#import <stdio.h>
#import <stdlib.h>
#import <libc.h>
#define MASS    100000
#define LOOP    4

@interface Chunk: NSObject
{
    int number;
    id target;
    char mass[MASS];
}
- (id)initWithLabel:(const char *)lab;
- (void)setTarget:(id)obj;
- (void)finalize;
@end

@implementation Chunk

- (id)initWithLabel:(const char *)lab
{
    static int serial = 0;
    
    self = [super init];
    number = ++serial;
    target = nil;
    strcpy(mass, lab);
    return self;
}

- (void)setTarget:(id)obj {
    target = obj;
}

- (void)finalize {
    printf("%d %s\n", number, mass);
    [super finalize];
}
@end

Chunk *g = nil; // 전역 변수
id a[2];        // C 스타일 배열
id *ma = nil;   // malloc: 동적 할당
id *na = nil;   // NSAlloc: 동적 할당
void *v = NULL; // 객체가 아닌 경우
__weak Chunk *w[LOOP];  // 약한 참조

static void func(id *ptr)
{
    int i;
    id f;
    static id s = nil;
    
    f = [[Chunk alloc] initWithLabel:"Stack in func"];
    s = [[Chunk alloc] initWithLabel:"Static var"];
    g = [[Chunk alloc] initWithLabel:"Global"];
    [g setTarget: [[Chunk alloc] initWithLabel:"Instance var"]];
    i = 1;
    a[i] = [[Chunk alloc] initWithLabel:"C-Style Array"];
    ma[i] = [[Chunk alloc] initWithLabel:"malloc"];
    na[i] = [[Chunk alloc] initWithLabel:"NSAlloc"];
    v = [[Chunk alloc] initWithLabel:"Void*"];
    *ptr = [[Chunk alloc] initWithLabel:"Pointer"];
    for (i = 0; i < LOOP; i++) {
        if (w[i] == nil)
            w[i] = [[Chunk alloc] initWithLabel:"Weak Reference"];
    }
}


int main(void)
{
    int i;
    
    ma = (id *)malloc(sizeof(id) * 2);
    na = (id *)NSAllocateCollectable(sizeof(id) * 2, NSScannedOption);
    for (i = 0; i < 8; i++) {
        id entry = nil;
        id m;
        m = [[Chunk alloc] initWithLabel:"Stack"];
        func(&entry);
        printf("------\n");
        [[NSGarbageCollector defaultCollector] collectIfNeeded];
        sleep(1);
    }
    free(ma);
    return 0;
}
















