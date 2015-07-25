//
//  SplashViewController.m
//  
//
//  Created by Ankit Jain on 27/06/15.
//
//

#import "SplashViewController.h"
#import "VMButtonCircleFun.h"
#include "InitialViewController.h"

#define rgb(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Hide navigation bar
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self performSelectorOnMainThread:@selector(showInitialView) withObject:nil waitUntilDone:NO];
    //[self authenticatePopUp];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)authenticatePopUp {
    LAContext *context = [[LAContext alloc] init];
    
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"Are you the device owner?"
                          reply:^(BOOL success, NSError *error) {
                              
                              if (error) {
                                  // Error
                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                  message:@"There was a problem verifying your identity."
                                                                                 delegate:nil
                                                                        cancelButtonTitle:@"Ok"
                                                                        otherButtonTitles:nil];
                                  [alert show];
                                  return;
                              }
                              
                              if (success) {
                                  [self performSelectorOnMainThread:@selector(showSplashMessage) withObject:nil waitUntilDone:NO];
                              } else {
                                  // If someone else access the device show message
                              }
                              
                          }];
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Your device cannot authenticate using TouchID."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
}

-(void)showSplashMessage {
    [self performSelector:@selector(addCircleViewRow1) withObject:nil afterDelay:0.5];
    [self performSelector:@selector(addCircleViewRow2) withObject:nil afterDelay:3.0];
    [self performSelector:@selector(addCircleViewRow3) withObject:nil afterDelay:6.0];
    [self performSelector:@selector(showInitialView) withObject:nil afterDelay:10.0];
}

-(void)showInitialView {
    InitialViewController *initialVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InitialViewController"];
    [self.navigationController pushViewController:initialVC animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addCircleViewRow1
{
    CGFloat offset = 100;
    
    VMButtonCircleFun *circleView1 = [[VMButtonCircleFun alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [circleView1 addCircleLayerWithType:VMMakeLocationTop];
    circleView1.strokeColor = rgb(243, 106, 106);
    circleView1.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2 - 120, CGRectGetHeight(self.view.bounds)/2 - offset);
    [circleView1 setIconButton:@"A" withType:VMMakeLocationTop withColor:rgb(127, 140, 141)];
    [circleView1 setLineWidthValue:1];
    [self.view addSubview:circleView1];
    [circleView1 buildButton];
    
    VMButtonCircleFun *circleView2 = [[VMButtonCircleFun alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [circleView2 addCircleLayerWithType:VMMakeLocationBottom];
    circleView2.strokeColor = rgb(255, 195, 45);
    circleView2.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2 - 60, CGRectGetHeight(self.view.bounds)/2 - offset);
    [circleView2 setIconButton:@"N" withType:VMMakeLocationBottom withColor:rgb(127, 140, 141)];
    [circleView2 setLineWidthValue:1];
    [self.view addSubview:circleView2];
    [circleView2 buildButton];
    
    VMButtonCircleFun *circleView3 = [[VMButtonCircleFun alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [circleView3 addCircleLayerWithType:VMMakeLocationTop];
    circleView3.strokeColor = rgb(74, 220, 239);
    circleView3.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2, CGRectGetHeight(self.view.bounds)/2 - offset);
    [circleView3 setIconButton:@"K" withType:VMMakeLocationTop withColor:rgb(127, 140, 141)];
    [circleView3 setLineWidthValue:1];
    [self.view addSubview:circleView3];
    [circleView3 buildButton];
    
    VMButtonCircleFun *circleView5 = [[VMButtonCircleFun alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [circleView5 addCircleLayerWithType:VMMakeLocationBottom];
    circleView5.strokeColor = rgb(190, 50, 106);
    circleView5.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2 + 60, CGRectGetHeight(self.view.bounds)/2 - offset);
    [circleView5 setIconButton:@"I" withType:VMMakeLocationTop withColor:rgb(127, 140, 141)];
    [circleView5 setLineWidthValue:1];
    [self.view addSubview:circleView5];
    [circleView5 buildButton];
    
    VMButtonCircleFun *circleView4 = [[VMButtonCircleFun alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [circleView4 addCircleLayerWithType:VMMakeLocationTop];
    circleView4.strokeColor = rgb(74, 220, 139);
    circleView4.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2 + 120, CGRectGetHeight(self.view.bounds)/2 - offset);
    [circleView4 setIconButton:@"T" withType:VMMakeLocationTop withColor:rgb(127, 140, 141)];
    [circleView4 setLineWidthValue:1];
    [self.view addSubview:circleView4];
    [circleView4 buildButton];
}

- (void)addCircleViewRow2
{
    VMButtonCircleFun *circleView1 = [[VMButtonCircleFun alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [circleView1 addCircleLayerWithType:VMMakeLocationTop];
    circleView1.strokeColor = rgb(243, 106, 106);
    circleView1.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2 - 90, CGRectGetHeight(self.view.bounds)/2);
    [circleView1 setIconButton:@"L" withType:VMMakeLocationTop withColor:rgb(127, 140, 141)];
    [circleView1 setLineWidthValue:1];
    [self.view addSubview:circleView1];
    [circleView1 buildButton];
    
    VMButtonCircleFun *circleView2 = [[VMButtonCircleFun alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [circleView2 addCircleLayerWithType:VMMakeLocationBottom];
    circleView2.strokeColor = rgb(255, 195, 45);
    circleView2.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2 - 30, CGRectGetHeight(self.view.bounds)/2);
    [circleView2 setIconButton:@"O" withType:VMMakeLocationBottom withColor:rgb(127, 140, 141)];
    [circleView2 setLineWidthValue:1];
    [self.view addSubview:circleView2];
    [circleView2 buildButton];
    
    VMButtonCircleFun *circleView3 = [[VMButtonCircleFun alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [circleView3 addCircleLayerWithType:VMMakeLocationTop];
    circleView3.strokeColor = rgb(74, 220, 239);
    circleView3.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2 + 30, CGRectGetHeight(self.view.bounds)/2);
    [circleView3 setIconButton:@"V" withType:VMMakeLocationTop withColor:rgb(127, 140, 141)];
    [circleView3 setLineWidthValue:1];
    [self.view addSubview:circleView3];
    [circleView3 buildButton];
    
    VMButtonCircleFun *circleView5 = [[VMButtonCircleFun alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [circleView5 addCircleLayerWithType:VMMakeLocationBottom];
    circleView5.strokeColor = rgb(0, 170, 172);
    circleView5.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2 + 90, CGRectGetHeight(self.view.bounds)/2);
    [circleView5 setIconButton:@"E" withType:VMMakeLocationTop withColor:rgb(127, 140, 141)];
    [circleView5 setLineWidthValue:1];
    [self.view addSubview:circleView5];
    [circleView5 buildButton];
}

- (void)addCircleViewRow3
{
    CGFloat offset = 100;
    VMButtonCircleFun *circleView1 = [[VMButtonCircleFun alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [circleView1 addCircleLayerWithType:VMMakeLocationBottom];
    circleView1.strokeColor = rgb(243, 106, 106);
    circleView1.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2 - 120, CGRectGetHeight(self.view.bounds)/2 + offset);
    [circleView1 setIconButton:@"R" withType:VMMakeLocationTop withColor:rgb(127, 140, 141)];
    [circleView1 setLineWidthValue:1];
    [self.view addSubview:circleView1];
    [circleView1 buildButton];
    
    VMButtonCircleFun *circleView2 = [[VMButtonCircleFun alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [circleView2 addCircleLayerWithType:VMMakeLocationTop];
    circleView2.strokeColor = rgb(255, 195, 45);
    circleView2.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2 - 60, CGRectGetHeight(self.view.bounds)/2 + offset);
    [circleView2 setIconButton:@"U" withType:VMMakeLocationBottom withColor:rgb(127, 140, 141)];
    [circleView2 setLineWidthValue:1];
    [self.view addSubview:circleView2];
    [circleView2 buildButton];
    
    VMButtonCircleFun *circleView3 = [[VMButtonCircleFun alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [circleView3 addCircleLayerWithType:VMMakeLocationBottom];
    circleView3.strokeColor = rgb(74, 220, 239);
    circleView3.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2, CGRectGetHeight(self.view.bounds)/2 + offset);
    [circleView3 setIconButton:@"C" withType:VMMakeLocationTop withColor:rgb(127, 140, 141)];
    [circleView3 setLineWidthValue:1];
    [self.view addSubview:circleView3];
    [circleView3 buildButton];
    
    VMButtonCircleFun *circleView5 = [[VMButtonCircleFun alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [circleView5 addCircleLayerWithType:VMMakeLocationTop];
    circleView5.strokeColor = rgb(0, 170, 172);
    circleView5.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2 + 60, CGRectGetHeight(self.view.bounds)/2 + offset);
    [circleView5 setIconButton:@"H" withType:VMMakeLocationTop withColor:rgb(127, 140, 141)];
    [circleView5 setLineWidthValue:1];
    [self.view addSubview:circleView5];
    [circleView5 buildButton];
    
    VMButtonCircleFun *circleView4 = [[VMButtonCircleFun alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [circleView4 addCircleLayerWithType:VMMakeLocationBottom];
    circleView4.strokeColor = rgb(74, 220, 139);
    circleView4.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2 + 120, CGRectGetHeight(self.view.bounds)/2 + offset);
    [circleView4 setIconButton:@"U" withType:VMMakeLocationTop withColor:rgb(127, 140, 141)];
    [circleView4 setLineWidthValue:1];
    [self.view addSubview:circleView4];
    [circleView4 buildButton];
}

@end
