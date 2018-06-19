//
//  ViewController.m
//  iPhone_1
//
//  Created by Oh Sangho on 2018. 6. 18..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize display;

- (IBAction)click1
{
    display.text = @"1";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
