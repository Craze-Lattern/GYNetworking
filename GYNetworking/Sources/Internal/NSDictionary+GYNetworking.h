//
//  NSDictionary+GYNetworking.h
//  GYNetworking
//
//  Created by 郭源 on 2017/4/24.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MapKeyValues)(id<NSCopying>, id);

typedef void(^DictionaryForEach)(MapKeyValues);

@interface NSDictionary (GYNetworking)

@property (readonly, nonatomic, copy) DictionaryForEach forEach;

@end

NS_ASSUME_NONNULL_END
