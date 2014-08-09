//
//  OSTableViewDelegate.m
//  DrawPP
//
//  Created by olivier on 03/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import "OSTableViewDelegate.h"
#import "OSChannel.h"
#import "OSLength.h"
#import "OSChannelEvent+utilities.h"

@implementation OSTableViewDelegate

@synthesize dataSource = _dataSource;
@synthesize pulseProgramController = _pulseProgramController;

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    [self updateColumnsInTableView:tableView];
    NSString *identifier = [tableColumn identifier];

    NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
    cellView.textField.stringValue = @"Hello";
	return cellView;
	}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return [self.dataSource numberOfChannelEvents];
}


-(NSString *)description{
    return @"Delegate for OSPulseProgramView.";
}

- (void)updateColumnsInTableView:(NSTableView *)tableView{
    if (tableView.numberOfColumns < self.dataSource.numberOfChannelsInPulseProgram ) {
        [tableView addTableColumn:[[NSTableColumn alloc] init]];
    }
    else if (tableView.numberOfColumns > self.dataSource.numberOfChannelsInPulseProgram){
        [tableView removeTableColumn:[tableView.tableColumns lastObject]];
    }
    NSUInteger position = 0;
    for (NSTableColumn * aColumn in tableView.tableColumns) {
        aColumn.identifier = [self.dataSource channelForPosition:position].name;
        [aColumn.headerCell setStringValue:[self.dataSource channelForPosition:position].name];
    }
    
}

@end
