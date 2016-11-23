//
//  StructureModel.m
//  HSKExamination
//
//  Created by printer on 2016/10/24.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "StructureModel.h"
#import "ProblemModel.h"
@implementation StructureModel
{
    NSXMLParser         *       _parse ;
    NSString            *       head ;
    NSString            *       read ;
    NSString            *       write ;
}


- (id)init
{
    self = [super init];
    if (self) {
        _exam_head_string = @"" ;
        _exam_read_string = @"" ;
        _exam_write_string = @"" ;
        
        NSString * code = [User shareInstance].candiateModel.SubjectCode;
        head = [NSString stringWithFormat:@"exam_Level%@_head_string",code] ;
        write = [NSString stringWithFormat:@"exam_Leve1%@_write_string",code] ;
        read = [NSString stringWithFormat:@"exam_Level%@_read_string",code] ;
    }
    
    return self ;
}

- (void)parse
{
    _parse = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"试卷结构" ofType:@"xml"]]];
    _parse.delegate = self;
    [_parse parse];

}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (_index == 10) {
        _exam_head_string = [_exam_head_string stringByAppendingString:string];
    }else if (_index == 20)
    {
        _exam_read_string = [_exam_read_string stringByAppendingString:string];
    }else if (_index == 30)
    {
        _exam_write_string = [_exam_write_string stringByAppendingString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict
{

    NSString * s = attributeDict[@"name"] ;
    
    if ([s isEqualToString:head]) {
        _index = 10 ;
    }else if ([s isEqualToString:read])
    {
        _index = 20 ;
    }else if ([s isEqualToString:write])
    {
        _index = 30 ;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
{
    if ([elementName isEqualToString:@"string"]) {
        _index = 0;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    _exam_head_string = [_exam_head_string stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    _exam_read_string = [_exam_read_string stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    _exam_write_string = [_exam_write_string stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];

//    NSLog(@"%@----%@----%@",_exam_head_string,_exam_read_string,_exam_write_string) ;
}


@end
