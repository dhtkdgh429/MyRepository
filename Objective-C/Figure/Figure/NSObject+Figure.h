//
//  NSObject+Figure.h
//  Figure
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSObject.h>
#import <Foundation/NSGeometry.h>

@class NSString;

@interface Figure : NSObject
{
    NSPoint location;
}
- (void)setLocation:(NSPoint)point;
- (void)setSize:(NSSize)newsize;
- (float)area;
- (NSString *)figureName;
- (NSString *)stringOfSize;
- (NSString *)description;

@end
