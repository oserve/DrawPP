//
//  OSChannel.h
//  DrawPP
//
//  Created by Olivier Serve on 26/02/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OSDelay, OSPowerLevel, OSPulse;

@interface OSChannel : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * isAcquisitionChannel;
@property (nonatomic, retain) NSString * nucleus;
@property (nonatomic, retain) NSNumber * piPulseLength;
@property (nonatomic, retain) NSNumber * positionOnGraph;
@property (nonatomic, retain) NSSet *delays;
@property (nonatomic, retain) NSSet *powerLevels;
@property (nonatomic, retain) NSSet *pulses;
@end

@interface OSChannel (CoreDataGeneratedAccessors)

- (void)addDelaysObject:(OSDelay *)value;
- (void)removeDelaysObject:(OSDelay *)value;
- (void)addDelays:(NSSet *)values;
- (void)removeDelays:(NSSet *)values;
- (void)addPowerLevelsObject:(OSPowerLevel *)value;
- (void)removePowerLevelsObject:(OSPowerLevel *)value;
- (void)addPowerLevels:(NSSet *)values;
- (void)removePowerLevels:(NSSet *)values;
- (void)addPulsesObject:(OSPulse *)value;
- (void)removePulsesObject:(OSPulse *)value;
- (void)addPulses:(NSSet *)values;
- (void)removePulses:(NSSet *)values;
@end
