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
#import "OSLength.h"
#import "OSChannelEvent+utilities.h"

@implementation OSTableViewDelegate

@synthesize dataSource = _dataSource;
@synthesize pulseProgramController = _pulseProgramController;

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {	
	OSChannelEventView * channelView = [tableView makeViewWithIdentifier:@"channelView" owner:self];
    if(!channelView){
		channelView = [[OSChannelEventView alloc] initWithFrame:NSMakeRect(0, 0, [self.dataSource channelEventIChannel:[self.dataSource channelForPosition:row] atPosition:[[tableView tableColumns] indexOfObject:tableColumn]].length.duration.floatValue, 150)];
	}
	channelView.identifier = @"channelView";

	channelView.tempField.textColor = [NSColor blueColor];
	if ([[self.dataSource channelEventIChannel:[self.dataSource channelForPosition:row] atPosition:[[tableView tableColumns] indexOfObject:tableColumn]] isDelay]) {
		channelView.tempField.stringValue = @"wait baby";
	}
	else{
		channelView.tempField.stringValue = @"yo baby";
	}
	[[tableColumn headerCell] setStringValue:@""];
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
