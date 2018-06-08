//
//  NSObject+RGB.h
//  RGB
//
//  Created by Oh Sangho on 2018. 6. 5..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSObject.h>

@interface RGB: NSObject
{
    unsigned char red, green, blue;
}

- (id)initWithRed:(int)r green:(int)g blue:(int)b;
- (id)blendColor:(RGB *)color;
- (void)print;

@end
