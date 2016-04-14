//
//  EditViewController.m
//  Table2
//
//  Created by 张雨楠 on 15/11/4.
//  Copyright (c) 2015年 张雨楠. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController () <UITextViewDelegate>
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

//@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation EditViewController

@synthesize textView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-UITextView Delegate Method
- (BOOL)textViewShouldReturn:(UITextView *)_textView{
    [_textView resignFirstResponder];//退出键盘
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancel:(id)sender {
   /* [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"点击Cancel按钮,关闭模态视图");
    }];*/

}

- (IBAction)done:(id)sender {
    [self.view endEditing:YES];
   
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.contentView.frame=CGRectMake(0, 0, self.contentView.frame.size.width,1000);
    self.scrollView.contentSize=CGSizeMake(self.view.frame.size.width, 1000);
}


    
@end
