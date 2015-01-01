//
//  OSChannelController.m
//  DrawPP
//
//  Created by olivier on 31/12/2014.
//  Copyright (c) 2014 MyOwnCompany. All rights reserved.
//

#import "OSChannelController.h"

#define DEFAULT_LENTGH 100.0
#define DEFAULT_POWER 10.0
#define DEFAULT_NUCLEUS @"1H"

@implementation OSChannelController
@synthesize context = _context;

- (instancetype)initControllerWithContext:(NSManagedObjectContext *)context{
    self = [super init];
    if (self) {
        self.context = context;
        }
    return self;
}

- (NSArray *)channels{
    NSSortDescriptor * channelDescriptor = [[NSSortDescriptor alloc] initWithKey:@"positionOnGraph" ascending:YES];
    NSFetchRequest * channelRequest = [NSFetchRequest fetchRequestWithEntityName:@"Channel"];
    channelRequest.sortDescriptors = [NSArray arrayWithObject:channelDescriptor];
    NSError * error = nil;
    NSArray * channels = [self.context executeFetchRequest:channelRequest error:&error];
    return channels;
}

- (NSUInteger)numberOfChannels{
    return [self.channels count];
}

- (OSChannel *)channelForPosition:(NSUInteger)position{
    OSChannel * resultChannel = nil;
    if (position <= [self numberOfChannels]) {
        resultChannel = [self.channels objectAtIndex:position];
    }
    return resultChannel;
}

- (OSChannel *)channelWithName:(NSString *)name{
    OSChannel * resultChannel = nil;
    if ([name isNotEqualTo:@""]) {
        
        NSFetchRequest * channelRequest = [NSFetchRequest fetchRequestWithEntityName:@"Channel"];
        NSPredicate * namePredicate = [NSPredicate predicateWithFormat:@"name == @%", name];
        channelRequest.predicate = namePredicate;
        NSError * error = nil;
        NSArray * channels = [self.context executeFetchRequest:channelRequest error:&error];
        if (channels.count == 1) {
            resultChannel = [channels objectAtIndex:0];
        }
    }
    return resultChannel;
}

- (OSChannel *)newChannel:(NSDictionary *)channelParameters{
    OSChannel * aChannel = nil;
    if (![self.channelsNames containsObject:[channelParameters objectForKey:@"name"]]) {
        
        aChannel = [NSEntityDescription insertNewObjectForEntityForName:@"Channel" inManagedObjectContext:self.context];
        
        aChannel.positionOnGraph = [channelParameters objectForKey:@"position"];
        aChannel.name = [channelParameters objectForKey:@"name"];
        aChannel.piPulseLength = [channelParameters objectForKey:@"length"];
        aChannel.piPulsePower = [channelParameters objectForKey:@"power"];
        aChannel.nucleus = [channelParameters objectForKey:@"nucleus"];
        if (self.numberOfChannels == 1) {
            aChannel.isAcquisitionChannel = [NSNumber numberWithBool:YES];
        }
        else{
            aChannel.isAcquisitionChannel = [NSNumber numberWithBool:NO];
        }
    }
    return aChannel;
}

- (void)removeChannel:(OSChannel *)channel{
    
    [self.context deleteObject:channel];
}

- (void)moveChannelFromPosition:(NSUInteger)previousPosition toPosition:(NSUInteger)newPosition{
    
    if (newPosition <= self.numberOfChannels) {
        NSMutableArray * allChannels = [self.channels mutableCopy];
        OSChannel * movingChannel = [self channelForPosition:previousPosition];
        [allChannels removeObjectAtIndex:previousPosition];
        [allChannels insertObject:movingChannel atIndex:newPosition];
        NSUInteger newIndex = 0;
        for (OSChannel * aChannel in allChannels) {
            aChannel.positionOnGraph = [NSNumber numberWithInteger:newIndex];
            newIndex++;
        }
    }
}

- (NSArray *)channelsNames{
    NSMutableArray * names = [[NSMutableArray alloc] init];
    for (OSChannel * channel in self.channels) {
        if (![names containsObject:channel.name]) {
            [names addObject:channel.name];
        }
    }
    return [NSArray arrayWithArray:names];
}
@end
