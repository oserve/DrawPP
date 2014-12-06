//
//  OSEventChannelView.h
//  DrawPP
//
//  Created by olivier on 10/11/2014.
//  Copyright (c) 2014 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSPulseProgramDataSourceProtocol.h"


@interface OSChannelEventView : NSObject <NSTableViewDelegate, NSTableViewDataSource>
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView;
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;

@property(weak, atomic) IBOutlet id <OSPulseProgramDataSourceProtocol> dataSource;

@property(weak, atomic) IBOutlet NSTableView * channelView;

@end
