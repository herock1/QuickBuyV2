//
//  ProductsDetailsController.m
//  Quickbuy
//
//  Created by Mehedi Hasan on 11/18/15.
//  Copyright (c) 2015 Mehedi Hasan. All rights reserved.
//

#import "ProductsDetailsController.h"

@interface ProductsDetailsController ()
@property NSMutableDictionary  *detailsObject;
@end

@implementation ProductsDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDetails];
    // Do any additional setup after loading the view.
}

-(void)loadDetails
{
    // NSString *currentURL=homrurl;
    NSString * categoryurls = [NSString stringWithFormat:@"%@%@",productdetailsurl,_productId];
    NSLog(@"%@",categoryurls);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:categoryurls parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON return Object: %@",responseObject);
        _detailsObject   =[responseObject objectForKey:@"product_info"];
       NSLog(@"guvk %@",_detailsObject);
         [self loadDetailsData];
    }
     
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
    NSLog(@"guvk %@",_detailsObject);
    
}
-(void)loadDetailsData
{
    self.price.text = [_detailsObject objectForKey:@"price"];
    self.status.text = [_detailsObject objectForKey:@"quantity"];
    self.descriptions.text = [_detailsObject objectForKey:@"description"];
    NSString * preurl= [NSString stringWithFormat:@"%@%@",imagebase,[_detailsObject objectForKey:@"image"]];
    NSString* encodedUrl = [preurl stringByAddingPercentEscapesUsingEncoding:
                            NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodedUrl];
    [self.banner setImageWithURL:url placeholderImage:[UIImage imageNamed:@"no-image.jpg"]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
