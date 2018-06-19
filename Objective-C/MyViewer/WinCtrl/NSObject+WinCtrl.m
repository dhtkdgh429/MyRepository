//
//  NSObject+WinCtrl.m
//  MyViewer
//
//  Created by Oh Sangho on 2018. 6. 15..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import "NSObject+WinCtrl.h"
#import <Cocoa/Cocoa.h>

#define ImageSizeMIN    32
#define TitleBarHeight  22

NSString *ShrinkAllNotification = @"ShrinkAllNotification"; // extern
NSString *SizeDidChangeNotification = @"SizeDidChangeNotification"; // extern

static BOOL autoResize = NO;
static NSSize screenSize = { 1028.0, 768.0 };

@implementation WinCtrl

+ (void)initialize
{
    static BOOL nomore = NO;
    if (nomore == NO) {
        NSScreen *screen = [[NSScreen screens] objectAtIndex:0];
        screenSize = [screen visibleFrame].size;
        nomore = YES;
    }
}

+ (BOOL)autoResize { return autoResize; }
+ (void)setAutoResize:(BOOL)flag {
    autoResize = flag;
}

// 지역 메소드
- (void)windowSetup
{
    static int wincount = 0;
    float sft = (wincount++ & 07) * 20.0;
    id imageview;
    NSRect winrect, imgrect, contrect;
    float x, y;
    NSUInteger wstyle = (NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask);
    
    contrect.size.width = (int)(originalSize.width * mag);
    contrect.size.height = (int)(originalSize.height * mag);
    contrect.origin = NSZeroPoint;
    winrect = [NSWindow frameRectForContentRect:contrect styleMask:wstyle];
    x = 100.0 + sft;
    y = 150.0 + sft;
    if (x + winrect.size.width > screenSize.width)
        x = screenSize.width - winrect.size.width;
    if (y + winrect.size.height > screenSize.height)
        y = screenSize.height - winrect.size.height;
    contrect.origin = NSMakePoint(x, y);
    window = [[NSWindow alloc] initWithContentRect:contrect styleMask:wstyle backing:NSBackingStoreBuffered defer:YES];
    [window setReleasedWhenClosed:YES];
    imgrect.size = originalSize;
    imgrect.origin = NSZeroPoint;
    imageview = [[NSImageView alloc] initWithFrame:imgrect];
    [imageview setImage:docImage];
    [imageview setEditable:NO];
    [imageview setImageScaling:YES];
    [imageview setFrameSize: contrect.size];
    [window setContentView:imageview];
    [window makeFirstResponder:imageview];
    
}

// 지역 메소드

- (void)shrinkAll:(NSNotification *)notification {
    [self shrink:[notification object]];
}

- (id)initWithFile:(NSString *)path
{
    NSImageRep *rep;
    int x;
    
    if ((self = [super init]) == nil)
        return nil;
    if ((docImage = [[NSImage alloc] initWithContentsOfFile:path]) == nil) {
        return nil;
    }
    undoManager = [[NSUndoManager alloc] init];
    filename = path;
    
    originalSize = [docImage size];
    rep = [docImage bestRepresentationForDevice:nil];
    x = [rep pixelsWide];
    if (x != NSImageRepMatchesDevice && x != originalSize.width) {
        originalSize = NSMakeSize(x, [rep pixelsHigh]);
        [docImage setSize:originalSize];
    }
    
    mag = 1.0;
    if (autoResize) {
        double wr = screenSize.width / originalSize.width;
        double hr = (screenSize.height - TitleBarHeight) / originalSize.height;
        double ratio = (wr < hr) ? wr : hr;
        if (ratio < 1.0)
            mag = ratio;
    }
    [self windowSetup];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shrinkAll:) name:ShrinkAllNotification object:nil];
    [window setDelegate:self];
    [window setTitleWithRepresentedFilename:filename];
    [window makeKeyAndOrderFront:self];
    [window setDocumentEdited:(mag < 1.0)];
    return self;
}

- (NSString *)attributesOfImage
{
    static NSString *fnamestr, *sizestr, *magstr;
    NSSize sz;
    if (fnamestr == nil) {
        fnamestr = NSLocalizedString(@"Filename", "filename");
        sizestr = NSLocalizedString(@"Size", "Size");
        magstr = NSLocalizedString(@"Magnification", "Magnification");
    }
    sz = [docImage size];
    return [NSString stringWithFormat: @"%@: %@\n%@: %d x %d\n%@: %.1lf%%", fnamestr, [filename lastPathComponent],
            sizestr, (int)sz.width, (int)sz.height, magstr, mag*100.0];
}

// 지역 메소드
- (void)setScaleFactor:(double)factor
{
    id view = [window contentView];
}

@end































