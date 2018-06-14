//
//  NSObject+RingBuffer_Enumerator.h
//  11ringbuf1
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import "NSObject+RingBuffer.h"

@interface RingBuffer (Enumerator)

- (NSEnumerator *)objectEnumerator;

@end
