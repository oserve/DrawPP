//
//  OSPowerLevel.h
//  DrawPP
//
//  Created by Olivier Serve on 26/02/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OSChannel, OSPulse;

@interface OSPowerLevel : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * power;
@property (nonatomic, retain) OSChannel *channel;
@property (nonatomic, retain) NSSet *pulses;
@end

@interface OSPowerLevel (CoreDataGeneratedAccessors)

- (void)addPulsesObject:(OSPulse *)value;
- (void)removePulsesObject:(OSPulse *)value;
- (void)addPulses:(NSSet *)values;
- (void)removePulses:(NSSet *)values;

@end
