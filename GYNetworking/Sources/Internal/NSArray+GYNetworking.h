//
//  NSArray+GYNetworking.h
//  GYNetworking
//
//  Created by 郭源 on 2017/4/23.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MapItem)(id);

typedef void(^ArrayForEach)(MapItem);

@interface NSArray<ObjectType> (GYNetworking)

@property (readonly, nonatomic, copy) ArrayForEach forEach;

@end

NS_ASSUME_NONNULL_END
