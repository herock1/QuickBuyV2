//
//  CategoryviewControllerViewController.h
//  Quickbuy
//
//  Created by Mehedi Hasan on 11/11/15.
//  Copyright (c) 2015 Mehedi Hasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSTableView.h"
@interface CategoryviewControllerViewController : UIViewController<SKSTableViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet SKSTableView *tableView;

@end
