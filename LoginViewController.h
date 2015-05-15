//
//  LoginViewController.h
//  Final_Project
//
//  Created by Anantha Shankar Arun Kumar on 5/1/15.
//  Copyright (c) 2015 Anantha Shankar Arun Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface LoginViewController : UIViewController <ADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet ADBannerView *adBanner;

@end
