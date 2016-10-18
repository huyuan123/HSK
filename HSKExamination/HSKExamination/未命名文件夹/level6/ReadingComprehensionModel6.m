//
//  ReadingComprehensionModel6.m
//  HSKExamination
//
//  Created by hiddy on 16/10/15.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ReadingComprehensionModel6.h"

@implementation ReadingComprehensionModel6
- (id)init
{
    self = [super init];
    if (self) {
        _correctResponseArray = [NSMutableArray arrayWithCapacity:5];
        _subItemArray = [NSMutableArray arrayWithCapacity:5];
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
    }else if ([elementName isEqualToString:@"media"])
    {
        _media = [[Media alloc] initWithDictionary:attributeDict];
    }else if ([elementName isEqualToString:@"simpleChoice"])
    {
        _index = 30 ;
        [_model.array addObject:[[SimpleChoice alloc] initWithDictionary:attributeDict]];
    }

}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"ldquo;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&" withString:@""];
    
    if (_index == 10) {
        [_correctResponseArray addObject:string];
        _index ++ ;
    }else if (_index == 30)
    {
        SimpleChoice * choice = [_model.array lastObject] ;
        choice.textString = [choice.textString stringByAppendingString:string] ;
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
