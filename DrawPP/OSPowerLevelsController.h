//
//  OSPowerLevelsController.h
//  DrawPP
//
//  Created by olivier on 01/01/2015.
//  Copyright (c) 2015 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSPowerLevel.h"

@interface OSPowerLevelsController : NSObject
- (instancetype)initControllerWithContext:(NSManagedObjectContext *)context;
- (OSPowerLevel *)powerLevelWithName:(NSString *)name andLevel:(NSNumber *)aPowerLevel;
- (void)removePowerLevel:(OSPowerLevel *)aLevel;
- (OSPowerLevel *)zeroPower;

@property (atomic, strong) NSManagedObjectContext * context;
@property (atomic, readonly) NSArray * levels;
@end
