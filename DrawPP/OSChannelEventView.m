//
//  OSEventChannelView.m
//  DrawPP
//
//  Created by olivier on 10/11/2014.
//  Copyright (c) 2014 MyOwnCompany. All rights reserved.
//

#import "OSChannelEventView.h"
#import "OSChannelEvent+utilities.h"
#import "OSLength.h"
#import "OSChannel.h"


@implementation OSChannelEventView

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    if (self.channelView.selectedRow == -1) {
        return 0;
    }
    else{
        return [self.dataSource numberOfChannelEvents];
    }
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSString *identifier = [tableColumn identifier];
    NSInteger chanelEventRow = self.channelView.selectedRow;
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
    cellView.textField.stringValue = [NSString stringWithFormat:@"%@", [self.dataSource channelEventInChannel:[self.dataSource channelForPosition:chanelEventRow] atPosition:row].length.duration];
    return cellView;
}

@end