//
//  OSChannelEventsArrayController.m
//  DrawPP
//
//  Created by Olivier Serve on 23/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import "OSChannelEventsArrayController.h"

@implementation OSChannelEventsArrayController

@synthesize channelEventsViews = _channelEventsViews;
@synthesize eventsDataSource = _eventsDataSource;

//Should add a way of communication between this class and the tableViewDelegate, protocol probably

-(NSMutableDictionary *)channelEventsViews{
	if (!_channelEventsViews) {
		_channelEventsViews = [[NSMutableDictionary alloc] init];
	}
	return _channelEventsViews;
}

-(void)addChannelEventView:(NSView *)aView forChannelPosition:(NSInteger)channelPosition atPosition:(NSInteger)eventPosition{
	NSDictionary * positionsforView = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:channelPosition], @"channelPosition",[NSNumber numberWithInteger:eventPosition], @"eventPosition", nil];
	[self.channelEventsViews setObject:positionsforView forKey:aView];
//	add channelEvent in model now
}

-(void)removeChannelEventsView:(NSView *)aView{
	[self.channelEventsViews removeObjectForKey:aView];
//remove channelEvent in model now
}

//- (void)addNewChannelEventInPulseProgramAtPosition:(NSInteger)position{
//	NSArray * allChannels = [self.dataSource channelsInPulseProgram];
//	for (OSChannel * aChannel in allChannels) {
//		[self.dataSource addNewDelayToChannel:aChannel atPosition:position];
//	}
//	NSTableColumn * newColumn = [[[NSTableColumn alloc] init] autorelease];
//	[self.pulseProgramView addTableColumn:newColumn];
//	
//}
//
//- (IBAction)AddPulse:(id)sender {
//	NSInteger channelPosition =[self.pulseProgramView selectedRow];
//	if (channelPosition != -1) {
//		//		[self addNewChannelEventInPulseProgramAtPosition:channelPosition];
//		//if pulse make it so, need to know the channel
//		
//		[self.pulseProgramView reloadData];
//	}
//}
//
//- (IBAction)AddDelay:(id)sender {
//	NSInteger channelPosition =[self.pulseProgramView selectedRow];
//	if (channelPosition != -1) {
//		//		[self addNewChannelEventInPulseProgramAtPosition:channelPosition];		
//		[self.pulseProgramView reloadData];
//	}	
//}
//
//- (IBAction)removeChannelEvent:(id)sender {
//	NSInteger channelPosition =[self.pulseProgramView selectedRow];
//	if (channelPosition != -1) {
//		OSChannel * selectedChannel = [self.dataSource channelForPosition:channelPosition];
//		NSInteger eventPosition = [self.pulseProgramView selectedColumn];
//		if (eventPosition != -1) {
//			OSChannelEvent * selectedEvent = [self.dataSource channelEventIChannel:selectedChannel atPosition:eventPosition];
//			[self.dataSource removeChannelEvent:selectedEvent];
//			[self.dataSource addNewDelayToChannel:selectedChannel atPosition:[self.dataSource lastPositionAvailableOnChannel:selectedChannel]];
//		}
//	}
//	[self.pulseProgramView reloadData];
//}

@end
