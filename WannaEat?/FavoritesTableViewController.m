//
//  FavoritesTableViewController.m
//  WannaEat?
//
//  Created by Eleni Stavroglou on 7/12/17.
//  Copyright © 2017 Eleni Stavroglou. All rights reserved.
//

#import "FavoritesTableViewController.h"
#import "FullRecipeViewController.h"
@interface FavoritesTableViewController ()

@end
//@synthesize tableView;
@implementation FavoritesTableViewController
{
    NSArray *alltitles;
    NSArray *allImages;
    NSArray*alldetails;
    NSArray*allids;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [[NSUserDefaults standardUserDefaults ] synchronize];
    
    NSUserDefaults*defaults5=[NSUserDefaults standardUserDefaults];
    self.favoritesLoaded =[defaults5 objectForKey:@"favorites"];
    alldetails=[self.favoritesLoaded valueForKey:@"therecipedetails"];
    allids=[self.favoritesLoaded valueForKey:@"therecipeidd"];
    alltitles = [self.favoritesLoaded valueForKey:@"thetitle"];
    //NSLog(@"%@", alltheimagetitles);
    
    allImages = [self.favoritesLoaded valueForKey:@"theimage"];
   // [self.tableView reloadData];
    //NSLog(@"%@", allImages);
    
    //NSLog(@"the favorites recipes are: \n %@",self.favoritesLoaded);

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
   // [super viewWillAppear:YES];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.favoritesLoaded count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    
    NSData *imageData = [allImages objectAtIndex:indexPath.row];
    UIImage *image = [UIImage imageWithData:imageData];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(64,64), YES, 0);//we need to resize the image so that it fit in the cell.
    [image drawInRect:CGRectMake(0,0,64,64)];
    UIImage* im2 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    // Configure the cell...
    cell.textLabel.text = [alltitles objectAtIndex:indexPath.row];
    cell.imageView.image = im2;
    //cell.imageView.image = im2;
    
    return cell;
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
/*
//In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"segue3"]) {
        //here we will use the code written for a random recipe,but slightly different this time.
        //we need to pass the information of the chosen recipe in the cell to the other view controller,but this time for the specific recipeid. Recipeid correpsonds to a number which is unique for each recipe. So now it's easier for us to pass the data for the specific recipe,using this id.
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        FullRecipeViewController*destViewController = segue.destinationViewController;
        destViewController.fullrecipeid = [allids objectAtIndex:indexPath.row];
        
        NSString *str = @"http://food2fork.com/api/get?key=6131e7aabf3511307b540284e63641ab&rId=";
        str = [str stringByAppendingString:[allids objectAtIndex:indexPath.row]];
        
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
        NSURL *imageURL = [NSURL URLWithString:[allImages objectAtIndex:indexPath.row]];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];//[imageData release];
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(250,200), YES, 0);
        [image drawInRect:CGRectMake(0,0,250,200)];
        UIImage* im3 = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        destViewController.fullrecipeimage=im3;
        
        destViewController.recipedirections=[alldetails objectAtIndex:indexPath.row];
        NSUserDefaults *defaults4=[NSUserDefaults standardUserDefaults];
        [defaults4 setObject: destViewController.recipedirections forKey:@"kmethod"];
        [defaults4 synchronize];
        
    }
}
*/

@end
