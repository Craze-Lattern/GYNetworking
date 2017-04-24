//
//  GYEndpoint+Internal.h
//  GYNetworking
//
//  Created by 郭源 on 2017/4/24.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import "GYEndpoint.h"

NS_ASSUME_NONNULL_BEGIN

@class GYMultipartProvider, GYDataMultipart, GYFileMultipart;

@interface GYEndpoint (Internal)

@property (nullable, nonatomic, strong) NSArray<GYMultipartProvider *> *formDatas;

- (void)appendMultipartForms:(NSArray<GYMultipartProvider *> *)formDatas;

- (AFHTTPRequestSerializer *)gy_requestSerializer;

- (GYHttpHeaderFields *)addHttpHeaderFields:(nullable GYHttpHeaderFields *)httpHeaderFields;

- (GYParameters *)addParameters:(nullable GYParameters *)parameters;

- (void)appendData:(GYDataMultipart *)data to:(id<AFMultipartFormData>)form;

- (void)appendFile:(GYFileMultipart *)file to:(id<AFMultipartFormData>)form;

@end

NS_ASSUME_NONNULL_END
