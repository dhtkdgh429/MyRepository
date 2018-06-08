//
//  NSObject+List1.h
//  Chap2
//
//  Created by Oh Sangho on 2018. 6. 4..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSObject.h>

@interface List1: NSObject
{
    int val;
    int min, max, step;
}

- (id)initWithMin:(int)a max:(int)b step:(int)s;
- (int)value;
- (id)up;
- (id)down;
- (id)test;
@end
