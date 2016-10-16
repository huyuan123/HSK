//
//  CityPickView.m
//  HSKExamination
//
//  Created by hiddy on 16/10/16.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "CityPickView.h"
#import "CityModel.h"
#import "TestCenter.h"
@implementation CityPickView
{
    UIPickerView * _pickView ;
    
    NSArray      * _cityArray ;
}

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, screenHeight(), screenWith(), 200)];
    if (self) {
        
        self.backgroundColor = [UIColor grayColor];
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, screenWith() -100, 170)];
        [self addSubview:_pickView] ;
        UIButton * cancelBu = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [cancelBu setTitle:@"取消" forState:BuNormal];
        [cancelBu setTitleColor:[UIColor blackColor] forState:BuNormal];
        [self addSubview:cancelBu];
        cancelBu.tag = 1 ;
        
        UIButton * confirmBu = [[UIButton alloc] initWithFrame:CGRectMake(screenWith() -100-80, 0, 80, 30)];
        [confirmBu setTitle:@"确定" forState:BuNormal];
        [confirmBu setTitleColor:[UIColor blackColor] forState:BuNormal];
        [self addSubview:confirmBu];
        confirmBu.tag = 2 ;
        
        [cancelBu addTarget:self action:@selector(buEvent:) forControlEvents:BuTouchUpInside];
        [confirmBu addTarget:self action:@selector(buEvent:) forControlEvents:BuTouchUpInside];
    }
    
    return self ;
}


- (void)buEvent:(UIButton *)bu
{
    [self hidden];
    if (bu.tag == 2 && _block) {
        int index = (int)[_pickView selectedRowInComponent:0];
        int row   = (int)[_pickView selectedRowInComponent:1] ;
        _block([_cityArray[index] testCenters][row]) ;
    }
}

- (void)show
{
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (self.y == screenHeight() -200) {
        return ;
    }
    CGRect r = CGRectMake(0, screenHeight() - 200, screenWith() -100, 200) ;
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = r ;
    }];
}

- (void)hidden
{
    if (self.y == screenHeight() ) {
        return ;
    }
    
    CGRect r = CGRectMake(0, screenHeight(), screenWith() -100, 200) ;
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = r ;
    }];
}

- (void)loadData:(NSArray *)arr
{
    _cityArray = arr ;
    _pickView.delegate  =self ;
    _pickView.dataSource = self ;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2 ;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return _cityArray.count ;
    }else if (component == 1)
    {
        long index = [pickerView selectedRowInComponent:0] ;
        
        CityModel * model = _cityArray[index];
        
        return model.testCenters.count ;
    }
    
    return 0 ;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    
    if (component == 0) {
        CityModel * model = _cityArray[row];

        return model.city ;
    }else if (component == 1)
    {
        long index = [pickerView selectedRowInComponent:0] ;
        
        CityModel * model = _cityArray[index];

        TestCenter * testModel = model.testCenters[row];
        
        return testModel.testCenter ;
    }
    
    return @"" ;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED
{
    if (component == 0) {
        return 60 ;
    }
    
    return 700 ;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED
{
    if (component == 0) {
        [pickerView reloadComponent:1];
    }
}

//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED
//{
//return <#expression#>
//}// attributed title is favored if both methods are implemented


@end
