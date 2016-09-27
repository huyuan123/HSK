//
//  TestPaperPackageInfo.m
//  HSKExamination
//
//  Created by printer on 9/7/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "TestPaperPackageInfoModel.h"

@implementation TestPaperPackageInfoModel
- (void)parseInPath:(NSString *)path
{
    path = [NSString stringWithFormat:@"%@/%@/%@",IpadPath,path,@"TestPaperPackageInfo.xml"];
    
    [super parseInPath:path];
    
//    NSLog(@"--------------------%@",_href) ;
}


// 遇到一个开始标签的时候触发
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
//           NSLog(@"----------%@,%@",qName,attributeDict) ;
    [attributeDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        NSLog(@"----------key=%@   value=%@",key,obj) ;
        [self setValue:obj forKey:key];
    }];
    

}
@end
