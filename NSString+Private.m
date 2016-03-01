//
//  NSString+Private.m
//  collectionView
//
//  Created by 1234 on 15/12/7.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "NSString+Private.h"

@implementation NSString (Private)

-(NSString *)clearURL {
    
    NSMutableString *str = [[NSMutableString alloc] initWithString:self];
    [str replaceOccurrencesOfString:@"\\" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, str.length)];
    return str;
}
@end
