//
//  NSObject+MyViewerCtrl.h
//  MyViewer
//
//  Created by Oh Sangho on 2018. 6. 15..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSObject.h>

@class NSNotification;

@interface MyViewerCtrl: NSObject
{
    id autoResizeItem;
}
- (void)setupMainMenu;
- (void)openFile:(id)sender;
- (void)activateInspector:(id)sender;
- (void)toggleAutoResize:(id)sender;

// 델리게이트 메시지
- (void)applicationDidfinishLaunching:(NSNotification *)aNotification;
- (void)applicationWillTerminate:(NSNotification *)aNotification

@end

