//
//  MainViewController.m
//  WannaEat?
//
//  Created by Eleni Stavroglou on 23/11/17.
//  Copyright © 2017 Eleni Stavroglou. All rights reserved.
//

#import "MainViewController.h"
#import "JSON.h"
#import "recipe.h"
#import "MainTableViewController.h"
#import "RecipeCellTableViewCell.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)search:(id)sender {
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:@"http://food2fork.com/api/search?key=6131e7aabf3511307b540284e63641ab&q=shredded%20chicken"]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                // handle response
                
                NSError*e=nil;
                NSDictionary*bitlyJSON=[NSJSONSerialization JSONObjectWithData:data options:0 error:&e];
                NSLog(@"results******%@",bitlyJSON);
                
                NSArray*recipearray =[bitlyJSON objectForKey:@"recipes"];
                self.recipes2=[[NSMutableArray alloc]init];
                for (NSDictionary*dic in recipearray) {
                    recipe*recipes=[[recipe alloc]init];
                    recipes.title=[dic objectForKey:@"title"];
                    recipes.image=[dic objectForKey:@"image_url"];
                    recipes.recipeid=[dic objectForKey:@"recipe_id"];
                    
                    [_recipes2 addObject:recipes];
                    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                    [defaults setObject:_recipes2 forKey:@"ka"];
                    [defaults synchronize];
                    
                    
                }
                
            }] resume];
}

@end
