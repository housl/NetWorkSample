//
//  PTViewController.m
//  NSURLConnectionExample
//
//  Created by Haoran Chen on 6/25/13.
//  Copyright (c) 2013 KiloApp. All rights reserved.
//

#import "PTViewController.h"
#import "PTNormalDownloaler.h"
#import "PTThreadDownloader.h"
#import "PTOperationDownloader.h"

@interface PTViewController ()

@property(nonatomic,strong)UILabel  *label;
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation PTViewController
static int count;
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(100, 100, 100, 30);
    [button addTarget:self action:@selector(toggleButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(40, 200, 200, 40)];
    self.label.text = @"测试---";
    [self.view addSubview:self.label];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 100, 100)];
    [self.view addSubview:self.imageView];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval: 0.2
                                                      target: self
                                                    selector: @selector(incrementCounter:)
                                                    userInfo: nil
                                                     repeats: YES];
}

-(void)incrementCounter:(id)send
{
    ++count;
    self.label.text = [NSString stringWithFormat:@"%d",count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toggleButton
{
    self.imageView.image = nil;
    NSString *URLString = @"http://farm7.staticflickr.com/6191/6075294191_4c8ca20409.jpg";
//    NSString *URLString =       @"http://user.kaolafm.com/v3/usercenter/initapp.json";
//    //Use PTNormalDownloaler
//    PTNormalDownloaler *downloader = [PTNormalDownloaler
//                                      downloadWithURL:[NSURL URLWithString:URLString]
//                                      timeoutInterval:15
//                                              success:^(id responseData){
//                                                  NSLog(@"get data size: %d", [(NSData *)responseData length]);
//                                                  NSLog(@"success block in main thread?: %d", [NSThread isMainThread]);
//                                                  UIImage *img = [UIImage imageWithData:responseData];
//                                                  self.imageView.image = img;
//                                              }
//                                              failure:^(NSError *error){
//                                                  NSLog(@"failure block in main thread?: %d", [NSThread isMainThread]);
//                                              }];

//    //Use PTThreadDownloaler
    PTThreadDownloader *downloader = [PTThreadDownloader
                                      downloadWithURL:[NSURL URLWithString:URLString]
                                      timeoutInterval:15
                                      success:^(id responseData){
                                          NSLog(@"get data size: %d", [(NSData *)responseData length]);
                                          NSLog(@"success block in main thread?: %d", [NSThread isMainThread]);
                                          UIImage *img = [UIImage imageWithData:responseData];
                                          self.imageView.image = img;
                                          
                                          //                                          NSString *jsonstr = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                                      }
                                      failure:^(NSError *error){
                                          NSLog(@"failure block in main thread?: %d", [NSThread isMainThread]);
                                      }];
    
    
////    Use PTOperationDownloader
//    PTOperationDownloader *downloader = [PTOperationDownloader
//                                        downloadWithURL:[NSURL URLWithString:URLString]
//                                        timeoutInterval:15
//                                        success:^(id responseData){
//                                            NSLog(@"get data size: %d", [(NSData *)responseData length]);
//                                            NSLog(@"success block in main thread?: %d", [NSThread isMainThread]);
//                                            UIImage *img = [UIImage imageWithData:responseData];
//                                            self.imageView.image = img;
//                                        }
//                                        failure:^(NSError *error){
//                                            NSLog(@"failure block in main thread?: %d", [NSThread isMainThread]);
//                                        }];
//    
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperation:downloader];//NSBlockOperation
    
    NSLog(@"started downloader: %@", downloader.URL.absoluteString);
}

@end
