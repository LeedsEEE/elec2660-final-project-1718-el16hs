//
//  MainTableViewController.h
//  WannaEat?
//
//  Created by Eleni Stavroglou on 23/11/17.
//  Copyright © 2017 Eleni Stavroglou. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "FullRecipeViewController.h"
@interface MainTableViewController : UITableViewController
@property(nonatomic,retain)NSMutableArray *recipestitle;
@property(nonatomic,retain)NSMutableArray *recipesimage;
@property(nonatomic,retain)NSMutableArray*fullrecipe;
@property(nonatomic,retain)NSMutableArray*directions;
@end
