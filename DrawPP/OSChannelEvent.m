//
//  OSChannelEvent.m
//  DrawPP
//
//  Created by Olivier Serve on 23/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import "OSChannelEvent.h"
#import "OSChannel.h"
#import "OSLength.h"
#import "OSPowerLevel.h"


@implementation OSChannelEvent

@dynamic name;
@dynamic phase;
@dynamic positionOnChannel;
@dynamic shape;
@dynamic channel;
@dynamic powerLevel;
@dynamic length;

- (NSString *)debugDescription{
    if (self.length) {
        return [NSString stringWithFormat:@"%@", self.length.duration ];
    }
    else{
        return [super description];
    }
}

@end
