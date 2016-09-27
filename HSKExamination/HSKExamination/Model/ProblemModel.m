//
//  ProblemModel.m
//  HSKExamination
//
//  Created by printer on 9/27/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "ProblemModel.h"

@implementation ProblemModel
- (void)parseInPath:(NSString *)path
{
    //    NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path]];
    NSString * s = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:path] encoding:NSUTF8StringEncoding error:nil];
    NSMutableString * muS = nil ;
    
    if (s) {
        muS = [NSMutableString stringWithString:s];
    }
    
    [muS replaceOccurrencesOfString:@"&lt;" withString:@"<" options:NSCaseInsensitiveSearch range:NSMakeRange(0, s.length)];
    
    [muS replaceOccurrencesOfString:@"&gt;" withString:@">" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muS.length)];
    
    self.parse = [[NSXMLParser alloc] initWithData:[muS dataUsingEncoding:NSUTF8StringEncoding]];
    self.parse.delegate = self ;
    
    [self.parse parse];
    
}
@end
