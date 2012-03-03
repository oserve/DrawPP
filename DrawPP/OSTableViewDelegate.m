//
//  OSTableViewDelegate.m
//  DrawPP
//
//  Created by olivier on 03/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import "OSTableViewDelegate.h"
#import "OSChannelView.h"

@implementation OSTableViewDelegate

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	OSChannelView *channelView = [tableView makeViewWithIdentifier:@"MyView" owner:self];
    if(!channelView){
		channelView = [[[OSChannelView alloc] init] autorelease];
        channelView.identifier = @"MyView";
        channelView.stringValue = @"Yo baby";
        
	}
	return channelView;
    
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 150;
}

-(NSString *)description{
    return @"Delegate for OSPulseProgramView.";
}

@end
