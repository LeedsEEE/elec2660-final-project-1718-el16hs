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


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //we initiliaze the arrays.
    self.recipestitle=[[NSMutableArray alloc]init];
    self.recipesimage=[[NSMutableArray alloc]init];
    self.fullrecipe=[[NSMutableArray alloc]init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

 //In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
      if ([segue.identifier isEqualToString:@"segue2"]) {
    FullRecipeViewController*destViewController = segue.destinationViewController;
    NSString *str = @"http://food2fork.com/api/get?key=6131e7aabf3511307b540284e63641ab&rId=";
    
    int r = 35000+arc4random() % 1000;
    str = [str stringByAppendingString:[NSString stringWithFormat:@"%d", r]];
    
    NSError *error;
    NSString *url_string = [NSString stringWithFormat:str];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    NSDictionary *bitlyJSON1= [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    
    NSDictionary *myresponse=[bitlyJSON1 objectForKey:@"recipe"];
    destViewController.fullrecipetitle=[myresponse objectForKey:@"title"];
          NSURL *imageURL = [NSURL URLWithString:[myresponse objectForKey:@"image_url"]];
          NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
          UIImage *image = [UIImage imageWithData:imageData];//[imageData release];
          UIGraphicsBeginImageContextWithOptions(CGSizeMake(250,200), YES, 0);
          [image drawInRect:CGRectMake(0,0,250,200)];
          UIImage* im3 = UIGraphicsGetImageFromCurrentImageContext();
          UIGraphicsEndImageContext();
          
    NSDictionary *myresponse2=[myresponse objectForKey:@"ingredients"];
    
    NSString *contenttext = @"";
    for (NSDictionary *item in myresponse2){
        
        contenttext= [contenttext stringByAppendingString:[NSString stringWithFormat:@"%@", item]];
        contenttext= [contenttext stringByAppendingString:[NSString stringWithFormat:@"%s", "\n"]];
    }
          destViewController.fullrecipedetails=contenttext;
          destViewController.fullrecipeid=[NSString stringWithFormat:@"%d", r];
          destViewController.fullrecipeimage=im3;
}
}

    - (IBAction)search:(id)sender {
        
        NSString *strURL = @"http://food2fork.com/api/search?key=6131e7aabf3511307b540284e63641ab&q=";
        NSString *strsearch = [self.searchbox.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        strURL = [strURL stringByAppendingString:strsearch];
        
        NSLog(@"the resulting url is %@",strURL);
        
        NSError *error;
       // NSString *url_string = [NSString stringWithFormat:strURL];
        NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:strURL]];
        
        NSDictionary *bitlyJSON= [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
       
        
        NSDictionary *recipearray=[bitlyJSON objectForKey:@"recipes"];
                    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                    NSUserDefaults *defaults1=[NSUserDefaults standardUserDefaults];
                    NSUserDefaults *defaults2=[NSUserDefaults standardUserDefaults];
                   
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ktitle"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [self.recipestitle removeAllObjects];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kimage"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [self.recipesimage removeAllObjects];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"krecipe"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [self.fullrecipe removeAllObjects];
                    
                    for (NSDictionary*dic in recipearray) {
                        
                        [self.recipestitle addObject:[dic objectForKey:@"title"]];
                        [defaults setObject:self.recipestitle forKey:@"ktitle"];
                        [defaults synchronize];
                        
                        [self.recipesimage addObject:[dic objectForKey:@"image_url"]];
                        [defaults1 setObject:self.recipesimage forKey:@"kimage"];
                        [defaults1 synchronize];
                        
                        [self.fullrecipe addObject:[dic objectForKey:@"recipe_id"]];
                        [defaults2 setObject:self.fullrecipe forKey:@"krecipe"];
                        [defaults2 synchronize];
                        
                    }
                   
}
   
-(IBAction)ifeellucky:(id)sender{
}

@end
