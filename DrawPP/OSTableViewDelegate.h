//
//  OSTableViewDelegate.h
//  DrawPP
//
//  Created by olivier on 03/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSPulseProgramDataSourceProtocol.h"

@interface OSTableViewDelegate : NSObject <NSTableViewDelegate, NSTableViewDataSource>

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView;
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;

@property(weak, atomic) IBOutlet id <OSPulseProgramDataSourceProtocol> dataSource;
@end
