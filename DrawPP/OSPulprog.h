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
#import "OSChannelEventArrayControllerDataSourceProtocol.h"

@interface OSPulprog : NSPersistentDocument <OSPulseProgramDataSourceProtocol, OSPulseProgramControllerDataSourceProtocol, OSChannelEventArrayControllerDataSourceProtocol>{
@private

}
#pragma mark TableView controller datasource protocol
- (OSChannel *)channelForPosition:(NSUInteger)position;
- (NSInteger)numberOfChannelsInPulseProgram;
- (NSInteger)numberOfChannelEventsinChannel:(OSChannel *)aChannel;
- (OSChannelEvent *)channelEventIChannel:(OSChannel *)aChannel atPosition:(NSUInteger)position;

#pragma mark Interface controller datasource methods
- (void)addChannelToProgram;
- (void)removeChannel:(OSChannel *)channel;

- (NSInteger)lastPositionAvailableOnChannel:(OSChannel *)channel;
- (NSArray *)channelsInPulseProgram;

- (void)addNewPulseToChannel:(OSChannel *)channel atPosition:(NSInteger)position;
- (void)addNewDelayToChannel:(OSChannel *)channel atPosition:(NSInteger)position;
- (void)removeChannelEvent:(OSChannelEvent *)aChannelEvent;

@end
