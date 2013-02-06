//
//  Default_HDTableCell.h
//  Germanium
//
//  Created by SadikAli on 9/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Default_HDTableCell : UITableViewCell
{
    IBOutlet UILabel* cellText;
    IBOutlet UIImageView* cellImage;
}

@property(nonatomic,retain)UILabel* cellText;
@property(nonatomic,retain)UIImageView* cellImage;


@end
