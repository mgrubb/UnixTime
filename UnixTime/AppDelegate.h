//
//  AppDelegate.h
//  UnixTime
//
//  Created by Michael Grubb on 11/6/14.
//  Copyright (c) 2014 Michael Grubb. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate>
{
    NSDate *_currentDate;
    NSTimer *_currentTimer;
    NSStatusItem *unixTimeStatusItem;
    __weak NSUserDefaults *_defaults;
}

@property (weak) IBOutlet NSMenu *statusMenu;
@property (weak) IBOutlet NSMenuItem *epochTime;
@property (weak) IBOutlet NSMenuItem *epochDay;
@property (weak) IBOutlet NSMenuItem *launchAtLogin;

- (IBAction)copyItem:(NSMenuItem *)sender;
- (IBAction)changeLaunchAtLogin:(NSMenuItem *)sender;

@end

