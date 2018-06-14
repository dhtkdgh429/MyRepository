//
//  NSObject+RealArray.h
//  11real
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSArray.h>
#import "RealNumber.h"

@interface NSMutableArray (RealArray)
- (void)addRealNumber:(id <RealNumber>)number;
- (void)sort;

@end
