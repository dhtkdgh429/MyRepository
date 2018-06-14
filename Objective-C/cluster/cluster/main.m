//
//  main.m
//  cluster
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSAutoreleasePool.h>
#import <Foundation/NSPathUtilities.h>
#import <stdio.h>

static void printClass(NSString *obj)
{
    printf("Class=%s,\tMember=%s,\tKind=%s\n",
           [NSStringFromClass([obj class]) UTF8String],
           [obj isMemberOfClass: [NSString class]] ? "YES" : "NO",
           [obj isKindOfClass: [NSString class]] ? "YES" : "NO");
}

int main(void)
{
    NSString *ss = @"static string";
    id pool = [[NSAutoreleasePool alloc] init];
    
    printClass( ss );
    printClass( [ss stringByAppendingString: @"(^-^)"] );
    printClass( [NSString stringWithUTF8String: "(-_-)"] );
    printClass( NSHomeDirectory() );
    
    [pool release];
    return 0;
    
}
