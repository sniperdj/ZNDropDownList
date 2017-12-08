//
//  RootViewController.m
//  ZNDropDownListDemo
//
//  Created by Sniper on 07/12/2017.
//  Copyright © 2017 Sniper. All rights reserved.
//

#import "RootViewController.h"
#import "ZNDropDownList.h"

@interface RootViewController ()<ZNDropDownListDataSource, ZNDropDownListDelegate>

/** 数据 */
@property (nonatomic, strong)NSArray *arrayList;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayList = @[@"apple", @"banana", @"tomato", @"orange", @"melon"];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    ZNDropDownList *dropDownList = [[ZNDropDownList alloc] initWithFrame:CGRectMake(100, 100, 120, 40)];
    [self.view addSubview:dropDownList];
    dropDownList.dataSource = self;
    dropDownList.delegate = self;

}

#pragma mark - ZNDropDownListDataSource
- (NSInteger)numberOfRowsIndropDownList:(ZNDropDownList *)dropDownList {
    return self.arrayList.count;
}
static NSString *reuseId = @"com.RootViewController.UITableViewCell";
- (UITableViewCell *)dropDownList:(ZNDropDownList *)dropDownList tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.arrayList[indexPath.row];
    return cell;
}

#pragma mark - ZNDropDownListDelegate
- (NSString *)dropDownList:(ZNDropDownList *)dropDownList didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.arrayList[indexPath.row];
}

//- (NSString *)defaultDropDownTextInDropDownList:(ZNDropDownList *)dropDownList {
//    return [self.arrayList firstObject];
//}

//- (UIImage *)imageOfDropDownTxt {
//    return [UIImage imageNamed:@"arrow_down"];
//}

//- (ZNDropDownListStyle)styleInDropDownList:(ZNDropDownList *)dropDownList {
//    return ZNDropDownListDownStyle;
//}

@end
