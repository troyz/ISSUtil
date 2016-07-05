//
//  NSString+URL.h
//  YeSanPo
//
//  Created by xdzhangm on 16/6/20.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)
// 将url中的参数转化成NSDictionary对象
- (NSDictionary *)urlParameterDictionary;
@end
