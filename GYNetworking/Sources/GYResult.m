//
//  GYResult.m
//  GYNetworking
//
//  Created by 郭源 on 2017/4/24.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import "GYResult.h"

@implementation GYResult

+ (instancetype)resultWithValue:(id)value {
    return [[self alloc] initWithValue:value error:nil];
}

+ (instancetype)resultWithError:(NSError *)error {
    return [[self alloc] initWithValue:nil error:error];
}

- (instancetype)initWithValue:(id _Nullable)value error:(NSError * _Nullable)error {
    if (self = [super init]) {
        _value = value;
        _error = error;
    }
    return self;
}

@end
