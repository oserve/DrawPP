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

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * phase;
@property (nonatomic, strong) NSNumber * positionOnChannel;
@property (nonatomic, strong) NSString * shape;
@property (nonatomic, strong) OSChannel *channel;
@property (nonatomic, strong) OSPowerLevel *powerLevel;
@property (nonatomic, strong) OSLength *length;

@end
