//
//  ViewController.m
//  Table2
//
//  Created by 张雨楠 on 15/10/14.
//  Copyright (c) 2015年 张雨楠. All rights reserved.
//

#import "ViewController.h"
#import "EditViewController.h"
#import "DetailViewController.h"
#import "Note.h"
#import "NoteDAO.h"
#import "NoteBL.h"

@interface ViewController ()

//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, retain) NSMutableArray *listcontents;

@property (nonatomic, strong) NoteBL *bl;
- (IBAction)add:(id)sender;


@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;//添加编辑按钮

    _tableView.frame = CGRectMake(0, 0, 320, 568);//设置表视图的大小为模拟器屏幕大小，否则超出屏幕范围，扩展视图将不显示
    
    self.bl = [[NoteBL alloc] init];
    self.listcontents = [self.bl findAll];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadView:)
                                                 name:@"reloadViewNotification"
                                               object:nil];

//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *plistPath = [bundle pathForResource:@"NotesList" ofType:@"plist"];
//    self.listcontents = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    //数据保存
    /*listcontents是程序的数据源，在开发的时候，从NotesList.plist中读出数据赋值给它。在程序结束之前，所有的更改都需要被保存到NotesList.plist中去。要做到这点，可以让BookTableViewController在“感知”到程序快要结束时保存数据*/
//    //为对象添加一个“观察者”
//    UIApplication *app = [UIApplication sharedApplication];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) name:UIApplicationWillTerminateNotification object:app];
//    
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)add:(id)sender {
    
}



- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.contentView.frame=CGRectMake(0, 0, self.contentView.frame.size.width,1000);
    self.scrollView.contentSize=CGSizeMake(self.view.frame.size.width, 1000);
}



//指定单元格的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listcontents count];
}

//单元格对象
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier ];
//       
//    }
//    
//    cell.textLabel.text = [[self.listcontents objectAtIndex:indexPath.row] valueForKey:@"content"];
//    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
//    cell.detailTextLabel.text = [[self.listcontents objectAtIndex:indexPath.row] valueForKey:@"date"];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;  //单元格右边的显示为一个箭头，用以提示用户点击后展开
//    
//    
//    return cell;
//}
//
//选中某行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//  DetailViewController *detailViewController = [[DetailViewController alloc] init];
    DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Detail"];
    detailViewController.detailDictionary= [self.listcontents objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //初始化重用Cell
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier ];
    
        }
    
    //配置重用Cell数据
    Note  *note = self.listcontents[indexPath.row];
    cell.textLabel.text = note.content;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
//    cell.detailTextLabel.text = [[self.listcontents objectAtIndex:indexPath.row] valueForKey:@"date"];
    cell.detailTextLabel.text = [note.date description];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;  //单元格右边的显示为一个箭头，用以提示用户点击后展开
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.listcontents count]) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.listcontents count]) {
        return NO;
    } else {
        return YES;
    }
}

#pragma mark -- UIViewController生命周期方法，用于响应视图编辑状态变化
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    [self.tableView setEditing:editing animated:YES];
//    if (editing) {
//        self.txtField.hidden = NO;
//    } else {
//        self.txtField.hidden = YES;
//    }
}




- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Note *note = [self.listcontents objectAtIndex:[indexPath row]];
        NoteBL *bl = [[NoteBL alloc] init];
        self.listcontents = [bl remove: note];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

#pragma mark - 处理通知
-(void)reloadView:(NSNotification*)notification {
    NSMutableArray *resList = [notification object];
    self.listcontents  = resList;
    [self.tableView reloadData];
}




//删除
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        NSString *filePath = [[self.listcontents objectAtIndex:indexPath.row] valueForKey:@"content"];
//        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
//        {
//            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
//        }
//        
//        [self.listcontents removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
////        NSString *path = [[NSBundle mainBundle] pathForResource:@"NotesList" ofType:@"plist"];//找到文件路径
//        NSString *path = [self applicationDocumentsDirectoryFile];
//        [self.listcontents writeToFile:path atomically:YES];//写入
//    }
//
//}


@end
