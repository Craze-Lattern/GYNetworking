//
//  GYEndpoint+Internal.m
//  GYNetworking
//
//  Created by 郭源 on 2017/4/24.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import "GYEndpoint+Internal.h"
#import <objc/runtime.h>
#import "GYMultipartProvider.h"
#import "NSDictionary+GYNetworking.h"

static char GYENDPOINT_FORMDATAS_KEY;

@implementation GYEndpoint (Internal)

- (void)setFormDatas:(NSArray<GYMultipartProvider *> *)formDatas {
    objc_setAssociatedObject(self, &GYENDPOINT_FORMDATAS_KEY, formDatas, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray<GYMultipartProvider *> *)formDatas {
    return objc_getAssociatedObject(self, &GYENDPOINT_FORMDATAS_KEY);
}

- (void)appendMultipartForms:(NSArray<GYMultipartProvider *> *)formDatas {
    self.formDatas = formDatas;
}

- (AFHTTPRequestSerializer *)gy_requestSerializer {
    switch (self.requestSerializer) {
        case GYRequestSerializerHTTP:
            return [AFHTTPRequestSerializer serializer];
        case GYRequestSerializerJSON:
            return [AFJSONRequestSerializer serializer];
        case GYRequestSerializerPlist:
            return [AFPropertyListRequestSerializer serializer];
    }
}

- (GYHttpHeaderFields *)addHttpHeaderFields:(GYHttpHeaderFields *)httpHeaderFields {
    if (!httpHeaderFields) {
        return self.httpHeaderFields;
    }
    
    NSMutableDictionary *httpFields = [NSMutableDictionary dictionaryWithDictionary:httpHeaderFields];
    if (self.httpHeaderFields) {
        self.httpHeaderFields.forEach(^(id<NSCopying> _Nonnull key, id _Nonnull value) {
            [httpFields setObject:value forKey:key];
        });
    }
    return httpFields;
}

- (GYParameters *)addParameters:(GYParameters *)parameters {
    if (!parameters) {
        return self.parameters;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if (self.parameters) {
        self.parameters.forEach(^(id<NSCopying> _Nonnull key, id _Nonnull value) {
            [params setObject:key forKey:value];
        });
    }
    return params;
}

- (void)appendData:(GYDataMultipart *)data to:(id<AFMultipartFormData>)form {
    if (data.mimeType && data.fileName) {
        [form appendPartWithFileData:data.data name:data.name fileName:data.fileName mimeType:data.mimeType];
    }else {
        [form appendPartWithFormData:data.data name:data.name];
    }
    
}

- (void)appendFile:(GYFileMultipart *)file to:(id<AFMultipartFormData>)form {
    if (file.mimeType && file.fileName) {
        [form appendPartWithFileURL:file.url name:file.name fileName:file.fileName mimeType:file.mimeType error:nil];
    }else {
        [form appendPartWithFileURL:file.url name:file.name error:nil];
    }
}

@end
