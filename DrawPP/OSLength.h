//
//  OSLength.h
//  DrawPP
//
//  Created by Olivier Serve on 23/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OSChannelEvent;

@interface OSLength : NSManagedObject

@property (nonatomic, strong) NSNumber * duration;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSSet *channelEvents;
@end

@interface OSLength (CoreDataGeneratedAccessors)

- (void)addChannelEventsObject:(OSChannelEvent *)value;
- (void)removeChannelEventsObject:(OSChannelEvent *)value;
- (void)addChannelEvents:(NSSet *)values;
- (void)removeChannelEvents:(NSSet *)values;

@end
