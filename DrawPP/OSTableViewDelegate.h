//
//  OSTableViewDelegate.h
//  DrawPP
//
//  Created by olivier on 03/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSPulseProgramDataSourceProtocol.h"
#import "OSChannelDataSourceProtocol.h"

@interface OSTableViewDelegate : NSObject <NSTableViewDelegate, OSChannelDataSourceProtocol>
- (OSChannelEvent *)channelEventForPosition:(NSUInteger)position;
- (NSArray *)channelEventsInChannel;
- (NSInteger)numberOfChannelEventsInChannel;
@property(retain) IBOutlet id <OSPulseProgramDataSourceProtocol> dataSource;
@end
