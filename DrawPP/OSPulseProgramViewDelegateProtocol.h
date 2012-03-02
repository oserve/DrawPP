//
//  OSPulseProgramViewDelegateProtocol.h
//  DrawPP
//
//  Created by Olivier Serve on 28/02/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OSPulseProgramView;
@class OSChannelView;
@protocol OSPulseProgramViewDelegateProtocol <NSObject>

- (OSChannelView *)pulseProgramView:(OSPulseProgramView *)aPulseProgramView channelViewForPosition:(NSUInteger)position;

@end
