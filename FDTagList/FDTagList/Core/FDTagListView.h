//
//  FDTagListView.h
//  FDTagList
//
//  Created by fengdongwang on 2020/7/24.
//  Copyright © 2020 fdd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ClicBlock)(NSString*);
typedef void (^UnflodActionBlock)(BOOL);

@interface FDTagListView : UIView{
    
    CGRect previousFrame ;
    int totalHeight ;
}
/**
 * 整个view的背景色
 */
@property(nonatomic,retain)UIColor *GBbackgroundColor;
/**
 *  设置单一颜色
 */
@property(nonatomic)UIColor *signalTagColor;
//设置tag字体颜色
@property(nonatomic)UIColor *tagFontColor;
/**
 *  设置最大行数
 */
@property(nonatomic,assign)NSUInteger maxLineCount;
/**
 *  设置字体
 */
@property(nonatomic,strong)UIFont *font;
@property(nonatomic,copy)ClicBlock clickBlock;
@property (nonatomic, copy) void(^tagHeightBlock)(CGFloat tagHeight);
@property (nonatomic, copy) void(^tagCurrentClickTitleBlock)(NSString *titleStr);

@property (nonatomic, copy) UnflodActionBlock unflodActionBlock;

/**
 *  标签文本赋值
 */
-(void)setTagWithTagArray:(NSArray *)arr;

- (void)reloadTags;
@end

NS_ASSUME_NONNULL_END
