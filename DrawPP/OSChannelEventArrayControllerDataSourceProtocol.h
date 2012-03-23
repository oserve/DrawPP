//
//  OSChannelEventArrayControllerDataSourceProtocol.h
//  DrawPP
//
//  Created by Olivier Serve on 23/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSPulseProgramDataSourceProtocol.h"

@protocol OSChannelEventArrayControllerDataSourceProtocol <OSPulseProgramDataSourceProtocol>

-(void)addNewPulseToChannel:(OSChannel *)aChannel atPosition:(NSInteger)position;
-(void)addNewDelayToChannel:(OSChannel *)aChannel atPosition:(NSInteger)position;
-(void)removeChannelEvent:(OSChannelevent *)anEvent;

@end
