//
//  ReadingComprehensionModel7.m
//  HSKExamination
//
//  Created by hiddy on 16/10/16.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ReadingComprehensionModel7.h"

@implementation ReadingComprehensionModel7

- (id)init
{
    self = [super init];
    if (self) {
        _correctResponseArray = [NSMutableArray arrayWithCapacity:5];
        _subItemArray = [NSMutableArray arrayWithCapacity:5];
        _textString = @"       " ;
    }
    
    return self ;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"correctResponse"]) {
        _index = 10 ;
    }else if ([elementName isEqualToString:@"subItem"])
    {
        _model = [[SimpleChoice alloc] init];
        _model.array = [NSMutableArray arrayWithCapacity:5];
        [_subItemArray addObject:_model];
        _index = 19 ;
    }else if ([elementName isEqualToString:@"simpleChoice"])
    {
        _index = 30 ;
        [_model.array addObject:[[SimpleChoice alloc] initWithDictionary:attributeDict]];
    }else if ([elementName isEqualToString:@"itemBody"])
    {
        _index = 99 ;
    }else if ([elementName isEqualToString:@"prompt"])
    {
        _index ++ ;
    }else if ([elementName isEqualToString:@"br"])
    {
        _textString = [_textString stringByAppendingString:@"\n\n       "];
    }
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"nbsp;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"rdquo;" withString:@""];

    string = [string stringByReplacingOccurrencesOfString:@"ldquo;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&" withString:@""];
    
    if (_index == 10) {
        [_correctResponseArray addObject:string];
        _index ++ ;
    }else if (_index == 30)
    {
        SimpleChoice * choice = [_model.array lastObject] ;
        choice.textString = [choice.textString stringByAppendingString:string] ;
    }else if (_index == 100)
    {
        _textString = [_textString stringByAppendingString:string];
    }else if (_index == 20)
    {
        _model.textString = [_model.textString stringByAppendingString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"subItem"]) {
        _index ++ ;
    }else if ([elementName isEqualToString:@"simpleChoice"])
    {
        _index ++ ;
    }else if ([elementName isEqualToString:@"prompt"])
    {
        _index ++ ;
    }
}

@end
