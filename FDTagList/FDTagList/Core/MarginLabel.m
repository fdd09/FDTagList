//
//  MarginLabel.m
//  FDTagList
//
//  Created by fengdongwang on 2020/7/24.
//  Copyright © 2020 fdd. All rights reserved.
//

#import "MarginLabel.h"

@implementation MarginLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.contentInsert = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}
- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.contentInsert)];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.contentInsert) limitedToNumberOfLines:numberOfLines];
    rect.origin.x -= self.contentInsert.left;
    rect.origin.y -= self.contentInsert.top;
    rect.size.width += self.contentInsert.left + self.contentInsert.right;
    rect.size.height += self.contentInsert.top + self.contentInsert.bottom;
    return rect;
}


@end
