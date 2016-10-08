//
//  Judgement3.m
//  HSKExamination
//
//  Created by hiddy on 16/10/7.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "Judgement3.h"

@implementation Judgement3
- (id)init
{
    self = [super init];
    if (self) {
        self.pinyinString = self.textString = @"" ;
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
    
    [muS replaceOccurrencesOfString:@"(" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];
    
    [muS replaceOccurrencesOfString:@")" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];

    [muS replaceOccurrencesOfString:@"&amp;" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];
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
        
    }else if ([elementName isEqualToString:@"simpleChoice"])
    {
        if(!self.simpleChoiceArray)
        {
            self.simpleChoiceArray = [NSMutableArray arrayWithCapacity:2];
        }
        [self.simpleChoiceArray addObject:attributeDict[@"identifier"]];
        
    }else if ([elementName isEqualToString:@"correctResponse"])
    {
        _index = 10 ;
    }else if ([elementName isEqualToString:@"itemBody"])
    {
        _index = 99 ;
    }else if ([elementName isEqualToString:@"prompt"])
    {
        _index ++ ;
    }else if ([elementName isEqualToString:@"media"])
    {
        _media = [[Media alloc] initWithDictionary:attributeDict];
        _media.srcType = judgeMent ;

    }
    
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (_index == 10) {
        self.correctResponse = string ;
        _index ++ ;
    }else if (_index == 100)
    {
        if ([_currentElement isEqualToString:@"rt"])
        {
            self.pinyinString = [self.pinyinString stringByAppendingString:string];
        }else if ([string isEqualToString:@"★"])
        {
            self.textString = [self.textString stringByAppendingFormat:@"\n\n%@",string];
        }
        else
        {
            self.textString = [self.textString stringByAppendingString:string];
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
