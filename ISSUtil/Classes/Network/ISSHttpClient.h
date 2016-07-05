//
//  ISSHttpClient.h
//  Pods
//
//  Created by xdzhangm on 16/7/4.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ISSHttpError)
{
    HTTP_ERROR_NONE                 = 0,    // None
    HTTP_ERROR_NETWORK              = 1,    // 网络连接异常
    HTTP_ERROR_SERVER               = 2,    // 服务器异常
    HTTP_ERROR_TIMEOUT              = 3,    // 超时
    HTTP_ERROR_DATA_PARSE           = 4     // 数据解析异常
};

// jsonData is NSArray or NSDictionary
typedef void (^ISSHttpJSONResponseBlock)(ISSHttpError errorCode, id jsonData);
typedef void (^ISSHttpResponseBlock)(ISSHttpError errorCode, NSString *responseText);
typedef void (^ISSHttpDataResponseBlock)(ISSHttpError errorCode, NSData *data);
// 发送请求参数之前，你可以修改参数，dict中的key/value都是string
typedef void (^ISSHttpParameterWrapperBlock)(NSMutableDictionary *dict);

@protocol ISSHttpStreamFormModel <NSObject>
@end

@interface ISSHttpStreamFormModel : NSObject
// 字段名，如：Filedata
@property (nonatomic, copy) NSString *fieldName;
// 文件名，如：test.png
@property (nonatomic, copy) NSString *fileName;
// 文件类型，如：image/png、image/jpeg
// 支持: @"image/jpeg", @"image/gif", @"image/png", @"image/ico", @"image/bmp", @"video/mpeg4"
@property (nonatomic, copy) NSString *mimeType;
@property (nonatomic, strong) NSData *data;
- (instancetype)initWithFieldName:(NSString *)fieldName withData:(NSData *)data;
- (instancetype)initWithFieldName:(NSString *)fieldName withData:(NSData *)data withMimeType:(NSString *)mimeType;
- (NSString *)getFileName;
@end

@interface ISSHttpClient : NSObject

+ (ISSHttpClient *)sharedInstance;

- (void)setParameterWrapper:(ISSHttpParameterWrapperBlock)wrapperBlock;

- (NSOperation *) getJSON:(NSString *)url withBlock:(ISSHttpJSONResponseBlock)block;
- (NSOperation *) getText:(NSString *)url withBlock:(ISSHttpResponseBlock)block;
- (NSOperation *) getData:(NSString *)url withBlock:(ISSHttpDataResponseBlock)block;

- (NSOperation *) getJSON:(NSString *)url withKVDict:(NSDictionary *)kvDict withBlock:(ISSHttpJSONResponseBlock)block;
- (NSOperation *) getText:(NSString *)url withKVDict:(NSDictionary *)kvDict withBlock:(ISSHttpResponseBlock)block;
- (NSOperation *) getData:(NSString *)url withKVDict:(NSDictionary *)kvDict withBlock:(ISSHttpDataResponseBlock)block;

/**
 `url`              : the request url
 `kvDict`           : k1=v1&k2=v2&k3=v3
 `jsonDict`         : k1=objectToJsonString(v1)&k2=objectToJsonString(v2)&k3=objectToJsonString(v3)
 */
- (NSOperation *) getJSON:(NSString *)url withKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict withBlock:(ISSHttpJSONResponseBlock)block;
- (NSOperation *) getText:(NSString *)url withKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict withBlock:(ISSHttpResponseBlock)block;
- (NSOperation *) getData:(NSString *)url withKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict withBlock:(ISSHttpDataResponseBlock)block;

- (NSOperation *) postJSON:(NSString *)url withKVDict:(NSDictionary *)kvDict withBlock:(ISSHttpJSONResponseBlock)block;
- (NSOperation *) postText:(NSString *)url withKVDict:(NSDictionary *)kvDict withBlock:(ISSHttpResponseBlock)block;
- (NSOperation *) postData:(NSString *)url withKVDict:(NSDictionary *)kvDict withBlock:(ISSHttpDataResponseBlock)block;

- (NSOperation *) postJSON:(NSString *)url withKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict withBlock:(ISSHttpJSONResponseBlock)block;
- (NSOperation *) postText:(NSString *)url withKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict withBlock:(ISSHttpResponseBlock)block;
- (NSOperation *) postData:(NSString *)url withKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict withBlock:(ISSHttpDataResponseBlock)block;
- (NSOperation *) postData:(NSString *)url withKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict withStreamList:(NSArray *)streamList withBlock:(ISSHttpDataResponseBlock)block;
- (NSOperation *) postData:(NSString *)url withKVDict:(NSDictionary *)kvDict withJsonDict:(NSDictionary *)jsonDict withStream:(ISSHttpStreamFormModel *)stream withBlock:(ISSHttpDataResponseBlock)block;
@end
