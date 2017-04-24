//
//  GYMultipartProvider.h
//  GYNetworking
//
//  Created by 郭源 on 2017/4/23.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GYMultipartType) {
    GYMultipartFile = 0,
    GYMultipartData = 1,
};

@interface GYMultipartProvider : NSObject

- (instancetype)initWithName:(NSString *)name
                    fileName:(nullable NSString *)fileName
                    mimeType:(nullable NSString *)mimeType;

@property (readonly, nonatomic, copy) NSString *name;

@property (nullable, readonly, nonatomic, copy) NSString *fileName;

@property (nullable, readonly, nonatomic, copy) NSString *mimeType;

@property (readonly, nonatomic, assign) GYMultipartType type;

@end

@interface GYFileMultipart : GYMultipartProvider

- (instancetype)initWithFileURL:(NSURL *)fileURL
                           name:(NSString *)name
                       fileName:(nullable NSString *)fileName
                       mimeType:(nullable NSString *)mimeType;

@property (readonly, nonatomic, strong) NSURL *url;

@end

@interface GYDataMultipart : GYMultipartProvider

- (instancetype)initWithData:(NSData *)data
                        name:(NSString *)name
                    fileName:(nullable NSString *)fileName
                    mimeType:(nullable NSString *)mimeType;

@property (readonly, nonatomic, strong) NSData *data;

@end

NS_ASSUME_NONNULL_END
