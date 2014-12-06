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

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (![self numberOfChannelsInPulseProgram]){
            [self addChannelWithName:@"New Channel"];
        }
    }
    return self;
}

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

    return [aChannel.channelEvents sortedArrayUsingDescriptors:[NSArray arrayWithObject:channelEventDescriptor]];
}

- (NSInteger)numberOfChannelEventsInChannel:(OSChannel *)aChannel{
	return [[self channelEventsInChannel:aChannel] count];
}

- (NSInteger)numberOfChannelEvents{
    if (self.numberOfChannelsInPulseProgram) {
        return [[self channelEventsInChannel:[self.channelsInPulseProgram lastObject]] count];
    } else {
        return 0;
    }
}

- (OSChannelEvent *)channelEventInChannel:(OSChannel *)aChannel atPosition:(NSUInteger)position{
    OSChannelEvent * theChannelEvent = nil;
    if (position < [[self channelEventsInChannel:aChannel] count]) {
        theChannelEvent = [[self channelEventsInChannel:aChannel] objectAtIndex:position];
    }
    return theChannelEvent;
}

#pragma mark Model management methods

- (NSInteger)lastPositionAvailableOnChannel:(OSChannel *)channel{
	return [[self channelEventsInChannel:channel] count];
}

#pragma mark Creation of new elements

-(void)insertNewChannelEvent:(OSChannelEvent *)anEvent InChannel:(OSChannel *)aChannel atPosition:(NSUInteger)position{
    NSArray * allEvents = [self channelEventsInChannel:aChannel];
    for (OSChannelEvent * event in allEvents) {
        if (event.positionOnChannel.integerValue > position) {
            event.positionOnChannel = [NSNumber numberWithInteger:event.positionOnChannel.integerValue +1 ];
        }
    }
    anEvent.positionOnChannel = [NSNumber numberWithInteger:position];
    anEvent.channel = aChannel;
}

- (OSLength *)lengthWithName:(NSString *)name andLength:(NSNumber *)aLength{
    NSFetchRequest * lengthRequest = [NSFetchRequest fetchRequestWithEntityName:@"Length"];
    NSArray * lengths = [self.managedObjectContext executeFetchRequest:lengthRequest error:nil];
    OSLength * theLength;
    for (OSLength * existingLength in lengths) {
        if ([existingLength.name  isEqualToString:name]) {
            theLength = existingLength;
            break;
        }
    }
    if (theLength == nil) {
        theLength = [NSEntityDescription insertNewObjectForEntityForName:@"Length" inManagedObjectContext:self.managedObjectContext];
        theLength.duration = aLength;
        theLength.name = name;
    }
    return theLength;
}

- (OSPowerLevel *)powerLevelWithName:(NSString *)name andLevel:(NSNumber *)aPowerLevel{
    NSFetchRequest * powerLevelRequest = [NSFetchRequest fetchRequestWithEntityName:@"PowerLevel"];
    NSArray * powerLevels = [self.managedObjectContext executeFetchRequest:powerLevelRequest error:nil];
    OSPowerLevel * thePowerLevel;
    for (OSPowerLevel * existingPowerLevel in powerLevels) {
        if ([existingPowerLevel.name isEqualToString:name]) {
            thePowerLevel = existingPowerLevel;
            break;
        }
    }
    if (thePowerLevel == nil) {
        thePowerLevel = [NSEntityDescription insertNewObjectForEntityForName:@"PowerLevel" inManagedObjectContext:self.managedObjectContext];
        thePowerLevel.power = aPowerLevel;
        thePowerLevel.name = name;
    }
    return thePowerLevel;
}

- (void)addNewPulseToChannel:(OSChannel *)aChannel atPosition:(NSInteger)position withLength:(OSLength *)aLength Power:(OSPowerLevel *)aPower{

    OSChannelEvent * aPulse = [NSEntityDescription insertNewObjectForEntityForName:@"ChannelEvent" inManagedObjectContext:self.managedObjectContext];
    aPulse.length = aLength;
    aPulse.powerLevel = aPower;
    
    [self insertNewChannelEvent:aPulse InChannel:aChannel atPosition:position];
    for (OSChannel * existingChannel in self.channelsInPulseProgram) {
        if (existingChannel != aChannel) {
            if ([self numberOfChannelEventsInChannel:aChannel] != [self numberOfChannelEventsInChannel:aChannel]) {
                [self addNewDelayToChannel:existingChannel atPosition:position withLength:aLength];
            }
        }
    }
    
}

- (void)addNewDelayToChannel:(OSChannel *)channel atPosition:(NSInteger)position withLength:(OSLength *)aLength
{
    [self addNewPulseToChannel:channel atPosition:position withLength:aLength Power:[self powerLevelWithName:@"zero" andLevel:[NSNumber numberWithFloat:0]]];
}


- (void)addChannelWithName:(NSString*)aChannelName{
	NSInteger newChannelPosition = [[self channelsInPulseProgram] count];

	OSChannel * aChannel = [NSEntityDescription insertNewObjectForEntityForName:@"Channel" inManagedObjectContext:self.managedObjectContext];
	aChannel.positionOnGraph = [NSNumber numberWithInteger:newChannelPosition];
	aChannel.name = aChannelName;

	if (!newChannelPosition) {
		aChannel.isAcquisitionChannel = [NSNumber numberWithBool:YES];
		[self addNewDelayToChannel:aChannel atPosition:0 withLength:[self lengthWithName:@"d1" andLength:[NSNumber numberWithFloat:DEFAULT_LENTGH]]];
		[self addNewPulseToChannel:aChannel atPosition:1 withLength:[self lengthWithName:@"p1" andLength:[NSNumber numberWithFloat:DEFAULT_LENTGH]] Power:[self powerLevelWithName:@"pl1" andLevel:[NSNumber numberWithFloat:DEFAULT_POWER]]];
        [self addNewDelayToChannel:aChannel atPosition:0 withLength:[self lengthWithName:@"d1" andLength:[NSNumber numberWithFloat:DEFAULT_LENTGH]]];
	}

	else {
		NSInteger eventPosition = 0;
        for (OSChannelEvent * anEvent in [self channelEventsInChannel:[self channelForPosition:0]]) {
            [self addNewDelayToChannel:aChannel atPosition:eventPosition withLength:anEvent.length];
            eventPosition++;
        }
	}
}

#pragma mark Deletion of elements

- (void)removeChannelEvent:(OSChannelEvent *)aChannelEvent{
    NSFetchRequest * lentghRequest = [NSFetchRequest fetchRequestWithEntityName:@"Length"];
    NSArray * lentghsBefore = [self.managedObjectContext executeFetchRequest:lentghRequest error:nil];
	[self.managedObjectContext deleteObject:aChannelEvent];
    NSArray * lentghsAfter = [self.managedObjectContext executeFetchRequest:lentghRequest error:nil];
    //TODO : Must remove channelevent in all channels
	
}

- (void)removeChannel:(OSChannel *)channel{
    while ([channel.channelEvents count]) {
        [self removeChannelEvent:[channel.channelEvents anyObject]];
    }

   [self.managedObjectContext deleteObject:channel];
}

#pragma mark Move elements

- (void)moveChannelEvent:(OSChannelEvent *)aChannelEvent ToPosition:(NSInteger)position{
    for (OSChannel * aChannel in [self channelsInPulseProgram]) {
        NSMutableArray * allEventsInChannel = [[self channelEventsInChannel:aChannel] mutableCopy];
//        OSChannel * currentChannel = aChannelEvent.channel;
        //Resort channelEvents in currentChannel
        [allEventsInChannel removeObject:aChannelEvent];
        [allEventsInChannel insertObject:aChannelEvent atIndex:position];//Leave the sorting to apple's experts
        NSInteger newPosition = 0;
        for (OSChannelEvent * event in allEventsInChannel) {
            event.positionOnChannel = [NSNumber numberWithInteger:newPosition];
            newPosition++;
        }
//        currentChannel.channelEvents = [NSSet setWithArray:allEventsInChannel];

    }
	//Should also adjust the length to other events at the same position on other channels if any

//	if ([[self channelsInPulseProgram] count] > 1) {
//		for (OSChannel * aChannel in [self channelsInPulseProgram]) {
//			if (aChannel != currentChannel) {
//				aChannelEvent.length.duration = [NSNumber numberWithInteger:[[[self channelEventsInChannel:aChannel] objectAtIndex:position] length]];
//                break;
//			}
//		}
//	}
}

- (void)moveChannelFromPosition:(NSInteger)previousPosition toPosition:(NSInteger)newPosition{

    if (newPosition >= 0 && newPosition <= [self numberOfChannelsInPulseProgram]) {
        NSMutableArray * allChannels = [[self channelsInPulseProgram] mutableCopy];
        OSChannel * movingChannel = [self channelForPosition:previousPosition];
        [allChannels removeObject:movingChannel];
        [allChannels insertObject:movingChannel atIndex:newPosition];
        NSInteger newIndex = 0;
        for (OSChannel * aChannel in allChannels) {
            aChannel.positionOnGraph = [NSNumber numberWithInteger:newIndex];
            newIndex++;
        }
    }
}

- (NSArray *)channelNames{
    NSMutableArray * names = [[NSMutableArray alloc] init];
    for (OSChannel * channel in [self channelsInPulseProgram]) {
        if (![names containsObject:channel.name]) {
            [names addObject:channel.name];
        }
    }
    return [NSArray arrayWithArray:names];
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
