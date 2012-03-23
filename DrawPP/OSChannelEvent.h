//
//  OSChannelEvent.h
//  DrawPP
//
//  Created by Olivier Serve on 23/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OSChannel, OSLength, OSPowerLevel;

@interface OSChannelEvent : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phase;
@property (nonatomic, retain) NSNumber * positionOnChannel;
@property (nonatomic, retain) NSString * shape;
@property (nonatomic, retain) OSChannel *channel;
@property (nonatomic, retain) OSPowerLevel *powerLevel;
@property (nonatomic, retain) OSLength *length;

@end
