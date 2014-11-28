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
- (NSInteger)numberOfChannelsInPulseProgram;
//- (NSInteger)numberOfChannelEventsInChannel:(OSChannel *)aChannel;
- (NSInteger)numberOfChannelEvents;
- (OSChannelEvent *)channelEventInChannel:(OSChannel *)aChannel atPosition:(NSUInteger)position;

#pragma mark Interface controller datasource methods
- (void)addChannelToProgramWithName:(NSString*)aChannelName;
- (void)removeChannel:(OSChannel *)channel;

- (NSInteger)lastPositionAvailableOnChannel:(OSChannel *)channel;
- (NSArray *)channelsInPulseProgram;

- (void)addNewPulseToChannel:(OSChannel *)channel atPosition:(NSInteger)position withLength:(NSNumber *)aLength Power:(NSNumber *)aPower andName:(NSString *)name;
- (void)addNewDelayToChannel:(OSChannel *)channel atPosition:(NSInteger)position withLength:(NSNumber *)aLength andName:(NSString *)name;
- (void)removeChannelEvent:(OSChannelEvent *)aChannelEvent;
- (NSArray *)channelNames;

@end
