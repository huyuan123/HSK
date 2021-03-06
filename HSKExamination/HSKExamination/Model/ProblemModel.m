//
//  ProblemModel.m
//  HSKExamination
//
//  Created by printer on 9/27/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "ProblemModel.h"
NSString            *           _currentElement ;
SimpleChoice        *           _model ;
int                             _index ;

@implementation ProblemModel
- (void)parseInPath:(NSString *)path
{
    NSString * s = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:path] encoding:NSUTF8StringEncoding error:nil];
    NSMutableString * muS = nil ;
    
    
    if (s) {
        muS = [NSMutableString stringWithString:s];
    }
    
    [muS replaceOccurrencesOfString:@"&lt;" withString:@"<" options:NSCaseInsensitiveSearch range:NSMakeRange(0, s.length)];
    
    [muS replaceOccurrencesOfString:@"&gt;" withString:@">" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];
    
    NSLog(@"%@",muS) ;
    self.parse = [[NSXMLParser alloc] initWithData:[muS dataUsingEncoding:NSUTF8StringEncoding]];
    self.parse.delegate = self ;
    
    [self.parse parse];
    
}


+ (id)createChildWithLevel:(int)level
{
    
    NSString * classString =  [NSStringFromClass(self.class) stringByAppendingFormat:@"%d",level];
    
    return [[NSClassFromString(classString) alloc] init] ;
}


@end
