//
//  GYResponse.m
//  GYNetworking
//
//  Created by 郭源 on 2017/4/22.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import "GYResponse.h"
#import "GYResult.h"

NSString * const GYResponseStatusCodeErrorDomain = @"com.GYNetworking.error.statusCode.response";

@implementation GYResponse

+ (instancetype)responseWithStatusCode:(NSInteger)statusCode
                        responseObject:(NSData *)responseObject
                               request:(NSURLRequest *)request
                              response:(NSURLResponse *)response {
    return [[self alloc] initWithStatusCode:statusCode responseObject:responseObject request:request response:response];
}

- (instancetype)initWithStatusCode:(NSInteger)statusCode
                    responseObject:(NSData *)responseObject
                           request:(NSURLRequest *)request
                          response:(NSURLResponse *)response {
    if (self = [super init]) {
        _statusCode = statusCode;
        _responseObject = responseObject;
        _request = request;
        _response = response;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Status Code: %ld, Data Length: %@", (long)self.statusCode, self.responseObject];
}

- (NSString *)debugDescription {
    return self.description;
}

- (BOOL)isEqualToResponse:(GYResponse *)response {
    return self.statusCode == response.statusCode && [self.responseObject isEqualToData:response.responseObject] && [self.response isEqual:response.response];
}

@end

@implementation GYResponse (Extension)

- (GYResponse *)filterWithStatusCodes:(NSRange)range error:(NSError * __autoreleasing *)error {
    if (self.statusCode >= range.location && self.statusCode <= NSMaxRange(range)) {
        return self;
    }
    if (error) {
        *error = [NSError errorWithDomain:GYResponseStatusCodeErrorDomain code:self.statusCode userInfo:nil];
    }
    
    return nil;
}

- (GYResponse *)filterWithStatusCode:(NSInteger)statusCode error:(NSError * __autoreleasing *)error {
    return [self filterWithStatusCodes:NSMakeRange(statusCode, 0) error:error];
}

- (GYResponse *)filterSuccessfulStatusCodesWithError:(NSError * __autoreleasing *)error {
    return [self filterWithStatusCodes:NSMakeRange(200, 99) error:error];
}

- (GYResponse *)filterSuccessfulStatusAndRedirectCodesWithError:(NSError * __autoreleasing *)error {
    return [self filterWithStatusCodes:NSMakeRange(200, 199) error:error];
}

@end

@implementation GYProgressResponse

+ (instancetype)responseWithProgress:(NSProgress *)progress response:(GYResponse *)response {
    return [[self alloc] initWithProgress:progress response:response];
}

- (instancetype)initWithProgress:(NSProgress *)progress response:(GYResponse *)response {
    if (self = [super init]) {
        _progressObj = progress;
        _response = response;
    }
    return self;
}

- (double)progress {
    return self.progressObj ? self.progressObj.fractionCompleted : 1.0;
}

- (BOOL)completed {
    return self.progress == 1.0 && self.response != nil;
}

@end
