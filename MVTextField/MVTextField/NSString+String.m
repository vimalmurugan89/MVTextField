//
//  NSString+String.m
//  MVTextField
//
//  Created by admin on 11/03/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "NSString+String.h"



@implementation NSString (String)

-(BOOL)containsString:(NSString*)string{
    
    //Check given string is exist or not
    if ([string rangeOfString:self].location == NSNotFound){
        return NO;
    }
    
    return YES;
    
}

-(BOOL)isAllowedLength:(int)length{
    
    //Check allowed length in textfield
    if (length==0){
        return YES;
    } else if (self.length<length){
        return YES;
    }
    
    return NO;
}

-(BOOL)containsDotString{
    
    if ([self rangeOfString:@"."].location == NSNotFound){
        return NO;
    }
    return YES;
}

-(BOOL)isCorrectDecimalFormat:(int)decimalLength
{
    NSArray *stringArray=[self componentsSeparatedByString:@"."];
    NSString *stringValue=nil;
    
    if(decimalLength<=0)
        decimalLength=2;
        
    
    if ([stringArray count]==2)
        stringValue=[stringArray objectAtIndex:1];
    
    if (stringValue!=nil&&[stringValue length]>=decimalLength)
        return NO;
    
    return YES;
}


-(void)logWithDescription:(NSString*)description
{
    NSLog(@"%@=%@",description,self);
}

@end
