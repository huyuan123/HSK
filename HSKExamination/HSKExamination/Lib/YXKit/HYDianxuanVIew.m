//
//  HYDianxuanVIew.m
//  YueYi
//
//  Created by eric on 14-5-3.
//  Copyright (c) 2014年 hu.yuan. All rights reserved.
//

#import "HYDianxuanVIew.h"

@implementation HYDianxuanVIew
{
    UIImageView * imageView ;

}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGSize size = frame.size ;
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        imageView.center = CGPointMake(size.width/2, size.height/2) ;
        [self addSubview:imageView];
        
         imageView.image = [UIImage imageNamed:@"点选－nor.png"];
        self.userInteractionEnabled = YES ;
        UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeDianxuan)];
        [self addGestureRecognizer:ges];
        
    }
    return self;
}




- (void)changeDianxuan
{
    if (_isDIanxuan) {
        imageView.image = [UIImage imageNamed:@"点选－nor.png"];
    }else
    {
        
    imageView.image = [UIImage imageNamed:@"点选－pre.png"];
    
    }
    _isDIanxuan = !_isDIanxuan ;
    if (_block) {
          _block(_isDIanxuan);
    }
  
}

- (void)awakeFromNib
{
    
    CGSize size = self.frame.size ;
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(size.width/2, size.height/2, 20, 20)];
    [self addSubview:imageView];
    imageView.center = CGPointMake(size.width/2, size.height/2) ;
     imageView.image = [UIImage imageNamed:@"点选－nor.png"];
    self.userInteractionEnabled = YES ;
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeDianxuan)];
    [self addGestureRecognizer:ges];

}

- (void)dianxuan
{
    imageView.image = [UIImage imageNamed:@"点选－pre.png"];
    _isDIanxuan = YES ;
}

- (void)notDianxuan
{
    imageView.image = [UIImage imageNamed:@"点选－nor.png"];
    _isDIanxuan = NO ;
}

- (void)setIsDIanxuan:(BOOL)isDIanxuan
{
    if (isDIanxuan) {
        [self dianxuan] ;
    }else
    {
        [self notDianxuan];
    }
}
@end
