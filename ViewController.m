//
//  ViewController.m
//  Final_Project
//
//  Created by Anantha Shankar Arun Kumar on 4/18/15.
//  Copyright (c) 2015 Anantha Shankar Arun Kumar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage * myImage = [UIImage imageNamed:@"Wall_Image.jpg"];
    
    self.imageview.image = myImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
