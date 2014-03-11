MVTextField
===========

   <h1>It has the following features,</h1>
  
   <h2>MVTextFieldType</h2>
   <div><b>MVTextFieldMoneyFormatType</b> - Which is used to accept money format entry(like 2.5,234.50).
   <div><b>MVTextFeildNumberType</b> - Which is accept only number value.
   <div><b>MVTextFieldStringType</b> - Which is accept only string value.
   <div><b>MVTextFieldStringWithNumberType</b> - Which is accept string with number. It won't accept special character.
   <div><b>MVTextFieldDefautType</b> - Which is accept all values like default text field.</div>
         
  <h2>MVTextfieldValidationType</h2>
             
  <div><b>MVMailValidationType</b> - Validate Entered text is email or not
  <div><b>MVEmptyValidationType</b> - Validate textfield is empty or empty spaces.
  <div><b>MVValidationTypeNone</b> - No validation.
  
  <h2>MVKeyBoardType</h2>
  <div>This is custom keyboard for your specific field</div>
  <div><b>MVNumberKeyBoardType</b> - It shows custom keyboard which is created by me.
  
  <h2>MVTextField text margin adjust</h2>
  <div>1. Use <b>marginValue</b> property to adjust the text from left side.
  
  <h2>MVTextField Restrict number of character entry</h2>
  <div>1. Use <b>allowedTextLength</b> to restrict the number of character entry into the textfield.
  <div>2. Use <b>allowedDecimalLength</b> to restrict the character entry after dot entered.
  
  <h2>MVTextField block methods which is equalent to textfield delegate methods</h2>
  <div><b>TextFieldDidBeginEditBlock</b> - Which is called while textfield edit begun.
  <div><b>TextFieldDidEndEditBlock</b> - Which is called while textfield end editing.
  <div><b>TextDidChangeBlock</b> - Which is called while textfield charcater change.
  
  <h2>Whom use this?</h2>
  <div>1. Who's need money format entry in text field (like 124.98)?
  <div>2. Who's need to restrict the number of character entry?
  <div>3. Whom wants to integrate custom keyboard into the text field?
  <div>4. Who's need email validation on textfield?
  
  <h2>Future Enhancement</h2>
  <div>1. Integrate showing visual validation on textfield leftview for email,number and etc...
  <div>2. Custom keyboard customization like changing background color and title color and etc..
  <div>3. Add new type of keyboard.
  <div>4. Add icon on left and right view with simple method.
  
  <h2>Implementation</h2>
  
     MVTextField  *_defaultTextField=[[MVTextField alloc]init];
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
