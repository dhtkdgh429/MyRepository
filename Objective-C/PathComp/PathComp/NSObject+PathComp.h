//
//  NSObject+PathComp.h
//  PathComp
//
//  Created by Oh Sangho on 2018. 6. 12..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSString.h>

@interface NSObject (PathComp)

- (NSString *)stringByAppendingPathComponents:(NSString *) aString, ...
    NS_REQUIRES_NIL_TERMINATION;

@end
