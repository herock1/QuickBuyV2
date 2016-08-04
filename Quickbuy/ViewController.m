//
//  ViewController.m
//  Quickbuy
//
//  Created by Mehedi Hasan on 10/21/15.
//  Copyright (c) 2015 Mehedi Hasan. All rights reserved.
//

#import "ViewController.h"
#import "HomeCell.h"
#import "CategoryviewControllerViewController.h"
#import "ProductViewController.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UINavigationControllerDelegate>
@property(strong , nonatomic) NSMutableArray *products;
@property(strong , nonatomic) NSMutableArray *products1;
@property(strong , nonatomic) NSMutableArray *products2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.category1 reloadData];
    [self.category2 reloadData];
    _products= [[NSMutableArray alloc] init];
    _products1= [[NSMutableArray alloc] init];
    _products2= [[NSMutableArray alloc] init];
    [_scrollview setScrollEnabled:YES];
    [self Loadjson];
    [self.category1 reloadData];
      [self.category2 reloadData];
    [self.category3 reloadData];
    

}

-(void)Loadjson
{
    // This method will Retrive server Json
    // NSString *currentURL=homrurl;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:homrurl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON return Object: %@",responseObject);
        
        NSMutableArray *catobject= [responseObject objectForKey:@"categories"]; //Load response object categories
        for (int i=0; i<[catobject count]; i++) {
            NSDictionary *catdic = [catobject objectAtIndex:i];
            NSMutableArray     *subcatarr= [catdic objectForKey:@"subcategories"]; //load response object subcategories
            for (int j=0; j<[subcatarr count]; j++) {
                if (i==0) {
                        [_products addObject:[subcatarr objectAtIndex:j]]; // this mutablearray will store first collection cell data will be use further
                }
                if (i==1) {
                 
                    [_products1 addObject:[subcatarr objectAtIndex:j]];
                }
                if (i==2) {
                    [_products2 addObject:[subcatarr objectAtIndex:j]];
                 
                }
            
            }
 
        }

        [self.category1 reloadData];
        [self.category2 reloadData];
        [self.category3 reloadData];
    }
  
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];

}
- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    
    int imgCount = 0;
    if(collectionView.tag==0)
    {
      imgCount=  [_products count];
    }
    if(collectionView.tag==1)
    {
        imgCount = [_products1 count];
    }
    if(collectionView.tag==2)
    {
        imgCount = [_products2 count];
    }
    return imgCount;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
       HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cvcell" forIndexPath:indexPath];
        cell.layer.borderWidth=1.0f;
        cell.layer.borderColor=[UIColor lightGrayColor].CGColor;
    if (collectionView.tag == 0) {

        NSDictionary *temp= [_products objectAtIndex:indexPath.row];
        NSString *imageurl = [NSString stringWithFormat:@"%@%@",imagebase, [temp objectForKey:@"image"]];
        NSString* encodedUrl = [imageurl stringByAddingPercentEscapesUsingEncoding:
                                NSUTF8StringEncoding]; //Encode URL
        NSLog(@"%@",imageurl);
        NSURL *url = [NSURL URLWithString:encodedUrl];
        [cell.Homeimageview setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1.jpg"]];
        cell.nameLabel.text =  [temp objectForKey:@"name"];
    }
    
    if (collectionView.tag == 1) {
        NSDictionary *temp= [_products1 objectAtIndex:indexPath.row];
        NSString *imageurl = [NSString stringWithFormat:@"%@%@",imagebase, [temp objectForKey:@"image"]];
        NSString* encodedUrl = [imageurl stringByAddingPercentEscapesUsingEncoding:
                                NSUTF8StringEncoding]; //Encode URL
        NSLog(@"%@",imageurl);
        NSURL *url = [NSURL URLWithString:encodedUrl];
        [cell.Homeimageview setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1.jpg"]];
         cell.nameLabel.text =  [temp objectForKey:@"name"];
    }
    if (collectionView.tag == 2) {
        NSDictionary *temp= [_products2 objectAtIndex:indexPath.row];
        NSString *imageurl = [NSString stringWithFormat:@"%@%@",imagebase, [temp objectForKey:@"image"]];
        NSString* encodedUrl = [imageurl stringByAddingPercentEscapesUsingEncoding:
                                NSUTF8StringEncoding]; //Encode URL
        NSURL *url = [NSURL URLWithString:encodedUrl];
        [cell.Homeimageview setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1.jpg"]];
         cell.nameLabel.text =  [temp objectForKey:@"name"];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
//    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
//    datasetCell.backgroundColor = [UIColor blueColor]; // highlight selection
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ProductViewController *product = (ProductViewController *)[storyboard instantiateViewControllerWithIdentifier:@"totalproduct"];

    if (collectionView.tag == 0) {
        NSDictionary *catdic = [_products objectAtIndex:indexPath.row];
  
        //   cell.textLabel.text = [NSString stringWithFormat:@"%@",[subcatdic objectForKey:@"name"]];
        product.categoryId = [catdic objectForKey:@"category_id"];
        product.categoryNameremote =[catdic objectForKey:@"name"];
    }
    if (collectionView.tag == 1) {
        NSDictionary *catdic = [_products1 objectAtIndex:indexPath.row];
        
        //   cell.textLabel.text = [NSString stringWithFormat:@"%@",[subcatdic objectForKey:@"name"]];
        product.categoryId = [catdic objectForKey:@"category_id"];
        product.categoryNameremote =[catdic objectForKey:@"name"];
    }
    if (collectionView.tag == 2) {
        NSDictionary *catdic = [_products2 objectAtIndex:indexPath.row];
        
        //   cell.textLabel.text = [NSString stringWithFormat:@"%@",[subcatdic objectForKey:@"name"]];
        product.categoryId = [catdic objectForKey:@"category_id"];
        product.categoryNameremote =[catdic objectForKey:@"name"];
    }
  
    [self.navigationController pushViewController:product animated:YES];
    
}

- (IBAction)showMenu:(id)sender {
    

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CategoryviewControllerViewController *viewController = (CategoryviewControllerViewController *)[storyboard instantiateViewControllerWithIdentifier:@"category"];
    [self.navigationController pushViewController:viewController animated:YES];
    
   // [self presentViewController:viewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
