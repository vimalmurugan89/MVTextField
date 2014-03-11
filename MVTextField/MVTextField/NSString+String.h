//
//  NSString+String.h
//  MVTextField
//
//  Created by admin on 11/03/14.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (String)

/* Check stringContains string
     -string is passing 
 */
-(BOOL)containsString:(NSString*)string;

/*
  Restrict the allowed length of text to type
   - length is length text has to be type
 */
-(BOOL)isAllowedLength:(int)length;

/* Check the given string has . character
 */
-(BOOL)containsDotString;

/*
  Check the given string is correct in decimal format
    -decide number of decimal point value
 */
-(BOOL)isCorrectDecimalFormat:(int)decimalLength;

/*
 Print the log of string value
    - description is showing the description before the output
 */
-(void)logWithDescription:(NSString*)description;

@end
