//
//  OSChannelEvent.h
//  DrawPP
//
//  Created by Olivier Serve on 26/02/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OSChannelEvent;

@interface OSChannelEvent : NSManagedObject

@property (nonatomic, retain) NSNumber * length;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * positionOnChannel;
@property (nonatomic, retain) OSChannelEvent *sameLengthAs;

@end
