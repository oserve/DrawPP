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

@property (nonatomic, retain) NSNumber * isAcquisitionChannel;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * nucleus;
@property (nonatomic, retain) NSNumber * piPulseLength;
@property (nonatomic, retain) NSNumber * positionOnGraph;
@property (nonatomic, retain) NSSet *channelEvents;
@property (nonatomic, retain) NSSet *powerLevels;
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
