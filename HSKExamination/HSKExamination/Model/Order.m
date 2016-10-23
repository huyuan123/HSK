//
//  Order.m
//  HSKExamination
//
//  Created by hiddy on 16/10/16.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "Order.h"

@implementation Order
- (id)init
{
    self = [super init];
    if (self) {
//        _textString = @"" ;
//        _i = 1 ;
    }
    
    return self ;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    _currentElement = elementName ;

    
    if([elementName isEqualToString:@"correctResponse"])
    {
        _correctResponse = @"" ;
        _index = 10 ;
    }else if ([elementName isEqualToString:@"itemBody"])
    {
        _index = 99 ;
    }else if ([elementName isEqualToString:@"simpleChoice"])
    {
        _index = 100 ;
        if (!_subItemArray) {
            _subItemArray = [NSMutableArray array];
        }
        _model = [[SimpleChoice alloc] initWithDictionary:attributeDict];
        [_subItemArray addObject:_model];
    }
     
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (_index == 10) {
        [_correctResponse stringByAppendingString:string];
    }else if (_index == 100)
    {
       _model.textString = [_model.textString stringByAppendingString:string] ;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
{
    if ([elementName isEqualToString:@"promt"]) {
        _index ++ ;
    }else if ([elementName isEqualToString:@"correctResponse"])
    {
        _index ++ ;
    }else if ([elementName isEqualToString:@"itemBody"])
    {
        _index ++ ;
    }
}
@end
