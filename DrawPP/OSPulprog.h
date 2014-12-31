//
//  OSPulprog.h
//  DrawPP
//
//  Created by olivier on 11/01/12.
//  Copyright 2012 IMS. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OSChannelEvent+utilities.h"
#import "OSPowerLevel.h"
#import "OSChannel.h"
#import "OSLength.h"
#import "OSPulseProgramDataSourceProtocol.h"
#import "OSPulseProgramControllerDataSourceProtocol.h"

@interface OSPulprog : NSPersistentDocument <OSPulseProgramDataSourceProtocol, OSPulseProgramControllerDataSourceProtocol> {
@private
}
#pragma mark PulseProgramView controller datasource protocol
- (OSChannel *)channelForPosition:(NSUInteger)position;
//- (NSInteger)numberOfChannelEventsInChannel:(OSChannel *)aChannel;
- (NSInteger)numberOfChannelEvents;
- (OSChannelEvent *)channelEventInChannel:(OSChannel *)aChannel atPosition:(NSUInteger)position;

#pragma mark Interface controller datasource methods
- (void)addChannelWithName:(NSString*)aChannelName;
- (void)removeChannel:(OSChannel *)channel;
- (void)moveChannelFromPosition:(NSInteger)previousPosition toPosition:(NSInteger)newPosition;

- (NSArray *)channelsInPulseProgram;

- (OSLength *)lengthWithName:(NSString *)name andDuration:(NSNumber *)aLength;
- (OSPowerLevel *)powerLevelWithName:(NSString *)name andLevel:(NSNumber *)aPowerLevel;

- (void)addChannelEventWithName:(NSString*)anEventName;
- (void)moveChannelEventFromPosition:(NSInteger)previousPosition ToPosition:(NSInteger)newPosition;
- (void)addNewPulseToChannel:(OSChannel *)aChannel atPosition:(NSInteger)position withLength:(OSLength *)aLength Power:(OSPowerLevel *)aPower;
- (void)addNewDelayToChannel:(OSChannel *)channel atPosition:(NSInteger)position withLength:(OSLength *)aLength;
- (void)removeChannelEvent:(OSChannelEvent *)aChannelEvent;

//- (NSArray *)channelNames;

@property (atomic, readonly) OSPowerLevel * zeroPower;
@property (atomic, readonly) NSInteger numberOfChannelsInPulseProgram;
@property (atomic, readonly) NSArray * channelNames;
@end
