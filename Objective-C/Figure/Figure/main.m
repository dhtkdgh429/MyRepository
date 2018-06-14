//
//  main.m
//  Figure
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSString.h>
#import <Foundation/NSAutoreleasePool.h>
#import "NSObject+Figure.h"
#import "NSObject+Circle.h"
#import "NSObject+Rectangle.h"
#import <stdio.h>

BOOL testloop(void)
{
    Figure *fig =nil;
    NSPoint pnt;
    NSSize sz;
    char buf[64], com;
    
    do {
        printf("Shape (C=Circle, R=Rectnagle. Q=Quit) ? ");
        if (scanf("%s", buf) == 0 || (com = buf[0]) == 'Q' || com == 'q')
            return NO;
        switch (com) {
            case 'C': case 'c': /* Circle */
                fig = [[[Circle alloc] init] autorelease];
                break;
            case 'R': case 'r': /* Rectangle */
                fig = [[[Rectangle alloc] init] autorelease];
                break;
        }
    }while (fig == nil);
    
    printf("Location ? ");
    scanf("%f %f", &pnt.x, &pnt.y);
    [fig setLocation: pnt];
    printf("Size ? ");
    scanf("%f %f", &sz.width, &sz.height);
    [ fig setSize: sz];
    printf("%s\n", [[fig description] UTF8String]);
    return YES;
}

int main(void)
{
    NSAutoreleasePool *pool;
    BOOL flag;
    
    do {
        pool = [[NSAutoreleasePool alloc] init];
        flag = testloop();
        [pool release];
    }while (flag);
    return 0;
}

























