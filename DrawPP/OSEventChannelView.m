//
//  OSEventChannelView.m
//  DrawPP
//
//  Created by olivier on 10/11/2014.
//  Copyright (c) 2014 MyOwnCompany. All rights reserved.
//

#import "OSEventChannelView.h"
#import "OSChannelEvent+utilities.h"
#import "OSLength.h"


@implementation OSEventChannelView

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return [self.dataSource numberOfChannelEvents];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSString *identifier = [tableColumn identifier];
//    OSChannelEvent * anEvent = [self.dataSource channelEventInChannel:[self.dataSource channelForPosition:self.channelView.selectedRow] atPosition:row];
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
    cellView.textField.stringValue = [NSString stringWithFormat:@"%@", [self.dataSource channelEventInChannel:[self.dataSource channelForPosition:self.channelView.selectedRow] atPosition:row].length.duration];
    return cellView;
    
}

@end