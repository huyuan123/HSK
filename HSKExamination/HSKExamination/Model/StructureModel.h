//
//  StructureModel.h
//  HSKExamination
//
//  Created by printer on 2016/10/24.
//  Copyright © 2016年 printer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StructureModel : NSObject<NSXMLParserDelegate>

@property (nonatomic, strong) NSString  *   exam_read_string ;
@property (nonatomic, strong) NSString  *   exam_head_string ;
@property (nonatomic, strong) NSString  *   exam_write_string ;

- (void)parse ;

@end
