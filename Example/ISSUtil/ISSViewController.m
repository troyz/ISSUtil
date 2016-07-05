//
//  ISSViewController.m
//  ISSUtil
//
//  Created by Troy Zhang on 07/04/2016.
//  Copyright (c) 2016 Troy Zhang. All rights reserved.
//

#import "ISSViewController.h"
#import <ISSUtil/ISSUtil.h>

@interface ISSViewController ()

@end

@implementation ISSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[ISSHttpClient sharedInstance] setParameterWrapper:^(NSMutableDictionary *dict) {
        for(NSString *key in dict)
        {
            if([@"content" isEqualToString:key])
            {
                NSString *value = [dict objectForKey:key];
                value = [value base64String];
                [dict setObject:value forKey:key];
                break;
            }
        }
    }];
    NSString *url = @"http://223.223.183.103:8098/datacent/external/execute.jhtml?system=CT&serviceName=DC_USERCENTER&serviceKey=rYzcn1iQWiCz9pCtJ68Eng==";
    NSDictionary *dict = @{@"content": @{@"type": @(10), @"user": @{@"PhoneNumber": @"18080079668", @"Pwd": @"111111"}}};
    [[ISSHttpClient sharedInstance] postText:url withKVDict:nil withJsonDict:dict withBlock:^(ISSHttpError errorCode, NSString *responseText) {
        NSLog(@"response: %@", responseText);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
