//
//  Judgement.m
//  HSKExamination
//
//  Created by hiddy on 16/9/25.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "Judgement.h"

@implementation Judgement
- (id)init
{
    self = [super init];
    if (self) {
        _pinyinString = @"" ;
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
        
    }else if ([elementName isEqualToString:@"img"])
    {
        _img = [[Img alloc] initWithDictionary:attributeDict] ;
        
    }else if ([elementName isEqualToString:@"simpleChoice"])
    {
        if(!_simpleChoiceArray)
        {
            _simpleChoiceArray = [NSMutableArray arrayWithCapacity:2];
        }
        [_simpleChoiceArray addObject:attributeDict[@"identifier"]];
        
    }else if ([elementName isEqualToString:@"correctResponse"])
    {
        _correctResponse = @"correctResponse" ;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([_correctResponse isEqualToString:@"correctResponse"]) {
        _correctResponse = string ;
    }else if ([_currentElement isEqualToString:@"rt"])
    {
        _pinyinString = [_pinyinString stringByAppendingString:[string stringByAppendingString:@" "]];
    }else if ([_currentElement isEqualToString:@"rb"] )
    {
        _textString = [_textString stringByAppendingString:[string stringByAppendingString:@"  "]];
    }

}

@end
