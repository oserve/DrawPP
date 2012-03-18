//
//  OSChannelEvent.h
//  DrawPP
//
//  Created by Olivier Serve on 17/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OSChannel, OSChannelEvent, OSPowerLevel;

@interface OSChannelEvent : NSManagedObject

@property (nonatomic, retain) NSNumber * length;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * positionOnChannel;
@property (nonatomic, retain) NSString * phase;
@property (nonatomic, retain) NSString * shape;
@property (nonatomic, retain) OSChannelEvent *sameLengthAs;
@property (nonatomic, retain) OSChannel *channel;
@property (nonatomic, retain) OSPowerLevel *powerLevel;

@end
