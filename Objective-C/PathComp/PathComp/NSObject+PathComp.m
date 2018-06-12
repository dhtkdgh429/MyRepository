//
//  NSObject+PathComp.m
//  PathComp
//
//  Created by Oh Sangho on 2018. 6. 12..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import "NSObject+PathComp.h"
#import <Foundation/NSPathUtilities.h>
#import <stdarg.h>

@implementation NSString (PathComp)

- (NSString *)stringByAppendingPathComponents:(NSString *)aString, ...
{
    va_list varglist;
    NSString *work, *comp;
    
    if (aString == nil)
        return self;
    work = [self stringByAppendingPathComponent:aString];
    va_start(varglist, aString);
    while ((comp = va_arg(varglist, NSString *)) != nil)
        work = [work stringByAppendingPathComponent:comp];
        va_end(varglist);
        return work;
}

@end
