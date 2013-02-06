//
//  industrialProductsDetailVC.h
//  Germanium
//
//  Created by SadikAli on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Default_TableCell.h"
@interface industrialProductsDetailVC : UITableViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSString* referenceKey;
    NSMutableDictionary* productDictionary;
    
    //Arrays for each product line
    
    NSMutableArray* stockPanels;
    NSMutableArray* fabricatedGrating;
    NSMutableArray* mezzanineGrating;
    NSMutableArray* mebac;
    NSMutableArray* higg;
    NSMutableArray* specialityProducts;
    
    NSMutableArray* imageArray;
    NSMutableArray* pickerDataArray;
    
    UIPickerView* pickerView;
    
}

-(id)initWithKey:(NSString*)key;

-(void)initImages;
-(void)initPickerArray:(NSInteger)row;

@end
