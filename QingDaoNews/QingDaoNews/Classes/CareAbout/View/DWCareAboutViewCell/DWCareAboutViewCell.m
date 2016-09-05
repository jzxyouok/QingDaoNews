//
//  DWCareAboutViewCell.m
//  QingDaoNews
//
//  Created by dwang_sui on 16/9/2.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import "DWCareAboutViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DWScrollPictures.h"

@interface DWCareAboutViewCell ()

@end

static NSString *ID;

@implementation DWCareAboutViewCell

- (instancetype) dw_CellWithTableView:(UITableView *)tableView newsDataArray:(NSMutableArray *)newsDataArray cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    @try {
        
        self.careAboutDataModels = newsDataArray[indexPath.row];
        
    }
    @catch (NSException *exception) {
        // 捕获到的异常exception
        DWLog(@"%@",exception);

        return self;
    }
    @finally {
        

        
    }
    
    UIButton *cnm = [[UIButton alloc] init];
    
    [cnm setBackgroundImage:[UIImage imageNamed:@"thread_frame"] forState:UIControlStateNormal];
    
    cnm.frame = cnm.currentBackgroundImage.accessibilityFrame;
    
    [self addSubview:cnm];
    
    [cnm mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        
        make.left.equalTo(self.mas_left).offset(8);
        
    }];
    
    [cnm setTitle:[NSString stringWithFormat:@"%ld评论",(long)self.careAboutDataModels.cnm] forState:UIControlStateNormal];
    
    cnm.titleLabel.font = [UIFont systemFontOfSize:10];
    
    [cnm setTitleColor:DWTextColor forState:UIControlStateNormal];
    
    UILabel *subject = [[UILabel alloc] init];
    
    subject.numberOfLines = 0;
    
    subject.textColor = DWTextColor;
    
    subject.text = self.careAboutDataModels.subject;
    
    [self addSubview:subject];
    
    UIImageView *cellImageView = [[UIImageView alloc] init];
    
    [self addSubview:cellImageView];
    
    if ([self.careAboutDataModels.newstype isEqualToString:@"small"]) {
        
        ID = @"small";
        
        tableView.rowHeight = DWScreen_Height/7.5;
        
        [cellImageView sd_setImageWithURL:[NSURL URLWithString:self.careAboutDataModels.img]
                          placeholderImage:[UIImage imageNamed:@"backpic.png"]];
        
        [cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).offset(10);
            
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            
            make.right.equalTo(self.mas_right).offset(-10);
            
            make.width.mas_equalTo(self.width / 3);
            
        }];
        
        [subject mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).offset(15);
            
            make.left.equalTo(self.mas_left).offset(8);
            
            make.right.equalTo(cellImageView.mas_left).offset(-3);
            
        }];
        
        }
    
    if ([self.careAboutDataModels.newstype isEqualToString:@"pic"]) {
        
        ID = @"pic";
        
        self.tag = indexPath.row;
        
        tableView.rowHeight = DWScreen_Height / 2.5;
        
        [subject mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).offset(20);
            
            make.left.equalTo(self.mas_left).offset(8);
            
        }];
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        
        self.scrollView = scrollView;
        
        scrollView.showsHorizontalScrollIndicator = NO;
        
        for (int i = 0 ; i < [self.careAboutDataModels.imgs count]; i ++) {
            
            NSDictionary *imageUrl = self.careAboutDataModels.imgs[i];
            
            //循环添加imageView
            cellImageView = [[UIImageView alloc] init];
            
            cellImageView.userInteractionEnabled = YES;
            
            [cellImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClick)]];

            
            [cellImageView sd_setImageWithURL:[NSURL URLWithString:[imageUrl objectForKey:@"link"]] placeholderImage:[UIImage imageNamed:@"backpic"]];
            
            cellImageView.size = CGSizeMake(DWScreen_Width / 1.5 - 3, DWScreen_Height / 3);
            
            cellImageView.x = i * DWScreen_Width / 1.5;
            
            scrollView.contentOffset = CGPointMake([self.careAboutDataModels.imgs count] * DWScreen_Width / 2 / 1.5, 0);
            
            [scrollView addSubview:cellImageView];
            
        }
        
        [scrollView setContentSize:CGSizeMake([self.careAboutDataModels.imgs count] * DWScreen_Width / 1.5, 0)];
        
        [self addSubview:scrollView];
        
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(subject.mas_bottom).offset(15);
            
            make.bottom.equalTo(cnm.mas_top).offset(-15);
        
            make.left.equalTo(self.mas_left).offset(8);
            
            make.right.equalTo(self.mas_right).offset(-8);
            
        }];
    }
    if ([self.careAboutDataModels.newstype isEqualToString:@"text"]) {
        
        ID = @"text";
        
        tableView.rowHeight = DWScreen_Height/7.5;
        
        [cellImageView sd_setImageWithURL:[NSURL URLWithString:self.careAboutDataModels.img] placeholderImage:[UIImage imageNamed:@"backpic.png"]];
        
        [cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).offset(8);
            
            make.left.equalTo(self.mas_left).offset(8);
            
            make.bottom.equalTo(self.mas_bottom).offset(-15);
            
            make.width.equalTo(self.mas_height);
            
        }];
        
        [cnm mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.mas_centerY);
            
            make.right.equalTo(self.mas_right).offset(-8);
            
        }];
        
        [subject mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(cellImageView.mas_top).offset(3);
            
            make.left.equalTo(cellImageView.mas_right).offset(4);
            
            make.right.equalTo(self.mas_right).offset(-3);
            
        }];
        
    }
    if ([self.careAboutDataModels.newstype isEqualToString:@"title"]){
        
        ID = @"title";
        
        tableView.rowHeight = DWScreen_Height / 7.5;
        
        [subject mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).offset(10);
            
            make.left.equalTo(self.mas_left).offset(8);
            
            make.right.equalTo(self.mas_right).offset(-8);
            
        }];
        
        UILabel *memo = [[UILabel alloc] init];
        
        memo.textColor = DWTextColor;
        
        memo.text = self.careAboutDataModels.memo;
        
        memo.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:memo];
        
        [memo mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(subject.mas_bottom).offset(5);
            
            make.left.equalTo(subject.mas_left);
            
            make.right.equalTo(self.mas_right);
            
        }];
        
    }
    
    DWCareAboutViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[DWCareAboutViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    
    }
    
    if (self.careAboutDataModels.subject.length <= 0) {
        
        tableView.rowHeight = 0;
        
    }
    
    return cell;
    
}

- (void)scrollViewClick {
    
    DWLog(@"%ld",self.tag);
    
}

#pragma mark - 绘制Cell分割线
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, 0, rect.size.width, 0.1));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 0.1));
}

- (DWCareAboutDataModels *)careAboutDataModels {
    
    if (!_careAboutDataModels) {
        
        _careAboutDataModels = [[DWCareAboutDataModels alloc] init];
        
    }
    
    return _careAboutDataModels;
}

@end
