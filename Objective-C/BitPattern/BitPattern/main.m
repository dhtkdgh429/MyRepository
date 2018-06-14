//
//  main.m
//  BitPattern
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import "NSObject+BitPattern.h"
#import <Foundation/Foundation.h>
#import <stdio.h>

int main(int argc, char *argv[])
{
    NSString *bits, *tmp;
    
    bits = [[BitPattern alloc] initWithChar:argv[1][0]];
    printf("Bit Pattern = %s\n", [bits UTF8String]);
    tmp = [@"Bit Pattern = " stringByAppendingString: bits];
    printf("%s\n", [tmp UTF8String]);
    return 0;
}
