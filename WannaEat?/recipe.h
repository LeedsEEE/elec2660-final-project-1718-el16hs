//
//  recipe.h
//  WannaEat?
//
//  Created by Eleni Stavroglou on 23/11/17.
//  Copyright © 2017 Eleni Stavroglou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface recipe : NSObject

//This the datamodel of the app. Here we need to create some strings to use them in a different view controller.
@property(nonatomic,strong)NSString*title;
@property(nonatomic,strong)NSString*image;
@property(nonatomic,strong)NSString*recipeid;

@end
