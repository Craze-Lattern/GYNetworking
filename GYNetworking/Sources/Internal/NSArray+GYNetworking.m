//
//  NSArray+GYNetworking.m
//  GYNetworking
//
//  Created by 郭源 on 2017/4/23.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import "NSArray+GYNetworking.h"

@implementation NSArray (GYNetworking)


- (ArrayForEach)forEach {
    return ^(MapItem block) {
        for (id obj in self) { block(obj); }
    };
}

@end
