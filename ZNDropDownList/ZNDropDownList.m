//
//  ZNDropDownList.m
//  ZNDropDownListDemo
//
//  Created by Sniper on 07/12/2017.
//  Copyright © 2017 Sniper. All rights reserved.
//

#import "ZNDropDownList.h"

#define KEY_WINDOW [UIApplication sharedApplication].keyWindow

@interface ZNDropDownList ()<UITextFieldDelegate, UITableViewDelegate>

/** 输入框 */
@property (nonatomic, strong)UITextField *dropDownTxt;
/** 下拉列表 */
@property (nonatomic, strong)UITableView *listView;
/** 遮挡 */
@property (nonatomic, strong)UIButton *coverBtn;
/** 默认cell高度 */
@property (nonatomic, assign)CGFloat cellHeight;

@end

@implementation ZNDropDownList

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupData];
    }
    return self;
}
#pragma mark - Custom
- (void)reloadData {
    [self.listView reloadData];
}

- (void)clearTxt {
    self.dropDownTxt.text = nil;
}

#pragma mark - Data
- (void)setupData {
    _cellHeight = 40;
}

- (void)setDataSource:(id<ZNDropDownListDataSource>)dataSource {
    _listView.dataSource = dataSource;
}

#pragma mark - UIControlEvent
- (void)coverBtnClick:(UIButton *)btn {
    _listView.hidden = TRUE;
    
    [_listView removeFromSuperview];
    [_coverBtn removeFromSuperview];
}

- (void)showDropDownList:(UIButton *)btn {
    _listView.hidden = FALSE;
    
    [KEY_WINDOW addSubview:_coverBtn];
    [KEY_WINDOW addSubview:_listView];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self showDropDownList:nil];
    return FALSE;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _dropDownTxt.text = [self.delegate dropDownList:self didSelectRowAtIndexPath:indexPath];
    
    [self coverBtnClick:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(dropDownList:heightForRowAtIndexPath:)]) {
        return [self.delegate dropDownList:self heightForRowAtIndexPath:indexPath];
    } else {
        return _cellHeight; 
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(dropDownList:didDeselectRowAtIndexPath:)]) {
        [self.delegate dropDownList:self didDeselectRowAtIndexPath:indexPath];
    }
}

#pragma mark - UI
- (void)setupUI {
    _dropDownTxt = [[UITextField alloc] init];
    [self addSubview:_dropDownTxt];
    _dropDownTxt.delegate = self;
    _dropDownTxt.borderStyle = UITextBorderStyleRoundedRect;
    _dropDownTxt.layer.cornerRadius = 3;
    _dropDownTxt.layer.borderWidth = 1;
    
    UIButton *dropButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _dropDownTxt.rightView = dropButton;
    dropButton.frame = CGRectMake(0, 0, 27, 20);
    dropButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _dropDownTxt.rightViewMode = UITextFieldViewModeAlways;
    [dropButton addTarget:self action:@selector(showDropDownList:) forControlEvents:UIControlEventTouchUpInside];
    
    _listView = [[UITableView alloc] init];
    _listView.hidden = TRUE;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.layer.cornerRadius = 6;
    _listView.clipsToBounds = TRUE;
    _listView.delegate = self;
    
    _coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _coverBtn.frame = [UIScreen mainScreen].bounds;
    [_coverBtn addTarget:self action:@selector(coverBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (CGRect)rectOfStyle:(ZNDropDownListStyle)dropDownListStyle {
    CGRect rectInWindow = [KEY_WINDOW convertRect:self.dropDownTxt.frame fromView:self];
    CGFloat x = rectInWindow.origin.x;    // dropDownText x
    CGFloat y = rectInWindow.origin.y;    // dropDownText y
    CGFloat w = rectInWindow.size.width;  // dropDownText width
    CGFloat h = rectInWindow.size.height; // dropDownText height
    CGFloat height = 200;                 // dropDownList height
    switch (dropDownListStyle) {
        case ZNDropDownListRightStyle:
            return CGRectMake(x + w, y, w, height);
        case ZNDropDownListLeftStyle:
            return CGRectMake(x - w, y, w, height);
        case ZNDropDownListUpStyle:
            return CGRectMake(x, y - height, w, height);
        default:
            return CGRectMake(x, y + h, w, height);
    }
}

- (ZNDropDownListStyle)dropDownListStyle {
    ZNDropDownListStyle style = ZNDropDownListDownStyle;
    if ([self.delegate respondsToSelector:@selector(styleInDropDownList:)]) {
        style = [self.delegate styleInDropDownList:self];
    }
    return style;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _dropDownTxt.frame = CGRectMake(0, 0, self.frame.size.width, 40);
    
    _listView.frame = [self rectOfStyle:[self dropDownListStyle]];
    
    if ([self.delegate respondsToSelector:@selector(defaultDropDownTextInDropDownList:)]) {
        _dropDownTxt.text = [self.delegate defaultDropDownTextInDropDownList:self];
    }
    
    if ([self.delegate respondsToSelector:@selector(imageOfDropDownTxt)]) {
        UIImage *img = [self.delegate imageOfDropDownTxt];
        UIButton *dropBtn = (UIButton *)_dropDownTxt.rightView;
        [dropBtn setImage:img forState:UIControlStateNormal];
    }
}

@end
