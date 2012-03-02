//
//  OSPulseProgramViewDataSourceProtocol.h
//  DrawPP
//
//  Created by Olivier Serve on 28/02/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OSChannel;
@class OSPulseProgramView;
@protocol OSPulseProgramViewDataSourceProtocol <NSObject>

- (NSUInteger)numberOfChannelsInPulseProgramView:(OSPulseProgramView *)aPulseProgramView;
- (OSChannel *)pulseProgramView:(OSPulseProgramView *)aPulseProgramView channelForPosition:(NSUInteger)position;

@end
