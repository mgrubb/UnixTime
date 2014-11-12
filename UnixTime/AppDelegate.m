//
//  AppDelegate.m
//  UnixTime
//
//  Created by Michael Grubb on 11/6/14.
//  Copyright (c) 2014 Michael Grubb. All rights reserved.
//

#import "AppDelegate.h"
#import <ServiceManagement/ServiceManagement.h>

static NSString *kShouldStartAtLoginState = @"kShouldStartAtLoginState";

@interface AppDelegate ()
- (void)updateMenu;
@end

@implementation AppDelegate

- (void)updateMenu
{
    _currentDate = [NSDate date];
    NSTimeInterval t = _currentDate.timeIntervalSince1970;
    
    self.epochTime.title = [NSString stringWithFormat:@"%llu", (UInt64)t];
    self.epochDay.title = [NSString stringWithFormat:@"%llu", (UInt64)(t / 86400)];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSImage *iconImage = [NSImage imageNamed:@"statusIcon"];
    unixTimeStatusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [iconImage setTemplate:YES];
    unixTimeStatusItem.image = iconImage;
    unixTimeStatusItem.menu = self.statusMenu;
    [self updateMenu];
}

- (IBAction)copyItem:(NSMenuItem *)sender
{
    NSPasteboard *pb = [NSPasteboard generalPasteboard];
    [pb clearContents];
    [pb setString:sender.title forType:NSPasteboardTypeString];
}

- (void)menuWillOpen:(NSMenu *)menu
{
    [self updateMenu];
    _currentTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                     target:self
                                                   selector:@selector(updateMenu)
                                                   userInfo:nil
                                                    repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_currentTimer forMode:NSRunLoopCommonModes];
}

- (void)menuDidClose:(NSMenu *)menu
{
    if (_currentTimer)
    {
        [_currentTimer invalidate];
        _currentTimer = nil;
    }
}

- (IBAction)showPreferencePane:(id)sender
{
    if (!_prefPane)
    {
        _prefPane = [PreferencesWindowController new];
    }
    [_prefPane showWindow:self];
}

@end
