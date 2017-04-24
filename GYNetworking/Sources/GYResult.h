//
//  GYResult.h
//  GYNetworking
//
//  Created by 郭源 on 2017/4/24.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GYResult<__covariant ObjectType> : NSObject

+ (instancetype)resultWithValue:(ObjectType)value;

+ (instancetype)resultWithError:(NSError *)error;

@property (nullable, readonly, nonatomic, strong) ObjectType value;

@property (nullable, readonly, nonatomic, strong) NSError *error;

@end

NS_ASSUME_NONNULL_END
