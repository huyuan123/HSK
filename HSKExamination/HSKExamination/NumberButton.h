//
//  NumberButton.h
//  HSKExamination
//
//  Created by hiddy on 16/9/25.
//  Copyright © 2016年 printer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASTModel.h"
@interface NumberButton : UIButton

@property (nonatomic ,assign) ASTIndex index ;

- (void)setIsSelect:(BOOL)b ;

@end
