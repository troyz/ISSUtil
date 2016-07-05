//
//  ISSHttpClient.m
//  Travel
//
//  Created by xdzhangm on 15-4-3.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "ISSHttpClient.h"
#import "AFNetworking.h"
#import "JSONModel.h"
#import "NSDate+ISSTransform.h"
#import "NSString+Addtions.h"
#import "SysUtil.h"

@implementation ISSHttpClient
{
    ISSHttpParameterWrapperBlock paramWrapperBlock;
}

+ (ISSHttpClient *)sharedInstance
{
    static ISSHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ISSHttpClient alloc] init];
    });
    return _sharedClient;
}

- (void)setParameterWrapper:(ISSHttpParameterWrapperBlock)wrapperBlock
{
    paramWrapperBlock = [wrapperBlock copy];
}

- (NSURLSessionDataTask *) getJSON:(NSString *)url withBlock:(ISSHttpJSONResponseBlock)block
{
    return [self getJSON:url withKVDict:nil withBlock:block];
}

- (NSURLSessionDataTask *) getJSON:(NSString *)url withKVDict:(NSDictionary *)kvDict withBlock:(ISSHttpJSONResponseBlock)block
{
    return [self getJSON:url withKVDict:kvDict withJsonDict:nil withBlock:block];
}

- (NSURLSessionDataTask *) getJSON:(NSString *)url withKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict withBlock:(ISSHttpJSONResponseBlock)block
{
    return [self requestJSONWithMethod:@"GET" withUrl:url withKVDict:kvDict withJsonDict:jsonDict withBlock:block];
}

- (NSURLSessionDataTask *) postJSON:(NSString *)url withKVDict:(NSDictionary *)kvDict withBlock:(ISSHttpJSONResponseBlock)block
{
    return [self postJSON:url withKVDict:kvDict withJsonDict:nil withBlock:block];
}

- (NSURLSessionDataTask *) postJSON:(NSString *)url withKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict withBlock:(ISSHttpJSONResponseBlock)block
{
    return [self requestJSONWithMethod:@"POST" withUrl:url withKVDict:kvDict withJsonDict:jsonDict withBlock:block];
}

/**
 `method`           : `POST` or `GET`
 `url`              : the request url
 `kvDict`           : k1=v1&k2=v2&k3=v3
 `jsonK`/`jsonV`    : jsonK=objectToJsonString(jsonV)
 */
- (NSURLSessionDataTask *) requestJSONWithMethod:(NSString *)method withUrl:(NSString *)url withKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict withBlock:(ISSHttpJSONResponseBlock)block
{
    return [self requestWithMethod:method withUrl:url withKVDict:kvDict withJsonDict:jsonDict withStreamList:nil withTextBlock:nil withDataBlock:nil withJsonBlock:block];
}

- (NSURLSessionDataTask *) getText:(NSString *)url withBlock:(ISSHttpResponseBlock)block
{
    return [self getText:url withKVDict:nil withBlock:block];
}

- (NSURLSessionDataTask *) getText:(NSString *)url withKVDict:(NSDictionary *)kvDict withBlock:(ISSHttpResponseBlock)block
{
    return [self getText:url withKVDict:kvDict withJsonDict:nil withBlock:block];
}

- (NSURLSessionDataTask *) getText:(NSString *)url withKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict withBlock:(ISSHttpResponseBlock)block
{
    return[self requestTextWithMethod:@"GET" withUrl:url withKVDict:kvDict withJsonDict:jsonDict withTextBlock:block withDataBlock:nil];
}

- (NSURLSessionDataTask *) postText:(NSString *)url withKVDict:(NSDictionary *)kvDict withBlock:(ISSHttpResponseBlock)block
{
    return [self postText:url withKVDict:kvDict withJsonDict:nil withBlock:block];
}

- (NSURLSessionDataTask *) postText:(NSString *)url withKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict withBlock:(ISSHttpResponseBlock)block
{
    return [self requestTextWithMethod:@"POST" withUrl:url withKVDict:kvDict withJsonDict:jsonDict withTextBlock:block withDataBlock:nil];
}

- (NSURLSessionDataTask *) requestTextWithMethod:(NSString *)method withUrl:(NSString *)url withKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict withTextBlock:(ISSHttpResponseBlock)textBlock withDataBlock:(ISSHttpDataResponseBlock)dataBlock
{
    return [self requestTextWithMethod:method withUrl:url withKVDict:kvDict withJsonDict:jsonDict withStreamList:nil withTextBlock:textBlock withDataBlock:dataBlock];
}

- (NSURLSessionDataTask *) requestTextWithMethod:(NSString *)method withUrl:(NSString *)url withKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict withStreamList:(NSArray *)streamList withTextBlock:(ISSHttpResponseBlock)textBlock withDataBlock:(ISSHttpDataResponseBlock)dataBlock
{
    return [self requestWithMethod:method withUrl:url withKVDict:kvDict withJsonDict:jsonDict withStreamList:streamList withTextBlock:textBlock withDataBlock:dataBlock withJsonBlock:nil];
}
- (NSURLSessionDataTask *) requestWithMethod:(NSString *)method withUrl:(NSString *)url withKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict withStreamList:(NSArray *)streamList withTextBlock:(ISSHttpResponseBlock)textBlock withDataBlock:(ISSHttpDataResponseBlock)dataBlock withJsonBlock:(ISSHttpJSONResponseBlock)jsonBlock
{
    if([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable)
    {
        if(textBlock)
        {
            textBlock(HTTP_ERROR_NETWORK, nil);
        }
        else if(jsonBlock)
        {
            jsonBlock(HTTP_ERROR_NETWORK, nil);
        }
        else if(dataBlock)
        {
            dataBlock(HTTP_ERROR_NETWORK, nil);
        }
        return nil;
    }
    NSMutableDictionary *dict = [self organizeKVDict:kvDict withJsonDict:jsonDict];
    dict = dict.count ? dict : nil;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    // IMPORTANT for isoftstone
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", @"text/xml", nil];
    manager.responseSerializer = responseSerializer;
    
    // success block
    void (^successBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable data) {
        ISSHttpError errorCode = HTTP_ERROR_NONE;
        if(textBlock)
        {
            NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            textBlock(errorCode, result);
        }
        else if(jsonBlock)
        {
            NSError* error;
            id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            if(error)
            {
                errorCode = HTTP_ERROR_DATA_PARSE;
                jsonData = nil;
            }
            jsonBlock(errorCode, jsonData);
        }
        else if(dataBlock)
        {
            dataBlock(errorCode, data);
        }
    };
    
    // failure blcok
    void (^failureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure: %@", error);
        if(textBlock || dataBlock || jsonBlock)
        {
            ISSHttpError errorCode = HTTP_ERROR_SERVER;
            switch (error.code)
            {
                case NSURLErrorNotConnectedToInternet:
                    errorCode = HTTP_ERROR_NETWORK;
                    break;
                case NSURLErrorTimedOut:
                    errorCode = HTTP_ERROR_TIMEOUT;
                    break;
                default:
                    break;
            }
            if(textBlock)
            {
                textBlock(errorCode, nil);
            }
            else if(jsonBlock)
            {
                jsonBlock(errorCode, nil);
            }
            else
            {
                dataBlock(errorCode, nil);
            }
        }
    };
    
    if(streamList && streamList.count > 0)
    {
        return [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for(ISSHttpStreamFormModel *streamItem in streamList)
            {
                if(!streamItem.data)
                {
                    continue;
                }
                if([SysUtil emptyString:streamItem.mimeType])
                {
                    [formData appendPartWithFormData:streamItem.data name:streamItem.fieldName];
                }
                else
                {
                    [formData appendPartWithFileData:streamItem.data name:streamItem.fieldName fileName:[streamItem getFileName] mimeType:streamItem.mimeType];
                }
            }
        } progress:nil success:successBlock failure:failureBlock];
    }
    else
    {
        if([@"POST" isEqualToString:[method uppercaseString]])
        {
            [manager.requestSerializer setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            return [manager POST:url parameters:dict progress:nil success:successBlock failure:failureBlock];
        }
        else
        {
            return [manager GET:url parameters:dict progress:nil success:successBlock failure:failureBlock];
        }
    }
}

- (NSURLSessionDataTask *) getData:(NSString *)url withBlock:(ISSHttpDataResponseBlock)block
{
    return [self getData:url withKVDict:nil withBlock:block];
}
- (NSURLSessionDataTask *) postData:(NSString *)url withBlock:(ISSHttpDataResponseBlock)block
{
    return [self postData:url withKVDict:nil withBlock:block];
}

- (NSURLSessionDataTask *) postData:(NSString *)url withKVDict:(NSDictionary *)kvDict withBlock:(ISSHttpDataResponseBlock)block
{
    return [self postData:url withKVDict:kvDict withJsonDict:nil withBlock:block];
}
- (NSURLSessionDataTask *) getData:(NSString *)url withKVDict:(NSDictionary *)kvDict withBlock:(ISSHttpDataResponseBlock)block
{
    return [self getData:url withKVDict:kvDict withJsonDict:nil withBlock:block];
}

- (NSURLSessionDataTask *) getData:(NSString *)url withKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict withBlock:(ISSHttpDataResponseBlock)block
{
    return [self requestTextWithMethod:@"GET" withUrl:url withKVDict:kvDict withJsonDict:jsonDict withTextBlock:nil withDataBlock:block];
}

- (NSURLSessionDataTask *) postData:(NSString *)url withKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict withBlock:(ISSHttpDataResponseBlock)block
{
    return [self requestTextWithMethod:@"POST" withUrl:url withKVDict:kvDict withJsonDict:jsonDict withTextBlock:nil withDataBlock:block];
}

- (NSURLSessionDataTask *) postData:(NSString *)url withKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict withStreamList:(NSArray *)streamList withBlock:(ISSHttpDataResponseBlock)block
{
    return [self requestTextWithMethod:@"POST" withUrl:url withKVDict:kvDict withJsonDict:jsonDict withStreamList:streamList withTextBlock:nil withDataBlock:block];
}

- (NSURLSessionDataTask *) postData:(NSString *)url withKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict withStream:(ISSHttpStreamFormModel *)stream withBlock:(ISSHttpDataResponseBlock)block
{
    return [self postData:url withKVDict:kvDict withJsonDict:jsonDict withStreamList:(stream ? [NSArray arrayWithObject:stream] : nil) withBlock:block];
}

/**
 Convert `object` to json string.
 */
-(NSString*)objectToJsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:0
                                                         error:&error];
    if (!jsonData)
    {
        NSLog(@"Got an error: %@", error);
    }
    else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
- (NSMutableDictionary *) organizeKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:(kvDict ? [kvDict count] : 0 + 1)];
    if(kvDict)
    {
        [dict setDictionary:kvDict];
    }
    // convert nsdictionary/jsonmodel to string.
    if(jsonDict && [jsonDict count] > 0)
    {
        for(NSString *key in jsonDict)
        {
            NSObject *obj = [jsonDict objectForKey:key];
            if(![SysUtil emptyString:key] && obj)
            {
                NSString *json = nil;
                if([obj isKindOfClass:[NSDictionary class]])
                {
                    json = [self objectToJsonString:obj];
                }
                else if([obj isKindOfClass:[JSONModel class]])
                {
                    json = [((JSONModel *) obj) toJSONString];
                }
                if(![SysUtil emptyString:json])
                {
                    // EDIT BY xdzhangm, 2016/05/18
//                    if([@"content" isEqualToString:key])
//                    {
//                        json = [json base64String];
//                    }
                    // END EDIT
                    [dict setObject:json forKey:key];
                }
            }
        }
    }
    if(paramWrapperBlock)
    {
        paramWrapperBlock(dict);
    }
    return dict;
}

@end

@implementation ISSHttpStreamFormModel
- (instancetype)initWithFieldName:(NSString *)fieldName withData:(NSData *)data
{
    return [self initWithFieldName:fieldName withData:data withMimeType:nil];
}
- (instancetype)initWithFieldName:(NSString *)fieldName withData:(NSData *)data withMimeType:(NSString *)mimeType
{
    self = [super init];
    if(self)
    {
        _fieldName = fieldName;
        _data = data;
        _mimeType = [mimeType lowercaseString];
    }
    return self;
}

- (NSString *)getFileName
{
    if(![SysUtil emptyString:_fileName])
    {
        return _fileName;
    }
    if(![SysUtil emptyString:_mimeType])
    {
        NSString *name = [NSDate stringFromDate:[NSDate new] withDateFormat:@"yyyyMMddhhmmss"];
        static NSInteger count = 0;
        count++;
        name = [NSString stringWithFormat:@"%@%zd", name, count];
        if([_mimeType rangeOfString:@"png"].location != NSNotFound)
        {
            return [NSString stringWithFormat:@"%@.png", name];
        }
        else if([_mimeType rangeOfString:@"jpeg"].location != NSNotFound)
        {
            return [NSString stringWithFormat:@"%@.jpg", name];
        }
        else if([_mimeType rangeOfString:@"gif"].location != NSNotFound)
        {
            return [NSString stringWithFormat:@"%@.gif", name];
        }
        else if([_mimeType rangeOfString:@"bmp"].location != NSNotFound)
        {
            return [NSString stringWithFormat:@"%@.bmp", name];
        }
        else if([_mimeType rangeOfString:@"ico"].location != NSNotFound)
        {
            return [NSString stringWithFormat:@"%@.ico", name];
        }
        else if([_mimeType isEqualToString:@"video/mpeg4"])
        {
            return [NSString stringWithFormat:@"%@.mp4", name];
        }
    }
    return _fieldName;
}
@end
