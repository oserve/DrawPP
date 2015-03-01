//
//  AppDelegate.m
//  DrawPP
//
//  Created by olivier on 20/02/2015.
//  Copyright (c) 2015 MyOwnCompany. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSDictionary * channelDefaults = [NSDictionary
                                 dictionaryWithObjectsAndKeys:@"H", @"channelName",[NSNumber numberWithFloat:100],@"powerValue", [NSNumber numberWithFloat:100], @"lengthValue", [NSNumber numberWithFloat:100], @"piPulseLength", [NSNumber numberWithFloat:100], @"piPulsePower", @"1H", @"nucleus", nil];
    NSDictionary * channelEventDefaults = [NSDictionary dictionaryWithObjectsAndKeys:@"d1", @"delayName", @"p1", @"pulseName", @"pl1", @"powerName", nil];
    
    NSDictionary * appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:channelDefaults, @"channelDefaultsParameters", channelEventDefaults, @"channelEventDefaults",nil];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
