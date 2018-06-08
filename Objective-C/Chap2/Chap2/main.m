//
//  main.m
//  Chap2
//
//  Created by Oh Sangho on 2018. 6. 4..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <stdio.h>
#import "List1.h"

int main(void)
{
    id v, w;
    
    v = [[List1 alloc] initWithMin:0 max:10 step:2];
    w = [[List1 alloc] initWithMin:0 max:9 step:3];
    [v up];
    printf("%d %d\n", [v value], [w value]);
    [v up];
    [w up];
    printf("%d %d\n", [v value], [w value]);
    [v down];
    [w down];
    printf("%d %d\n", [v value], [w value]);
    return 0;
}
