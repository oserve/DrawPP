//
//  OSPulseProgramDataSourceProtocol.h
//  DrawPP
//
//  Created by olivier on 03/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OSChannel;
@class OSChannelEvent;

@protocol OSPulseProgramDataSourceProtocol <NSObject>

- (NSInteger)numberOfChannelsInPulseProgram;
- (OSChannel *)channelForPosition:(NSUInteger)position;
- (NSInteger)numberOfChannelEventsinChannel:(OSChannel *)aChannel;
- (OSChannelEvent *)channelEventIChannel:(OSChannel *)aChannel atPosition:(NSUInteger)position;

@end
