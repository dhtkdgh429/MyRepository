//
//  main.m
//  MyViewer
//
//  Created by Oh Sangho on 2018. 6. 15..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MyViewerCtrl.h"

int main(int argc, const char *argv[]) {
    id controller = [[MyViewerCtrl alloc] init];
    id app = [NSApplication sharedApplication];
    [app setDelegate:controller];
    [controller setupMainMenu];
    [app run];
    return 0;
}


