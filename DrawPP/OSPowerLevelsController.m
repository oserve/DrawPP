//
//  OSPowerLevelsController.m
//  DrawPP
//
//  Created by olivier on 01/01/2015.
//  Copyright (c) 2015 MyOwnCompany. All rights reserved.
//

#import "OSPowerLevelsController.h"

@implementation OSPowerLevelsController
@synthesize context = _context;

- (instancetype)initControllerWithContext:(NSManagedObjectContext *)context{
    self = [super init];
    if (self) {
        self.context = context;
    }
    return self;
}

- (OSPowerLevel *)powerLevelWithName:(NSString *)name andLevel:(NSNumber *)aPowerLevel{
    OSPowerLevel * thePowerLevel = nil;
    for (OSPowerLevel * existingPowerLevel in self.levels) {
        if ([existingPowerLevel.name isEqualToString:name]) {
            thePowerLevel = existingPowerLevel;
            break;
        }
    }
    if (thePowerLevel == nil) {
        thePowerLevel = [NSEntityDescription insertNewObjectForEntityForName:@"PowerLevel" inManagedObjectContext:self.context];
        thePowerLevel.power = aPowerLevel;
        thePowerLevel.name = name;
    }
    return thePowerLevel;
}

- (OSPowerLevel *)zeroPower{
    return [self powerLevelWithName:@"Zero" andLevel:[NSNumber numberWithFloat:0]];
}

- (NSArray *)levels{
    NSFetchRequest * powerLevelRequest = [NSFetchRequest fetchRequestWithEntityName:@"PowerLevel"];
    return [self.context executeFetchRequest:powerLevelRequest error:nil];
    
}

- (void)removePowerLevel:(OSPowerLevel *)aLevel{
    [self.context deleteObject:aLevel];    
}

@end
