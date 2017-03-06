//
//  ActionSheetPickerCustomPickerDelegate.m
//  ActionSheetPicker
//
//  Created by  on 13/03/2012.
//  Copyright (c) 2012 Club 15CC. All rights reserved.
//

#import "ActionSheetPickerCustomPickerDelegate.h"
#import "MD_Province.h"

@interface ActionSheetPickerCustomPickerDelegate()

/**  */
@property (nonatomic,strong) NSArray *allPro;

@end


@implementation ActionSheetPickerCustomPickerDelegate



- (instancetype)init
{
    if (self = [super init]) {
        NSMutableArray *proListArr = [NSMutableArray array];
        self.allPro = [MD_Province mj_objectArrayWithKeyValuesArray:[[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"]]];
        for (MD_Province *pro in self.allPro) {
            [proListArr addObject:pro.state];
        }
        notesToDisplayForKey = [NSArray arrayWithArray:proListArr];
        scaleNames = [self.allPro[5] cities];
    }
    return self;
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - ActionSheetCustomPickerDelegate Optional's
/////////////////////////////////////////////////////////////////////////
- (void)configurePickerView:(UIPickerView *)pickerView
{
    // Override default and hide selection indicator
    pickerView.showsSelectionIndicator = NO;
}

- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    
    //获取选中的省份
    NSString *province = notesToDisplayForKey[(NSUInteger) [(UIPickerView *) actionSheetPicker.pickerView selectedRowInComponent:0]];
    //获取选中的城市
    NSString *cityName = scaleNames[(NSUInteger) [(UIPickerView *) actionSheetPicker.pickerView selectedRowInComponent:1]];
    //如果没有滚动第二个pickerView 获取的值为空 默认是第0个.
    if (!cityName) {
        cityName = scaleNames[0];
    }
    self.callback(province,cityName);
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - UIPickerViewDataSource Implementation
/////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // Returns
    switch (component) {
        case 0: return [notesToDisplayForKey count];
        case 1: return [scaleNames count];
        default:break;
    }
    return 0;
}

/////////////////////////////////////////////////////////////////////////
#pragma mark UIPickerViewDelegate Implementation
/////////////////////////////////////////////////////////////////////////

// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    switch (component) {
        case 0: return 90.0f;
        case 1: return 260.0f;
        default:break;
    }

    return 0;
}
/*- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
 {
 return
 }
 */
// these methods return either a plain UIString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0: return notesToDisplayForKey[(NSUInteger) row];
        case 1: return scaleNames[(NSUInteger) row];
        default:break;
    }
    return nil;
}

/////////////////////////////////////////////////////////////////////////

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"Row %li selected in component %li", (long)row, (long)component);
    switch (component) {
        case 0: {
            self.selectedKey = notesToDisplayForKey[(NSUInteger) row];
            for (MD_Province *pro in self.allPro) {
                NSString *proNameStr = pro.state;
                if ([proNameStr isEqualToString:self.selectedKey]) {
                    scaleNames = pro.cities;
                }
            }
            [pickerView reloadComponent:1];
            return;
        }

        case 1:
            self.selectedScale = scaleNames[(NSUInteger) row];
            return;
        default:break;
    }
}

@end
