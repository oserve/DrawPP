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
- (void)addNewPulseToChannel:(OSChannel *)channel atPosition:(NSInteger)position;
- (void)addNewDelayToChannel:(OSChannel *)channel atPosition:(NSInteger)position;
- (void)addChannelToProgram;
- (void)moveChannelEventToPosition:(OSChannelEvent *)aChannelEvent;
- (void)removeChannelEvent:(OSChannelEvent *)aChannelEvent;
- (void)moveChannel:(OSChannel *)channel toPosition:(NSInteger)position;
- (void)removeChannel:(OSChannel *)channel;

- (OSChannel *)channelForPosition:(NSUInteger)position;
- (NSInteger)numberOfChannelInPulseProgram;

@property (weak,atomic) IBOutlet NSTableView * pulseProgramView;
@end
