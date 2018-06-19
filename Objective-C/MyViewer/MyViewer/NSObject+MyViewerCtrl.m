//
//  NSObject+MyViewerCtrl.m
//  MyViewer
//
//  Created by Oh Sangho on 2018. 6. 15..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import "NSObject+MyViewerCtrl.h"
#import <Cocoa/Cocoa.h>
#import "NSObject+WinCtrl.h"
#import "MyInspector.h"

static NSString *AutoResizeKey = @"AutoResize";

@interface NSMenu (Local)
- (void)setMenuName:(NSString *)str;
@end

@implementation NSMenu (Local)
- (void)setMenuName:(NSString *)str { _name = str; } // Hidden Interface

@end


enum {
    menu_item, menu_self, menu_submenu, menu_bar
};

typedef struct {
    NSString *title;
    NSString *shortcut;
    NSString *selector;
    int     kind;
    id      submenu;
} itemdata;

@implementation MyViewerCtrl

// 지역 메소드

- (NSMenu *)newMenuWithTitle:(NSString *)title
name:(NSString *)name items:(itemdata *)itemdata
{
    NSMenu *menu;
    int i;
    
    menu = [[NSMenu alloc] initWithTitle: NSLocalizedString(title, "")];
    if (name)
        [menu setMenuName:name];
    for (i = 0; itemdata[i].title != nil; i++) {
        if (itemdata[i].kind == menu_bar)
             [menu addItem:[NSMenuItem separatorItem]];
        else {
            id item;
            NSString *str = NSLocalizedString(itemdata[i].title, "");
            SEL sel = NSSelectorFromString(itemdata[i].selector);
            item = [menu addItemWithTitle:str action:sel keyEquivalent:itemdata[i].shortcut];
            if (itemdata[i].kind == menu_submenu)
                [item setSubmenu: itemdata[i].submenu];
            else if (itemdata[i].kind == menu_self)
                [item setTarget: self];
            // 메뉴 아이템 타겟이 nil일 경우, 첫번째 리스폰더.
        }
    }
    return menu;
}

- (void)setupMainMenu
{
    NSMenu *menu, *submenu;
    NSString *str, *appname;
    NSBundle *bundle = [NSBundle mainBundle];
    static itemdata appitems[] = {
        { nil, @"h", @"hide", menu_item, nil },
        { nil, @"q", @"terminate", menu_item, nil },
        [ nil, nil, nil, 0, nil ]
    };
    static itemdata fileitems[] = {
        { @"Open File...", @"o", @"openFile:", menu_self, nil },
        { @"Inspector...", @"i", @"activateInspector:", menu_self, nil },
        { @"", @"", NULL, menu_self, nil },
        { @"Auto Resize", @"", @"toggleAutoResize:", menu_self, nil }, // index = 3
        { nil, nil, nil, 0, nil }
    };
    static itemdata edititems[] = {
        { @"Undo", @"z", @"undo:", menu_item, nil },
        { @"Redo", @"Z", @"redo:", menu_item, nil },
        { @"", @"", NULL, menu_item, nil },
        { @"Copy", @"c", @"copy:", menu_item, nil },
        { @"Shrink", @"-", @"shrink:", menu_item, nil },
        { nil, nil, nil, 0, nil }
    };
    static itemdata winitems[] = {
        { @"Miniaturize", @"m", @"performMiniaturize:", menu_item, nil },
        { @"Close", @"w", @"performClose:", menu_item, nil },
        { nil, nil, nil, 0, nil }
    };
    static itemdata mainmenu[] = {
        { nil, @"", nil, menu_submenu, nil }, // App. Name is added.
        { @"File", @"", nil, menu_submenu, nil },
        { @"Edit", @"", nil, menu_submenu, nil },
        { @"Window", @"", nil, menu_submenu, nil },
        { nil, nil, nil, 0, nil }
    };
    
    appname = [bundle objectForInfoDictionaryKey:@"CFBundleName"];
    if (appname == nil)
        appname = @"MyViewer";
    
    str = NSLocalizedString(@"Hide %@", "Hide");
    appitems[0].title = [NSString stringWithFormat:str, appname];
    str = NSLocalizedString(@"Quit %@", "Quit");
    appitems[1].title = [NSString stringWithFormat:str, appname];
    
    mainmenu[0].title = appname;
    mainmenu[0].submenu = [self newMenuWithTitle:appname name:@"NSAppleMenu" items:appitems];
    submenu = [self newMenuWithTitle:@"File" name:nil items:fileitems];
    autoResizeItem = [submenu itemAtIndex:3];
    mainmenu[1].submenu = submenu;
    mainmenu[2].submenu = [self newMenuWithTitle:@"Edit" name:nil items:edititems];
    mainmenu[3].submenu = [self newMenuWithTitle:@"Window" name:nil items:winitems];
    menu = [self newMenuWithTitle:appname name:@"NSMainmenu" items:mainmenu];

    [NSApp setMainMenu: menu];
    [NSApp setWindowsMenu: mainmenu[3].submenu];
    
}

- (void)openFile:(id)sender
{
    NSArray *fileTypes = [NSImage imageFileTypes];
    NSOpenPanel *oPanel = [NSOpenPanel openPanel];
    NSArray *filesToOpen;
    NSString *aFile;
    static NSString *currentDir = nil;
    int result;
    
    if (currentDir == nil)
        currentDir = NSHomeDirectory();
    [oPanel setAllowsMultipleSelection:YES];
    result = [oPanel runModalForDirectory:currentDir file:nil types:fileTypes];
    if (result != NSOKButton)
        return; // Cancel
    currentDir = [oPanel directory];
    filesToOpen = [oPanel filenames];
    for (aFile in filesToOpen)
        (void)[[WinCtrl alloc] initWithFile:aFile];
}

- (void)activateInspector:(id)sender
{
    static Class inspectorClass = Nil;
    NSBundle *bundle;
    NSString *path;
    
    if (inspectorClass == nil) {
        path = [[NSBundle mainBundle] pathForResource:@"Inspecctor" ofType:@"bundle"];
        if ((bundle = [NSBundle bundleWithPath: path]) == nil)
            return; // ERROR!!
        inspectorClass = [bundle classNamed:@"MyInspector"];
    }
    (void)[inspectorClass sharedInstance];
}

- (void)toggleAutoResize:(id)sender
{
    BOOL newState = ([sender state] != NSOnState);
    [WinCtrl setAutoResize: newState];
    [sender setState:(newState ? NSOnState : NSOffState)];
    [[NSUserDefaults standardUserDefaults] setBool:newState forKey:AutoResizeKey];
}


// 델리게이트 메시지

- (void)applicationDidfinishLaunching:(NSNotification *)aNotification
{
    BOOL flag = [[NSUserDefaults standardUserDefaults] boolForKey:AutoResizeKey];
    [WinCtrl setAutoResize: flag];
    [autoResizeItem setState:(flag ? NSOnState : NSOffState)];
}

// 델리게이트 메시지

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


@end


