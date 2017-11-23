//
//  ViewController.h
//  WannaEat?
//
//  Created by Eleni Stavroglou on 22/11/17.
//  Copyright © 2017 Eleni Stavroglou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)loginbutton:(id)sender;
- (IBAction)signupbutton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *noaccountlabel;


@end

