//
//  metalsInnovationsViewController.h
//  Germanium
//
//  Created by SadikAli on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Default_TableCell.h"
#import "metalsInnovationDetailsViewController.h"

@interface metalsInnovationsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView* innovationsTable;
    IBOutlet UINavigationBar* metalHeader;
    
    NSMutableArray* dataArray;
}


@property(nonatomic,retain)UITableView* innovationsTable;
@property(nonatomic,retain)UINavigationBar* metalHeader;
@property(nonatomic,retain)NSMutableArray* dataArray;
-(void)initVars;

@end
