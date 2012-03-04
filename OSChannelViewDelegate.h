//
//  OSChannelViewDelegate.h
//  DrawPP
//
//  Created by olivier on 04/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSChannelDataSourceProtocol.h"

@interface OSChannelViewDelegate : NSObject <NSTableViewDelegate>
@property(retain) id <OSChannelDataSourceProtocol> dataSource;
@end
