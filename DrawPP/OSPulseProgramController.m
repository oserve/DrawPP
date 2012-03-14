//
//  OSPulseProgramController.m
//  DrawPP
//
//  Created by Olivier Serve on 10/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import "OSPulseProgramController.h"

@implementation OSPulseProgramController

@synthesize pulseProgramView = _aTableView;
@synthesize dataSource = _dataSource;

#pragma mark UI Actions methods

- (IBAction)addChannel:(id)sender {
	[self.dataSource addChannelToProgram];
	while ([self.dataSource numberOfChannelEventsinChannel:[self.dataSource channelForPosition:0]] > [self.pulseProgramView numberOfColumns]) {
		NSTableColumn * newColumn = [[[NSTableColumn alloc] init] autorelease];
		[self.pulseProgramView addTableColumn:newColumn];
	}  
	[self.pulseProgramView reloadData];
}

- (IBAction)RemoveChannel:(id)sender {
	NSInteger channelPosition =[self.pulseProgramView selectedRow];
	if (channelPosition != -1) {
		[self.dataSource removeChannel:[self.dataSource channelForPosition:channelPosition]];
		[self.pulseProgramView reloadData];

	}
}

- (IBAction)AddPulse:(id)sender {
	NSInteger channelPosition =[self.pulseProgramView selectedRow];
	if (channelPosition != -1) {
		[self.dataSource addNewPulseToChannel:[self.dataSource channelForPosition:channelPosition] atPosition:[self.dataSource lastPositionAvailableOnChannel:[self.dataSource channelForPosition:channelPosition]]];
		
		NSTableColumn * newColumn = [[[NSTableColumn alloc] init] autorelease];
		[self.pulseProgramView addTableColumn:newColumn];
		[self.pulseProgramView reloadData];
	}
}

- (IBAction)AddDelay:(id)sender {
	NSInteger channelPosition =[self.pulseProgramView selectedRow];
	if (channelPosition != -1) {
		[self.dataSource addNewDelayToChannel:[self.dataSource channelForPosition:channelPosition] atPosition:[self.dataSource lastPositionAvailableOnChannel:[self.dataSource channelForPosition:channelPosition]]];
		
		NSTableColumn * newColumn = [[[NSTableColumn alloc] init] autorelease];
		[self.pulseProgramView addTableColumn:newColumn];
		[self.pulseProgramView reloadData];
	}	
}

- (IBAction)removeChannelEvent:(id)sender {
	NSInteger channelPosition =[self.pulseProgramView selectedRow];
	if (channelPosition != -1) {
		OSChannel * selectedChannel = [self.dataSource channelForPosition:channelPosition];
		NSInteger eventPosition = [self.pulseProgramView selectedColumn];
		if (eventPosition != -1) {
			OSChannelEvent * selectedEvent = [self.dataSource channelEventIChannel:selectedChannel atPosition:eventPosition];
			[self.dataSource removeChannelEvent:selectedEvent];
			[self.dataSource addNewDelayToChannel:selectedChannel atPosition:[self.dataSource lastPositionAvailableOnChannel:selectedChannel]];
		}
	}
	[self.pulseProgramView reloadData];
}

@end
