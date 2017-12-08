//
//  ZNDropDownList.h
//  ZNDropDownListDemo
//
//  Created by Sniper on 07/12/2017.
//  Copyright © 2017 Sniper. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZNDropDownList;

typedef NS_ENUM(NSUInteger, ZNDropDownListStyle) {
    ZNDropDownListDownStyle,
    ZNDropDownListRightStyle,
    ZNDropDownListLeftStyle,
    ZNDropDownListUpStyle
};

@protocol ZNDropDownListDataSource <NSObject>

- (NSInteger)numberOfRowsIndropDownList:(ZNDropDownList *)dropDownList;

- (UITableViewCell *)dropDownList:(ZNDropDownList *)dropDownList tableView:(UITableView *)tableView cellForRowAtIndex:(NSInteger)rowIndex;

@end

@protocol ZNDropDownListDelegate <NSObject>

@required
- (NSString *)dropDownList:(ZNDropDownList *)dropDownList didSelectRowAtIndex:(NSInteger)rowIndex;

@optional
// return Default text in DropDownText
- (NSString *)defaultDropDownTextInDropDownList:(ZNDropDownList *)dropDownList;
// return DropDownList cell height
- (CGFloat)dropDownList:(ZNDropDownList *)dropDownList heightForRowAtIndex:(NSInteger)rowIndex;

- (void)dropDownList:(ZNDropDownList *)dropDownList didDeselectRowAtIndex:(NSInteger)rowIndex;
// return the Image in the right of DropDownListText
- (UIImage *)imageOfDropDownTxt;

- (ZNDropDownListStyle)styleInDropDownList:(ZNDropDownList *)dropDownList;

@end

@interface ZNDropDownList : UIView

/** delegate */
@property (nonatomic, weak)id<ZNDropDownListDelegate> delegate;
/** datasource */
@property (nonatomic, weak)id<ZNDropDownListDataSource> dataSource;

- (void)reloadData;

- (void)clearTxt;

@end
