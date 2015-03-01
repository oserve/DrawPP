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

//@synthesize pulseProgramView = _pulseProgramView;
@synthesize programDataSource = _programDataSource;


#pragma mark UI Actions methods

- (IBAction)addChannel:(id)sender {
    if (![self.channelText.stringValue isEqual:@""]) {
        NSDictionary * channelParameters = [NSDictionary dictionaryWithObjectsAndKeys:self.channelText.stringValue, @"name", nil];
        [self.programDataSource addChannelWithParameters:channelParameters];
//        [self.programDataSource addChannelWithName:self.channelText.stringValue];
    }
    [self refreshUI];
//    self.channelText.stringValue = @"r";

}
- (IBAction)selectChannel:(NSTableView *)sender {
    [self.channelEventView reloadData];
}

- (IBAction)RemoveChannel:(id)sender {
	NSInteger channelPosition =self.channelView.selectedRow;
	if (channelPosition != -1) {
		[self.programDataSource removeChannel:[self.programDataSource channelForPosition:channelPosition]];
        [self refreshUI];
	}
}

- (IBAction)channelUp:(id)sender {
    NSInteger channelPosition =self.channelView.selectedRow;
    if (channelPosition > 0) {
        [self.programDataSource moveChannelFromPosition:channelPosition toPosition:channelPosition-1];
        [self refreshUI];
        [self.channelView selectRowIndexes:[NSIndexSet indexSetWithIndex:channelPosition-1] byExtendingSelection:NO];
    }

}

- (IBAction)channelDown:(id)sender {
    NSInteger channelPosition =self.channelView.selectedRow;
    if (channelPosition < (self.channelView.numberOfRows)) {
        [self.programDataSource moveChannelFromPosition:channelPosition toPosition:channelPosition+1];
        [self refreshUI];
        [self.channelView selectRowIndexes:[NSIndexSet indexSetWithIndex:channelPosition-1] byExtendingSelection:NO];
    }
    
}

- (IBAction)AddEvent:(id)sender {
//    if (![self.eventText.stringValue isEqual:@""]) {
//        self.programDataSource;
//    }
    [self refreshUI];
//    self.eventText.stringValue = @"";
    
}

- (IBAction)removeEvent:(id)sender {
}

- (void)refreshUI{
    [self.channelView reloadData];
    [self.channelEventView reloadData];
}

@end
