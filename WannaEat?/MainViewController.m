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
    self.recipestitle=[[NSMutableArray alloc]init];
    self.recipesimage=[[NSMutableArray alloc]init];
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
                    //NSLog(@"results******%@",bitlyJSON);
                    
                    NSArray*recipearray =[bitlyJSON objectForKey:@"recipes"];
                    
                    for (NSDictionary*dic in recipearray) {
                        
                        recipe*allrecipes=[[recipe alloc]init];
                        allrecipes.title=[dic objectForKey:@"title"];
                        allrecipes.image=[dic objectForKey:@"image_url"];
                        allrecipes.recipeid=[dic objectForKey:@"recipe_id"];
                        
                        [self.recipestitle addObject:allrecipes.title];
                        NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
                        [defaults setObject:self.recipestitle forKey:@"ktitle"];
                        [defaults synchronize];
                        
                        [self.recipesimage addObject:allrecipes.image];                       NSUserDefaults*defaults1=[NSUserDefaults standardUserDefaults];
                        [defaults1 setObject:self.recipesimage forKey:@"kimage"];
                        [defaults1 synchronize];
                    
                    }
                   // NSLog(@"ssssssssss%@",self.recipesimage);
                }] resume];
    
   
}

@end
