//
//  FullRecipeViewController.h
//  WannaEat?
//
//  Created by Eleni Stavroglou on 27/11/17.
//  Copyright © 2017 Eleni Stavroglou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "recipe.h"
#import "MainTableViewController.h"
@interface FullRecipeViewController : UIViewController
@property(weak,nonatomic)IBOutlet UILabel *recipeidd; 
@property(weak,nonatomic)IBOutlet UILabel *recipedetails;
@property(weak,nonatomic)IBOutlet UIImageView *image2;
@property(weak,nonatomic)IBOutlet UILabel *title2;
//@property(nonatomic,retain)recipe*allrecipes;
@property(nonatomic,retain)NSString*fullrecipeid;
@property(nonatomic,retain)NSString*fullrecipedetails;
@property(nonatomic,retain)NSString*fullrecipetitle;
@property(nonatomic,retain)NSString*fullrecipeimage;

@end
