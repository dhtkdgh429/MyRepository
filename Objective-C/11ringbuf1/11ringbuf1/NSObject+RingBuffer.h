//
//  NSObject+RingBuffer.h
//  11ringbuf1
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSObject.h>
#import <Foundation/NSEnumerator.h>

@interface RingBuffer: NSObject <NSFastEnumeration>

{
    id *buffer;
    NSUInteger capacity, head, tail, count;
    unsigned long modification;
}

- (id)initWithCapacity:(NSUInteger)cap;
- (void)enqueue:(id)obj;
- (id)dequeue;

@end
