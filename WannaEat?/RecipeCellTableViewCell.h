//
//  RecipeCellTableViewCell.h
//  WannaEat?
//
//  Created by Eleni Stavroglou on 23/11/17.
//  Copyright © 2017 Eleni Stavroglou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "recipe.h"
@interface RecipeCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UILabel *title2;

-(void)seDetailsWithRecipe:(recipe *)recipes;
@end
