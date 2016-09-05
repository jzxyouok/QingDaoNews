//
//  DWMeListCell.m
//  QingDaoNews
//
//  Created by dwang_sui on 16/9/3.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import "DWMeListCell.h"
#import "DWSwipeGestures.h"

@interface DWMeListCell ()

@end

@implementation DWMeListCell

- (instancetype) dw_CellWithTableView:(UITableView *)tableView dataArray:(NSArray *)dataArray cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *ID;
    
    UIImageView *backgroundView = [[UIImageView alloc] init];
    
    backgroundView.userInteractionEnabled = YES;
    
    UIImageView *icon = [[UIImageView alloc] init];
    
    icon.userInteractionEnabled = YES;
    
    UILabel *functionName = [[UILabel alloc] init];
    
    UIButton *functionButton = [[UIButton alloc] init];
    
    [self addSubview:functionButton];
    
    self.backgroundView = backgroundView;
    
    [self addSubview:functionName];
    
    [self addSubview:icon];
    
    if (indexPath.section == 0) {
        
        tableView.rowHeight = DWScreen_Height / 3;
        
        backgroundView.image = [UIImage imageNamed:@"head_image_back"];
        
        icon.image = [UIImage imageNamed:@"person_avatar"];
        
        [[[DWSwipeGestures alloc] init] dw_SwipeGestureType:DWTapGesture Target:self Action:@selector(enterLoging) AddView:icon BackSwipeGestureTypeString:^(NSString * _Nonnull backSwipeGestureTypeString) {
        }];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.mas_centerY);
            
            make.centerX.equalTo(self.mas_centerX);
            
        }];
        
        [functionButton setTitle:@"立即登录" forState:UIControlStateNormal];
        
        [functionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [functionButton addTarget:self action:@selector(enterLoging) forControlEvents:UIControlEventTouchUpInside];
        
        [functionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(icon.mas_bottom).offset(10);
            
            make.centerX.equalTo(self.mas_centerX);
            
        }];
        
        functionName.text = @"赢金币 换好礼!";
        
        functionName.textColor = DWTextColor;
        
        [functionName mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(functionButton.mas_bottom).offset(10);
            
            make.centerX.equalTo(self.mas_centerX);
            
        }];
        
    }
    if (indexPath.section == 1) {
        
        tableView.rowHeight = DWScreen_Height / 4.5;
        
    }
    if (indexPath.section == 2) {
        
        tableView.rowHeight = DWScreen_Height / dataArray.count / 2;
        
        ID = @"cell";
        
        DWMeListModels *meListModels = dataArray[indexPath.row];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        icon.image = [UIImage imageNamed:meListModels.icon];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).offset(20);
            
            make.centerY.equalTo(self.mas_centerY);
            
        }];
        
        functionName.text = meListModels.function;
        
        functionName.font = [UIFont systemFontOfSize:13];
        
        [functionName setTextColor:DWTextColor];
        
        [functionName mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(icon.mas_right).offset(5);
            
            make.centerY.equalTo(icon.mas_centerY).offset(3);
            
        }];
        
        self.imageView.image = [UIImage imageNamed:meListModels.icon];
        
    }
    
        DWMeListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[DWMeListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    return cell;
    
}

- (void)enterLoging {
    
    
    
}

#pragma mark - 绘制Cell分割线
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, 0, rect.size.width, 0));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 0.01));
}


@end
