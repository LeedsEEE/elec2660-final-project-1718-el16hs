//
//  RecipeCellTableViewCell.m
//  WannaEat?
//
//  Created by Eleni Stavroglou on 23/11/17.
//  Copyright © 2017 Eleni Stavroglou. All rights reserved.
//

#import "RecipeCellTableViewCell.h"

@implementation RecipeCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)seDetailsWithRecipe:(recipe *)recipes{
    
    self.title2.text=recipes.title;
    
    NSURL*url=[NSURL URLWithString:recipes.image];
    NSData*imagedata=[NSData dataWithContentsOfURL:url];
    UIImage*imagee=[UIImage imageWithData:imagedata];
    self.image2.image=imagee;
    
}
@end
