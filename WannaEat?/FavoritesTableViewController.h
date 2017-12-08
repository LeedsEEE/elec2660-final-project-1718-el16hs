//
//  FavoritesTableViewController.h
//  WannaEat?
//
//  Created by Eleni Stavroglou on 7/12/17.
//  Copyright © 2017 Eleni Stavroglou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesTableViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)NSMutableArray*favoritesLoaded;
@end
