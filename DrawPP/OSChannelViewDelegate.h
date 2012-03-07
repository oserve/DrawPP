//
//  OSChannelViewDelegate.h
//  DrawPP
//
//  Created by olivier on 04/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSChannelViewDelegate : NSObject <NSTableViewDelegate>
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;
@end
