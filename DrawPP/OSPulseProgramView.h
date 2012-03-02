//
//  OSPulseProgramView.h
//  DrawPP
//
//  Created by Olivier Serve on 27/02/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OSPulseProgramViewDataSourceProtocol.h"
#import "OSPulseProgramViewDelegateProtocol.h"

@interface OSPulseProgramView : NSView{
	NSArray * _viewStackConstraints;

}
@property(retain) IBOutlet id <OSPulseProgramViewDelegateProtocol> delegate;
@property(retain) IBOutlet id <OSPulseProgramViewDataSourceProtocol> dataSource;
- (NSArray *)channelViews;
- (void)setChannelViews:(NSArray *)channelViews;
@end
