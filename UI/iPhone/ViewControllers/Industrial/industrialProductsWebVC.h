//
//  industrialProductsWebVC.h
//  Germanium
//
//  Created by SadikAli on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "metalsInnovationDetailsViewController.h"

@interface industrialProductsWebVC : metalsInnovationDetailsViewController
{
    NSString* productTitle;
}

@property(nonatomic,retain)NSString* productTitle;

@end
