//
//  ViewController.h
//  Fraction_Calculator
//
//  Created by Oh Sangho on 2018. 6. 18..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fraction_CalculatorViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *display;

- (void)processDigit:(int)digit;
- (void)processOp:(char)theOp;
- (void)storeFracPart;

// 숫자 키
- (IBAction)clickDigit: (UIButton *) sender;

// 산술 연산 키
- (IBAction)clickPlus;
- (IBAction)clickMinus;
- (IBAction)clickMultiply;
- (IBAction)clickDivide;

// 기타 키
- (IBAction)clickOver;
- (IBAction)clickEquals;
- (IBAction)clickClear;


@end

