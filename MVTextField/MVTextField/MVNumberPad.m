//
//  MVNumberPad.m
//  MVTextField
//
//  Created by admin on 13/02/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "MVNumberPad.h"
#import "MVTextField.h"


#define BACKGROUND_COLOR [UIColor colorWithRed:(float)138/255 green:(float)43/255 blue:(float)226/255 alpha:1.0]
#define BUTTON_BACKGROUND_COLOR [UIColor whiteColor]
#define TITTLE_COLOR [UIColor blackColor]
#define FONT_NAME @"Helvetica"
#define BORDER_COLOR [UIColor clearColor]
#define BORDER_WIDTH 1.0f
#define CORNER_RADIUS 3.0f



@interface MVNumberPad()
@property(nonatomic,strong)MVTextField *textField;
@property(nonatomic,weak)IBOutlet UIView *keyBoardBaseView;
@property(nonatomic)BOOL isLongPress;
-(IBAction)numberPressed:(id)sender;
-(IBAction)deletePressed:(id)sender;
-(IBAction)returnPressed:(id)sender;
- (void)longPressHandler:(UILongPressGestureRecognizer *)gestureRecognizer;
-(void)initializeValues;
-(void)applyTheme:(id)sender;
@end


@implementation MVNumberPad

+(id)numberPad{
    
    NSString *numberPad=iPad?@"MVNumber_iPad":@"MVNumber_iPhone";
    return [[NSBundle mainBundle] loadNibNamed:numberPad owner:self options:nil][0];
}

#pragma mark -init method
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
      [self initializeValues];

    }
    return self;
}

#pragma mark -init coder method
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor=BACKGROUND_COLOR;
 
     }
    return self;
}

#pragma mark -Draw method
-(void)layoutSubviews{
    
    _keyBoardBaseView.center=self.center;
}
-(void)removeFromSuperview{
    _textField=nil;
    [super removeFromSuperview];
}

#pragma mark - Initialize values
-(void)initializeValues{
 
    for (id subview in [self.keyBoardBaseView subviews]) {
        if ([subview isKindOfClass:[UIButton class]]){
            [self applyTheme:subview];
        }
    }
    _isLongPress=NO;
    
    UIButton *deleteButton=(UIButton*)[self viewWithTag:13];
    UILongPressGestureRecognizer *longpressGesture =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(longPressHandler:)];
    longpressGesture.minimumPressDuration = .1;
    longpressGesture.cancelsTouchesInView=NO;
    [deleteButton addGestureRecognizer:longpressGesture];
}

#pragma mark -Public method
-(void)setMVTextField:(MVTextField*)field{
    _textField=field;
}

#pragma mark NIB method
-(void)awakeFromNib{
    
    [super awakeFromNib];
    [self initializeValues];
}

#pragma mark -Private method
-(void)applyTheme:(id)sender{
    
    UIButton *button=(UIButton*)sender;
    [button.layer setBorderWidth:BORDER_WIDTH];
    [button.layer setCornerRadius:CORNER_RADIUS];
    [button.layer setBorderColor:BORDER_COLOR.CGColor];
    button.backgroundColor=BUTTON_BACKGROUND_COLOR;
    [button setTitleColor:TITTLE_COLOR forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont fontWithName:FONT_NAME size:iPad?24:14];
        
    
    
}




#pragma mark - Button events
- (void)longPressHandler:(UILongPressGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer.state==UIGestureRecognizerStateBegan) {
        _isLongPress=YES;
        [self deleteValueWithLongPress:_textField];
        
    }else if (gestureRecognizer.state==UIGestureRecognizerStateChanged){
       //You can do the needful actions
    }else if (gestureRecognizer.state==UIGestureRecognizerStateEnded){
      
        _isLongPress=NO;            
    }
}
-(IBAction)numberPressed:(id)sender{
 
    NSString *string=Nil;
    if ([sender tag]==10) {
        string=@".";
    }else{
        string=[sender currentTitle];
    }
    
    BOOL success=[_textField textField:_textField shouldChangeCharactersInRange:NSMakeRange([_textField.text length],0) replacementString:string];
    if (success) {
        _textField.text=[_textField.text stringByAppendingString:string];
    }
   
    
}
-(IBAction)deletePressed:(id)sender{
    BOOL success=[_textField textField:_textField shouldChangeCharactersInRange:NSMakeRange([_textField.text length],0) replacementString:@""];
    if (success) {
        if([_textField.text length]!=0){
            _textField.text=[_textField.text substringToIndex:[_textField.text length]-1];
        }
    }
}
-(void)deleteValueWithLongPress:(MVTextField*)gftextField{
    if (_isLongPress) {
        
            if([_textField.text length]!=0){
                _textField.text=[_textField.text substringToIndex:[_textField.text length]-1];
                
                [self performSelector:@selector(deleteValueWithLongPress:) withObject:_textField afterDelay:.1];
            }else{
                _isLongPress=NO;
            }
        
        
    }
}
-(IBAction)returnPressed:(id)sender{
   
    [_textField textFieldShouldReturn:_textField];
    
}


-(void)dealloc{
   // [self deallocDescription];
}
@end
