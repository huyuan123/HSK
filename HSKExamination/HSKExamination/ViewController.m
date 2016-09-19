//
//  ViewController.m
//  HSKExamination
//
//  Created by printer on 9/7/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "ViewController.h"
#import "SSZipArchive.h"
#import "TestPaperPackageInfoModel.h"
#import "SHXMLParser.h"
#import "ASTModel.h"

#import "AssessmentSection.h"
#import "assessmentItemRef.h"
#import "testPart.h"
//#import "AssessmentSection.h"

@interface ViewController ()
{
    TestPaperPackageInfoModel * _model ;
    SHXMLParser                 * parser ;
    ASTModel * model ;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    model = [[ASTModel alloc] init];
    [model parseInPath:[[NSBundle mainBundle] pathForResource:@"AST_fe901f32-9968-df11-910b-002219a717d6" ofType:@"xml"]];
    
//    NSLog(@"%@",model.testPartArray) ;
    
    for (testPart * test in model.testPartArray) {
        NSLog(@"%@",test) ;
        for (AssessmentSection * sec in test.assessmentSectionArray) {
            NSLog(@"%@",sec) ;

            for (assessmentItemRef * ref in sec.assessmentItemRefArray) {
                NSLog(@"%@",ref) ;
            }
        }
    }
    
//    NSString * s= ;
//    NSString *zipPath = [[NSBundle mainBundle] pathForResource:@"HSK二级" ofType:@"zip"];
//    NSString *destinationPath = [examination pathWithType:Documents] ;
//    
//    [SSZipArchive unzipFileAtPath:zipPath toDestination:destinationPath];
//    
//    _model = [[TestPaperPackageInfoModel alloc] init];
//    
//    [_model parseInPath:[[examination stringByAppendingPathComponent:TestPaperPackageInfo] pathWithType:Documents]];
//    
//    NSLog(@"%@",destinationPath);
    
//   NSData * data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AST_fe901f32-9968-df11-910b-002219a717d6" ofType:@"xml"]];
//    parser = [[SHXMLParser alloc] init];
//    NSDictionary * dic = [parser parseData:data];
//    
//    NSLog(@"%@",dic);
    
//    NSString *trimmedPath = [@"ooooooooooooo[]" stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"[]"]];
//
//    NSLog(@"%@",trimmedPath) ;
//    
//    [];
    // 压缩
//    NSString *zippedPath = @"压缩文件路径";
//    NSArray *inputPaths = [NSArray arrayWithObjects:
//                           [[NSBundle mainBundle] pathForResource:@"photo1" ofType:@"jpg"],
//                           [[NSBundle mainBundle] pathForResource:@"photo2" ofType:@"jpg"]
//                           nil nil];
//    [SSZipArchive createZipFileAtPath:zippedPath withFilesAtPaths:inputPaths];
   
//    NSLog(@"hhhhhhh%@",s) ;
    
    
    UIView  * view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor redColor];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
