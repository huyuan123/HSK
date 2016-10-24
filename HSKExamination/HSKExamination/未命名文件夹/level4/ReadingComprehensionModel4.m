//
//  ReadingComprehensionModel4.m
//  HSKExamination
//
//  Created by hiddy on 16/10/8.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ReadingComprehensionModel4.h"

@implementation ReadingComprehensionModel4
- (void)parseInPath:(NSString *)path
{
    NSString * s = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:path] encoding:NSUTF8StringEncoding error:nil];
    NSMutableString * muS = nil ;
    
    
    if (s) {
        muS = [NSMutableString stringWithString:s];
    }
    
    [muS replaceOccurrencesOfString:@"&lt;" withString:@"<" options:NSCaseInsensitiveSearch range:NSMakeRange(0, s.length)];
    
    [muS replaceOccurrencesOfString:@"&gt;" withString:@">" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];
    
    
//    [muS  replaceOccurrencesOfString:@"nbsp;" withString:@"+" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];
//    
//    
//    [muS replaceOccurrencesOfString:@"&amp;" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];
    
    [muS replaceOccurrencesOfString:@"（）" withString:@"*" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];
    
    [muS replaceOccurrencesOfString:@")" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];
    
    [muS replaceOccurrencesOfString:@"(" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];
    
    [muS replaceOccurrencesOfString:@"ldquo;" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];
    [muS replaceOccurrencesOfString:@"(" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];

    [muS replaceOccurrencesOfString:@"rdquo;" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];

    
    
    NSLog(@"%@",muS) ;
    
    //    [muS replaceOccurrencesOfString:@";" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];
    
    self.parse = [[NSXMLParser alloc] initWithData:[muS dataUsingEncoding:NSUTF8StringEncoding]];
    self.parse.delegate = self ;
    
    [self.parse parse];
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&amp" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"nbsp;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&" withString:@""];

    [super parser:parser foundCharacters:string];
}



@end
