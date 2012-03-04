//
//  OSTableViewDelegate.m
//  DrawPP
//
//  Created by olivier on 03/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import "OSTableViewDelegate.h"
#import "OSChannelView.h"
#import "OSChannelViewDelegate.h"

@implementation OSTableViewDelegate

@synthesize dataSource = _dataSource;

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	OSChannelView *channelView = [tableView makeViewWithIdentifier:@"channelView" owner:self];
    if(!channelView){
		channelView = [[[OSChannelView alloc] init] autorelease];
        channelView.identifier = @"channelView";
        [channelView rotateByAngle:90];
	}
	return channelView;    
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return [self.dataSource numberOfChannelInPulseProgram];
}

- (OSChannelEvent *)channelEventForPosition:(NSUInteger)position{
    return [self.dataSource channelEventInChannel:aChannel forPosition:position];
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 150;
}

-(NSString *)description{
    return @"Delegate for OSPulseProgramView.";
}

@end
