//
//  ViewController.m
//  GYNetworking
//
//  Created by 郭源 on 2017/4/22.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import "ViewController.h"
#import "GYNetworking.h"

@interface API : NSObject<GYTargetInterface>

@end

@implementation API

- (NSURL *)baseURL {
    return [NSURL URLWithString:@"http://api.maxjia.com:80/"];
}

- (NSString *)path {
    return @"api/activity/data";
}

- (GYHTTPMethodType)method {
    return GYHTTPMethodGET;
}

- (GYParameters *)parameters {
    return @{};
}

- (GYRequestSerializerType)requestSerializer {
    return GYRequestSerializerJSON;
}

- (GYRequestTask *)task {
    return [GYRequestTask new];
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GYProvider *provider = [GYProvider providerWithEndpoint:^GYEndpoint * _Nonnull(id<GYTargetInterface> _Nonnull target) {
        NSString *urlString = [NSURL URLWithString:target.path relativeToURL:target.baseURL].absoluteString;
        return [GYEndpoint endpointWithURL:urlString method:target.method parameters:target.parameters requestSerializer:target.requestSerializer httpHeaderFields:nil];
    } request:^(GYEndpoint * _Nonnull endpoint, RequestResultBlock _Nonnull result) {
        result(endpoint.urlRequest);
    } manager:[[Manager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]]];
    
    [provider requestWithTarget:[API new] completion:^(GYResult<GYResponse *> * _Nonnull result) {
        if (result.value) {
            NSLog(@"%@", result.value);
        }else {
            NSLog(@"%@", result.error);
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
