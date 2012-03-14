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
#import "OSDelay.h"

@implementation OSTableViewDelegate

@synthesize dataSource = _dataSource;
@synthesize pulseProgramController = _pulseProgramController;

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {	
	OSChannelEventView * channelView = [tableView makeViewWithIdentifier:@"channelView" owner:self];
    if(!channelView){
		channelView = [[[OSChannelEventView alloc] initWithFrame:NSMakeRect(0, 0, [self.dataSource channelEventIChannel:[self.dataSource channelForPosition:row] atPosition:[[tableView tableColumns] indexOfObject:tableColumn]].length.floatValue, 150)] autorelease];
	}
	channelView.identifier = @"channelView";

//	channelView.textColor = [NSColor blueColor];
	if ([[self.dataSource channelEventIChannel:[self.dataSource channelForPosition:row] atPosition:[[tableView tableColumns] indexOfObject:tableColumn]] isKindOfClass:[OSDelay class]]) {
//		channelView.stringValue = @"wait baby";
	}
	else{
//		channelView.stringValue = @"yo baby";
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
