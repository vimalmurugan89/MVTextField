//
//  ViewController.m
//  MVTextField
//
//  Created by admin on 11/03/14.
//  Copyright (c) 2014 admin. All rights reserved.
//


#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //Set textfield type
    _defaultTextField.fieldType=MVTextFeildNumberType;
    
    //Set maximum length of text
    _defaultTextField.allowedTextLength=4;
    
    //Set maximum length after entering dot
    _defaultTextField.allowedDecimalLength=3;
    
    //Set margin value for text as well as placeholder
    _defaultTextField.marginValue=2;
    
    //Set validation type
    _defaultTextField.textFieldValidationType=MVMailValidationType;
    
    //Set return string value if validation got failed
    _defaultTextField.validationString=@"Mail id is incorrect";
    
    //Set custom key board type if fieldtype is not a numberpad means it won't work
    _defaultTextField.textFieldKeyBoardType=MVNumberKeyBoardType;
    
    //Set Block method for textfield didbegin editing delegate
    [_defaultTextField showWithBeginEditingValue:^(UITextField *textField) {
        NSLog(@"did begin editing");
    }];
    
    //Set Block method for textfield endediting delegate
    [_defaultTextField showWithEndEditingValue:^(UITextField *textField) {
          NSLog(@"edit end %@",textField.text);
        
        //check validation when textfield end editing value called by calling below method
        // If nil means validation success
        // If return the validationstring means validation got failed.
          NSLog(@"valid==%@",[_defaultTextField validateTheTextField]);
    }];
    
    //Set Block method for textfield textdidchange delegate
    [_defaultTextField showTextDidchange:^(UITextField *textField) {
        NSLog(@"text change %@",textField.text);
      
    }];
    
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
