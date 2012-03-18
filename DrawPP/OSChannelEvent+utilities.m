//
//  OSChannelEvent+utilities.m
//  DrawPP
//
//  Created by Olivier Serve on 17/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import "OSChannelEvent+utilities.h"

@implementation OSChannelEvent (utilities)
-(BOOL)isDelay{
	BOOL isDelay = YES;
	if (self.powerLevel) {
		isDelay = NO;
	}
	return isDelay;
}
@end
