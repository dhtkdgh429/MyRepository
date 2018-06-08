//
//  main.m
//  retain
//
//  Created by Oh Sangho on 2018. 6. 8..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSObject.h>
#import <stdio.h>

int main()
{
    id obj = [[NSObject alloc] init];
    printf("init: %d\n", [obj retainCount]);
    [obj retain];
    printf("retain: %d\n", [obj retainCount]);
    [obj retain];
    printf("retain: %d\n", [obj retainCount]);
    
    [obj release];
    printf("release: %d\n", [obj retainCount]);
    [obj release];
    printf("release: %d\n", [obj retainCount]);
    [obj release];
    printf("release: %d\n", [obj retainCount]);
    return 0;
}
