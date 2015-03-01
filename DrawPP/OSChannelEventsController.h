//
//  OSChannelEventsController.h
//  DrawPP
//
//  Created by olivier on 01/01/2015.
//  Copyright (c) 2015 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSChannelEvent+utilities.h"

@interface OSChannelEventsController : NSObject
- (instancetype)initControllerWithContext:(NSManagedObjectContext *)context;

- (OSChannelEvent *)newChannelEventWithParameters:(NSDictionary *)channelEventParameters;
- (void)moveChannelEventFromPosition:(NSUInteger)previousPosition toPosition:(NSUInteger)newPosition inChannels:(NSArray *)channels;
- (void)removeChannelEvent:(OSChannelEvent*)aChannelEvent;
- (OSChannelEvent *)channelEventInChannel:(OSChannel *)aChannel atPosition:(NSUInteger)position;
- (NSUInteger)numberOfChannelEventsInChannel:(OSChannel *)aChannel;
- (NSArray *)channelEventsInChannel:(OSChannel *)aChannel;

@property (atomic, strong) NSManagedObjectContext * context;
@property (atomic, readonly) NSArray * events;
@end
