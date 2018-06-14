//
//  NSObject+BitPattern.h
//  BitPattern
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSString.h>

@interface BitPattern : NSString
{
    unsigned char value;
}

- (id)initWithChar:(char)val; // 지정 이니셜라이저
- (NSUInteger)length;
- (unichar)characterAtIndex:(NSUInteger)index;

@end
