//
//  newsHDdetails.h
//  Germanium
//
//  Created by SadikAli on 9/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseHDWebview.h"

@interface newsHDdetails : baseHDWebview
{
    NSString* urlstring;
}

@property(nonatomic,retain)NSString* urlstring;

@end
