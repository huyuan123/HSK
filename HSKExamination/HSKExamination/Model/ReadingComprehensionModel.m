//
//  ReadingComprehensionModel.m
//  HSKExamination
//
//  Created by printer on 9/28/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "ReadingComprehensionModel.h"
BOOL   isCorrectResponse ;
@implementation ReadingComprehensionModel
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    
    if([elementName isEqualToString:@"assessmentItem"])
    {
        [self setValuesForKeysWithDictionary:attributeDict];
        
    }else if ([elementName isEqualToString:@"correctResponse"])
    {
        if (!_correctResponseArray) {
            _correctResponseArray = [NSMutableArray array];
        }
        isCorrectResponse = YES ;
    }else if ([elementName isEqualToString:@"media"])
    {
        _media = [[Media alloc] initWithDictionary:attributeDict];
    }else if ([elementName isEqualToString:@"img"])
    {
        if (!_imgArray) {
            _imgArray = [NSMutableArray arrayWithCapacity:6] ;
        }
        
        [_imgArray addObject:[[Img alloc] initWithDictionary:attributeDict]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (isCorrectResponse == YES) {
        [_correctResponseArray addObject:string];
        isCorrectResponse = NO ;
    }
}

@end
