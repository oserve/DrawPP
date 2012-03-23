//
//  OSPowerLevel.h
//  DrawPP
//
//  Created by Olivier Serve on 23/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OSChannel, OSChannelEvent;

@interface OSPowerLevel : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * power;
@property (nonatomic, retain) OSChannel *channel;
@property (nonatomic, retain) NSSet *channelEvents;
@end

@interface OSPowerLevel (CoreDataGeneratedAccessors)

- (void)addChannelEventsObject:(OSChannelEvent *)value;
- (void)removeChannelEventsObject:(OSChannelEvent *)value;
- (void)addChannelEvents:(NSSet *)values;
- (void)removeChannelEvents:(NSSet *)values;

@end
