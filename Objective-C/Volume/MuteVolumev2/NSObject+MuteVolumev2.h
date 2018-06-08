//
//  NSObject+MuteVolumev2.h
//  Volume
//
//  Created by Oh Sangho on 2018. 6. 5..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import "NSObject+Volume.h"

@interface MuteVolumev2 : Volume
{
    BOOL muting;
}

// override
- (id)initWithMin:(int)a max:(int)b step:(int)s;
- (int)value;

- (id)mute;

@end
