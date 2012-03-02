//
//  OSPulseProgramView.m
//  DrawPP
//
//  Created by Olivier Serve on 27/02/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import "OSPulseProgramView.h"
#import "OSChannelView.h"

@implementation OSPulseProgramView

@synthesize delegate = _delegate;
@synthesize dataSource = _dataSource;

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (NSArray *)viewStackConstraints{
	return _viewStackConstraints;
}

- (NSArray *)channelViews{
	NSMutableArray * channelViewsArray = [[[NSMutableArray alloc] init ] autorelease];
	for (NSView * aSubView in [self subviews]) {
		if ([aSubView isKindOfClass:[OSChannelView class]]) {
			[channelViewsArray addObject:aSubView];
		}
	}
	return channelViewsArray;
}

- (void)setChannelViews:(NSArray *)channelViews{
	for (id item in channelViews) {
		if ([item isKindOfClass:[OSChannelView class]]) {
			if (![self.subviews containsObject:item]) {
				[self addSubview:item];
			}
		}
	}
	[self setNeedsDisplay:YES];
}

// passing nil marks us as needing to update the stack constraints 
- (void)setViewStackConstraints:(NSArray *)stackConstraints {
    if (_viewStackConstraints != stackConstraints) {
        if (_viewStackConstraints) [self removeConstraints:_viewStackConstraints];
        [_viewStackConstraints release];
        _viewStackConstraints = [stackConstraints retain];
        
        if (_viewStackConstraints) {
            [self addConstraints:_viewStackConstraints];
        } else {
            [self setNeedsUpdateConstraints:YES];
        }
    }
}

// set up constraints to lay out subviews in a vertical stack with space between each consecutive pair.  This doesn't specify the heights of views, just that they're stacked up head to tail.
- (void)updateViewStackConstraints {
    if (!self.viewStackConstraints) {
        NSMutableArray *stackConstraints = [NSMutableArray array];
		
		[stackConstraints addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:0 multiplier:0 constant:10]];
		
        NSMutableDictionary *viewsDict = [NSMutableDictionary dictionary];
        
        // iterate over our subviews from top to bottom
        OSChannelView *previousView = nil;
        for (OSChannelView * currentView in [[self channelViews] sortedArrayUsingSelector:@selector(positionOnGraph)]) {
            [viewsDict setObject:currentView forKey:@"currentView"];
            
            if (!previousView) {
                // tie topmost view to the top of the container
                [stackConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[currentView(>=150)]" options:0 metrics:nil views:viewsDict]];
            } else {
                // tie current view to the next one higher up
                [viewsDict setObject:previousView forKey:@"previousView"];
                [stackConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[previousView(>=150)][currentView(previousView)]" options:0 metrics:nil views:viewsDict]];
            }
			
            // each view should fill the splitview horizontally
            [stackConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[currentView(>=200)]|" options:0 metrics:nil views:viewsDict]];
            
            previousView = currentView;
        }
        
        // tie the bottom view to the bottom of the splitview
        if ([[self subviews] count] > 0) [stackConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[currentView(>=150)]|" options:0 metrics:nil views:viewsDict]];
        
        [self setViewStackConstraints:stackConstraints];
    }
}

#pragma mark Super method overridings
// need to recompute the view stack when we gain or lose a subview
- (void)didAddSubview:(NSView *)subview {
    [subview setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self setViewStackConstraints:nil];
    [super didAddSubview:subview];
}
- (void)willRemoveSubview:(NSView *)subview {
    [self setViewStackConstraints:nil];
    [super willRemoveSubview:subview];
}

#pragma mark Update Layout Constraints Override 

- (void)updateConstraints {
    [super updateConstraints];
    [self updateViewStackConstraints];
}

#pragma mark View Stack

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)reloadData{
	NSMutableArray * channelsViews = [[NSMutableArray alloc] init];
	NSUInteger i;
	for (i=0; i<[self.dataSource numberOfChannelsInPulseProgramView:self]; i++) {
		[channelsViews addObject:[self.delegate pulseProgramView:self channelViewForPosition:i]];
	}
	[self setChannelViews:[NSArray arrayWithArray:channelsViews]];
	[channelsViews release];
	[self setNeedsDisplay:YES];

}

- (void)drawRect:(NSRect)dirtyRect
{
	[[NSColor whiteColor] set];
    NSRectFill(dirtyRect);
}

- (void) dealloc
{
    [_viewStackConstraints release];
    
    [super dealloc];
}

@end
