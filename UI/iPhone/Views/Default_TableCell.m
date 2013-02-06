//
//  Default_TableCell.m
//  Germanium
//
//  Created by SadikAli on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Default_TableCell.h"

@implementation Default_TableCell
@synthesize cellText;
@synthesize cellImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initVars];
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
