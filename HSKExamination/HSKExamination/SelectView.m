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
    
    int i = 0 ;
    for (NSString * s in arr) {
        ItemBu * item = [[ItemBu alloc] initWithFrame:CGRectMake(i*55, 20, 30, 30)];
        [self addSubview:item];
        item.imageName = @"点" ;
        [item setTitle:s forState:BuNormal];
        i++ ;
    }
    
}
@end
