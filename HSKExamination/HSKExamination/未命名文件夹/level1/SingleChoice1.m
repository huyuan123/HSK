//
//  SingleChoice1.m
//  HSKExamination
//
//  Created by hiddy on 16/10/7.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "SingleChoice1.h"

@implementation SingleChoice1
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    _currentElement = elementName ;
    if([elementName isEqualToString:@"assessmentItem"])
    {
        [self setValuesForKeysWithDictionary:attributeDict];
        
    }else if ([elementName isEqualToString:@"media"])
    {
        _media = [[Media alloc] initWithDictionary:attributeDict];
        _media.srcType = judgeMent ;
        
    }else if ([elementName isEqualToString:@"img"])
    {
        if (!_imgArr) {
            _imgArr = [NSMutableArray arrayWithCapacity:3];
        }
        [_imgArr addObject:[[Img alloc] initWithDictionary:attributeDict]];
        
    }else if ([elementName isEqualToString:@"simpleChoice"])
    {
        if(!_simpleChoiceArray)
        {
            _simpleChoiceArray = [NSMutableArray arrayWithCapacity:2];
        }
        
        _model = [[SimpleChoice alloc] initWithDictionary:attributeDict];
        _model.textString = _model.pinYInString = @"" ;
        [_simpleChoiceArray addObject: _model];
        
    }else if ([elementName isEqualToString:@"correctResponse"])
    {
        _correctResponse = @"correctResponse" ;
    }else if (_model && [_currentElement isEqualToString:@"rt"])
    {
        _model.pinYInString = [_model.pinYInString stringByAppendingString:@" "];
    }else if (_model && ([_currentElement isEqualToString:@"rb"] || [_currentElement isEqualToString:@"simpleChoice"]))
    {
        _model.textString = [_model.textString stringByAppendingString:@" "];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"ldquo;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"rdquo;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&" withString:@""];

    
    if ([_correctResponse isEqualToString:@"correctResponse"]) {
        _correctResponse = string ;
    }else if (_model && [_currentElement isEqualToString:@"rt"])
    {
        _model.pinYInString = [_model.pinYInString stringByAppendingString:string];
    }else if (_model && ([_currentElement isEqualToString:@"rb"] || [_currentElement isEqualToString:@"simpleChoice"]))
    {
        _model.textString = [_model.textString stringByAppendingString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
{
    if ([elementName isEqualToString:@"simpleChoice"])
    {
        _model = nil ;
    }
}
@end


@implementation SingleChoice2
@end


