//
//  OSChannelViewDelegate.m
//  DrawPP
//
//  Created by olivier on 04/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import "OSChannelViewDelegate.h"
#import "OSChannelEventView.h"

@implementation OSChannelViewDelegate

@synthesize dataSource = _dataSource;

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	NSTextField *channelEventView = [tableView makeViewWithIdentifier:@"EventView" owner:self];
    if(!channelEventView){
		channelEventView = [[[NSTextField alloc] init] autorelease];
        channelEventView.identifier = @"EventView";
        channelEventView.stringValue = @"Yo baby";        
	}
	return channelEventView;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return [self.dataSource numberOfChannelEventViewsInChannelView:tableView];
}


@end
