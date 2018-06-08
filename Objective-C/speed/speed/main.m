//
//  main.m
//  speed
//
//  Created by Oh Sangho on 2018. 6. 7..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdio.h>
#import <stdlib.h>

#define MASS        2000
#define SEED        12345
#define ARRAYSIZE   (1 << 6)
#define ARRAYMASK   (ARRAYSIZE - 1)
#define LOOP        800
#define ACCIDENT    0x0f

id buf[ARRAYSIZE];

@interface Cell: NSObject {
    id next;
    char mass[MASS];
}

- (id)initWithNext:(id)obj;
//- (void)dealloc;
@end

@implementation Cell

- (id)initWithNext:(id)obj {
    self = [super init];
    //    next = [obj retain];
    return self;
}

//- (void)dealloc {
//    [next release];
//    [super dealloc];
//}

@end

int main(void)
{
    int i, j;
    
    srandom(SEED);
    for (i = 0; i < LOOP; i++) {
        //        id pool = [[NSAutoreleasePool alloc] init];
        for (j = 0; j < LOOP; j++) {
            int idx = random() & ARRAYMASK;
            if (buf[idx] != nil && (random() & ACCIDENT) == 0) {
                
                //            [buf[idx] autorelease];
                buf[idx] = nil;
            }else {
                id t = buf[idx];
                buf[idx] = [[Cell alloc] initWithNext: t];
                //            [t autorelease];
            }
        }
//        [pool drain];
    }
    return 0;
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
