//
//  PaperModel.m
//  HSKExamination
//
//  Created by hiddy on 16/10/31.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "PaperModel.h"
#import "Media.h"
@implementation PaperModel

- (id)init
{
    self = [super init];
    if (self) {
        _testPartArray = [NSMutableArray arrayWithCapacity:3];
    }
    return self ;
}

- (void)parseInPath:(NSString *)path
{
    astIndex = (ASTIndex){0,0,0} ;
    Candidates * model = [User shareInstance].candiateModel;
    __block NSString * paperPath = [@"TEST" pathWithType:Documents];
    paperPath = [paperPath stringByAppendingFormat:@"/examdata/%@/",model.SubjectCode];
    [User shareInstance].paperPath = paperPath;


    [paperPath enumeratorFolder:^(NSString *filePath) {
        NSLog(@"------------------%@",filePath) ;
        if ([filePath rangeOfString:@"xml"].length) {
            paperPath = [paperPath stringByAppendingPathComponent:filePath];
        }
    }];
    
    
    [super parseInPath:paperPath];
}


- (void)parserDidStartDocument:(NSXMLParser *)parser {
    // 此方法只在解析开始时触发一次，因此可在这个方法中初始化解析过程中用到的一些成员变量
    NSLog(@"开始解析") ;
}

// 文档出错的时候触发
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"%@", parseError);
}

// 遇到一个开始标签的时候触发
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"testPart"]) {
        testPartModel  = [[TestPart alloc] initWithDictionary:attributeDict];
        [_testPartArray addObject:testPartModel];
        astIndex.textPart = _testPartArray.count ;
        astIndex.assessmentSection = 0 ;
        astIndex.assessmentItemRef = 0 ;

        _index = 10 ;
    }else if ([elementName isEqualToString:@"rubricBlock"] && _index == 10)
    {
        _index ++ ;
    }else if ([elementName isEqualToString:@"media"] ) // && _index == 11)
    {
        NSLog(@"======================%d",_index) ;
        if (_index == 11) {
            testPartModel.rubricBlock = [[Media alloc] initWithDictionary:attributeDict];
        }else if (_index == 13)
        {
            testPartModel.endBlock = [[Media alloc] initWithDictionary:attributeDict];
        }else if (_index == 101)
        {
            assessmentSection.rubricMedia = [[Media alloc] initWithDictionary:attributeDict];
        }else if (_index == 1000)
        {
            assessmentItem.media = [[Media alloc] initWithDictionary:attributeDict];
        }
        _index ++ ;
    }
    else if ([elementName isEqualToString:@"endBlock"])
    {
        _index ++ ;
        
    }else if ([elementName isEqualToString:@"timeLimits"])
    {
        testPartModel.timeLimit = [[TimeLimit alloc] initWithDictionary:attributeDict];
    }
    else if ([elementName isEqualToString:@"assessmentSection"])
    {
        assessmentSection = [[AssessmentSection alloc] initWithDictionary:attributeDict];
        assessmentSection.assessmentItemRefArray = [NSMutableArray array] ;
        [testPartModel.assessmentSectionArray addObject:assessmentSection];
        astIndex.assessmentSection = testPartModel.assessmentSectionArray.count ;
        astIndex.assessmentItemRef = 0 ;
        _index = 100 ;
    }else if ([elementName isEqualToString:@"assessmentItemRef"])
    {
            assessmentItem = [[AssessmentItemRef alloc] initWithDictionary:attributeDict];
            [assessmentSection.assessmentItemRefArray  addObject:assessmentItem] ;
            astIndex.textPart = _testPartArray.count ;
            astIndex.assessmentSection = testPartModel.assessmentSectionArray.count ;
            astIndex.assessmentItemRef = assessmentSection.assessmentItemRefArray.count ;
            assessmentItem.astIndex = astIndex ;
            _index = 1000 ;
    }
        
}

// 遇到字符串时候触发，该方法是解析元素文本内容主要场所
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    // 剔除回车和空格
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];

    if (_index == 101) {
        assessmentSection.rubricBlock = [assessmentSection.rubricBlock stringByAppendingString:string];
    }
}

// 遇到结束标签时触发，在该方法中主要是清理刚刚解析完成的元素产生的影响，以便于不影响接下来的解析
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
}

//// 遇到文档结束时触发
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    NSLog(@"解析真的完成啦完成啦完成啦完成啦") ;
    if (_completeBlock) {
        _completeBlock() ;
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //    if([key isEqualToString:@"id"]) {
    //        self.productID = value;
    //    }
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([value isKindOfClass:[NSNull class]]) {
        
        //        NSLog(@"%@------%@",key,value);
        [super setValue:@"" forKey:key] ;
        return;
    }
    
    [super setValue:value forKey:key];
}


@end
