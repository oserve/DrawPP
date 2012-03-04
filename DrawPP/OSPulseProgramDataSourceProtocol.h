//
//  OSPulseProgramDataSourceProtocol.h
//  DrawPP
//
//  Created by olivier on 03/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OSChannel;

@protocol OSPulseProgramDataSourceProtocol <NSObject>

- (OSChannel *)channelForPosition:(NSUInteger)position;
- (NSArray *)channelsInPulseProgram;
- (NSInteger)numberOfChannelInPulseProgram;

@end
