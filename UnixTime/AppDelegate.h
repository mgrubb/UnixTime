//
//  AppDelegate.h
//  UnixTime
//
//  Created by Michael Grubb on 11/6/14.
//  Copyright (c) 2014 Michael Grubb. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PreferencesWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate>
{
    NSDate *_currentDate;
    NSTimer *_currentTimer;
    NSStatusItem *unixTimeStatusItem;
    PreferencesWindowController *_prefPane;
}

@property (weak) IBOutlet NSMenu *statusMenu;
@property (weak) IBOutlet NSMenuItem *epochTime;
@property (weak) IBOutlet NSMenuItem *epochDay;

- (IBAction)copyItem:(NSMenuItem *)sender;
- (IBAction)showPreferencePane:(id)sender;
@end