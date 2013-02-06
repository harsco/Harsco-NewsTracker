//
//  indHDIKGProducts.h
//  Germanium
//
//  Created by SadikAli on 9/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Default_HDTableCell.h"
#import "industrialProductsWebVC.h"


@interface indHDIKGProducts : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UINavigationBar* header;
    IBOutlet UITableView* table;
    
    NSMutableArray* productTitles;
    NSMutableArray* imageArray;
}
@property(nonatomic,retain)UINavigationBar* header;
@property(nonatomic,retain)UITableView* table;

@end
