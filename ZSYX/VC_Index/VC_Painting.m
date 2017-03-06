//
//  VC_Painting.m
//  ZSYX
//
//  Created by cnmobi on 16/12/5.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_Painting.h"
#import "View_BezierCurve.h"
#import "PopoverView.h"
#import "ActionSheetStringPicker.h"
#import "ActionSheetMultipleStringPicker.h"
#import "MD_Electric.h"
#import "MD_Index.h"



#define SCREEN_W  [UIScreen mainScreen].bounds.size.width
#define SCREEN_H  [UIScreen mainScreen].bounds.size.height
#define YEAR(year) [NSString stringWithFormat:@"%@年",year]
#define YEAR_MONTH(year,month) [NSString stringWithFormat:@"%@年 %@月",year,month]
#define MONTH_REQUEST(year,month) [NSString stringWithFormat:@"%@-%@",year,month]


@interface VC_Painting ()
{
    //当前选择的年
    NSString *_selectedYear;
    //当前选择的年月
    NSString *_selectedMonth;
    //目前年份
    NSString *_currentYear;
    //目前月份
    NSString *_currentMonth;
    
    BOOL _isYear;
    /// 存放沙河的数组
    NSArray *array_DataSource;
    /// 设备ID
    NSString *string_equipID;
}

@property (strong,nonatomic)View_BezierCurve *bezierView;
@property (strong,nonatomic)NSMutableArray *x_names;
@property (strong,nonatomic)NSMutableArray *targets;

@property (weak, nonatomic) IBOutlet UIView *view_Content;

@end

@implementation VC_Painting

/**
 *  X轴值
 */
-(NSMutableArray *)x_names{
    if (!_x_names) {
        _x_names = [NSMutableArray array];
    }
    return _x_names;
}
/**
 *  Y轴值
 */
-(NSMutableArray *)targets{
    if (!_targets) {
        _targets = [NSMutableArray array];
    }
    return _targets;
}

- (BOOL)fd_interactivePopDisabled
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //记录当前时间
    [self makeCurrentDate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(someMethod1:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"iconfonr_chaxun"] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(0, 0, 25, 25);
    [searchBtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
}

- (void)initData
{
    // 4. 反归档
    NSData *data = [[NSUserDefaults standardUserDefaults]valueForKey:index_Data];
    array_DataSource = [MD_Index mj_objectArrayWithKeyValuesArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    /// 获取首页选择的第几个设备，在首页保存在沙河了
    MD_Index *model = array_DataSource[[[kUserDefaults objectForKey:index_SelectNum_Equipment] integerValue] ];
    string_equipID = model.ID;
}

#pragma mark ================ 屏幕横屏 ================

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self interfaceOrientation:UIInterfaceOrientationLandscapeLeft];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //0.获取网络数据
    [self fetch_Month_Infor:MONTH_REQUEST(_currentYear, _currentMonth)];
    //1.初始化
    [self createNewConteneView];
}
#pragma - 屏幕屏幕方向
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation{
    // arc下
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)])
    {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

#pragma mark ============== 获取网络数据 ==============

- (void) fetch_Month_Infor:(NSString *)month {
    month =@"2016-12";
    //每次请求数据之前 删除数据
    [self.targets removeAllObjects];
    [self.x_names removeAllObjects];
    [HTTP_DataPreview fetch_Month_Information:[Singleton shareInstance].user.token withEquipId:string_equipID withMonth:month withType:@"useElectric" withSucceed:^(NSDictionary *returnDic) {

        NSArray *arr = [MD_Electric mj_objectArrayWithKeyValuesArray:returnDic[@"result"]];
        if (arr.count == 0 && [returnDic[@"code"] intValue] == 0) {
            [MBProgressHUD showSuccess:@"成功 无数据"];
            return ;
        } else {
            [MBProgressHUD showSuccess:returnDic[@"msg"]];
        }

        for (MD_Electric *electric in arr) {
            [self.targets addObject:electric.value];
            [self.x_names addObject:[self cutWithString:electric.createDate WithRaneg:NSMakeRange(8, 2)]];
        }
        //画图
        dispatch_async(dispatch_get_main_queue(), ^{
            [self drawGraphics];
        });
    } failed:^{
        
    }];
}

- (void) fetch_Year_Infor:(NSString *)year {
    
    [self.targets removeAllObjects];
    [self.x_names removeAllObjects];
    
    
    [HTTP_DataPreview fetch_Year_Information:[Singleton shareInstance].user.token withEquipId:string_equipID withYear:year withSucceed:^(NSDictionary *returnDic) {
        NSArray *arr = [MD_Electric mj_objectArrayWithKeyValuesArray:returnDic[@"result"]];
        if (arr.count == 0 && [returnDic[@"code"] intValue] == 0) {
            [MBProgressHUD showSuccess:@"成功 无数据"];
            return ;
        } else {
            [MBProgressHUD showSuccess:returnDic[@"msg"]];
        }
        for (MD_Electric *electric in arr) {
            [self.targets addObject:electric.value];
            [self.x_names addObject:[self cutWithString:electric.createDate WithRaneg:NSMakeRange(5, 2)]];
        }
        //画图
        dispatch_async(dispatch_get_main_queue(), ^{
//            NSArray *arr = @[@"1",@"2",@"3",@"4"];
    
            [self drawGraphics];
        });

    } failed:^{
        
    }];
}

#pragma mark ============== 私有方法 ==============

/**
 创建每次需要绘制的view
 */
- (void) createNewConteneView {
    [self.bezierView removeFromSuperview];
    

    
    self.bezierView = [View_BezierCurve initWithFrame:CGRectMake(0, 0, self.view_Content.bounds.size.width, self.view_Content.bounds.size.height)];
    [self.view_Content addSubview:_bezierView];
    // 动画
    CATransition *animation = [CATransition animation];
    animation.type = @"cube";
    animation.duration = 0.5;
    [self.view_Content.layer addAnimation:animation forKey:nil];
    NSLog(@"%@",NSStringFromCGRect(self.view_Content.frame));
    
    
    [self drawGraphics];
}

/**
 画图
 */
- (void) drawGraphics {
//    [self.targets addObject:electric.value];
//    [self.x_names addObject:[self cutWithString:electric.createDate WithRaneg:NSMakeRange(5, 2)]];
//    [self.targets setArray:@[@"1",@"2",@"3",@"4",@"5",@"6"]];
//    [self.x_names setArray:@[@"1",@"2",@"3",@"4",@"5",@"6"]];
    //2.画图
    if (self.type == GraphType_BarChart) {
        _bezierView.unit_Y = @"单位: kw/h";
        self.title = @"用电量";
        [self drawBaseChart];
    } else if (self.type == GraphType_LineChart) {
        _bezierView.unit_Y = @"单位: 摄氏度";
        self.title = @"温度";
        [self drawLineChart];
    }
}

/**
 点击右上角按钮
 */
- (void) search:(UIButton *)sender {
    //    UIDatePicker
    PopoverView *popView = [PopoverView new];
    popView.menuTitles = @[@"按年查询",@"按月查询"];
    [popView showFromView:sender selected:^(NSInteger index) {
        if (index == 0) {
            [self stringPikerOnView:sender];
        } else if (index == 1) {
            [self multiStringPikerOnView:sender];
        }
    }];
}
/*
 * 弹出一组picker
 */
- (void) stringPikerOnView:(UIView *)sender {

    NSArray *years = [self getYearsAboutTen];
    ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:@"按年查询" rows:years initialSelection:0 doneBlock:^(ActionSheetStringPicker *stringPicker, NSInteger  selectedIndex, id selectedValue) {
        _isYear = YES;
        _selectedYear = selectedValue ? (NSString *)selectedValue : years[0];
        _label_Title.text = YEAR(_selectedYear);
        //如果没有选择,selectedValue为nil
        [self fetch_Year_Infor:_selectedYear];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self createNewConteneView];
        });
    } cancelBlock:^(ActionSheetStringPicker *stringPicker) {
        
    } origin: (UIView*)sender ];
    [picker showActionSheetPicker];
}
/*
 * 弹出多组picker
 */
- (void) multiStringPikerOnView:(UIView *)sender {
    NSArray *years = [self getYearsAboutTen];
    NSArray *months = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12];
    NSMutableArray *rows = [NSMutableArray array];
    [rows addObject:years];
    [rows addObject:months];
    NSArray *initialSelection = @[@0, @5];
    [ActionSheetMultipleStringPicker showPickerWithTitle:@"按月查询" rows:[rows copy] initialSelection:initialSelection doneBlock:^(ActionSheetMultipleStringPicker *picker, NSArray *selectedIndexes, id selectedValues) {
        NSLog(@"%@", selectedIndexes);
        NSLog(@"%@", [selectedValues componentsJoinedByString:@", "]);
        _isYear = NO;
        _selectedMonth = selectedValues[1];
        _selectedYear = selectedValues[0];
        NSString *index = [NSString stringWithFormat:@"%@-%@",selectedValues[0],selectedValues[1]];
        _label_Title.text = YEAR_MONTH(_selectedYear, _selectedMonth);
        [self fetch_Month_Infor:index];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self createNewConteneView];
        });
    } cancelBlock:^(ActionSheetMultipleStringPicker *picker) {
        NSLog(@"picker = %@", picker);
    } origin:(UIView *)sender];
}
/*
 * 获取最近十年 返回数组
 */
- (NSArray *) getYearsAboutTen {
    int currentYear = [_currentYear intValue];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<10;i++) {
        NSString *indexStr = [NSString stringWithFormat:@"%d", currentYear];
        [arr addObject:indexStr];
        currentYear--;
    }
    return [arr copy];
}
/*
 * 记录当前时间
 */
- (void) makeCurrentDate {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy/MM";
    NSString *res = [formatter stringFromDate:date];
    NSArray *arr = [res componentsSeparatedByString:@"/"];
    _currentYear = arr[0];
    _currentMonth = arr[1];
    //一开始默认相等
    _selectedMonth = _currentMonth;
    _selectedYear = _currentYear;
    _label_Title.text = [NSString stringWithFormat:@"%@年 %@月",_selectedYear, _selectedMonth];
}

/**
 截取字符串
 */
- (NSString *) cutWithString:(NSString *)str WithRaneg:(NSRange)range{
    return [str substringWithRange:range];
}

#pragma mark ================ 上下页 ================
- (IBAction)last:(UIButton *)sender {
    //如果按年查询 选择的年份减一
    if (_isYear) {
        if ([_selectedYear intValue] <= [_currentYear intValue]-9) {
            [MBProgressHUD showError:@"这已经是第一页数据"];
            return;
        } else {
            _selectedYear = [NSString stringWithFormat:@"%d",[_selectedYear intValue]-1];
        }
        [self createNewConteneView];
        _label_Title.text = YEAR(_selectedYear);
        //加载数据
        [self fetch_Year_Infor:_selectedYear];
        
    } else {
        if ([_selectedMonth intValue] <= 1) {
            [MBProgressHUD showError:@"这已经是第一页数据"];
            return;
        } else {
            _selectedMonth = [NSString stringWithFormat:@"%d",[_selectedMonth intValue]-1];
        }
        [self createNewConteneView];
        _label_Title.text = YEAR_MONTH(_selectedYear, _selectedMonth);
        //加载数据
        [self fetch_Month_Infor:[NSString stringWithFormat:@"%@-%@",_selectedYear, _selectedMonth]];
    }
}

- (IBAction)next:(UIButton *)sender {
    //如果按年查询
    if (_isYear) {
        //如果超出当前年份
        if ([_selectedYear intValue] >= [_currentYear intValue]) {
            [MBProgressHUD showError:@"这已经是最后一页数据"];
            return;
        } else {
            _selectedYear = [NSString stringWithFormat:@"%d",[_selectedYear intValue]+1];
        }
        [self createNewConteneView];
        _label_Title.text = YEAR(_selectedYear);
        //加载数据
        [self fetch_Year_Infor:_selectedYear];
    }else {
        //如果超出十二月
        if ([_selectedMonth intValue] >= 12) {
            [MBProgressHUD showError:@"这已经是最后一页数据"];
            return;
        }else {
            _selectedMonth = [NSString stringWithFormat:@"%d",[_selectedMonth intValue]+1];
        }
        [self createNewConteneView];
        _label_Title.text = YEAR_MONTH(_selectedYear, _selectedMonth);
        //加载数据
        [self fetch_Month_Infor:[NSString stringWithFormat:@"%@-%@",_selectedYear, _selectedMonth]];
    }
    
}
#pragma mark ============= app后台进入前台调用 ================
- (void) someMethod1:(NSNotification *)noti {
    [self viewWillAppear:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark ============== 绘制图表 ==============
/**
 画折线图
 */
-(void)drawLineChart{
    
    //直线
    [_bezierView drawLineChartViewWithX_Value_Names:self.x_names TargetValues:self.targets LineType:LineType_Straight];
    //曲线
    //    [_bezierView drawLineChartViewWithX_Value_Names:self.x_names TargetValues:self.targets LineType:LineType_Curve];
}
/**
 画柱状图
 */
-(void)drawBaseChart{
    
    [_bezierView drawBarChartViewWithX_Value_Names:self.x_names TargetValues:self.targets];
}
/**
 画饼状图
 */
-(void)drawPieChart{
    [_bezierView drawPieChartViewWithX_Value_Names:self.x_names TargetValues:self.targets];
}

@end
