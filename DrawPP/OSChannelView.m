//
//  OSChannelView.m
//  DrawPP
//
//  Created by olivier on 09/11/2014.
//  Copyright (c) 2014 MyOwnCompany. All rights reserved.
//

#import "OSChannelView.h"
#import "OSChannel.h"

@implementation OSChannelView

@synthesize dataSource = _dataSource;

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return self.dataSource.numberOfChannelsInPulseProgram;
    
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSString *identifier = [tableColumn identifier];
    
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
    cellView.textField.stringValue = [self.dataSource channelForPosition:row].name;
    return cellView;

}

@end
