//
//  ISSNullTableViewCell.m
//  BigCulture
//
//  Created by iss110302000283 on 15/11/30.
//  Copyright © 2015年 isoftstone. All rights reserved.
//

#import "ISSNullTableViewCell.h"

@implementation ISSNullTableViewCell

- (instancetype)init
{
    return [self initWithCellFrame:nil];
}

- (instancetype)initWithCellFrame:(ISSNullTableViewCellFrame *)cellFrame
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ISSNullTableViewCell"];
    if(self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self setCellFrame:cellFrame];
    }
    return self;
}

- (void)setCellFrame:(ISSNullTableViewCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    self.frame = cellFrame.frame;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellForTableView:(UITableView *)tableView
{
    ISSNullTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSNullTableViewCell"];
    if (!cell)
    {
        cell = [[ISSNullTableViewCell alloc] init];
        [tableView registerClass:[self class] forCellReuseIdentifier:@"ISSNullTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}
@end

@implementation ISSNullTableViewCellFrame
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if(self)
    {
        _frame = frame;
        _height = frame.size.height;
    }
    return self;
}

- (instancetype)initWithWidth:(CGFloat)width withHeight:(CGFloat)height
{
    return [self initWithFrame:CGRectMake(0, 0, width, height)];
}

@end