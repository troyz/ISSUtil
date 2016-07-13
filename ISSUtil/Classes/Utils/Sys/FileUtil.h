//
//  FileUtil.h
//  Pods
//
//  Created by xdzhangm on 16/7/13.
//
//

#import <Foundation/Foundation.h>

@interface FileUtil : NSObject
+ (NSData *) readFileFromPath:(NSString *)path;

+ (NSString *) readFileTextFromPath:(NSString *)path;

+ (void)deleteFileAtPath:(NSString *)filePath;
@end
