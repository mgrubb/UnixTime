//
//  PreferencesWindowController.m
//  UnixTime
//
//  Created by Michael Grubb on 11/11/14.
//  Copyright (c) 2014 Michael Grubb. All rights reserved.
//

#import "PreferencesWindowController.h"
#import <Sparkle/Sparkle.h>
#import <ServiceManagement/ServiceManagement.h>

static NSString *kLaunchAtLogin = @"kLaunchAtLogin";

@interface PreferencesWindowController ()

@end

@implementation PreferencesWindowController

- (instancetype)init
{
    self = [super initWithWindowNibName:@"PreferencesWindow"];
    if (!self)
    {
        return nil;
    }
    
    _defaults = [NSUserDefaults standardUserDefaults];
    [_defaults registerDefaults:@{kLaunchAtLogin: @NO,
                                  @"SUEnableAutomaticChecks": @YES,
                                  @"SUScheduledCheckInterval": @604800,
                                  @"SUAllowsAutomaticUpdates": @NO}];
    
    _appInfo = [[NSBundle mainBundle] infoDictionary];
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    NSDate *lastUpdate = [[SUUpdater sharedUpdater] lastUpdateCheckDate];
    NSString *creditPath = [[NSBundle mainBundle] pathForResource:@"Credits" ofType:@"rtf"];
    self.lastupdateLabel.stringValue = [NSDateFormatter localizedStringFromDate:lastUpdate
                                                                      dateStyle:NSDateFormatterLongStyle
                                                                      timeStyle:NSDateFormatterLongStyle];
    
    self.versionLabel.stringValue = [NSString stringWithFormat:@"%@ %@ (%@)",
                                     self.versionLabel.stringValue,
                                     [_appInfo objectForKey:@"CFBundleShortVersionString"],
                                     [_appInfo objectForKey:(__bridge NSString*)kCFBundleVersionKey]];
    
    self.copyrightLabel.stringValue = [_appInfo objectForKey:@"NSHumanReadableCopyright"];
    [self.creditsView.textStorage setAttributedString:[[NSAttributedString alloc] initWithPath:creditPath
                                                                            documentAttributes:nil]];
}

- (IBAction)changeLaunchAtLogin:(NSButton *)sender
{
    if ( !SMLoginItemSetEnabled(CFSTR("co.grubb.UnixTimeHelper"), sender.state == NSOnState) )
    {
        NSLog(@"Could not enable launch at login!");
        return;
    }
}
@end
