//
//  OSPulseProgramViewController.m
//  DrawPP
//
//  Created by Olivier Serve on 28/02/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import "OSPulseProgramViewController.h"
#import "OSPulseProgramView.h"
#import "OSChannelView.h"

@implementation OSPulseProgramViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

#pragma mark Delegate Methods

- (OSChannelView *)pulseProgramView:(OSPulseProgramView *)aPulseProgramView channelViewForPosition:(NSUInteger)position{
	OSChannelView * channelView = nil;
	for (OSChannelView * aChannelView in [aPulseProgramView channelViews]) {
		if (aChannelView.positionOnGraph == position) {
			channelView = aChannelView;
			break;
		}
	}
	if(!channelView){
		channelView = [[[OSChannelView alloc] init] autorelease];
		channelView.positionOnGraph = position;
	
	}
	return channelView;
}

- (void)reloadViews{
	if ([self.view respondsToSelector:@selector(reloadData)]) {
		[self.view reloadData];
	}
}

@end
