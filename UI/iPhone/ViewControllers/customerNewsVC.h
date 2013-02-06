//
//  customerNewsVC.h
//  Germanium
//
//  Created by SadikAli on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSParser.h"
#import "App_GeneralUtilities.h"
#import "newsWebVC.h"

@interface customerNewsVC : UIViewController<UITableViewDataSource,UITableViewDelegate,rssparserdelegate>
{
    IBOutlet UITableView* newsTable;
    IBOutlet UINavigationBar* newsHeader;
    
    NSMutableArray* dataArray;
}

@property(nonatomic,retain)IBOutlet UITableView* newsTable;
@property(nonatomic,retain)UINavigationBar* newsHeader;


@end
