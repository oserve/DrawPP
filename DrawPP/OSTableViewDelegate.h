//
//  OSTableViewDelegate.h
//  DrawPP
//
//  Created by olivier on 03/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSPulseProgramDataSourceProtocol.h"
#import "OSChannelDataSourceProtocol.h"

@interface OSTableViewDelegate : NSObject <NSTableViewDelegate, NSTableViewDataSource, OSChannelDataSourceProtocol>

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView;
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;

- (NSInteger)numberOfChannelEventViewsInChannelView:(NSTableView *)channelView;

@property(weak, atomic) IBOutlet id <OSPulseProgramDataSourceProtocol> dataSource;
@property(strong, atomic) NSMutableDictionary * channelViewDictionary;
@property(retain, atomic) NSMutableDictionary * channelViewDelegateDictionary;
@end
