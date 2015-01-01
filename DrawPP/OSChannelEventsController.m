//
//  OSChannelEventsController.m
//  DrawPP
//
//  Created by olivier on 01/01/2015.
//  Copyright (c) 2015 MyOwnCompany. All rights reserved.
//

#import "OSChannelEventsController.h"
#import "OSChannel.h"

@implementation OSChannelEventsController
@synthesize context = _context;

- (instancetype)initControllerWithContext:(NSManagedObjectContext *)context{
    self = [super init];
    if (self) {
        self.context = context;
    }
    return self;
}


- (NSArray *)events{
    NSFetchRequest * channelEventsRequest = [NSFetchRequest fetchRequestWithEntityName:@"Channel"];
    NSError * error = nil;
    NSArray * events = [self.context executeFetchRequest:channelEventsRequest error:&error];
    return events;
}

- (NSArray *)channelEventsInChannel:(OSChannel *)aChannel{
    NSSortDescriptor * channelEventDescriptor = [[NSSortDescriptor alloc] initWithKey:@"positionOnChannel" ascending:YES];
    
    return [aChannel.channelEvents sortedArrayUsingDescriptors:[NSArray arrayWithObject:channelEventDescriptor]];
}

- (NSUInteger)numberOfChannelEventsInChannel:(OSChannel *)aChannel{
    return [[self channelEventsInChannel:aChannel] count];
}

- (OSChannelEvent *)channelEventInChannel:(OSChannel *)aChannel atPosition:(NSUInteger)position{
    OSChannelEvent * theChannelEvent = nil;
    if (position < [[self channelEventsInChannel:aChannel] count]) {
        theChannelEvent = [[self channelEventsInChannel:aChannel] objectAtIndex:position];
    }
    return theChannelEvent;
}

- (OSChannelEvent *)newChannelEvent:(NSDictionary *)channelEventParameters{
    OSChannelEvent * newEvent = [NSEntityDescription insertNewObjectForEntityForName:@"ChannelEvent" inManagedObjectContext:self.context];
    newEvent.length = [channelEventParameters objectForKey:@"length"];
    newEvent.powerLevel = [channelEventParameters objectForKey:@"power"];
    newEvent.channel = [channelEventParameters objectForKey:@"channel"];
    newEvent.positionOnChannel = [channelEventParameters objectForKey:@"position"];
    return newEvent;
}

- (void)removeChannelEvent:(OSChannelEvent *)aChannelEvent{
    [self.context deleteObject:aChannelEvent];
    //TODO : Must remove channelevent in all channels
    
}

- (void)moveChannelEventFromPosition:(NSUInteger)previousPosition toPosition:(NSUInteger)newPosition inChannels:(NSArray *)channels{
    for (OSChannel * aChannel in channels) {
        if (aChannel.channelEvents.count) {
            
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

@end
