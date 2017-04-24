//
//  GYEndpoint.m
//  GYNetworking
//
//  Created by 郭源 on 2017/4/22.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import "GYEndpoint.h"
#import "GYMultipartProvider.h"
#import "NSArray+GYNetworking.h"
#import "GYEndpoint+Internal.h"
#import "GYResult.h"

static NSString * converHTTPMethod(GYHTTPMethodType type) {
    switch (type) {
        case GYHTTPMethodGET:
            return @"GET";
        case GYHTTPMethodPOST:
            return @"POST";
        case GYHTTPMethodHEAD:
            return @"HEAD";
        case GYHTTPMethodDELETE:
            return @"DELETE";
        case GYHTTPMethodPUT:
            return @"PUT";
        case GYHTTPMethodPATCH:
            return @"PATCH";
    }
}

@implementation GYEndpoint

+ (instancetype)endpointWithURL:(NSString *)url
                     method:(GYHTTPMethodType)method
                 parameters:(GYParameters *)parameters
          requestSerializer:(GYRequestSerializerType)requestSerializer
           httpHeaderFields:(GYHttpHeaderFields *)httpHeaderFields {
    return [[self alloc] initWithURL:url
                              method:method
                          parameters:parameters
                   requestSerializer:requestSerializer
                    httpHeaderFields:httpHeaderFields];;
}

- (instancetype)initWithURL:(NSString *)url
                     method:(GYHTTPMethodType)method
                 parameters:(GYParameters *)parameters
          requestSerializer:(GYRequestSerializerType)requestSerializer
           httpHeaderFields:(GYHttpHeaderFields *)httpHeaderFields {
    if (self = [super init]) {
        _url = url;
        _method = method;
        _parameters = parameters;
        _requestSerializer = requestSerializer;
        _httpHeaderFields = httpHeaderFields;
    }
    return self;
}

- (GYEndpoint *)addNewParameters:(GYParameters *)newParameters {
    GYParameters *params = [self addParameters:newParameters];
    return [GYEndpoint endpointWithURL:self.url
                                method:self.method
                            parameters:params
                     requestSerializer:self.requestSerializer
                      httpHeaderFields:self.httpHeaderFields];
}

- (GYEndpoint *)addNewRequestSerializer:(GYRequestSerializerType)newRequestSerializer {
    return [GYEndpoint endpointWithURL:self.url
                                method:self.method
                            parameters:self.parameters
                     requestSerializer:newRequestSerializer
                      httpHeaderFields:self.httpHeaderFields];
}

- (GYEndpoint *)addNewHttpHeaderFields:(GYHttpHeaderFields *)newHttpHeaderFields {
    GYHttpHeaderFields *headerFields = [self addHttpHeaderFields:newHttpHeaderFields];
    return [GYEndpoint endpointWithURL:self.url
                                method:self.method
                            parameters:self.parameters
                     requestSerializer:self.requestSerializer
                      httpHeaderFields:headerFields];
}

- (GYResult<NSURLRequest *> *)urlRequest {
    AFHTTPRequestSerializer *requestSerializer = [self gy_requestSerializer];
    
    NSMutableURLRequest *urlRequest = nil;
    NSError *error = nil;
    if (self.formDatas) {
        __weak typeof(self) weakSelf = self;
        urlRequest = [requestSerializer multipartFormRequestWithMethod:converHTTPMethod(self.method) URLString:self.url parameters:self.parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.formDatas.forEach(^(GYMultipartProvider * _Nonnull obj) {
                switch (obj.type) {
                    case GYMultipartData:
                        [strongSelf appendData:(GYDataMultipart *)obj to:formData];
                        break;
                    case GYMultipartFile:
                        [strongSelf appendFile:(GYFileMultipart *)obj to:formData];
                        break;
                }
            });
        } error:&error];
    }else {
        urlRequest = [requestSerializer requestWithMethod:converHTTPMethod(self.method)
                                                URLString:self.url
                                               parameters:self.parameters
                                                    error:&error];
    }
    if (error) {
        return [GYResult resultWithError:error];
    }else {
        urlRequest.allHTTPHeaderFields = self.httpHeaderFields;
        return [GYResult resultWithValue:urlRequest];
    }
}



@end
