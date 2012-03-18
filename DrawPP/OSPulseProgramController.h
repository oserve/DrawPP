//
//  OSPulseProgramController.h
//  DrawPP
//
//  Created by Olivier Serve on 10/03/12.
//  Copyright (c) 2012 MyOwnCompany. All rights reserved.
//

#import "OSPulprog.h"

@interface OSPulseProgramController : NSObject

@property (weak,atomic) IBOutlet NSTableView * pulseProgramView;
@property (weak, atomic) IBOutlet OSPulprog * dataSource; //Replace by a protocol
@property (strong, atomic) NSMutableArray * channelControllers;//Maybe NSMutableDictionnary would be more suitable
@end
