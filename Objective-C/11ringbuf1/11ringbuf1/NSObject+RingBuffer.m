//
//  NSObject+RingBuffer.m
//  11ringbuf1
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import "NSObject+RingBuffer.h"

@implementation RingBuffer

- (id)initWithCapacity:(NSUInteger)cap
{
    if ((self = [super init]) != nil) {
        buffer = NSAllocateCollectable(sizeof(id) * cap, NSScannedOption);
        capacity = cap;
        head = tail = count = 0;
        modification = 0;
    }
    return self;
}

- (void)enqueue:(id)obj {
    buffer[tail] = obj;
    tail = (tail + 1) % capacity;
    if (count >= capacity)
        head = (head + 1) % capacity;
    else
        ++count;
    ++modification;
        
}

- (id)dequeue {
    id obj = nil;
    if (count > 0) {
        obj = buffer[head];
        head = (head + 1) % capacity;
        --count;
        ++modification;
    }
    return obj;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len
{
    NSUInteger n, index, remain;
    
    if (state->state == 0) { // 루프 시작
        state->state = 1;
        state->extra[0] = index = head;
        state->extra[1] = remain = count;
        state->mutationsPtr = &modification;
    } else {
        index = state->extra[0];    // 다음 인덱스
        remain = state->extra[1];   // 남은 요소의 수
    }
    
#if defined(__DIRECT__)
    state->itemsPtr = &buffer[index];
    n = capacity - index;
    if (n >= remain) {
        n = remain;
        index += remain;
        remain = 0;
    } else {
        remain -= n;
        index = 0;
    }
#else
    for (n = 0; remain > 0 && n < len; n++, remain--) {
        stackbuf[n] = buffer[index];
        index = (index + 1) % capacity;
     }
    state->itemsPtr = stackbuf;
#endif
    state->extra[0] = index;
    state->extra[1] = remain;
    return n;
    
}
@end

















