//
//  CategoryviewControllerViewController.m
//  Quickbuy
//
//  Created by Mehedi Hasan on 11/11/15.
//  Copyright (c) 2015 Mehedi Hasan. All rights reserved.
//

#import "CategoryviewControllerViewController.h"
#import "SKSTableView.h"
#import "SKSTableViewCell.h"
#import "ProductViewController.h"
@interface CategoryviewControllerViewController ()
@property (nonatomic, strong) NSArray *contents;
@property (nonatomic, strong) NSMutableArray *catdata;
@end

@implementation CategoryviewControllerViewController

- (NSArray *)contents
{
    if (!_contents) {
        _contents = @[@[@[@"Section0_Row0", @"Row0_Subrow1",@"Row0_Subrow2"],
                        @[@"Section0_Row1", @"Row1_Subrow1", @"Row1_Subrow2", @"Row1_Subrow3", @"Row1_Subrow4", @"Row1_Subrow5", @"Row1_Subrow6", @"Row1_Subrow7", @"Row1_Subrow8", @"Row1_Subrow9", @"Row1_Subrow10", @"Row1_Subrow11", @"Row1_Subrow12"],
                        @[@"Section0_Row2"]],
                      @[@[@"Section1_Row0", @"Row0_Subrow1", @"Row0_Subrow2", @"Row0_Subrow3"],
                        @[@"Section1_Row1"],
                        @[@"Section1_Row2", @"Row2_Subrow1", @"Row2_Subrow2", @"Row2_Subrow3", @"Row2_Subrow4", @"Row2_Subrow5"]]];
    }
    
    return _contents;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.SKSTableViewDelegate = self;
    [self Loadjson];
}

-(void)Loadjson
{
    // NSString *currentURL=homrurl;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:categooryurl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON return Object: %@",responseObject);
        _catdata= [responseObject objectForKey:@"categories"];
   //     NSLog(@"%lu",(unsigned long)[_catdata count]);
        for (int i=0; i<[_catdata count]; i++) {
            NSDictionary *catdic = [_catdata objectAtIndex:i];
            NSMutableArray     *subcatarr= [catdic objectForKey:@"subcategories"];
               [self.tableView reloadData];
//            for (int j=0; j<[subcatarr count]; j++) {
//                
//            }

        }
     
    }
     
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSLog(@"Error: %@", error);
             
             
         }];
    
 
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_catdata count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        NSDictionary *catdic = [_catdata objectAtIndex:indexPath.section];
        NSMutableArray     *subcatarr= [catdic objectForKey:@"subcategories"];
    return [subcatarr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    
    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    NSDictionary *catdic = [_catdata objectAtIndex:indexPath.section];
 //   NSMutableArray     *subcatarr= [catdic objectForKey:@"subcategories"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[catdic objectForKey:@"name"]];
    cell.textLabel.font = [UIFont fontWithName:nil size:14];
    NSString *imageName =[NSString stringWithFormat:@"%d.png",indexPath.section+1];
    cell.imageView.image = [UIImage imageNamed:imageName];
    if ((indexPath.section == 0 && (indexPath.row == 1 || indexPath.row == 0)) || (indexPath.section == 1 && (indexPath.row == 0 || indexPath.row == 2)))
        cell.isExpandable = YES;
    else
        cell.isExpandable = YES;
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    NSDictionary *catdic = [_catdata objectAtIndex:indexPath.section];
    NSMutableArray     *subcatarr= [catdic objectForKey:@"subcategories"];
    NSDictionary *subcatdic = [ subcatarr objectAtIndex:indexPath.subRow-1];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[subcatdic objectForKey:@"name"]];
    cell.textLabel.font = [UIFont fontWithName:nil size:13];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row !=0) {
       // NSLog(@"%ld %ld",(long)indexPath.section, (long)indexPath.row);
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ProductViewController *product = (ProductViewController *)[storyboard instantiateViewControllerWithIdentifier:@"totalproduct"];
        NSDictionary *catdic = [_catdata objectAtIndex:indexPath.section];
        NSMutableArray     *subcatarr= [catdic objectForKey:@"subcategories"];
        NSDictionary *subcatdic = [ subcatarr objectAtIndex:indexPath.row-1];
     //   cell.textLabel.text = [NSString stringWithFormat:@"%@",[subcatdic objectForKey:@"name"]];
        product.categoryId = [subcatdic objectForKey:@"category_id"];
        product.categoryNameremote =[subcatdic objectForKey:@"name"];
        [self.navigationController pushViewController:product animated:YES];
    }
}

- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath{
   
}
- (IBAction)Done:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
