//
//  MainViewController.h
//  WannaEat?
//
//  Created by Eleni Stavroglou on 23/11/17.
//  Copyright © 2017 Eleni Stavroglou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITextFieldDelegate>

//we need arrays in which we can store the titles,images,ids and details of the recipes.
@property(nonatomic,retain)NSMutableArray *recipestitle;
@property(nonatomic,retain)NSMutableArray *recipesimage;
@property(nonatomic,retain)NSMutableArray*fullrecipe;
@property(nonatomic,retain)NSMutableArray*directions;
//this is the textbox where i can type the ingredients.
@property(weak,nonatomic)IBOutlet UITextField*searchbox;

- (IBAction)search:(id)sender;
- (IBAction)ifeellucky:(id)sender;
@end
