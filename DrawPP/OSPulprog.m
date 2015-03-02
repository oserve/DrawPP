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

@synthesize channelController = _channelController;
@synthesize channelEventsController = _channelEventsController;
@synthesize powersController = _powersController;
@synthesize lengthsController = _lengthsController;

#pragma mark initialization and properties
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.channelController = [[OSChannelController alloc] initControllerWithContext:self.managedObjectContext];
        self.channelEventsController = [[OSChannelEventsController alloc] initControllerWithContext:self.managedObjectContext];
        self.powersController = [[OSPowerLevelsController alloc] initControllerWithContext:self.managedObjectContext];
        self.lengthsController = [[OSLengthsController alloc] initControllerWithContext:self.managedObjectContext];
        
        if (![self numberOfChannelsInPulseProgram]){
//            [self addChannelWithName:@"New Channel"];
            [self addChannelWithParameters:[NSDictionary dictionaryWithObjectsAndKeys:@"New Channel", @"name", nil]];
        }
    }
    return self;
}

#pragma mark OSPulseProgramDataSourceProtocol Protocol methods

- (NSArray *)channelsInPulseProgram{
	return self.channelController.channels;
}

- (OSChannel *)channelForPosition:(NSUInteger)position{
    return [self.channelController channelForPosition:position];
}

- (NSUInteger)numberOfChannelsInPulseProgram{
    return self.channelController.numberOfChannels;
}

- (NSArray *)channelEventsInChannel:(OSChannel *)aChannel{
    return [self.channelEventsController channelEventsInChannel:aChannel];
}

- (NSInteger)numberOfChannelEventsInChannel:(OSChannel *)aChannel{
	return [self.channelEventsController numberOfChannelEventsInChannel:aChannel];
}

- (NSUInteger)numberOfChannelEvents{
    if (self.numberOfChannelsInPulseProgram) {
        return [[self channelEventsInChannel:[self.channelsInPulseProgram lastObject]] count];
    } else {
        return 0;
    }
}

- (OSChannelEvent *)channelEventInChannel:(OSChannel *)aChannel atPosition:(NSUInteger)position{
        return [self.channelEventsController channelEventInChannel:aChannel atPosition:position];
}

#pragma mark Channels Management

- (void)addChannelWithParameters:(NSDictionary *)newChannelParameters{
    NSMutableDictionary * channelParameters = [newChannelParameters mutableCopy];
    NSUInteger newChannelPosition = self.numberOfChannelsInPulseProgram;
    [channelParameters setObject:[NSNumber numberWithInteger:newChannelPosition] forKey:@"positionOnGraph"];

    
    OSChannel * aChannel = [self.channelController newChannelWithParameters:channelParameters];

    if (!newChannelPosition) {
        aChannel.isAcquisitionChannel = [NSNumber numberWithBool:YES];
        [self addNewDelayToChannel:aChannel atPosition:0 withLength:[self.lengthsController lengthWithName:@"d1" andDuration:[NSNumber numberWithFloat:DEFAULT_LENTGH]]];
        [self addNewPulseToChannel:aChannel atPosition:1 withLength:[self.lengthsController lengthWithName:@"p1" andDuration:[NSNumber numberWithFloat:DEFAULT_LENTGH]] Power:[self.powersController powerLevelWithName:@"pl1" andLevel:[NSNumber numberWithFloat:DEFAULT_POWER]]];
        [self addNewDelayToChannel:aChannel atPosition:2 withLength:[self.lengthsController lengthWithName:@"d1" andDuration:[NSNumber numberWithFloat:DEFAULT_LENTGH]]];
    }
    
    else {
        NSUInteger eventPosition = 0;
        for (OSChannelEvent * anEvent in [self channelEventsInChannel:[self channelForPosition:0]]) {
            [self addNewDelayToChannel:aChannel atPosition:eventPosition withLength:anEvent.length];
            eventPosition++;
        }
    }

}

//- (void)addChannelWithName:(NSString *)aChannelName{
//
//
//    NSUInteger newChannelPosition = self.numberOfChannelsInPulseProgram;
//    
//    OSChannel * aChannel = [NSEntityDescription insertNewObjectForEntityForName:@"Channel" inManagedObjectContext:self.managedObjectContext];
//    aChannel.positionOnGraph = [NSNumber numberWithInteger:newChannelPosition];
//    aChannel.name = aChannelName;
//    aChannel.piPulseLength = [NSNumber numberWithFloat:DEFAULT_LENTGH];
//    aChannel.piPulsePower = [NSNumber numberWithFloat:DEFAULT_POWER];
//    aChannel.nucleus = @"1H";
//    
//    if (!newChannelPosition) {
//        aChannel.isAcquisitionChannel = [NSNumber numberWithBool:YES];
//        [self addNewDelayToChannel:aChannel atPosition:0 withLength:[self.lengthsController lengthWithName:@"d1" andDuration:[NSNumber numberWithFloat:DEFAULT_LENTGH]]];
//        [self addNewPulseToChannel:aChannel atPosition:1 withLength:[self.lengthsController lengthWithName:@"p1" andDuration:[NSNumber numberWithFloat:DEFAULT_LENTGH]] Power:[self.powersController powerLevelWithName:@"pl1" andLevel:[NSNumber numberWithFloat:DEFAULT_POWER]]];
//        [self addNewDelayToChannel:aChannel atPosition:2 withLength:[self.lengthsController lengthWithName:@"d1" andDuration:[NSNumber numberWithFloat:DEFAULT_LENTGH]]];
//    }
//    
//    else {
//        NSUInteger eventPosition = 0;
//        for (OSChannelEvent * anEvent in [self channelEventsInChannel:[self channelForPosition:0]]) {
//            [self addNewDelayToChannel:aChannel atPosition:eventPosition withLength:anEvent.length];
//            eventPosition++;
//        }
//    }
//}

- (void)removeChannel:(OSChannel *)channel{
    while ([channel.channelEvents count]) {
        [self removeChannelEvent:[channel.channelEvents anyObject]];
    }
    
    [self.managedObjectContext deleteObject:channel];
}

- (void)moveChannelFromPosition:(NSUInteger)previousPosition toPosition:(NSUInteger)newPosition{
    [self.channelController moveChannelFromPosition:previousPosition toPosition:newPosition];
}

- (NSArray *)channelNames{
    return self.channelController.channelsNames;
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
