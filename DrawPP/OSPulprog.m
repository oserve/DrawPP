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

#pragma mark initialization and properties
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


- (OSPowerLevel *)zeroPower{
        return [self powerLevelWithName:@"Zero" andLevel:[NSNumber numberWithFloat:0]];
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

#pragma mark Channels Management

- (void)addChannelWithName:(NSString *)aChannelName{
    NSInteger newChannelPosition = self.numberOfChannelsInPulseProgram;
    
    OSChannel * aChannel = [NSEntityDescription insertNewObjectForEntityForName:@"Channel" inManagedObjectContext:self.managedObjectContext];
    aChannel.positionOnGraph = [NSNumber numberWithInteger:newChannelPosition];
    aChannel.name = aChannelName;
    aChannel.piPulseLength = [NSNumber numberWithFloat:DEFAULT_LENTGH];
    aChannel.piPulsePower = [NSNumber numberWithFloat:DEFAULT_POWER];
    aChannel.nucleus = @"1H";
    
    if (!newChannelPosition) {
        aChannel.isAcquisitionChannel = [NSNumber numberWithBool:YES];
        [self addNewDelayToChannel:aChannel atPosition:0 withLength:[self lengthWithName:@"d1" andDuration:[NSNumber numberWithFloat:DEFAULT_LENTGH]]];
        [self addNewPulseToChannel:aChannel atPosition:1 withLength:[self lengthWithName:@"p1" andDuration:[NSNumber numberWithFloat:DEFAULT_LENTGH]] Power:[self powerLevelWithName:@"pl1" andLevel:[NSNumber numberWithFloat:DEFAULT_POWER]]];
        [self addNewDelayToChannel:aChannel atPosition:2 withLength:[self lengthWithName:@"d1" andDuration:[NSNumber numberWithFloat:DEFAULT_LENTGH]]];
    }
    
    else {
        NSUInteger eventPosition = 0;
        for (OSChannelEvent * anEvent in [self channelEventsInChannel:[self channelForPosition:0]]) {
            [self addNewDelayToChannel:aChannel atPosition:eventPosition withLength:anEvent.length];
            eventPosition++;
        }
    }
}

- (void)removeChannel:(OSChannel *)channel{
    while ([channel.channelEvents count]) {
        [self removeChannelEvent:[channel.channelEvents anyObject]];
    }
    
    [self.managedObjectContext deleteObject:channel];
}

- (void)moveChannelFromPosition:(NSInteger)previousPosition toPosition:(NSInteger)newPosition{
    
    if (newPosition >= 0 && newPosition <= [self numberOfChannelsInPulseProgram]) {
        NSMutableArray * allChannels = [[self channelsInPulseProgram] mutableCopy];
        OSChannel * movingChannel = [self channelForPosition:previousPosition];
        [allChannels removeObjectAtIndex:previousPosition];
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

#pragma mark Channel Events Management

-(void)insertChannelEvent:(OSChannelEvent *)anEvent InChannel:(OSChannel *)aChannel atPosition:(NSUInteger)position{
    NSArray * allEvents = [self channelEventsInChannel:aChannel];
    for (OSChannelEvent * event in allEvents) {
        if (event.positionOnChannel.integerValue > position) {
            event.positionOnChannel = [NSNumber numberWithInteger:event.positionOnChannel.integerValue +1 ];
        }
    }
    anEvent.positionOnChannel = [NSNumber numberWithInteger:position];
    anEvent.channel = aChannel;
}

- (void)addChannelEventWithName:(NSString*)anEventName{
    
}


- (void)addNewPulseToChannel:(OSChannel *)aChannel atPosition:(NSInteger)position withLength:(OSLength *)aLength Power:(OSPowerLevel *)aPower{
    
    OSChannelEvent * aPulse = [NSEntityDescription insertNewObjectForEntityForName:@"ChannelEvent" inManagedObjectContext:self.managedObjectContext];
    aPulse.length = aLength;
    aPulse.powerLevel = aPower;
    
    [self insertChannelEvent:aPulse InChannel:aChannel atPosition:position];
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
    [self addNewPulseToChannel:channel atPosition:position withLength:aLength Power:self.zeroPower];
}

- (void)removeChannelEvent:(OSChannelEvent *)aChannelEvent{
    [self.managedObjectContext deleteObject:aChannelEvent];
    //TODO : Must remove channelevent in all channels
    
}

- (void)moveChannelEventFromPosition:(NSInteger)previousPosition ToPosition:(NSInteger)newPosition{
    if (newPosition >= 0 && newPosition <= [self numberOfChannelEvents]) {
        
        for (OSChannel * aChannel in [self channelsInPulseProgram]) {
            NSMutableArray * allEventsInChannel = [[self channelEventsInChannel:aChannel] mutableCopy];
            OSChannelEvent * movingEvent = [allEventsInChannel objectAtIndex:previousPosition];
            //Resort channelEvents in currentChannel
            [allEventsInChannel removeObjectAtIndex:previousPosition];
            [allEventsInChannel insertObject:movingEvent atIndex:newPosition];//Leave the sorting to apple's experts
            NSInteger newIndex = 0;
            for (OSChannelEvent * event in allEventsInChannel) {
                event.positionOnChannel = [NSNumber numberWithInteger:newIndex];
                newIndex++;
            }
            
        }
    }
}

#pragma mark Lengths Management

- (OSLength *)lengthWithName:(NSString *)name andDuration:(NSNumber *)duration{
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
        theLength.duration = duration;
        theLength.name = name;
    }
    return theLength;
}

#pragma mark PowerLevels Management

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
