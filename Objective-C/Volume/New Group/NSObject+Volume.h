//
//  NSObject+Volume.h
//  Volume
//
//  Created by Oh Sangho on 2018. 6. 5..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSObject.h>

@interface Volume : NSObject
{
    int val;
    int min, max, step;
}

- (id)initWithMin:(int)a max:(int)b step:(int)s;
- (int)value;
- (id)up;
- (id)down;
@end
