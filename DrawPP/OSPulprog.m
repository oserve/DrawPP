//
//  OSPulprog.m
//  DrawPP
//
//  Created by olivier on 11/01/12.
//  Copyright 2012 IMS. All rights reserved.
//

#import "OSPulprog.h"

@implementation OSPulprog

#define DEFAULT_LENTGH 100.0
#define DEFAULT_POWER 10.0

#pragma mark OSPulseProgramDataSourceProtocol Protocol methods

- (NSArray *)channelsInPulseProgram{
	NSSortDescriptor * channelDescriptor = [[NSSortDescriptor alloc] initWithKey:@"positionOnGraph" ascending:YES];
	NSFetchRequest * channelRequest = [NSFetchRequest fetchRequestWithEntityName:@"Channel"];
	channelRequest.sortDescriptors = [NSArray arrayWithObject:channelDescriptor];
	NSError * error = nil;
	NSArray * channels = [self.managedObjectContext executeFetchRequest:channelRequest error:&error];
	return channels;
}

- (OSChannel *)channelForPosition:(NSUInteger)position{
    OSChannel * resultChannel = nil;
    if (position <= [self numberOfChannelsInPulseProgram]) {
        resultChannel = [[self channelsInPulseProgram] objectAtIndex:position];
    }
    return resultChannel;
}

- (NSInteger)numberOfChannelsInPulseProgram{
    return [[self channelsInPulseProgram] count];
}

- (NSArray *)channelEventsInChannel:(OSChannel *)aChannel{
    NSSortDescriptor * channelEventDescriptor = [[NSSortDescriptor alloc] initWithKey:@"positionOnChannel" ascending:YES];
	NSFetchRequest * channelEventRequest = [NSFetchRequest fetchRequestWithEntityName:@"ChannelEvent"];
	channelEventRequest.sortDescriptors = [NSArray arrayWithObject:channelEventDescriptor];
	NSPredicate * channelPredicate = [NSPredicate predicateWithFormat:@"channel = %@",aChannel];
	channelEventRequest.predicate = channelPredicate;
	NSError * error = nil;
	return [self.managedObjectContext executeFetchRequest:channelEventRequest error:&error];    
}

- (NSInteger)numberOfChannelEventsInChannel:(OSChannel *)aChannel{
	return [[self channelEventsInChannel:aChannel] count];
//    return 2;
}

- (NSInteger)numberOfChannelEvents{
    if (self.numberOfChannelsInPulseProgram) {
        return [self numberOfChannelEventsInChannel:[self.channelsInPulseProgram objectAtIndex:0]];
    } else {
        return 0;
    }
    //    return 2;
}

- (OSChannelEvent *)channelEventInChannel:(OSChannel *)aChannel atPosition:(NSUInteger)position{
    OSChannelEvent * theChannelEvent = nil;
    if (position < [[self channelEventsInChannel:aChannel] count]) {
        theChannelEvent = [[self channelEventsInChannel:aChannel] objectAtIndex:position];
    }
    return theChannelEvent;
}

-(void)insertNewChannelEvent:(OSChannelEvent *)anEvent InChannel:(OSChannel *)aChannel atPosition:(NSUInteger)position{
	NSArray * allEvents = [self channelEventsInChannel:aChannel];
	for (OSChannelEvent * event in allEvents) {
		if (event.positionOnChannel.integerValue > position) {
			event.positionOnChannel = [NSNumber numberWithInteger:event.positionOnChannel.integerValue +1 ];
		}
	}
	OSLength * aLength = [NSEntityDescription insertNewObjectForEntityForName:@"Length" inManagedObjectContext:self.managedObjectContext];
	aLength.duration = [NSNumber numberWithFloat:DEFAULT_LENTGH];
	anEvent.length = aLength;
	anEvent.positionOnChannel = [NSNumber numberWithInteger:position];
	anEvent.channel = aChannel;
}

#pragma mark Model management methods

- (NSInteger)lastPositionAvailableOnChannel:(OSChannel *)channel{
	NSSortDescriptor * channelEventDescriptor = [[NSSortDescriptor alloc] initWithKey:@"positionOnChannel" ascending:YES];
	NSFetchRequest * channelEventRequest = [NSFetchRequest fetchRequestWithEntityName:@"ChannelEvent"];
	channelEventRequest.sortDescriptors = [NSArray arrayWithObject:channelEventDescriptor];
	NSPredicate * channelPredicate = [NSPredicate predicateWithFormat:@"channel = %@",channel];
	channelEventRequest.predicate = channelPredicate;
	NSError * error = nil;
	NSArray * channelEvents = [self.managedObjectContext executeFetchRequest:channelEventRequest error:&error];
	return [channelEvents count];
}

- (void)addNewDelayToChannel:(OSChannel *)channel atPosition:(NSInteger)position
{	
	OSChannelEvent * aDelay = [NSEntityDescription insertNewObjectForEntityForName:@"ChannelEvent" inManagedObjectContext:self.managedObjectContext];
	[self insertNewChannelEvent:aDelay InChannel:channel atPosition:position];
}

#pragma mark Creation of new elements

- (void)addNewPulseToChannel:(OSChannel *)channel atPosition:(NSInteger)position
{
	NSManagedObjectContext * moc = self.managedObjectContext;
	
	OSChannelEvent * aPulse = [NSEntityDescription insertNewObjectForEntityForName:@"ChannelEvent" inManagedObjectContext:moc];
	OSPowerLevel * aPowerLevel = [NSEntityDescription insertNewObjectForEntityForName:@"PowerLevel" inManagedObjectContext:moc];
	aPowerLevel.power = [NSNumber numberWithFloat:DEFAULT_POWER];
	aPulse.powerLevel = aPowerLevel;
	
//	OSPowerLevel * powerLevel = nil;
//	NSSet * powerLevels = channel.powerLevels;
//	if (![powerLevels count]) {
//		powerLevel = [NSEntityDescription insertNewObjectForEntityForName:@"PowerLevel" inManagedObjectContext:moc];
//		powerLevel.power = [NSNumber numberWithFloat:1.0];
//		powerLevel.channel = channel;
//		powerLevel.name = @"pl1";
//	}
//	else {
//		for (OSPowerLevel * aPowerLevel in powerLevels) {
//			if ([aPowerLevel.power floatValue] == 1.0) {
//				powerLevel = aPowerLevel;
//				break;
//			}
//		}
//	}
//	aPulse.powerLevel = powerLevel;
	[self insertNewChannelEvent:aPulse InChannel:channel atPosition:position];
	
}
- (void)addChannelToProgram{	
	NSInteger newChannelPosition = [[self channelsInPulseProgram] count];

	OSChannel * aChannel = [NSEntityDescription insertNewObjectForEntityForName:@"Channel" inManagedObjectContext:self.managedObjectContext];
	aChannel.positionOnGraph = [NSNumber numberWithInteger:newChannelPosition];
	aChannel.name = @"X";

	if (!newChannelPosition) {
		aChannel.isAcquisitionChannel = [NSNumber numberWithBool:YES];
		[self addNewDelayToChannel:aChannel atPosition:0];
		[self addNewPulseToChannel:aChannel atPosition:1];
		[self addNewDelayToChannel:aChannel atPosition:2];
	}

	else {
		NSInteger eventPosition = 0;
		for (eventPosition=0;eventPosition < [self lastPositionAvailableOnChannel:[[self channelsInPulseProgram] objectAtIndex:0]]; eventPosition++) {
			[self addNewDelayToChannel:aChannel atPosition:eventPosition];
		}
	}
}

#pragma mark Deletion of elements

- (void)removeChannelEvent:(OSChannelEvent *)aChannelEvent{
	[self.managedObjectContext deleteObject:aChannelEvent];
	
}

- (void)removeChannel:(OSChannel *)channel{
	[self.managedObjectContext deleteObject:channel];
}


#pragma mark Move elements

- (void)moveChannelEvent:(OSChannelEvent *)aChannelEvent ToPosition:(NSInteger)position{
	NSMutableArray * allEvents = [[self channelEventsInChannel:aChannelEvent.channel] mutableCopy];
	OSChannel * currentChannel = aChannelEvent.channel;
//Resort channelEvents in currentChannel
	[allEvents removeObject:aChannelEvent];
	[allEvents insertObject:aChannelEvent atIndex:position];//Leave the sorting to apple's experts
	NSInteger newPosition = 0;
	for (OSChannelEvent * event in allEvents) {
		event.positionOnChannel = [NSNumber numberWithInteger:newPosition];
		newPosition +=1;
	}
	//Should also adjust the length to other events at the same position on other channels if any

	if ([[self channelsInPulseProgram] count] > 1) {
		for (OSChannel * aChannel in [self channelsInPulseProgram]) {
			if (aChannel != currentChannel) {
				aChannelEvent.length.duration = [NSNumber numberWithInteger:[[[self channelEventsInChannel:aChannel] objectAtIndex:position] length]];
				break;
			}
		}
	}
	currentChannel.channelEvents = [NSSet setWithArray:allEvents];
}

- (void)moveChannel:(OSChannel *)channel toPosition:(NSInteger)position{
	
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
