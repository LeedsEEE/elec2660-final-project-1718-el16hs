//
//  MainViewController.h
//  WannaEat?
//
//  Created by Eleni Stavroglou on 23/11/17.
//  Copyright © 2017 Eleni Stavroglou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property(nonatomic,retain)NSMutableArray *recipestitle;
@property(nonatomic,retain)NSMutableArray *recipesimage;
- (IBAction)search:(id)sender;
- (IBAction)ifeellucky:(id)sender;
@property(nonatomic,retain)NSMutableArray*fullrecipe;
//@property(weak,nonatomic)IBOutlet UITextView*searchbox;
@property(weak,nonatomic)IBOutlet UITextField*searchbox;
@end
