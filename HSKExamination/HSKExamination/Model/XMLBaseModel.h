//
//  XMLBaseModel.h
//  HSKExamination
//
//  Created by printer on 9/7/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLBaseModel : NSObject<NSXMLParserDelegate>

- (void)parseInPath:(NSString *)path ;

@end
