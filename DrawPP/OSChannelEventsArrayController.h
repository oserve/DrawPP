//
//  OSChannelEventsArrayController.h
//  DrawPP
//
//  Created by Olivier Serve on 23/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSChannelEventArrayControllerDataSourceProtocol.h"

@interface OSChannelEventsArrayController : NSObject

@property(strong) NSMutableDictionary * channelEventsViews;

@property(weak, atomic) IBOutlet id <OSChannelEventArrayControllerDataSourceProtocol> eventsDataSource;

-(void)addChannelEventView:(NSView *)aView forChannelPosition:(NSInteger)channelPosition atPosition:(NSInteger)eventPosition;
@end
