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
    
    //we initiliaze the arrays.
    self.recipestitle=[[NSMutableArray alloc]init];
    self.recipesimage=[[NSMutableArray alloc]init];
    self.fullrecipe=[[NSMutableArray alloc]init];
    self.directions=[[NSMutableArray alloc]init];
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
   
    //now we need to merge a standard url with a random recipe id.
    NSString *str = @"http://food2fork.com/api/get?key=6131e7aabf3511307b540284e63641ab&rId=";
    // This random id can be calculated as:
    int r = 35000+arc4random() % 1000;
    str = [str stringByAppendingString:[NSString stringWithFormat:@"%d", r]];
    
    //in order to get the information we need from the API address, we need to pass the link through a JSON parse.
    NSError *error;
    NSString *url_string = [NSString stringWithFormat:str];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    NSDictionary *bitlyJSON1= [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    //now we read specific information(recipe,title,image,ingredients,method) from the API using the objectForKey.
    NSDictionary *myresponse=[bitlyJSON1 objectForKey:@"recipe"];
    destViewController.fullrecipetitle=[myresponse objectForKey:@"title"];
    NSURL *imageURL = [NSURL URLWithString:[myresponse objectForKey:@"image_url"]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(250,200), YES, 0);
    [image drawInRect:CGRectMake(0,0,250,200)];
    UIImage* im3 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
          
    NSDictionary *myresponse2=[myresponse objectForKey:@"ingredients"];
    
    NSString *contenttext = @"";
    for (NSDictionary *item in myresponse2){
        
        contenttext= [contenttext stringByAppendingString:[NSString stringWithFormat:@"%@", item]];
        contenttext= [contenttext stringByAppendingString:[NSString stringWithFormat:@"%s", "\n"]];//to make each ingrendient being displayed in different rows.
    }
        //now we pass the data to the next view controller(FullRecipeViewController).
          destViewController.fullrecipedetails=contenttext;
          destViewController.fullrecipeid=[NSString stringWithFormat:@"%d", r];
          destViewController.fullrecipeimage=im3;
          
          destViewController.recipedirections=[myresponse objectForKey:@"source_url"];
          //saving the url to use it later through nsuserdefaults.
          NSUserDefaults *defaults4=[NSUserDefaults standardUserDefaults];
          [defaults4 setObject: destViewController.recipedirections forKey:@"kmethod"];
          [defaults4 synchronize];
}
}
//by clicking on the search button:
    - (IBAction)search:(id)sender {
        //again here we combine the standard part of the url with the ingredient typed on textbox.
        NSString *strURL = @"http://food2fork.com/api/search?key=6131e7aabf3511307b540284e63641ab&q=";
        NSString *strsearch = [self.searchbox.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        strURL = [strURL stringByAppendingString:strsearch];
        
        NSLog(@"the resulting url is %@",strURL);
        
        NSError *error;
    
        NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:strURL]];
        NSDictionary *bitlyJSON= [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
       
        
        NSDictionary *recipearray=[bitlyJSON objectForKey:@"recipes"];
        //we save the information in a default for different keys to gain access to them in another view controller while we delete the results from the previous search.
                    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                    NSUserDefaults *defaults1=[NSUserDefaults standardUserDefaults];
                    NSUserDefaults *defaults2=[NSUserDefaults standardUserDefaults];
                    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
                   
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ktitle"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [self.recipestitle removeAllObjects];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kimage"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [self.recipesimage removeAllObjects];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"krecipe"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [self.fullrecipe removeAllObjects];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ktitle"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [self.directions removeAllObjects];
        
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
                        
                        [self.directions addObject:[dic objectForKey:@"source_url"]];
                        [defaults3 setObject:self.directions forKey:@"kdirections"];
                        [defaults3 synchronize];
                        
                    }
                   
}
   
-(IBAction)ifeellucky:(id)sender{
}

@end
