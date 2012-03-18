//
//  OSPulseProgramController.m
//  DrawPP
//
//  Created by Olivier Serve on 10/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import "OSPulseProgramController.h"
#import "OSChannelEvent+utilities.h"

@implementation OSPulseProgramController

@synthesize pulseProgramView = _pulseProgramView;
@synthesize dataSource = _dataSource;
@synthesize channelControllers = _channelControllers; //Implement new class channelController

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


- (void)addNewChannelEventInPulseProgramAtPosition:(NSInteger)position{
	NSArray * allChannels = [self.dataSource channelsInPulseProgram];
	for (OSChannel * aChannel in allChannels) {
		[self.dataSource addNewDelayToChannel:aChannel atPosition:position];
	}
	NSTableColumn * newColumn = [[[NSTableColumn alloc] init] autorelease];
	[self.pulseProgramView addTableColumn:newColumn];
	
}

- (IBAction)AddPulse:(id)sender {
	NSInteger channelPosition =[self.pulseProgramView selectedRow];
	if (channelPosition != -1) {
//		[self addNewChannelEventInPulseProgramAtPosition:channelPosition];
		//if pulse make it so, need to know the channel
		
		[self.pulseProgramView reloadData];
	}
}

- (IBAction)AddDelay:(id)sender {
	NSInteger channelPosition =[self.pulseProgramView selectedRow];
	if (channelPosition != -1) {
//		[self addNewChannelEventInPulseProgramAtPosition:channelPosition];		
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
