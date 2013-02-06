//
//  competitorListVC.h
//  Germanium
//
//  Created by SadikAli on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "newsItemsVC.h"


@interface competitorListVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView* competitorTable;
    IBOutlet UINavigationBar* newsHeader;
    
    NSMutableArray* dataArray;
    
    NSMutableArray* sectionArray;
    
    
    NSMutableDictionary* divisionDict;
}

@property(nonatomic,retain)UITableView* competitorTable;
@property(nonatomic,retain)UINavigationBar* newsHeader;

@end
