//
//  OSPulseProgramController.m
//  DrawPP
//
//  Created by Olivier Serve on 10/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import "OSPulseProgramController.h"
#import "OSChannelEvent+utilities.h"

@implementation OSPulseProgramController

@synthesize pulseProgramView = _pulseProgramView;
@synthesize programDataSource = _programDataSource;

#pragma mark UI Actions methods

- (IBAction)addChannel:(id)sender {
	[self.programDataSource addChannelToProgram];
	while ([self.programDataSource numberOfChannelEventsinChannel:[self.programDataSource channelForPosition:0]] > [self.pulseProgramView numberOfColumns]) {
		NSTableColumn * newColumn = [[[NSTableColumn alloc] init] autorelease];
		[self.pulseProgramView addTableColumn:newColumn];
	}  
	[self.pulseProgramView reloadData];
}

- (IBAction)RemoveChannel:(id)sender {
	NSInteger channelPosition =[self.pulseProgramView selectedRow];
	if (channelPosition != -1) {
		[self.programDataSource removeChannel:[self.programDataSource channelForPosition:channelPosition]];
		[self.pulseProgramView reloadData];

	}
}

@end
