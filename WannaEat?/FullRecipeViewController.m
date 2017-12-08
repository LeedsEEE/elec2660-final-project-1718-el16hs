//
//  FullRecipeViewController.m
//  WannaEat?
//
//  Created by Eleni Stavroglou on 27/11/17.
//  Copyright © 2017 Eleni Stavroglou. All rights reserved.
//

#import "FullRecipeViewController.h"
#import "JSON.h"
@interface FullRecipeViewController ()

@end

@implementation FullRecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //now we can display the data:
    _recipeidd.text = _fullrecipeid;
    _recipedetails.text= _fullrecipedetails;
    _title2.text=_fullrecipetitle;
    _image2.image=_fullrecipeimage;
  
}

-(IBAction)saveme:(id)sender{
    NSUserDefaults *defaults5 = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favoritesLoaded = [defaults5 objectForKey:@"favorites"];
    
    NSData *imageData = UIImageJPEGRepresentation(_fullrecipeimage, 1.0);
    
    NSDictionary *fav =@{@"thetitle":_fullrecipetitle,
                         @"theimage":imageData,
                         @"therecipeidd":_recipeidd.text,
                         @"therecipedetails":_fullrecipedetails
                         };
    NSMutableArray *favorites = [NSMutableArray array];
    NSLog(@"Print Array: \n %@",favorites);
    
    if (favoritesLoaded) {
        favorites = [[NSMutableArray alloc] initWithArray:favoritesLoaded];
    } else {
        favorites = [[NSMutableArray alloc] init];
    }
    
    [favorites addObject:fav];
    
    [defaults5 setObject:favorites forKey:@"favorites"];
    [defaults5 synchronize];
    NSLog(@"Print Array: \n %@",favorites);
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

@end
