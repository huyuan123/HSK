//
//  Judgement.m
//  HSKExamination
//
//  Created by hiddy on 16/9/25.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "Judgement.h"

@implementation Judgement

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if([elementName isEqualToString:@"assessmentItem"])
    {
        [self setValuesForKeysWithDictionary:attributeDict];
        
    }else if ([elementName isEqualToString:@"media"])
    {
        _media = [[Media alloc] initWithDictionary:attributeDict];
        _media.srcType = judgeMent ;
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
    
//    NSLog(@"-----------%@",elementName) ;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([_correctResponse isEqualToString:@"correctResponse"]) {
        _correctResponse = string ;
    }
    
//    NSLog(@"-----------000000000000000%@",string) ;

}
@end
