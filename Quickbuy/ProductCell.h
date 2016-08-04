//
//  ProductCell.h
//  Quickbuy
//
//  Created by Mehedi Hasan on 11/16/15.
//  Copyright (c) 2015 Mehedi Hasan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
