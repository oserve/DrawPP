//
//  OSPulseProgramController.h
//  DrawPP
//
//  Created by Olivier Serve on 10/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import "OSPulseProgramControllerDataSourceProtocol.h"

@interface OSPulseProgramController : NSObject

@property (weak, atomic) IBOutlet NSTableView * pulseProgramView;
@property (weak, atomic) IBOutlet id <OSPulseProgramControllerDataSourceProtocol> programDataSource;

@end
