//
//  OSChannelController.h
//  DrawPP
//
//  Created by olivier on 31/12/2014.
//  Copyright (c) 2014 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSChannel.h"

@interface OSChannelController : NSObject
- (instancetype)initControllerWithContext:(NSManagedObjectContext *)context;
- (OSChannel *)channelForPosition:(NSUInteger)position;
- (OSChannel *)channelWithName:(NSString *)name;

- (OSChannel *)newChannel:(NSDictionary *)channelParameters;
- (void)removeChannel:(OSChannel *)channel;
- (void)moveChannelFromPosition:(NSUInteger)previousPosition toPosition:(NSUInteger)newPosition;

@property (atomic, strong) NSManagedObjectContext * context;
@property (atomic, readonly) NSArray * channels;
@property (atomic, readonly) NSArray * channelsNames;
@property (atomic, readonly) NSUInteger numberOfChannels;

@end
