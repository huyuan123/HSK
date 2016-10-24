//
//  ExtendedText.m
//  HSKExamination
//
//  Created by hiddy on 16/10/23.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExtendedText4.h"

@implementation ExtendedText4
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict
{
    _currentElement = elementName ;
    if ([elementName isEqualToString:@"img"]) {
        _img = [[Img alloc] initWithDictionary:attributeDict];
    }else if ([elementName isEqualToString:@"itemBody"])
    {
        _index = 99 ;
        
    }else if ([elementName isEqualToString:@"prompt"])
    {
        _index ++ ;
        _textString = @"" ;
    }else if ([elementName isEqualToString:@"br"])
    {
        _textString = [_textString stringByAppendingString:@"\n"];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
{
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@" "];
    string = [string stringByReplacingOccurrencesOfString:@"nbsp;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&" withString:@" "];
    
    _textString = [_textString stringByAppendingString:string];
    
}



@end
