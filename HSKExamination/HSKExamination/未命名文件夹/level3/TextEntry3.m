//
//  TextEntry3.m
//  HSKExamination
//
//  Created by hiddy on 16/10/23.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "TextEntry3.h"

@implementation TextEntry3
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"mapEntry"]) {
        _correctResponse = attributeDict[@"mapKey"] ;
    }else if ([elementName isEqualToString:@"div"])
    {
        _textString  = @"" ;
        _index = 100 ;
    }else if ([elementName isEqualToString:@"img"])
    {
        _img = [[Img alloc] initWithDictionary:attributeDict];
    }
    
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"%@",string) ;
    string = [string stringByReplacingOccurrencesOfString:@"&" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"nbsp;" withString:@""];

    string = [string stringByReplacingOccurrencesOfString:@"）" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"（" withString:@""];

    if (_index == 100) {
        _textString = [_textString stringByAppendingString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"div"]) {
        _index ++ ;
    }
}
@end
