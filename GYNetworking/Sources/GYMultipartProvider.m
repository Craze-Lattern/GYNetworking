//
//  GYMultipartProvider.m
//  GYNetworking
//
//  Created by 郭源 on 2017/4/23.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import "GYMultipartProvider.h"

@implementation GYMultipartProvider

- (instancetype)initWithName:(NSString *)name
                    fileName:(NSString *)fileName
                    mimeType:(NSString *)mimeType {
    if (self = [super init]) {
        _name = name;
        _fileName = fileName;
        _mimeType = mimeType;
    }
    return self;
}

@end

@implementation GYFileMultipart

- (instancetype)initWithFileURL:(NSURL *)fileURL
                           name:(NSString *)name
                       fileName:(NSString *)fileName
                       mimeType:(NSString *)mimeType {
    if (self = [super initWithName:name fileName:fileName mimeType:mimeType]) {
        _url = fileURL;
    }
    return self;
}

- (GYMultipartType)type {
    return GYMultipartFile;
}

@end

@implementation GYDataMultipart

- (instancetype)initWithData:(NSData *)data
                        name:(NSString *)name
                    fileName:(NSString *)fileName
                    mimeType:(NSString *)mimeType {
    if (self = [super initWithName:name fileName:fileName mimeType:mimeType]) {
        _data = data;
    }
    return self;
}

- (GYMultipartType)type {
    return GYMultipartData;
}

@end
