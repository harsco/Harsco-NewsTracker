//
//  industrialAirXProducts.h
//  Germanium
//
//  Created by SadikAli on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Default_TableCell.h"
#import "industrialProductsWebVC.h"

@interface industrialAirXProducts : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UINavigationBar* header;
    IBOutlet UITableView* productsTable;
    
    NSMutableArray* productTitles;
}

@property(nonatomic,retain)UINavigationBar* header;
- (void)configureCell:(Default_TableCell *)cell atIndexPath:(NSIndexPath *)indexPath ;

@end
