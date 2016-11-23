//
//  TextEntry.m
//  HSKExamination
//
//  Created by hiddy on 16/10/10.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "TextEntry.h"

@implementation TextEntry
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict
{
    _currentElement = elementName ;
    if ([elementName isEqualToString:@"mapEntry"]) {
        _correctResponse = attributeDict[@"mapKey"];
    }else if ([elementName isEqualToString:@"itemBody"])
    {
        _index = 99 ;
    
    }else if ([elementName isEqualToString:@"div"])
    {
        _index ++ ;
        _simpleChoiceArray = [NSMutableArray array];
        if (!_textString) {
            _textString = @"" ;
        }
    }else if ([elementName isEqualToString:@"br"])
    {
        _textString = [_textString stringByAppendingString:@"\n\n"];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
{

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"nbsp;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&" withString:@""];

    _textString  = [_textString stringByAppendingString:string];
    
    if (string.isCharacter) {
        _model = [[SimpleChoice alloc] init];
        _model.identifier = string ;
        [_simpleChoiceArray addObject:_model];
        _model.textString = @"" ;
        return ;
    }
    
    _model.textString = [_model.textString stringByAppendingString:string];
    
    
}


@end
