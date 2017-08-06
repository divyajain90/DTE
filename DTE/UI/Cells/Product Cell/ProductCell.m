//
//  ProductCell.m
//  DTE
//
//  Created by Divya Jain on 5/2/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.btnAddToCart.layer.cornerRadius = 4;
    self.btnAddToCart.layer.masksToBounds = YES;

    self.btnProdDetail.layer.cornerRadius = 4;
    self.btnProdDetail.layer.masksToBounds = YES;
    
    self.btnProdWeight.layer.cornerRadius = 4;
    self.btnProdWeight.layer.masksToBounds = YES;
    self.btnProdWeight.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.btnProdWeight.layer.borderWidth = 0.5;


    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
