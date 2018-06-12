//
//  main.m
//  PathComp
//
//  Created by Oh Sangho on 2018. 6. 12..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSString.h>
#import <Foundation/NSPathUtilities.h>
#import <Foundation/NSAutoreleasePool.h>
#import "NSObject+PathComp.h"
#import <stdio.h>

#define BUFSIZE 80

int main(void)
{
    NSString *pict = @"Pictures";
    NSString *homedir, *s;
    id pool = [[NSAutoreleasePool alloc] init];
    homedir = NSHomeDirectory();
    s = [homedir stringByAppendingPathComponent: pict];
    printf("%s\n", [s UTF8String]);
    s = [homedir stringByAppendingPathComponents: pict, @"tmp", nil];
    printf("%s\n", [s UTF8String]);
    s = [homedir stringByAppendingPathComponents:@"Desktop", pict, @"Wallpaper", nil];
    printf("%s\n", [s UTF8String]);
    
    [pool drain];
    return 0;
}
