//
//  OSPulseProgramViewController.h
//  DrawPP
//
//  Created by Olivier Serve on 28/02/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OSPulseProgramViewDelegateProtocol.h"
#import "OSChannelViewController.h"

@interface OSPulseProgramViewController : NSViewController <OSPulseProgramViewDelegateProtocol>
- (void)reloadViews;
@end
