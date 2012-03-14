//
//  OSPulprog.h
//  DrawPP
//
//  Created by olivier on 11/01/12.
//  Copyright 2012 IMS. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OSPulse.h"
#import "OSDelay.h"
#import "OSChannel.h"
#import "OSPowerLevel.h"
#import "OSPulseProgramDataSourceProtocol.h"

@interface OSPulprog : NSPersistentDocument <OSPulseProgramDataSourceProtocol>{
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

- (void)addNewPulseToChannel:(OSChannel *)channel atPosition:(NSInteger)position;
- (void)addNewDelayToChannel:(OSChannel *)channel atPosition:(NSInteger)position;
- (void)removeChannelEvent:(OSChannelEvent *)aChannelEvent;

@end
