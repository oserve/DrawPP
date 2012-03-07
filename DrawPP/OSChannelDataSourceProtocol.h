//
//  OSChannelDataSourceProtocol.h
//  DrawPP
//
//  Created by olivier on 03/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OSChannelEvent;
@class OSChannelView;
@class OSChannel;

@protocol OSChannelDataSourceProtocol <NSObject>

//- (OSChannelEvent *)channelEventForPosition:(NSUInteger)position;
//- (NSArray *)channelEventsInChannel:(OSChannel *)aChannel;
- (NSInteger)numberOfChannelEventViewsInChannelView:(NSTableView *)channelView;

@end
