//
//  SingleChoice3.m
//  HSKExamination
//
//  Created by printer on 10/9/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "SingleChoice3.h"

@implementation SingleChoice3
- (id)init
{
    self = [super init];
    if (self) {
        _textString = @"" ;
    }
    
    return self ;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    _currentElement = elementName ;
    if([elementName isEqualToString:@"assessmentItem"])
    {
        [self setValuesForKeysWithDictionary:attributeDict];
        
    }else if ([elementName isEqualToString:@"media"])
    {
        _media = [[Media alloc] initWithDictionary:attributeDict];
        _media.srcType = judgeMent ;
        
    }else if ([elementName isEqualToString:@"simpleChoice"])
    {
        if(!_simpleChoiceArray)
        {
            _simpleChoiceArray = [NSMutableArray arrayWithCapacity:3];
        }
        
        _model = [[SimpleChoice alloc] initWithDictionary:attributeDict];
        _model.textString = _model.pinYInString = @"" ;
        [_simpleChoiceArray addObject: _model];
        
    }else if ([elementName isEqualToString:@"itemBody"])
    {
        _index = 99 ;
    }else if ([elementName isEqualToString:@"prompt"])
    {
        _index ++ ;
    }
    else if ([elementName isEqualToString:@"correctResponse"])
    {
        _index = 10 ;
    }
    
    NSLog(@"---------------%d",_index) ;

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"nbsp;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"mdash;" withString:@""];

    NSLog(@"---------------%@",string) ;

    if ([string isEqualToString:@"★"]) {
        string = [@"\n\n" stringByAppendingString:string];
    }

    if (_index == 100)
    {
        _textString = [_textString stringByAppendingString:string];
    }else
    if (_index == 10) {
        _correctResponse = string ;
        _index ++ ;
    }else if (_model)
    {
        _model.textString = [_model.textString stringByAppendingString:string];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
{
    if ([elementName isEqualToString:@"simpleChoice"])
    {
        _model = nil ;
        
    }else if ([elementName isEqualToString:@"prompt"])
    {
        _index ++ ;
    }
    
}


@end
