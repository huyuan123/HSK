//
//  SelectView.m
//  HSKExamination
//
//  Created by printer on 9/29/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "SelectView.h"
#import "ItemBu.h"

@implementation SelectView
- (void)loadData:(NSArray *)arr andTitle:(NSString *)title
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    [self addSubview:label];
    label.text = title ;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.tag = 10 ;
    int i = 0 ;
    for (NSString * s in arr) {
        ItemBu * item = [[ItemBu alloc] initWithFrame:CGRectMake(i*60, 20, 34, 30)];
        [self addSubview:item];
        
        item.imageName = @"点" ;
        [item setTitle:s forState:BuNormal];
        [item setTitleColor:[UIColor blackColor] forState:BuNormal];
        item.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)  ;
        [item addTarget:self action:@selector(buEvent:) forControlEvents:BuTouchUpInside];
        i++ ;
        
        item.tag = 100 + i ;
        
        if (_userRes && [_userRes isEqualToString:s]) {
            [item setIsSelect:YES];
        }
    }
}

- (void)loadsimpleChoice:(SimpleChoice *)model
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, -20, self.width, 40)];
    [self addSubview:label];
    label.numberOfLines = 0 ;
    label.text = [model.pinYInString stringByAppendingString:@"\n"];
    label.text = [label.text stringByAppendingString:model.textString];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:15];
}


- (void)hiddenNumber
{
    [[self viewWithTag:10] setHidden:YES];
}


- (void)buEvent:(UIButton *)button
{
    NSArray * arr = [self subviews];
    for (ItemBu * bu in arr) {
        if ([bu isKindOfClass:[ItemBu class]]) {
            if (bu == button) {
                [bu setIsSelect:YES];
                _userRes = button.titleLabel.text ;
            }else
            {
                [bu setIsSelect:NO];
            }
        }
    }
    
    NSString * s = [[self viewWithTag:10] text];
    if (_clickBlock) {
        _clickBlock(s,_userRes) ;
    }
}

- (void)loadSubItem:(NSArray *)arr andTitle:(NSString *)title
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    [self addSubview:label];
    label.text = title ;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.tag = 10 ;
    int i = 0 ;
    for (SimpleChoice * s in arr) {
        ItemBu * item = [[ItemBu alloc] initWithFrame:CGRectMake(i*60, 20, 34, 30)];
        [self addSubview:item];
        
        item.imageName = @"点" ;
        [item setTitle:s.textString forState:BuNormal];
        [item setTitleColor:[UIColor blackColor] forState:BuNormal];
        item.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)  ;
        [item addTarget:self action:@selector(buEvent:) forControlEvents:BuTouchUpInside];
        i++ ;
        
        item.tag = 100 + i ;
        
        if (_userRes && [_userRes isEqualToString:s.textString]) {
            [item setIsSelect:YES];
        }
    }

}


@end
