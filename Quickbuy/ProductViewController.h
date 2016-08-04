//
//  ProductViewController.h
//  Quickbuy
//
//  Created by Mehedi Hasan on 11/16/15.
//  Copyright (c) 2015 Mehedi Hasan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *categoryName;
@property (nonatomic,strong) NSString *categoryId;
@property (nonatomic , strong) NSString *categoryNameremote;
@property (weak, nonatomic) IBOutlet UICollectionView *productCollectionView;

@end
