//
//  ISSNullTableViewCell.h
//  BigCulture
//
//  Created by iss110302000283 on 15/11/30.
//  Copyright © 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ISSNullTableViewCellFrame;

@interface ISSNullTableViewCell : UITableViewCell
- (instancetype)initWithCellFrame:(ISSNullTableViewCellFrame *)cellFrame;
@property (nonatomic, strong) ISSNullTableViewCellFrame *cellFrame;
+ (instancetype)cellForTableView:(UITableView *)tableView;
@end

@interface ISSNullTableViewCellFrame : NSObject
- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithWidth:(CGFloat)width withHeight:(CGFloat)height;

@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) CGFloat height;

@end