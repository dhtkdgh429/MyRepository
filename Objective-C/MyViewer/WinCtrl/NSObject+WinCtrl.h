//
//  NSObject+WinCtrl.h
//  MyViewer
//
//  Created by Oh Sangho on 2018. 6. 15..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSGeometry.h>

@class NSWindow, NSNotification, NSUndoManager;

extern NSString *ShrinkAllNotification;
extern NSString *SizeDidChangeNotification;


@interface WinCtrl: NSObject
{
    NSString *filename;
    id docImage;
    NSSize originalSize;
    NSWindow *window;
    NSUndoManager *undoManager;
    double mag;
}

+ (void)initialize;
+ (BOOL)autoResize;
+ (void)setAutoResize:(BOOL)flag;
- (id)initWithFile:(NSString *)path;
- (NSString *)attributesOfImage;
- (void)shrink:(id)sender;


// 델리게이트 메시지
- (BOOL)windowShouldClose:(id)sender;
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)win;

@end
