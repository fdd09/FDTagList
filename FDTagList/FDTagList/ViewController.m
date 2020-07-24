//
//  ViewController.m
//  FDTagList
//
//  Created by fengdongwang on 2020/7/24.
//  Copyright © 2020 fdd. All rights reserved.
//

#import "ViewController.h"
#import "FDTagListView.h"

#define HeliosRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
#define WeakSelf(type)  __weak typeof(type) weak##type = type;
#define Screen_Width ([[UIScreen mainScreen] bounds].size.width)
#define Screen_Height ([[UIScreen mainScreen] bounds].size.height)

@interface ViewController ()
{
    FDTagListView *_tagListView;
    NSMutableArray *_tagArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTagDataArray];
    [self makeUI];
    
}
- (void)setTagDataArray {
    _tagArray = [[NSMutableArray alloc]init];
    NSArray *array0 = @[@"0第一个标"];

    //最多两行两行 不展示按钮
    NSArray *array1 = @[@"0第一个标签第一个标签第一个标签第一个标签第一个标签第一个标签第一个标签",@"1第标签",@"2个标签",@"3第四标"];

    //大于两行  移除最后一个  展示按钮
    NSArray *array10 = @[@"0第一个标签第一个标签第一个标签第一个标签第一个标签第一个标签第一个标签",@"1第标签",@"2个标签",@"3第四标签个标爱德华",@"4第标签标签一个标签第一个标签第一个标签第一个标签一个标签第一个标签第一个标签第一个标签",@"5第标签六个标签",@"6签",@"7第八签",@"8第标签",@"9个标签"];
    //大于两行  压缩最后一个  展示按钮
    NSArray *array11 = @[@"0第一个标签第一个标签第一个标签第一个标签",@"1第标签第标签标签一个标签第一个标签第一个标签第一个标签一个标签第一个标签第一个标签第一个标签", @"2家开始发货"];
    //大于两行  直接添加   展示按钮
    NSArray *array12 = @[@"0第一个标签第一个标签第一个标签第一个标签",@"1第标签第标签", @"2家开始发货", @"3第标签第标签标签一个标签第一个标签第一个标签第一个标签一个标签第一个标签第一个标签第一个标签", @"4家开始发货"];

    
    //全部展开大于两行 直接添加按钮
    NSArray *array20 = @[@"0第一个标签第一个标签第一个标签第一个标签第一个标签第一个标签第一个标签",@"1第标签",@"2个标签",@"3第四标签",@"4第标签标签一个标签第一个标签第一个标签第一个标签一个标签第一个标签第一个标签第一个标签",@"5第标签六个标签",@"6签",@"7第八签",@"8第标签",@"9个标签"];
    
    //全部展开大于两行 在下一行添加按钮 最后一行大于两个
    NSArray *array21 = @[@"0第一个标签第一个标签第一个标签第一个标签第一个标签第一个标签第一个标签",@"1第标签",@"2个标签",@"3第四标签",@"4第标签标签一个标签第一个标签第一个标签第一个标签一个标签第一个标签第一个标签第一个标签",@"5第标签六个标签",@"6签",@"7第八签",@"8第标签",@"9个标签第一个标签第一个标第一按时"];
    
    //全部展开大于两行 在下一行添加按钮 最后一行只有一个
    NSArray *array22 = @[@"0第一个标签第一个标签第一个标签第一个标签第一个标签第一个标签第一个标签",@"1第标签",@"2个标签",@"3第四标签",@"4第标签标签一个标签第一个标签第一个标签第一个标签一个标签第一个标签第一个标签第一个标签",@"5第标签六个标签",@"6签",@"7第八签",@"8第标签",@"9个标签第一个标签第一个标第一按时第一个标签第一个标第一第一个标签第一个标第一"];

    _tagArray = [NSMutableArray arrayWithArray:array11];
    
}
- (void)makeUI {
    WeakSelf(self);
    _tagListView = [[FDTagListView alloc] initWithFrame:CGRectMake(0, 104, Screen_Width, 200)];
    _tagListView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_tagListView];
    _tagListView.font = [UIFont systemFontOfSize:13];
    _tagListView.maxLineCount = 2; //2
    _tagListView.tagCurrentClickTitleBlock = ^(NSString *searchStr){
        NSLog(@"searchStr==%@",searchStr);
    };
    _tagListView.tagHeightBlock = ^(CGFloat tagHeight){
        [weakself uploadTagViewHeight:tagHeight];
    };
    _tagListView.unflodActionBlock = ^(BOOL unfold) {
        
    };
    _tagListView.tagFontColor = [UIColor blueColor];
    _tagListView.signalTagColor = [UIColor yellowColor];
    _tagListView.GBbackgroundColor = [UIColor lightGrayColor];
    //给标签注入数据
    [_tagListView setTagWithTagArray:_tagArray];
}
- (void)uploadTagViewHeight:(CGFloat )height {
   /*
    ** 动态修改tagView的高度
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
