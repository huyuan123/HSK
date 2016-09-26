//
//  Judgement.m
//  HSKExamination
//
//  Created by hiddy on 16/9/25.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "Judgement.h"

@implementation Judgement

- (void)parseInPath:(NSString *)path
{
//    NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path]];
   NSString * s = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:path] encoding:NSUTF8StringEncoding error:nil];
    NSMutableString * muS = [NSMutableString stringWithString:s];
    
    [muS replaceOccurrencesOfString:@"&lt;" withString:@"<" options:NSCaseInsensitiveSearch range:NSMakeRange(0, s.length)];
    
     [muS replaceOccurrencesOfString:@"&gt;" withString:@">" options:NSCaseInsensitiveSearch range:NSMakeRange(0, s.length - 20)];
    
    self.parse = [[NSXMLParser alloc] initWithData:[muS dataUsingEncoding:NSUTF8StringEncoding]];
    self.parse.delegate = self ;

                  [self.parse parse];

}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if([elementName isEqualToString:@"assessmentItem"])
    {
        [self setValuesForKeysWithDictionary:attributeDict];
        
    }else if ([elementName isEqualToString:@"media"])
    {
        _media = [[Media alloc] initWithDictionary:attributeDict];
    }else if ([elementName isEqualToString:@"img"])
    {
        _img = [[Img alloc] initWithDictionary:attributeDict];
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
    
    NSLog(@"-----------%@",elementName) ;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([_correctResponse isEqualToString:@"correctResponse"]) {
        _correctResponse = string ;
    }
    
    NSLog(@"-----------000000000000000%@",string) ;

}
@end
