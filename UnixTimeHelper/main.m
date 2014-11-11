//
//  main.m
//  UnixTimeHelper
//
//  Created by Michael Grubb on 11/10/14.
//  Copyright (c) 2014 Michael Grubb. All rights reserved.
//

#import <Cocoa/Cocoa.h>

int main(int argc, const char * argv[])
{
    @autoreleasepool {
            BOOL alreadyRunning = NO;
            BOOL isActive = NO;
            NSArray *running = [[NSWorkspace sharedWorkspace] runningApplications];
            for (NSRunningApplication *app in running)
            {
                if ([app.bundleIdentifier isEqualToString:@"co.grubb.UnixTime"])
                {
                    alreadyRunning = YES;
                    isActive = [app isActive];
                    break;
                }
            }
            
            if (!alreadyRunning || !isActive)
            {
                NSString *path = [NSBundle mainBundle].bundlePath;
                NSMutableArray *pathComponents = [NSMutableArray arrayWithArray:path.pathComponents];
                NSIndexSet *compIdx = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(pathComponents.count - 3, 3)];
                [pathComponents removeObjectsAtIndexes:compIdx];
                [pathComponents addObjectsFromArray:@[@"MacOS", @"UnixTime"]];
                NSString *newPath = [NSString pathWithComponents:pathComponents];
                NSFileManager *fm = [NSFileManager defaultManager];
                if ([fm fileExistsAtPath:newPath])
                {
                    [[NSWorkspace sharedWorkspace] launchApplication:newPath];
                }
                else
                {
                    NSLog(@"Could not find UnixTime Application at: %@", newPath);
                }
                
            }
            [NSApp terminate:nil];
    }
    
    return 0;
}
