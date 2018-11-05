//
//  ViewController.m
//  FileShare
//
//  Created by 帝青的Mac on 2018/11/5.
//  Copyright © 2018年 帝青的Mac. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_WIDTH     [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT    [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) returnModelBlock block;

@end

@implementation ViewController

- (instancetype)initWithBlock:(returnModelBlock)block
{
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self createUI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createUI
{
    self.navigationItem.title = @"文件共享";
    self.view.backgroundColor = [UIColor colorWithRed:238 green:238 blue:238 alpha:1];

    self.dataSource = [NSMutableArray array];
    [self.dataSource addObjectsFromArray:[[FileShareManage sharedInstance] getAllFile]];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];

    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView
{
    if (!_tableView) {

        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }

    FileShareModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.fileName;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FileShareModel *model = self.dataSource[indexPath.row];
    if (self.block) {
        self.block(model);
    }
}

#pragma mark - Click
- (void)rightItemClick
{
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:[[FileShareManage sharedInstance] getAllFile]];
    [self.tableView reloadData];
}


@end
