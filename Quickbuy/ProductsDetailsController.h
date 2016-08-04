//
//  ProductsDetailsController.h
//  Quickbuy
//
//  Created by Mehedi Hasan on 11/18/15.
//  Copyright (c) 2015 Mehedi Hasan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductsDetailsController : UIViewController
@property (strong , nonatomic ) NSString *productId;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *descriptions;
@property (weak, nonatomic) IBOutlet UIImageView *banner;


@end
