//
//  ProductViewController.m
//  Quickbuy
//
//  Created by Mehedi Hasan on 11/16/15.
//  Copyright (c) 2015 Mehedi Hasan. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductCell.h"
#import "ProductsDetailsController.h"
@interface ProductViewController ()
@property NSMutableArray  *categoryObject;
@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _categoryObject = [[ NSMutableArray alloc] init];
    self.categoryName.text = _categoryNameremote;
        [self loadCategoryProductJson];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

-(void)loadCategoryProductJson
{
    // NSString *currentURL=homrurl;
    NSString * categoryurls = [NSString stringWithFormat:@"%@%@",categoryallproduct,_categoryId];
    NSLog(@"%@",categoryurls);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:categoryurls parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON return Object: %@",responseObject);
     _categoryObject   =responseObject;
        [_productCollectionView reloadData];
       
    }
     
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
    
}
#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {

    return [_categoryObject count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"productcell" forIndexPath:indexPath];
 //   cell.layer.borderWidth =1.0f;
    
    NSDictionary *productdetails = [_categoryObject objectAtIndex:indexPath.row];
    NSString *imageurl = [NSString stringWithFormat:@"%@%@",imagebase, [productdetails objectForKey:@"image"]];
    NSLog(@"%@",imageurl);
    NSString* encodedUrl = [imageurl stringByAddingPercentEscapesUsingEncoding:
                            NSUTF8StringEncoding]; //Encode URL
  
    NSURL *url = [NSURL URLWithString:encodedUrl];
    cell.imageView.layer.borderWidth=1.0f;
    cell.imageView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [cell.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"no-image.jpg"]];
    cell.productName.text = [productdetails objectForKey:@"name"];
    cell.price.text = [productdetails objectForKey:@"price"];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ProductsDetailsController *product = (ProductsDetailsController *)[storyboard instantiateViewControllerWithIdentifier:@"details"];
   NSDictionary *productdetails = [_categoryObject objectAtIndex:indexPath.row];
   
    product. productId= [productdetails objectForKey:@"product_id"];

    [self.navigationController pushViewController:product animated:YES];
}

- (IBAction)backToCategory:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
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
