//
//  Default_HDTableCell.m
//  Germanium
//
//  Created by SadikAli on 9/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Default_HDTableCell.h"

@implementation Default_HDTableCell
@synthesize cellText;
@synthesize cellImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) initVars
{
    UIImage *myImage = [[UIImage imageNamed:@"cell_image"] stretchableImageWithLeftCapWidth:160
                                                                               topCapHeight:25];
    UIImageView *myImageView = [[UIImageView alloc] initWithImage:myImage];
    myImageView.frame = self.frame;
    [self setBackgroundView:myImageView];
    [myImageView release];
    //    self.selectionStyle = UITableViewCellSelectionStyleGray;
    //    self.textLabel.backgroundColor = [UIColor clearColor];
    //    self.detailTextLabel.backgroundColor = [UIColor clearColor];
}

@end
