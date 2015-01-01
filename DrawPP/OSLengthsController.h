//
//  OSLengthsController.h
//  DrawPP
//
//  Created by olivier on 01/01/2015.
//  Copyright (c) 2015 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSLength.h"

@interface OSLengthsController : NSObject
- (instancetype)initControllerWithContext:(NSManagedObjectContext *)context;
- (OSLength *)lengthWithName:(NSString *)name andDuration:(NSNumber *)duration;
- (void)removeLentgh:(OSLength *)aLentgh;

@property (atomic, strong) NSManagedObjectContext * context;
@property (atomic, readonly) NSArray * lengths;
@end
