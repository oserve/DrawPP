//
//  OSTableViewDelegate.m
//  DrawPP
//
//  Created by olivier on 03/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import "OSTableViewDelegate.h"
#import "OSChannel.h"
#import "OSChannelViewDelegate.h"

@implementation OSTableViewDelegate

@synthesize dataSource = _dataSource;
@synthesize channelViewDictionary = _channelViewDictionary;
@synthesize channelViewDelegateDictionary = _channelViewDelegateDictionary;

- (NSMutableDictionary *)channelViewDictionary{
    if (!_channelViewDictionary) {
        _channelViewDictionary = [[NSMutableDictionary alloc] init];
    }
    return _channelViewDictionary;
}

- (NSMutableDictionary *)channelViewDelegateDictionary{
    if (!_channelViewDelegateDictionary) {
        _channelViewDelegateDictionary = [[NSMutableDictionary alloc] init];
    }
    return _channelViewDelegateDictionary;
}


- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	NSTableView * channelView = [tableView makeViewWithIdentifier:@"channelView" owner:self];
    OSChannelViewDelegate * channelDelegate = nil;
    if(!channelView){
		channelView = [[[NSTableView alloc] init] autorelease];
        channelView.identifier = @"channelView";
        [channelView rotateByAngle:90];
        channelDelegate = [[OSChannelViewDelegate alloc] init];
        [self.channelViewDelegateDictionary setObject:channelDelegate forKey:channelView];
	}
    [self.channelViewDictionary setObject:channelView forKey:[self.dataSource channelForPosition:row]];
    channelView.delegate = channelDelegate;
    channelView.dataSource = channelDelegate;
    channelDelegate.dataSource = self;
	return channelView;    
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return [self.dataSource numberOfChannelInPulseProgram];
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 150;
}

-(NSString *)description{
    return @"Delegate for OSPulseProgramView.";
}

- (NSInteger)numberOfChannelEventViewsInChannelView:(NSTableView *)channelView{
    OSChannel * channelForChannelView = [self.channelViewDictionary objectForKey:channelView];
    return [channelForChannelView.pulses count] + [channelForChannelView.delays count];
}

@end
