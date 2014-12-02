//
//  OSPulseProgramControllerDataSourceProtocol.h
//  DrawPP
//
//  Created by Olivier Serve on 23/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSPulseProgramDataSourceProtocol.h"

@protocol OSPulseProgramControllerDataSourceProtocol <OSPulseProgramDataSourceProtocol>

-(void)addChannelWithName:(NSString *)aChannelName;
-(void)removeChannel:(OSChannel *)aChannel;
-(NSArray *)channelNames;

@end
