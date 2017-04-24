//
//  NSDictionary+GYNetworking.m
//  GYNetworking
//
//  Created by 郭源 on 2017/4/24.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import "NSDictionary+GYNetworking.h"

@implementation NSDictionary (GYNetworking)

- (DictionaryForEach)forEach {
    return ^(MapKeyValues block) {
        for (id key in [self allKeys]) {
            if (self[key]) {
                block(key, self[key]);
            }
        }
    };
}

@end
