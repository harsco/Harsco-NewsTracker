//
//  infraProductsVC.h
//  Germanium
//
//  Created by SadikAli on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Default_TableCell.h"
#import "industrialProductsWebVC.h"

@interface infraProductsVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView* infraProducts;
    
    IBOutlet UINavigationBar* infrastructureHeader;
    
    NSMutableArray* productsArray;
    
}

@property(nonatomic,retain)UINavigationBar* infrastructureHeader;

-(void)onHomeClick:(id)sender;


@end
