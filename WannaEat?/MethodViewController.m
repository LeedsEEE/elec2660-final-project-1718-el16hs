//
//  MethodViewController.m
//  WannaEat?
//
//  Created by Eleni Stavroglou on 6/12/17.
//  Copyright © 2017 Eleni Stavroglou. All rights reserved.
//

#import "MethodViewController.h"
#import <WebKit/WebKit.h>

@interface MethodViewController ()<WKNavigationDelegate,WKUIDelegate>
@property(strong,nonatomic) WKWebView *webView;
@property (strong, nonatomic) NSString *productURL;

@end

@implementation MethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //using the defaults again we can recall the source url so that we browse the method that the recipe is cooked.
    NSUserDefaults *defaults4=[NSUserDefaults standardUserDefaults];
    self.directions=[defaults4 objectForKey:@"kmethod"];
    
    self.productURL =self.directions;
  NSURL *url = [NSURL URLWithString:self.productURL];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _webView = [[WKWebView alloc]init] ;
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [_webView loadRequest:request];
    _webView.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:_webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
