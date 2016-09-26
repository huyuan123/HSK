//
//  Img.h
//  HSKExamination
//
//  Created by printer on 9/26/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Img : NSObject
@property (nonatomic ,strong) NSString * width  ;  // 路径
@property (nonatomic ,strong) NSString * height  ;  // 路径
@property (nonatomic ,strong) NSString * src  ;  // 路径
@property (nonatomic ,strong) NSString * alt  ;  // 路径
//@property (nonatomic ,strong) NSString * src  ;  // 路径
- (instancetype)initWithDictionary:(NSDictionary *)dictionary ;

@end
