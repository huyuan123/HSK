//
//  ReadingComprehensionModel2.m
//  HSKExamination
//
//  Created by hiddy on 16/10/3.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ReadingComprehensionModel2.h"

@implementation ReadingComprehensionModel2

- (id)init
{
    self = [super init];
    if (self) {
        _subItemArr = [NSMutableArray arrayWithCapacity:5];
    }
    
    return self ;
}

- (void)parseInPath:(NSString *)path
{
    NSString * s = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:path] encoding:NSUTF8StringEncoding error:nil];
    NSMutableString * muS = nil ;
    
    
    if (s) {
        muS = [NSMutableString stringWithString:s];
    }
    
    [muS replaceOccurrencesOfString:@"&lt;" withString:@"<" options:NSCaseInsensitiveSearch range:NSMakeRange(0, s.length)];
    
    [muS replaceOccurrencesOfString:@"&gt;" withString:@">" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];
    
    
    NSString * ss = @"（&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;）" ;
   [muS  replaceOccurrencesOfString:@"nbsp;" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];
    
    
    [muS replaceOccurrencesOfString:@"&amp;" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];

    [muS replaceOccurrencesOfString:@"（）" withString:@"*" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];


    
    NSLog(@"%@",muS) ;
    
    //    [muS replaceOccurrencesOfString:@";" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];
    
    self.parse = [[NSXMLParser alloc] initWithData:[muS dataUsingEncoding:NSUTF8StringEncoding]];
    self.parse.delegate = self ;
    
    [self.parse parse];
    
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    _currentElement = elementName ;
    if([elementName isEqualToString:@"assessmentItem"])
    {
        [self setValuesForKeysWithDictionary:attributeDict];
        
    }else if ([elementName isEqualToString:@"correctResponse"])
    {
        if (!_correctResponseArray) {
            _correctResponseArray = [NSMutableArray array];
        }
        isCorrectResponse = YES ;
    }
    
    else if ([elementName isEqualToString:@"subItem"])
    {
        NSMutableArray *  array = [NSMutableArray arrayWithCapacity:6];
        _model = [[SimpleChoice alloc] init];
        [_subItemArr addObject:_model];
        _model.array = array ;
    }
     else if ([elementName isEqualToString:@"simpleChoice"])
    {
        [_model.array addObject:attributeDict[@"identifier"]];
        
    }else if ([elementName isEqualToString:@"itemBody"])
    {
        _index = 99 ;
    }else if ([elementName isEqualToString:@"prompt"])
    {
        _index ++ ;
    }
    
    else if ([elementName isEqualToString:@"rt"] )
    {
        if (_model) {
            _model.pinYInString =   [_model.pinYInString stringByAppendingString:@" "];
        }else if (_index == 100)
        {
            SimpleChoice * choice = [_topicArray lastObject];
            choice.pinYInString = [choice.pinYInString stringByAppendingString:@" "];
        }
        
    }else if ([elementName isEqualToString:@"rb"])
    {
        if (_model) {
            _model.textString =    [_model.textString stringByAppendingString:@" "];
        }else if (_index == 100)
        {
            SimpleChoice * choice = [_topicArray lastObject];
            choice.textString = [choice.textString stringByAppendingString:@" "];
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (isCorrectResponse == YES) {
        [_correctResponseArray addObject:string];
        isCorrectResponse = NO ;
    }else if ([string rangeOfString:@"例如"].length)
    {
        _index ++ ;
    }
    else if (_index == 100)
    {
        if (string.isContainCharater && ![_currentElement isEqualToString:@"rt"] && ![_currentElement isEqualToString:@"rb"]) {
            if(!_topicArray) _topicArray = [NSMutableArray arrayWithCapacity:5];
            SimpleChoice * model = [[SimpleChoice alloc] init];
            model.identifier = string.isContainCharater ;
            [_topicArray addObject:model];
            
        }
        
        SimpleChoice * choice = [_topicArray lastObject];
        if ([_currentElement isEqualToString:@"rt"]) {
            
            choice.pinYInString = [choice.pinYInString stringByAppendingString:string];
        }else if ([_currentElement isEqualToString:@"rb"])
        {
            choice.textString = [choice.textString stringByAppendingString:string];
        }else if (string.isContainNum)
        {
            choice.textString = [choice.textString stringByAppendingString:string.isContainNum];
        }
    }
    else if (_model && [_currentElement isEqualToString:@"rt"])
    {
        _model.pinYInString = [_model.pinYInString stringByAppendingString:string];
        
    }else if (_model && ([_currentElement isEqualToString:@"rb"] || [_currentElement isEqualToString:@"simpleChoice"] ))
    {
        _model.textString = [_model.textString stringByAppendingString:string];
    }else if (string.isNumber && _model)
    {
        _model.textString = [_model.textString stringByAppendingString:string];

    }
    else if (_model && [string rangeOfString:@"*"].length )
    {
        NSString * s = [string stringByReplacingOccurrencesOfString:@"*" withString:@"(  )"];
        _model.textString = [_model.textString stringByAppendingString:s];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
{
    if ([elementName isEqualToString:@"subItem"]) {
        _model = nil ;
    }
}
@end