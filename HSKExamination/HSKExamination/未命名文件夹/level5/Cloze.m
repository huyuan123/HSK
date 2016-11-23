//
//  Cloze.m
//  HSKExamination
//
//  Created by printer on 2016/10/12.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "Cloze.h"

@implementation Cloze
- (id)init
{
    self = [super init];
    if (self) {
        _textString = @"" ;
        _i = 1 ;
    }
    
    return self ;
}

//- (void)parseInPath:(NSString *)path
//{
//    NSString * s = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:path] encoding:NSUTF8StringEncoding error:nil];
//    NSMutableString * muS = nil ;
//    
//    
//    if (s) {
//        muS = [NSMutableString stringWithString:s];
//    }
//    
//    [muS replaceOccurrencesOfString:@"&lt;" withString:@"<" options:NSCaseInsensitiveSearch range:NSMakeRange(0, s.length)];
//    
//    [muS replaceOccurrencesOfString:@"&gt;" withString:@">" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];
//    
//    [muS replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];
//
//    NSLog(@"%@",muS) ;
//    self.parse = [[NSXMLParser alloc] initWithData:[muS dataUsingEncoding:NSUTF8StringEncoding]];
//    self.parse.delegate = self ;
//    
//    [self.parse parse];
//}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    _currentElement = elementName ;
    if([elementName isEqualToString:@"correctResponse"])
    {
        if (!_correctResponseArray) {
            _correctResponseArray = [NSMutableArray array];
        }
        
        _index = 10 ;
    }else if ([elementName isEqualToString:@"itemBody"])
    {
        _index = 99 ;
        _textString = @"" ;
        _examString = @"" ;
    }else if ([elementName isEqualToString:@"prompt"])
    {
        _index ++ ;
    }else if ([elementName isEqualToString:@"subItem"])
    {
        if(!_subItemArr) _subItemArr = [NSMutableArray array];
        _index = 49 ;
        
        _model = [[SimpleChoice alloc] init];
        [_subItemArr addObject:_model];
        _model.array = [NSMutableArray array];
    }else if ([elementName isEqualToString:@"simpleChoice"])
    {
        [_model.array addObject:[[SimpleChoice alloc] initWithDictionary:attributeDict]];
        _index = 20 ;
    }else if ([elementName isEqualToString:@"media"])
    {
        _media = [[Media alloc] initWithDictionary:attributeDict];
    }else if ([elementName isEqualToString:@"clozeGap"])
    {
      _textString =  [_textString stringByAppendingFormat:@"(_%d_)",_i++];
    }else if ([elementName isEqualToString:@"br"])
    {
        _textString =  [_textString stringByAppendingFormat:@"\n\n"];
        
    }else if ([elementName isEqualToString:@"u"])
    {
        if (!_titleArray) {
            _titleArray = [NSMutableArray array];
        }
        _examString = [_examString stringByAppendingString:@"( "];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"hellip;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"nbsp;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"ldquo;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"mdash;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"rdquo;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"　" withString:@""];

    NSLog(@"------------%@",string) ;
    if ([string isCharacter]) {
        string = [NSString stringWithFormat:@"\n\n%@ ",string];
    }

    if (_index == 10) {
        [_correctResponseArray addObject:string];
        _index ++ ;
    }else if (_index == 100)
    {
        _textString = [_textString stringByAppendingString:string];
        _examString = [_examString stringByAppendingString:string];
    }else if (_index == 50)
    {
        _model.textString = [_model.textString stringByAppendingString:string];
    }else if (_index == 20)
    {
        SimpleChoice * choice = [_model.array lastObject];
        choice.textString = [choice.textString stringByAppendingString:string];
        _index ++ ;
    }
    
    if ([_currentElement isEqualToString:@"u"]) {
        [_titleArray addObject:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
{
    if ([elementName isEqualToString:@"promt"]) {
        _index ++ ;
    }else if ([elementName isEqualToString:@"itemBody"])
    {
        _index ++ ;
    }else if ([elementName isEqualToString:@"u"])
    {
        _examString = [_examString stringByAppendingString:@" )"];
        _currentElement = @"" ;
    }
}

@end
