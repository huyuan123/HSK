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

- (void)parseInPath:(NSString *)path
{
    NSString * s = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:path] encoding:NSUTF8StringEncoding error:nil];
    NSMutableString * muS = nil ;
    
    
    if (s) {
        muS = [NSMutableString stringWithString:s];
    }
    
    [muS replaceOccurrencesOfString:@"&lt;" withString:@"<" options:NSCaseInsensitiveSearch range:NSMakeRange(0, s.length)];
    
    [muS replaceOccurrencesOfString:@"&gt;" withString:@">" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];
    
    [muS replaceOccurrencesOfString:@"&amp;" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];

    [muS replaceOccurrencesOfString:@")" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];
    [muS replaceOccurrencesOfString:@"(" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];

    [muS replaceOccurrencesOfString:@"nbsp;" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];

    [muS replaceOccurrencesOfString:@"播放音频" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];


    NSLog(@"%@",muS) ;
    self.parse = [[NSXMLParser alloc] initWithData:[muS dataUsingEncoding:NSUTF8StringEncoding]];
    self.parse.delegate = self ;
    
    [self.parse parse];
    
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
    }else if ([elementName isEqualToString:@"itemBody"])
    {
        _index = 99 ;
    }else if ([elementName isEqualToString:@"prompt"])
    {
        _index ++ ;
    
    }if (_index == 100) {
        if ([_currentElement isEqualToString:@"rt"])
        {
            _pinyinString = [_pinyinString stringByAppendingString:@"  "];
        }else if ([_currentElement isEqualToString:@"rb"] )
        {
            _textString = [_textString stringByAppendingString:@"  "];
        }

    }


}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([_correctResponse isEqualToString:@"correctResponse"]) {
        _correctResponse = string ;
    }else if (_index == 100)
    {
         if ([_currentElement isEqualToString:@"rt"])
        {
            _pinyinString = [_pinyinString stringByAppendingString:string];
        }else if ([string isEqualToString:@"★"])
        {
            _textString = [_textString stringByAppendingFormat:@"\n\n%@",string];
        }
         else
        {
            _textString = [_textString stringByAppendingString:string];
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"prompt"]) {
        _index ++ ;
    }
}

@end
