//
//  UITableViewCell+Line.h
//  USA
//
//  Created by eric on 14-12-8.
//  Copyright (c) 2014年 fuhuaqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Line)
- (void)addHeadLine ;
- (void)deleteHeadLine ;
- (void)addFootLine ;
- (void)deleteFootLine ;
- (void)setLineColor:(UIColor *)color  ;
@end
