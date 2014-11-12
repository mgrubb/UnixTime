//
//  PreferencesWindowController.h
//  UnixTime
//
//  Created by Michael Grubb on 11/11/14.
//  Copyright (c) 2014 Michael Grubb. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferencesWindowController : NSWindowController
{
    NSUserDefaults *_defaults;
    NSDictionary *_appInfo;
}

@property (weak) IBOutlet NSTextField *versionLabel;
@property (weak) IBOutlet NSTextField *copyrightLabel;
@property (weak) IBOutlet NSButton *launchAtLogin;
@property (weak) IBOutlet NSTextField *lastupdateLabel;
@property (unsafe_unretained) IBOutlet NSTextView *creditsView;

- (IBAction)changeLaunchAtLogin:(NSButton *)sender;
@end
