//
//  OSLengthsController.m
//  DrawPP
//
//  Created by olivier on 01/01/2015.
//  Copyright (c) 2015 MyOwnCompany. All rights reserved.
//

#import "OSLengthsController.h"

@implementation OSLengthsController
@synthesize context = _context;

- (instancetype)initControllerWithContext:(NSManagedObjectContext *)context{
    self = [super init];
    if (self) {
        self.context = context;
    }
    return self;
}

- (OSLength *)lengthWithName:(NSString *)name andDuration:(NSNumber *)duration{
    OSLength * theLength = nil;
    for (OSLength * existingLength in self.lengths) {
        if ([existingLength.name  isEqualToString:name]) {
            theLength = existingLength;
            break;
        }
    }
    if (theLength == nil) {
        theLength = [NSEntityDescription insertNewObjectForEntityForName:@"Length" inManagedObjectContext:self.context];
        theLength.duration = duration;
        theLength.name = name;
    }
    return theLength;
}

-(NSArray *)lengths{
    NSFetchRequest * powerLevelRequest = [NSFetchRequest fetchRequestWithEntityName:@"Length"];
    return [self.context executeFetchRequest:powerLevelRequest error:nil];
    
}

- (void)removeLentgh:(OSLength *)aLentgh{
    [self.context deleteObject:aLentgh];
    
}

@end
