//
//  OSChannelEventView.m
//  DrawPP
//
//  Created by olivier on 04/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import "OSChannelEventView.h"

@implementation OSChannelEventView

@synthesize addButton= _addButton;
@synthesize editButton = _editButton;

#define BUTTON_SIZE 25

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
		self.addButton = [[[NSButton alloc] initWithFrame:NSMakeRect(0, 0, BUTTON_SIZE, BUTTON_SIZE)] autorelease];
		self.addButton.image = [NSImage imageNamed:NSImageNameAddTemplate];
		self.editButton = [[[NSButton alloc] initWithFrame:NSMakeRect(0, 0, BUTTON_SIZE, BUTTON_SIZE)] autorelease];
		self.editButton.image = [NSImage imageNamed:NSImageNameActionTemplate];
//		[self.addButton setHidden:NO];
		[self addSubview:self.addButton];
		[self addSubview:self.editButton];
		NSButton * addButton = self.addButton;
		NSButton * editButton = self.editButton;
		NSDictionary * buttonsDictionary = NSDictionaryOfVariableBindings(addButton, editButton);
		NSArray * addButtonHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[addButton(>=25)]|" options:0 metrics:nil views:buttonsDictionary];
		NSArray * addButtonVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[editButton(>=25)][addButton(==editButton)]|" options:0 metrics:nil views:buttonsDictionary];
		NSArray * editButtonHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[editButton(>=25)]|" options:0 metrics:nil views:buttonsDictionary];
		[addButton setTranslatesAutoresizingMaskIntoConstraints:NO];
		[editButton setTranslatesAutoresizingMaskIntoConstraints:NO];
		[self addConstraints:addButtonHConstraints];
		[self addConstraints:addButtonVConstraints];
		[self addConstraints:editButtonHConstraints];
		
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout{
	return YES;
}
//- (void)drawRect:(NSRect)dirtyRect{
//	
//}


@end
