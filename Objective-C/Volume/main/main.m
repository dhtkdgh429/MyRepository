//
//  main.m
//  Volume
//
//  Created by Oh Sangho on 2018. 6. 5..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <stdio.h>
#import "NSObject+MuteVolumev2.h"

int main(void)
{
    //    id v, w;  Volume main
    id v;
    char buf[8];
    
    v = [[MuteVolumev2 alloc] initWithMin:0 max:10 step:2];
    while (scanf("%s", buf) > 0) {
        switch (buf[0]) {
            case 'u': [v up]; break;
            case 'd': [v down]; break;
            case 'm': [v mute]; break;
            case 'q': return 0;
        }
        printf("Volume=%d\n", [v value]);
    }
    
    /*    w = [[Volume alloc] initWithMin:0 max:9 step:3];  Volume main
    [v up];
    printf("%d %d\n", [v value], [w value]);
    [v up];
    [w up];
    printf("%d %d\n", [v value], [w value]);
    [v down];
    [w down];
    printf("%d %d\n", [v value], [w value]); */
    
    return 0;
}
