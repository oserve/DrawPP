//
//  OSChannelViewDelegate.h
//  DrawPP
//
//  Created by olivier on 04/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSChannelDataSourceProtocol.h"

@interface OSChannelViewDelegate : NSObject <NSTableViewDelegate, NSTableViewDataSource>

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView;

@property(weak,atomic) id <OSChannelDataSourceProtocol> dataSource;
@end
