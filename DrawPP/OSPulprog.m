//
//  OSPulprog.m
//  DrawPP
//
//  Created by olivier on 11/01/12.
//  Copyright 2012 IMS. All rights reserved.
//

#import "OSPulprog.h"

@implementation OSPulprog

@synthesize pulseProgramViewController = _pulseProgramViewController;

- (NSArray *)channelsInPulseProgram{
	NSSortDescriptor * channelDescriptor = [[NSSortDescriptor alloc] initWithKey:@"positionOnGraph" ascending:YES];
	NSFetchRequest * channelRequest = [NSFetchRequest fetchRequestWithEntityName:@"Channel"];
	channelRequest.sortDescriptors = [NSArray arrayWithObject:channelDescriptor];
	[channelDescriptor release];
	NSError * error = nil;
	NSArray * channels = [self.managedObjectContext executeFetchRequest:channelRequest error:&error];
	return channels;
}

#pragma mark PulseProgramViewDataSource Protocol methods

- (NSUInteger)numberOfChannelsInPulseProgramView:(OSPulseProgramView *)aPulseProgramView{
	return [[self channelsInPulseProgram] count];
}

- (OSChannel *)pulseProgramView:(OSPulseProgramView *)aPulseProgramView channelForPosition:(NSUInteger)position{
	return [[self channelsInPulseProgram] objectAtIndex:position];
}

+(NSInteger)lastPositionAvailableOnChannel:(OSChannel *)channel{
	NSSortDescriptor * channelEventDescriptor = [[NSSortDescriptor alloc] initWithKey:@"positionOnChannel" ascending:YES];
	NSFetchRequest * channelEventRequest = [NSFetchRequest fetchRequestWithEntityName:@"ChannelEvent"];
	channelEventRequest.sortDescriptors = [NSArray arrayWithObject:channelEventDescriptor];
	[channelEventDescriptor release];
	NSPredicate * channelPredicate = [NSPredicate predicateWithFormat:@"channel = %@",channel];
	channelEventRequest.predicate = channelPredicate;
	NSError * error = nil;
	NSArray * channelEvents = [channel.managedObjectContext executeFetchRequest:channelEventRequest error:&error];
	return [channelEvents count];
}

- (void)addNewDelayToChannel:(OSChannel *)channel atPosition:(NSInteger)position;
{	
	OSDelay * aDelay = [NSEntityDescription insertNewObjectForEntityForName:@"Delay" inManagedObjectContext:self.managedObjectContext];
	aDelay.channel =channel;
	aDelay.positionOnChannel = [NSNumber numberWithInteger:position];
	aDelay.length = [NSNumber numberWithFloat:1.0];
		
}

#pragma mark Creation of new elements

- (void)addNewPulseToChannel:(OSChannel *)channel atPosition:(NSInteger)position;
{
	NSManagedObjectContext * moc = self.managedObjectContext;
	
	OSPulse * aPulse = [NSEntityDescription insertNewObjectForEntityForName:@"Pulse" inManagedObjectContext:moc];
	aPulse.channel = channel;
	aPulse.positionOnChannel = [NSNumber numberWithInteger:position];
	aPulse.length = [NSNumber numberWithFloat:1.0];
	
	OSPowerLevel * powerLevel = nil;
	NSSet * powerLevels = channel.powerLevels;
	if (![powerLevels count]) {
		powerLevel = [NSEntityDescription insertNewObjectForEntityForName:@"PowerLevel" inManagedObjectContext:moc];
		powerLevel.power = [NSNumber numberWithFloat:1.0];
		powerLevel.channel = channel;
		powerLevel.name = @"pl1";
	}
	else {
		for (OSPowerLevel * aPowerLevel in powerLevels) {
			if ([aPowerLevel.power floatValue] == 1.0) {
				powerLevel = aPowerLevel;
				break;
			}
		}
	}
	aPulse.powerLevel = powerLevel;
	
}
- (void)addChannelToProgram{	
	NSInteger newChannelPosition = [[self channelsInPulseProgram] count];

	OSChannel * aChannel = [NSEntityDescription insertNewObjectForEntityForName:@"Channel" inManagedObjectContext:self.managedObjectContext];
	aChannel.positionOnGraph = [NSNumber numberWithInteger:newChannelPosition];
	aChannel.name = @"X";
	if (!newChannelPosition) {
		aChannel.isAcquisitionChannel = [NSNumber numberWithBool:YES];
	}
}

#pragma mark Deletion of elements

- (void)removeChannelEvent:(OSChannelEvent *)aChannelEvent{
	
}

- (void)removeChannel:(OSChannel *)channel{
	
}


#pragma mark Move elements

- (void)moveChannelEventToPosition:(OSChannelEvent *)aChannelEvent{
	
}

- (void)moveChannel:(OSChannel *)channel toPosition:(NSInteger)position{
	
}

#pragma mark UI Actions methods

- (IBAction)addChannel:(id)sender {
	[self addChannelToProgram];
	[self.pulseProgramViewController.view setNeedsDisplay:YES];
}

#pragma mark Nib methods

- (NSString *)windowNibName
{
	// Override returning the nib file name of the document
	// If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
	return @"OSPulprog";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
	[super windowControllerDidLoadNib:aController];
	// Add any code here that needs to be executed once the windowController has loaded the document's window.
}

@end
