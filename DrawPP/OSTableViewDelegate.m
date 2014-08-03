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
    NSTableCellView * aCell = [[NSTableCellView alloc] init];
    aCell.textField.stringValue = @"Hello";
	return aCell;
	}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return [self.dataSource numberOfChannelEvents];
}


-(NSString *)description{
    return @"Delegate for OSPulseProgramView.";
}

@end
