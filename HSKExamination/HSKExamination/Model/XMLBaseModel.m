//
//  XMLBaseModel.m
//  HSKExamination
//
//  Created by printer on 9/7/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "XMLBaseModel.h"

@implementation XMLBaseModel
{
//    NSXMLParser * _parser ;
}
- (void)parseInPath:(NSString *)path
    {
    
        NSURL *url = [NSURL fileURLWithPath:path];
        
        // 开始解析XML
        _parse = [[NSXMLParser alloc] initWithContentsOfURL:url];
        _parse.delegate = self;
        [_parse parse];
        NSLog(@"解析完成。。。");
    }
    
    
    - (void)parserDidStartDocument:(NSXMLParser *)parser {
        // 此方法只在解析开始时触发一次，因此可在这个方法中初始化解析过程中用到的一些成员变量
        NSLog(@"开始解析") ;
    }
    
    // 文档出错的时候触发
    - (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
        NSLog(@"%@", parseError);
    }
    
    // 遇到一个开始标签的时候触发
    - (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
        
//        NSLog(@"%@", elementName);
//        NSLog(@"%@", namespaceURI);
//        NSLog(@"%@", qName);
//        NSLog(@"%@", attributeDict);
        
        [attributeDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self setValue:obj forKey:key];
        }];
        
        NSLog(@"解析正在进行啊啊啊啊啊") ;

        // elementName是正在解析的元素的名字
        //    _currentTagName = elementName;
        //    // 如果元素名字为Note，取出它的属性id
        //    if ([_currentTagName isEqualToString:@"Note"]) {
        //        // 属性在attributeDict参数中传递过来，它是一个字典类型，其中的键的名字就是属性的名字，值是属性的值
        //        NSString *_id = [attributeDict objectForKey:@"id"];
        //        NSMutableDictionary *dict = [NSMutableDictionary new];
        //        [dict setObject:_id forKey:@"id"];
        //        [_notes addObject:dict];
        //    }
    }
    
    // 遇到字符串时候触发，该方法是解析元素文本内容主要场所
    - (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
        // 剔除回车和空格
        // stringByTrimmingCharactersInSet：方法是剔除字符方法
        // [NSCharacterSet whitespaceAndNewlineCharacterSet]指定字符集为换行符和回车符
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([string isEqualToString:@""]) {
            return;
        }
        
        NSLog(@"------------%@", string);
        
        //    NSMutableDictionary *dict = [_notes lastObject];
        //
        //    if ([_currentTagName isEqualToString:@"CDate"] && dict) {
        //        [dict setObject:string forKey:@"CDate"];
        //    }
        //
        //    if ([_currentTagName isEqualToString:@"Content"] && dict) {
        //        [dict setObject:string forKey:@"Content"];
        //    }
        //
        //    if ([_currentTagName isEqualToString:@"UserID"] && dict) {
        //        [dict setObject:string forKey:@"UserID"];
        //    }
    }
    
    // 遇到结束标签时触发，在该方法中主要是清理刚刚解析完成的元素产生的影响，以便于不影响接下来的解析
    //- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    //    // 清理刚才解析的元素的名字，以便于记录接下来解析的元素的名字
    //    self.currentTagName = nil;
    //}
    //
    //// 遇到文档结束时触发
    - (void)parserDidEndDocument:(NSXMLParser *)parser {

        NSLog(@"解析真的完成啦完成啦完成啦完成啦") ;
    }

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //    if([key isEqualToString:@"id"]) {
    //        self.productID = value;
    //    }
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([value isKindOfClass:[NSNull class]]) {
        
        //        NSLog(@"%@------%@",key,value);
        [super setValue:@"" forKey:key] ;
        return;
    }
    
    [super setValue:value forKey:key];
}



@end
