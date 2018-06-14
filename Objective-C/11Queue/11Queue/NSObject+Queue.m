//
//  NSObject+Queue.m
//  11Queue
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import "NSObject+Queue.h"

@implementation Queue

- (id)init {
    if ((self = [super init]) != nil)
        buffer = [[NSMutableArray alloc] initWithCapacity:1];
    return self;
}

- (void)enqueue:(id)obj {
    [buffer addObject:obj];
}

- (id)dequeue {
    id obj = nil;
    if ([buffer count] > 0) {
        obj = [buffer objectAtIndex:0];
        [buffer removeObject:0];
    }
    return obj;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len
{
    return [buffer countByEnumeratingWithState:state objects:stackbuf count:len];
}

@end
