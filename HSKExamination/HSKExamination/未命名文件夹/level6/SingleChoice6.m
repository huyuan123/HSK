//
//  SingleChoice6.m
//  HSKExamination
//
//  Created by hiddy on 16/10/15.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "SingleChoice6.h"

@implementation SingleChoice6
- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self ;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"correctResponse"]) {
        _index = 10 ;
    }else if ([elementName isEqualToString:@"itemBody"])
    {
        _simpleModel = [[SimpleChoice alloc] init];
        _simpleModel.array = [NSMutableArray arrayWithCapacity:4];
        _index = 99 ;
    }else if ([elementName isEqualToString:@"simpleChoice"])
    {
        _index = 30 ;
        [_simpleModel.array addObject:[[SimpleChoice alloc] initWithDictionary:attributeDict]];
    }else if ([elementName isEqualToString:@"prompt"])
    {
        _index ++ ;
    }
    
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{

    string = [string stringByReplacingOccurrencesOfString:@"ldquo;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&" withString:@""];

    
    if (_index == 10) {
        _correctResponse = string ;
        _index ++ ;
    }else if (_index == 30)
    {
        SimpleChoice * choice = [_simpleModel.array lastObject] ;
        choice.textString = [choice.textString stringByAppendingString:string] ;
    }else if (_index == 100)
    {
        _simpleModel.textString = [_simpleModel.textString stringByAppendingString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"subItem"]) {
        _index ++ ;
    }else if ([elementName isEqualToString:@"simpleChoice"])
    {
        _index ++ ;
    }
}

@end
