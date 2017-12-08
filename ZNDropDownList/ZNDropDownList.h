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

@protocol ZNDropDownListDelegate <NSObject>

- (NSString *)dropDownList:(ZNDropDownList *)dropDownList didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
// return Default text in DropDownText
- (NSString *)defaultDropDownTextInDropDownList:(ZNDropDownList *)dropDownList;
// return DropDownList cell height
- (CGFloat)dropDownList:(ZNDropDownList *)dropDownList heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)dropDownList:(ZNDropDownList *)dropDownList didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
// return the Image in the right of DropDownListText
- (UIImage *)imageOfDropDownTxt;

- (ZNDropDownListStyle)styleInDropDownList:(ZNDropDownList *)dropDownList;

@end

@protocol ZNDropDownListDataSource <UITableViewDataSource>

@end

@interface ZNDropDownList : UIView

/** delegate */
@property (nonatomic, weak)id<ZNDropDownListDelegate> delegate;
/** datasource */
@property (nonatomic, weak)id<ZNDropDownListDataSource> dataSource;

- (void)reloadData;

- (void)clearTxt;

@end
