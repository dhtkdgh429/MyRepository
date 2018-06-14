//
//  NSObject+Queue.h
//  11Queue
//
//  Created by Oh Sangho on 2018. 6. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSArray.h>
#import <Foundation/NSEnumerator.h>

@interface Queue: NSObject <NSFastEnumeration>
{
    NSMutableArray *buffer;
}

- (id)init;
- (void)enqueue:(id)obj;
- (id)dequeue;

@end
