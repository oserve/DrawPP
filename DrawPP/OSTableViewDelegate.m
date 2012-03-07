//
//  OSTableViewDelegate.m
//  DrawPP
//
//  Created by olivier on 03/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import "OSTableViewDelegate.h"
#import "OSChannelEventView.h"
#import "OSChannel.h"

@implementation OSTableViewDelegate

@synthesize dataSource = _dataSource;


- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	OSChannelEventView * channelView = [tableView makeViewWithIdentifier:@"channelView" owner:self];
    if(!channelView){
		channelView = [[[OSChannelEventView alloc] init] autorelease];
        channelView.identifier = @"channelView";
        channelView.stringValue = @"yo baby";
        channelView.textColor = [NSColor blueColor];
	}
	return channelView;    
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return [self.dataSource numberOfChannelsInPulseProgram];
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 150;
}

-(NSString *)description{
    return @"Delegate for OSPulseProgramView.";
}

@end
