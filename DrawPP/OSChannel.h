//
//  OSChannel.h
//  DrawPP
//
//  Created by Olivier Serve on 23/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OSChannelEvent, OSPowerLevel;

@interface OSChannel : NSManagedObject

@property (nonatomic, strong) NSNumber * isAcquisitionChannel;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * nucleus;
@property (nonatomic, strong) NSNumber * piPulseLength;
@property (nonatomic, strong) NSNumber * positionOnGraph;
@property (nonatomic, strong) NSSet *channelEvents;
@property (nonatomic, strong) NSSet *powerLevels;
@end

@interface OSChannel (CoreDataGeneratedAccessors)

- (void)addChannelEventsObject:(OSChannelEvent *)value;
- (void)removeChannelEventsObject:(OSChannelEvent *)value;
- (void)addChannelEvents:(NSSet *)values;
- (void)removeChannelEvents:(NSSet *)values;

- (void)addPowerLevelsObject:(OSPowerLevel *)value;
- (void)removePowerLevelsObject:(OSPowerLevel *)value;
- (void)addPowerLevels:(NSSet *)values;
- (void)removePowerLevels:(NSSet *)values;

@end
