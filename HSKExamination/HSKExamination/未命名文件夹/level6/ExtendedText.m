//
//  ExtendedText.m
//  HSKExamination
//
//  Created by hiddy on 16/10/16.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExtendedText.h"

@implementation ExtendedText
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"itemBody"]) {
        _index = 99 ;
    }else if ([elementName isEqualToString:@"prompt"])
    {
        _index ++ ;
    }else if ([elementName isEqualToString:@"br"])
    {
       _textString = [_textString stringByAppendingString:@"\n"] ;
    }
    
    
    NSLog(@"%@",elementName) ;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    string = [string stringByReplacingOccurrencesOfString:@"rdquo;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"ldquo;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"nbsp;" withString:@" "];
    string = [string stringByReplacingOccurrencesOfString:@"hellip;" withString:@" "];


    if (_index == 100) {
        if (_textString == nil) {
            _textString = @"" ;
        }
        
        _textString = [_textString stringByAppendingString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"prompt"]) {
        _index ++ ;
    }
}
@end
