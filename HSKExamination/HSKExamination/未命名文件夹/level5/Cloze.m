//
//  Cloze.m
//  HSKExamination
//
//  Created by printer on 2016/10/12.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "Cloze.h"

@implementation Cloze
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    _currentElement = elementName ;
    if([elementName isEqualToString:@"correctResponse"])
    {
        if (!_correctResponseArray) {
            _correctResponseArray = [NSMutableArray array];
        }
        
        _index = 10 ;
    }else if ([elementName isEqualToString:@"itemBody"])
    {
        _index = 99 ;
        _textString = @"" ;
        _tiHao = 1 ;
    }else if ([elementName isEqualToString:@"prompt"])
    {
        _index ++ ;
    }else if ([elementName isEqualToString:@"subItem"])
    {
        if(!_subItemArr) _subItemArr = [NSMutableArray array];
        _index = 49 ;
        
        _model = [[SimpleChoice alloc] init];
        [_subItemArr addObject:_model];
        _model.array = [NSMutableArray array];
    }else if ([elementName isEqualToString:@"simpleChoice"])
    {
        [_model.array addObject:[[SimpleChoice alloc] initWithDictionary:attributeDict]];
        _index = 20 ;
    }else if ([elementName isEqualToString:@"media"])
    {
        _media = [[Media alloc] initWithDictionary:attributeDict];
    }else if ([elementName isEqualToString:@"clozeGap"])
    {
        _textString = [_textString stringByAppendingString:[NSString stringWithFormat:@"( %d )",_tiHao ++ ]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"nbsp;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"ldquo;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"rdquo;" withString:@""];

    if (_index == 10) {
        [_correctResponseArray addObject:string];
        _index ++ ;
    }else if (_index == 100)
    {
        _textString = [_textString stringByAppendingString:string];
    }else if (_index == 50)
    {
        _model.textString = [_model.textString stringByAppendingString:string];
    }else if (_index == 20)
    {
        SimpleChoice * choice = [_model.array lastObject];
        choice.textString = [choice.textString stringByAppendingString:string];
        _index ++ ;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
{
    if ([elementName isEqualToString:@"promt"]) {
        _index ++ ;
    }
}

@end
