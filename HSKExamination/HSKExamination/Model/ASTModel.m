//
//  ASTModel.m
//  HSKExamination
//
//  Created by printer on 9/8/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "ASTModel.h"
#import "AssessmentSection.h"
#import "assessmentItemRef.h"

TestPart  *  testPartModel ;
AssessmentSection  *  assessmentSection         ;
AssessmentItemRef  *  assessmentItem            ;

@implementation ASTModel
{
    ASTIndex   astIndex ;
}
- (id)init
{
    self = [super init];
    if (self) {
        
    }
   
    return self ;
}

- (void)parseInPath:(NSString *)path
{
    
    path = [IpadPath stringByAppendingPathComponent:path];
    
    NSLog(@"试卷路径--------%@",path) ;
    
    astIndex = (ASTIndex){0,0,0} ;
    
    _testPartArray = [NSMutableArray arrayWithCapacity:3];
    
    NSString * s = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:path] encoding:NSUTF8StringEncoding error:nil];
    
    NSMutableString * muS = nil ;
    if (s) {
        muS = [NSMutableString stringWithString:s];
    }
    
    [muS replaceOccurrencesOfString:@"&lt;" withString:@"<" options:NSCaseInsensitiveSearch range:NSMakeRange(0, s.length)];
    
    [muS replaceOccurrencesOfString:@"&gt;" withString:@">" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length - 20)];
    
    self.parse = [[NSXMLParser alloc] initWithData:[muS dataUsingEncoding:NSUTF8StringEncoding]];
    self.parse.delegate = self ;
    
    [self.parse parse];
}

// 遇到一个开始标签的时候触发
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {

    if ([elementName isEqualToString:@"assessmentTest"]) {
        
        [self setValuesForKeysWithDictionary:attributeDict];
        
    }else if ([elementName isEqualToString:@"testPart"])
    {
        testPartModel = [[TestPart alloc] initWithDictionary:attributeDict];
        testPartModel.assessmentSectionArray = [NSMutableArray array];
         [_testPartArray addObject:testPartModel];
        astIndex.textPart = _testPartArray.count ;
        astIndex.assessmentSection = 0 ;
        astIndex.assessmentItemRef = 0 ;
    }else if ([elementName isEqualToString:@"assessmentSection"])
    {
        assessmentSection = [[AssessmentSection alloc] initWithDictionary:attributeDict];
        assessmentSection.assessmentItemRefArray = [NSMutableArray array] ;
        [testPartModel.assessmentSectionArray addObject:assessmentSection];
        astIndex.assessmentSection = testPartModel.assessmentSectionArray.count ;
        astIndex.assessmentItemRef = 0 ;

    }else if ([elementName isEqualToString:@"assessmentItemRef"])
    {
        assessmentItem = [[AssessmentItemRef alloc] initWithDictionary:attributeDict];
        if (![assessmentItem.isExample isEqualToString:@"true"]) {
            [assessmentSection.assessmentItemRefArray  addObject:assessmentItem] ;
            astIndex.textPart = _testPartArray.count ;
            astIndex.assessmentSection = testPartModel.assessmentSectionArray.count ;
            astIndex.assessmentItemRef = assessmentSection.assessmentItemRefArray.count ;
            assessmentItem.astIndex = astIndex ;
        }
    }else if ([elementName isEqualToString:@"rubricBlock"])
    {
        if (astIndex.assessmentSection > 0) {
            assessmentSection.rubricBlock = @"-1" ;
        }else
        {
            testPartModel.rubricBlock = @"-1" ;
        }
    }else if ([elementName isEqualToString:@"endBlock"])
    {
        if (astIndex.assessmentSection > 0) {
            assessmentSection.endBlock = @"-1" ;
        }else
        {
            testPartModel.endBlock = @"-1" ;
        }
    }else if ([elementName isEqualToString:@"prompt"])
    {
        
    }

    
    

}

// 遇到字符串时候触发，该方法是解析元素文本内容主要场所
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    // 剔除回车和空格
    // stringByTrimmingCharactersInSet：方法是剔除字符方法
    // [NSCharacterSet whitespaceAndNewlineCharacterSet]指定字符集为换行符和回车符
//    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    if ([string isEqualToString:@""]) {
//        return;
//    }
    
//    NSLog(@"%@", string);

}


// 遇到结束标签时触发，在该方法中主要是清理刚刚解析完成的元素产生的影响，以便于不影响接下来的解析
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    // 清理刚才解析的元素的名字，以便于记录接下来解析的元素的名字
    if ([elementName isEqualToString:@"assessmentTest"]) {
        testPartModel = nil ;
        assessmentItem = nil ;
        assessmentSection = nil ;
    }
}

// 遇到文档结束时触发
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    // 使用通知机制将数据通过广播通知投送回表示层
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:self.notes userInfo:nil];
//    // 解析完成，清理成员变量
//    self.notes = nil;
}



@end
