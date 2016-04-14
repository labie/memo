//
//  DetailViewController.m
//  Table2
//
//  Created by 张雨楠 on 15/12/4.
//  Copyright (c) 2015年 张雨楠. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITextViewDelegate>
//@property (weak, nonatomic) IBOutlet UITextView *textView;

//@property (weak, nonatomic) IBOutlet UITextView *textView;
//@property (weak, nonatomic) IBOutlet UITextView *textView;
//@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end


@implementation DetailViewController

@synthesize textView;
@synthesize detailDictionary;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationItem.title = @"详细信息";
    self.navigationItem.title= [detailDictionary valueForKey:@"date"];
    self.textView.text = [detailDictionary valueForKey:@"content"];
}

//- (void)viewDidUnload
//{
//    
//    [self setTextView:nil];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark-UITextView Delegate Method
//- (BOOL)textViewShouldReturn:(UITextView *)textView{
//    [textView resignFirstResponder];
//    return YES;
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.contentView.frame=CGRectMake(0, 0, self.contentView.frame.size.width,1000);
    self.scrollView.contentSize=CGSizeMake(self.view.frame.size.width, 1000);
}


@end
