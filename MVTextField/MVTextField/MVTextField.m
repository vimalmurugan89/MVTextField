//
//  MVTextField.m
//  MVTextfield
//
//  Created by admin on 11/03/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "MVTextField.h"
#import "NSString+String.h"
#import "MVNumberPad.h"

#define Digits @"0123456789"
#define Decimal @"0123456789."
#define Period  @"."
#define Characters @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define MARGIN 10

@interface MVTextField()
@property (nonatomic,copy) TextFieldDidBeginEditBlock textFiledBeginEditBlock;
@property (nonatomic,copy) TextFieldDidEndEditBlock textFiledEndEditBlock;
@property (nonatomic,copy) TextDidChangeBlock textDidChangeBlock;

@end



@implementation MVTextField
@synthesize fieldType;
@synthesize allowedTextLength;
@synthesize allowedDecimalLength;


#pragma mark - Initialize through code
-(id)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        [self initializeValue];
        
    }
    return self;
    
}

#pragma mark -Initialize via XIB
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        [self initializeValue];
    }
    return self;
}

-(void)removeFromSuperview{
    if(_numberKeyPad!=nil){
    [_numberKeyPad removeFromSuperview];
   _numberKeyPad=nil;
    }
    
    _textFiledBeginEditBlock=nil;
   _textFiledEndEditBlock=nil;
    _textDidChangeBlock=nil;
    [super removeFromSuperview];
}



//Adjust placeholder margin
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect rect=bounds;
    rect.size.width+=_marginValue;
    return CGRectInset(rect, _marginValue,0);
}
//Adjust text margin
-(CGRect)textRectForBounds:(CGRect)bounds{
   
    CGRect rect=bounds;
    rect.size.width+=_marginValue;
    return CGRectInset(rect, _marginValue,0);
}
//Adjust text margin
-(CGRect)editingRectForBounds:(CGRect)bounds{
   
    CGRect rect=bounds;
    rect.size.width+=_marginValue;
    return CGRectInset(rect, _marginValue,0);
}



#pragma mark -Private Methods
-(void)initializeValue{
    
    _marginValue=MARGIN;
    //Assigned self as a delegate
    self.delegate=self;
    //For avoid crashing
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    
    self.fieldType=MVTextFieldDefautType;
    self.allowedTextLength=0;
    self.allowedDecimalLength=0;
    self.textFieldValidationType=MVValidationTypeNone;
    self.validationString=nil;
}
-(BOOL)isNULLOrEmpty{
    if (!self.text||[self.text isKindOfClass:[NSNull class]]||[self.text length]==0) {
        return YES;
    }
    return NO;
}

-(BOOL)isMailId{
    
    if (!self.text) {
        return NO;
    }
    
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink
                                                               error:nil];
    NSUInteger numberOfMatches = [detector numberOfMatchesInString:self.text
                                                           options:0
                                                             range:NSMakeRange(0, [self.text length])];
    if (numberOfMatches>0) {
        return YES;
    }
    return NO;
    
}

-(NSString*)validateTheTextField{
    if (self.textFieldValidationType==MVValidationTypeNone) {
        return Nil;
    }else if (self.textFieldValidationType==MVMailValidationType){
        if ([self isMailId]) {
            return nil;
        }
        return _validationString;
        
    }else if (self.textFieldValidationType==MVEmptyValidationType){
        if ([self isNULLOrEmpty]) {
            return _validationString;
        }
        return nil;
    }else{
        return nil;
    }
}
-(BOOL)validateMoneyValue:(NSString*)textFieldValue enteredString:(NSString*)newString {
    
    if(![newString containsString:Decimal]){
        return NO;
    }
    
    if([newString isEqualToString:Period]) {
        if([textFieldValue containsDotString]||![textFieldValue isAllowedLength:self.allowedTextLength]){
            return NO;
        }
        
        return [textFieldValue isCorrectDecimalFormat:self.allowedDecimalLength];
        
    } else {
        
        if([textFieldValue containsDotString]){
            
            return [textFieldValue isCorrectDecimalFormat:self.allowedDecimalLength];
        }
        return [textFieldValue isAllowedLength:self.allowedTextLength];
        
    }
    return YES;
}

#pragma mark - Public methods
//Set Custom keyboard type
-(void)setTextFieldKeyBoardType:(MVKeyBoardType)textFieldKeyBoardType{
    
    if(_numberKeyPad==nil&&fieldType==MVTextFeildNumberType){
        _numberKeyPad=[MVNumberPad numberPad];
        [_numberKeyPad setMVTextField:self];
        self.inputView=_numberKeyPad;
    }
    
}


-(void)showWithBeginEditingValue:(TextFieldDidBeginEditBlock)beginEditBlock {
    self.textFiledBeginEditBlock=beginEditBlock;
}

-(void)showWithEndEditingValue:(TextFieldDidEndEditBlock)endEditBlock {
    self.textFiledEndEditBlock=endEditBlock;
}

-(void)showTextDidchange:(TextDidChangeBlock)didChangeBlock{
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.textDidChangeBlock=didChangeBlock;
}

#pragma mark -TextField delegate methods
-(void)textFieldDidChange:(UITextField*)textField{
    if(self.textDidChangeBlock!=nil){
        self.textDidChangeBlock(textField);
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (_numberKeyPad!=nil) {
        [_numberKeyPad setMVTextField:self];
    }
    
    if(self.textFiledBeginEditBlock!=nil){
    self.textFiledBeginEditBlock(textField);
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.textFiledEndEditBlock!=nil){
    self.textFiledEndEditBlock(textField);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)stringValue {
    
  
    if([stringValue length]==0)
        return YES;
    
     BOOL success=YES;
   
    switch (self.fieldType) {
        case MVTextFeildNumberType:
            success=[stringValue containsString:Digits]&&[textField.text isAllowedLength:self.allowedTextLength];
            break;
        case MVTextFieldDefautType:
             success=[textField.text isAllowedLength:self.allowedTextLength];
            break;
        case MVTextFieldMoneyFormatType:
            success=[self validateMoneyValue:textField.text enteredString:stringValue];
            break;
        case MVTextFieldStringType:
            success=[stringValue containsString:Characters]&&[textField.text isAllowedLength:self.allowedTextLength];
            break;
        case MVTextFieldStringWithNumberType:
            success=([stringValue containsString:Characters]||[stringValue containsString:Digits])&&[textField.text isAllowedLength:self.allowedTextLength];
            break;
        
    }

    
    return success;
   
}


- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)dealloc{
    
}


@end
