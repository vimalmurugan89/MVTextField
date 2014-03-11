//
//  MVTextField.h
//  MVTextField
//
//  Created by admin on 11/03/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVNumberPad.h"

/*
 block method for textfield didbegin method
 -textfield respective field
 */
typedef void (^TextFieldDidBeginEditBlock) (UITextField *textField);

/*
 block method for textfield didend method
 -textfield respective field
 */
typedef void (^TextFieldDidEndEditBlock) (UITextField *textField);

/*
 block method for textfield text change
 -textfield respective field
 */
typedef void (^TextDidChangeBlock) (UITextField *textField);

/* Decide types of textfield
 - MVTextFieldDecimal is decide textfield will accept valid decimal values
 - MVTextFeildNumber is decide textfield will only accept integer values
 - MVTextFieldString is decide textfield will accept string only
 - MV
 */
typedef enum {
    MVTextFieldMoneyFormatType=0,
    MVTextFeildNumberType,
    MVTextFieldStringType,
    MVTextFieldDefautType,
    MVTextFieldStringWithNumberType,
    
} MVTextFieldType;

/* MVValidationType
   -MVMailvalidationType validate mail
   -MVEmptyValidationType validate is empty or empty space
   -MVValidationType no validation
 */
typedef enum {
    MVMailValidationType,
    MVEmptyValidationType,
    MVValidationTypeNone,
}MVTextFieldValidationType;

/* MVKeyBoardType
   -MVNumberKeyBoardType custom key board with number only Refer MVNumberPad class
 */
typedef enum {
    MVNumberKeyBoardType
}MVKeyBoardType;

@class MVNumberPad;

@interface MVTextField : UITextField<UITextFieldDelegate>


//For margin agjustment
@property(nonatomic)CGFloat marginValue;

//For information throw
@property(nonatomic,strong)NSString *validationString;

//Set text field validation type
@property(nonatomic)MVTextFieldValidationType textFieldValidationType;

//Set text field keyboard type
@property(nonatomic)MVKeyBoardType textFieldKeyBoardType;

//Set integer value to restrict the field entry value
@property(nonatomic)int allowedTextLength;

//Set integer value to restrict the field entry after dot entry.
@property(nonatomic)int allowedDecimalLength;

//choose textfield type Default is MVTextFieldDefautType
@property(nonatomic,assign)MVTextFieldType fieldType;

//Choose custom keyboard type
@property(nonatomic,strong)MVNumberPad *numberKeyPad;


/* method for initializing textfield didbegin block method
 - beginEditBlock is type of blockmethod
 */
-(void)showWithBeginEditingValue:(TextFieldDidBeginEditBlock)beginEditBlock;

/* method for initializing textfield didend block method
 - endEditBlock is type of blockmethod
 */
-(void)showWithEndEditingValue:(TextFieldDidEndEditBlock)endEditBlock;

/* method for initializing textfield didend block method
 - endEditBlock is type of blockmethod
 */
-(void)showTextDidchange:(TextDidChangeBlock)didChangeBlock;

/* Initialize the textfield with default value
 */
-(void)initializeValue;

/* method for validating textfield
  */
-(NSString*)validateTheTextField;

@end
