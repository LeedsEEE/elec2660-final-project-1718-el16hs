//
//  MainTableViewController.m
//  WannaEat?
//
//  Created by Eleni Stavroglou on 23/11/17.
//  Copyright © 2017 Eleni Stavroglou. All rights reserved.
//

#import "MainTableViewController.h"

//#import "MainViewController.h"

@interface MainTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation MainTableViewController  

- (void)viewDidLoad {
    [super viewDidLoad]; 
    self.navigationController.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed: @"energy-food.jpg"]];
    //self.tableView.backgroundColor=[UIColor clearColor];
    
    [[NSUserDefaults standardUserDefaults ] synchronize];
     NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
     self.recipestitle =[defaults objectForKey:@"ktitle"];
    
    
   NSUserDefaults*defaults1=[NSUserDefaults standardUserDefaults];
  self.recipesimage=[defaults1 objectForKey:@"kimage"];

    
   NSUserDefaults*defaults2=[NSUserDefaults standardUserDefaults];
   self.fullrecipe =[defaults2 objectForKey:@"krecipe"];
    
    
    NSUserDefaults*defaults3=[NSUserDefaults standardUserDefaults];
    self.directions =[defaults3 objectForKey:@"kdirections"];
   // // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"how many rows%lu",self.recipestitle.count );
    return [self.recipestitle count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
    cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.lineBreakMode =NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text=[self.recipestitle objectAtIndex:indexPath.row];
    
    NSURL *imageURL = [NSURL URLWithString:[self.recipesimage objectAtIndex:indexPath.row]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];    //[imageData release];
    
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(64,64), YES, 0);
    [image drawInRect:CGRectMake(0,0,64,64)];
    UIImage* im2 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    cell.imageView.image = im2;
    cell.imageView.contentMode = UIViewContentModeCenter;
   
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0; // edit this return value to your liking
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        FullRecipeViewController*destViewController = segue.destinationViewController;
        destViewController.fullrecipeid = [self.fullrecipe objectAtIndex:indexPath.row];
    
    NSString *str = @"http://food2fork.com/api/get?key=6131e7aabf3511307b540284e63641ab&rId=";
    str = [str stringByAppendingString:[self.fullrecipe objectAtIndex:indexPath.row]];
    
        NSError *error;
        NSString *url_string = [NSString stringWithFormat:str];
        NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
        NSDictionary *bitlyJSON1= [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
      
        
        NSDictionary *myresponse=[bitlyJSON1 objectForKey:@"recipe"];
       
        destViewController.fullrecipetitle=[myresponse objectForKey:@"title"];
        destViewController.fullrecipeimage=[myresponse objectForKey:@"image_url"];
        
        NSDictionary *myresponse2=[myresponse objectForKey:@"ingredients"];
        
        NSString *contenttext = @"";
        for (NSDictionary *item in myresponse2){
            
            contenttext= [contenttext stringByAppendingString:[NSString stringWithFormat:@"%@", item]];
            contenttext= [contenttext stringByAppendingString:[NSString stringWithFormat:@"%s", "\n"]];
        }
        destViewController.fullrecipedetails=contenttext;
        NSURL *imageURL = [NSURL URLWithString:[self.recipesimage objectAtIndex:indexPath.row]];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];//[imageData release];
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(250,200), YES, 0);
        [image drawInRect:CGRectMake(0,0,250,200)];
        UIImage* im3 = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        destViewController.fullrecipeimage=im3;
        
        destViewController.recipedirections=[self.directions objectAtIndex:indexPath.row];
       // NSLog(@"aaaaaa%@",destViewController.recipedirections);
        
        NSUserDefaults *defaults4=[NSUserDefaults standardUserDefaults];
        [defaults4 setObject: destViewController.recipedirections forKey:@"kmethod"];
        [defaults4 synchronize];

}
}

@end
