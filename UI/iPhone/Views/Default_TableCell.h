//
//  Default_TableCell.h
//  Germanium
//
//  Created by SadikAli on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Default_TableCell : UITableViewCell
{
    IBOutlet UILabel* cellText;
    IBOutlet UIImageView* cellImage;
}

@property(nonatomic,retain)UILabel* cellText;
@property(nonatomic,retain)UIImageView* cellImage;


- (void) initVars;

@end
