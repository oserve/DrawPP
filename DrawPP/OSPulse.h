//
//  OSPulse.h
//  DrawPP
//
//  Created by Olivier Serve on 26/02/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "OSChannelEvent.h"

@class OSChannel, OSPowerLevel;

@interface OSPulse : OSChannelEvent

@property (nonatomic, retain) NSString * phase;
@property (nonatomic, retain) NSString * shape;
@property (nonatomic, retain) OSPowerLevel *powerLevel;
@property (nonatomic, retain) OSChannel *channel;

@end
