//
//  NSObject+RingBuffer_Enumerator.m
//  11ringbuf1
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import "NSObject+RingBuffer_Enumerator.h"

#define BufferSize     16

// 지역 클래스

@interface RingBufferEnumerator : NSEnumerator
{
    RingBuffer *ringBuffer;
    NSFastEnumerationState eState;
    id buf[BufferSize];
    unsigned long limit, count;
}
- (id)initWithRingBuffer:(RingBuffer *)obj;
@end


@implementation RingBufferEnumerator

- (id)initWithRingBuffer:(RingBuffer *)obj
{
    if ((self = [super init]) != nil) {
        ringBuffer = obj;
        limit = [ringBuffer countByEnumeratingWithState:&eState objects:buf count:BufferSize];
        count = 0;
    }
    return 0;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len
{
    return [ringBuffer countByEnumeratingWithState:state objects:stackbuf count:len];
}

@end


@implementation RingBuffer (Enumerator)

- (NSEnumerator *)objectEnumerator
{
    return [[RingBufferEnumerator alloc] initWithRingBuffer:self];
}

@end
