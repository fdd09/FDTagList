//
//  FDTagListView.m
//  FDTagList
//
//  Created by fengdongwang on 2020/7/24.
//  Copyright © 2020 fdd. All rights reserved.
//

#import "FDTagListView.h"
#import "MarginLabel.h"

#define HORIZONTAL_PADDING 7.0f
#define VERTICAL_PADDING   3.0f
#define LABEL_MARGIN       10.0f  //左右
#define BOTTOM_MARGIN      8.0f    //上下
#define kSearchItemTag      1933

#define Screen_Width ([[UIScreen mainScreen] bounds].size.width)


@implementation FDTagListView
{
    NSUInteger totalLineCount;
    CGFloat getTagHeight;
    NSInteger _currentItemIndex;
    NSArray *_dataArray;
    NSInteger _lastLineCount;
    BOOL _isUnfold;
    CGRect _frame;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, Screen_Width, frame.size.height)];
    if (self) {
        totalHeight=0;
        _lastLineCount = 0;
        self.frame=frame;
        _frame = frame;
        totalLineCount = 0;
        _lastLineCount = 0;
        
        previousFrame = CGRectZero;
    }
    return self;
}
-(void)setTagWithTagArray:(NSArray*)arr{
    _dataArray = arr;
    NSParameterAssert(_signalTagColor);
    self.backgroundColor =[UIColor greenColor];
    //清空当前所有的view
    if(self.subviews.count){
        for (UIButton *btn in self.subviews) {
            [btn removeFromSuperview];
        }
        
        for (MarginLabel *label in self.subviews) {
            [label removeFromSuperview];
        }
    }
    BOOL isBreak = NO;
    for (int loop = 0; loop < arr.count; loop++) {
        NSString *str = arr[loop];
        MarginLabel *tag = [[MarginLabel alloc] init];
        tag.contentInsert = UIEdgeInsetsMake(0, 15, 0, 15);
        tag.numberOfLines = 1;
        tag.lineBreakMode = NSLineBreakByTruncatingTail;
        tag.backgroundColor=_signalTagColor;
        tag.tintColor = self.tagFontColor;
        tag.font = [UIFont systemFontOfSize:13];
        tag.text =str;
        tag.tag = kSearchItemTag + loop;
        _currentItemIndex = loop;
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:13]};
        CGSize Size_str=[str sizeWithAttributes:attrs];
        Size_str.width += 30;
        Size_str.height = 30;
        
        tag.layer.cornerRadius = 15;
        tag.layer.masksToBounds = YES;
        
        CGRect newRect = CGRectZero;
        if (previousFrame.origin.x + previousFrame.size.width + Size_str.width + LABEL_MARGIN > Screen_Width && _lastLineCount >= 1) {
            if(totalLineCount != 0 && totalLineCount == _maxLineCount){
                //达到最大行上限,终止运行,添加展开按钮
                if (_dataArray.count >= (_currentItemIndex + 1)) {//后面还有,
                    [self addUnfoldViewPreviousFrame:previousFrame strSize:Size_str];
                }
                isBreak = YES;
                break;
            }else{//加一行
                _lastLineCount = 1;
                //                newRect.origin = CGPointMake(10, previousFrame.origin.y + Size_str.height + BOTTOM_MARGIN);
                totalHeight +=Size_str.height + BOTTOM_MARGIN;
                
                newRect.origin = CGPointMake(10, previousFrame.origin.y + (loop != 0 ? Size_str.height + BOTTOM_MARGIN : BOTTOM_MARGIN));
                //                totalHeight +=Size_str.height + BOTTOM_MARGIN;
                totalLineCount++;
            }
        }
        else {//只在同行里添加
            newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + LABEL_MARGIN, previousFrame.origin.y > 0 ? previousFrame.origin.y : BOTTOM_MARGIN);
            _lastLineCount++;
            
            if (totalLineCount == 0) {
                _lastLineCount = 1;
                //                newRect.origin = CGPointMake(10, previousFrame.origin.y + Size_str.height + BOTTOM_MARGIN);
                //                               totalHeight +=Size_str.height + BOTTOM_MARGIN;
                
                newRect.origin = CGPointMake(10, previousFrame.origin.y + (loop != 0 ? Size_str.height + BOTTOM_MARGIN : BOTTOM_MARGIN));
                totalHeight +=Size_str.height + BOTTOM_MARGIN;
                totalLineCount++;
            }
        }
        if (Size_str.width > (375 - LABEL_MARGIN * 2)) {
            Size_str.width = (375 - LABEL_MARGIN * 2);
        }
        newRect.size = Size_str;
        
        NSLog(@"===%d=======%@", loop, NSStringFromCGRect(newRect));
        [tag setFrame:newRect];
        previousFrame=tag.frame;
        [self setHight:self andHight:totalHeight + BOTTOM_MARGIN];
        [self addSubview:tag];
    }
    if(_GBbackgroundColor){
        self.backgroundColor=_GBbackgroundColor;
    }else{
        self.backgroundColor=[UIColor whiteColor];
    }
    
    if (!isBreak && totalLineCount > 2) {//全部展开样式
        [self addPickViewPreviousFrame:previousFrame];
    }
}
//38*30 压缩 展开按钮,后面还有的情况
- (void)addUnfoldViewPreviousFrame:(CGRect )previousFrame strSize:(CGSize )size {
    //    return;
    if (_lastLineCount == 1) {//第二行只有一个
        //间距不够,压缩最后一个
        UIView *view = [self viewWithTag:(kSearchItemTag + _currentItemIndex - 1)];
        if ([view isKindOfClass:[UILabel class]]) {
            CGRect rect = view.frame;
            CGRect tempRect = CGRectZero;
            tempRect.origin = rect.origin;
            tempRect.size = CGSizeMake(rect.size.width - 38 - LABEL_MARGIN, rect.size.height);
            view.frame = tempRect;
            
            [self addActionLabelWithFrame:CGRectMake(tempRect.origin.x + tempRect.size.width + LABEL_MARGIN, tempRect.origin.y, 38, 30) isUnfold:YES];
        }
    } else {//第二行大于一个
        UIView *view = [self viewWithTag:(kSearchItemTag + _currentItemIndex - 1)];
        if (view.frame.origin.x + view.frame.size.width + LABEL_MARGIN + 38 < Screen_Width ) {//间距够, 直接添加展开按钮
            [self addActionLabelWithFrame:CGRectMake(view.frame.origin.x + view.frame.size.width + LABEL_MARGIN, view.frame.origin.y, 38, 30) isUnfold:YES];
            
        } else {//间距不够,移除最后一个,添加展开按钮
            UIView *view = [self viewWithTag:(kSearchItemTag + _currentItemIndex - 1)];
            if ([view isKindOfClass:[UILabel class]]) {
                [view removeFromSuperview];
                [self addActionLabelWithFrame:CGRectMake(previousFrame.origin.x, previousFrame.origin.y, 38, 30) isUnfold:YES];
            }
        }
    }
}
- (void)reloadTags {
    totalHeight=0;
    _lastLineCount = 0;
    self.frame=_frame;
    totalLineCount = 0;
    _lastLineCount = 0;
    
    previousFrame = CGRectZero;
    [self setTagWithTagArray:_dataArray];
}
- (void)addActionLabelWithFrame:(CGRect )frame isUnfold:(BOOL )unfold {
    MarginLabel *label = [[MarginLabel alloc] init];
    label.frame = frame;
    label.backgroundColor = [UIColor purpleColor];
    label.userInteractionEnabled = YES;
    [self addSubview:label];
    _isUnfold = unfold;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [label addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)gesture {
    if (self.unflodActionBlock) {
        self.unflodActionBlock(_isUnfold);
    }
    
    if (_isUnfold) {
        _maxLineCount = 0;
    } else {
        _maxLineCount = 2;
    }
    [self reloadTags];
}
//38*30 展开 收起按钮

- (void)addPickViewPreviousFrame:(CGRect )previousFrame {
    if (previousFrame.origin.x + previousFrame.size.width + 38 + LABEL_MARGIN < Screen_Width) {//直接添加收起按钮
        [self addActionLabelWithFrame:CGRectMake(previousFrame.origin.x + previousFrame.size.width + LABEL_MARGIN, previousFrame.origin.y, 38, 30) isUnfold:NO];
        
    } else {//间距不够,把走后一个移动到最后一行,并添加收起按钮
        if (_lastLineCount >= 2)  {//加一行
            UIView *view = [self viewWithTag:(kSearchItemTag + _currentItemIndex)];
            if ([view isKindOfClass:[UILabel class]]) {
                //重置最后一个
                CGRect tempRect = CGRectZero;
                tempRect.size = previousFrame.size;
                totalHeight +=30 + BOTTOM_MARGIN;
                
                tempRect.origin = CGPointMake(10, previousFrame.origin.y + 30 + BOTTOM_MARGIN);
                totalLineCount++;
                
                view.frame = tempRect;
                totalHeight = tempRect.origin.y + tempRect.size.height;
                [self setHight:self andHight:totalHeight + BOTTOM_MARGIN];
                
                //添加按钮
                [self addActionLabelWithFrame:CGRectMake(tempRect.origin.x + tempRect.size.width + LABEL_MARGIN, tempRect.origin.y, 38, 30) isUnfold:NO];
                
            }
            
        } else {//压缩本行,添加按钮
            UIView *view = [self viewWithTag:(kSearchItemTag + _currentItemIndex)];
            if ([view isKindOfClass:[UILabel class]]) {
                CGRect tempRect = CGRectZero;
                tempRect.origin = previousFrame.origin;
                tempRect.size = CGSizeMake(previousFrame.size.width - 38 - LABEL_MARGIN, previousFrame.size.height);
                view.frame = tempRect;
                
                [self addActionLabelWithFrame:CGRectMake(tempRect.origin.x + tempRect.size.width + LABEL_MARGIN, previousFrame.origin.y, 38, 30) isUnfold:NO];
                
            }
        }
    }
}
#pragma mark-改变控件高度
- (void)setHight:(UIView *)view andHight:(CGFloat)hight
{
    CGRect tempFrame = view.frame;
    tempFrame.size.height = hight;
    view.frame = tempFrame;
    
    if (self.tagHeightBlock)
    {
        self.tagHeightBlock(hight);
    }
}
-(void)tagClicked:(UIButton*)button
{
    if(self.tagCurrentClickTitleBlock){
        self.tagCurrentClickTitleBlock([button currentTitle]);
    }
}

@end
