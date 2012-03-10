//
//  OSPulseProgramController.m
//  DrawPP
//
//  Created by Olivier Serve on 10/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import "OSPulseProgramController.h"

@implementation OSPulseProgramController

@synthesize pulseProgramView = _aTableView;
@synthesize dataSource = _dataSource;

#pragma mark UI Actions methods

- (IBAction)addChannel:(id)sender {
	[self.dataSource addChannelToProgram];
	while ([self.dataSource numberOfChannelEventsinChannel:[self.dataSource channelForPosition:0]] > [self.pulseProgramView numberOfColumns]) {
		NSTableColumn * newColumn = [[[NSTableColumn alloc] init] autorelease];
		[self.pulseProgramView addTableColumn:newColumn];
	}  
	[self.pulseProgramView reloadData];
}

- (IBAction)AddPulse:(id)sender {
	NSInteger channelPosition =[self.pulseProgramView selectedRow];
	[self.dataSource addNewPulseToChannel:[self.dataSource channelForPosition:channelPosition] atPosition:[self.dataSource lastPositionAvailableOnChannel:[self.dataSource channelForPosition:channelPosition]]];

	NSTableColumn * newColumn = [[[NSTableColumn alloc] init] autorelease];
	[self.pulseProgramView addTableColumn:newColumn];
	[self.pulseProgramView reloadData];

}

@end
