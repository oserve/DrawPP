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
    if (![self.channelText.stringValue isEqual:@""]) {
        [self.programDataSource addChannelWithName:self.channelText.stringValue];
    }

    
    [self.channelView reloadData];
    [self.channelEventView reloadData];


}
- (IBAction)selectChannel:(NSTableView *)sender {
    [self.channelEventView reloadData];
}

- (IBAction)RemoveChannel:(id)sender {
	NSInteger channelPosition =[self.channelView selectedRow];
	if (channelPosition != -1) {
		[self.programDataSource removeChannel:[self.programDataSource channelForPosition:channelPosition]];
		[self.channelView reloadData];
        [self.channelEventView reloadData];

	}
}

//- (IBAction)AddPulse:(id)sender){
//    
//}
//
//- (IBAction)AddDelay:(id)sender{
//    
//}
//
//- (IBAction)RemoveEvent:(id)sender{
//    
//}

@end
