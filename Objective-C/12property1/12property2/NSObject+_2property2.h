//
//  NSObject+_2property2.h
//  12property1
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//


// 디클레어드 프로퍼티를 사용한 인터페이스 예시.

#import <Foundation/Foundation.h>

@interface Creature : NSObject
{
    NSString *name;
    int     hitPoint;
    int     magicPoint;
}
- (id)initWithName:(NSString *)str;
@property(readonly) NSString *name;
@property int hitPoint, magicPoint;
@property(readonly) int level;

@end
