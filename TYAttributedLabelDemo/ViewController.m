//
//  ViewController.m
//  TYAttributedLabelDemo
//
//  Created by tanyang on 15/4/8.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "ViewController.h"
#import "TYAttributedLabel.h"
#import "TYImageStorage.h"
#import "TYViewStorage.h"
#import "SimpleTextViewController.h"
#import "AttributedTextViewController.h"
#import "ImageTextViewController.h"
#import "LinkTextViewController.h"
#import "ParseTextViewController.h"
#import "AddViewTextViewController.h"

@interface tableViewItem : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *detailText;

@property (nonatomic, assign) Class destVcClass;

@end

@implementation tableViewItem

@end

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) TYAttributedLabel *label;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *itemArray;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self addTableView];
    
    [self addTableItems];
    
    [self.tableView reloadData];
    
}

- (NSMutableArray *)itemArray
{
    if (_itemArray == nil) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

- (void)addTableView
{
    // 添加tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)addTableItems
{
    [self addTableItemWithTitle:@"SimpleText" detailText:@"简单文本显示" destVcClass:[SimpleTextViewController class]];
    
    [self addTableItemWithTitle:@"AttributedText" detailText:@"属性文本显示" destVcClass:[AttributedTextViewController class]];
    
    [self addTableItemWithTitle:@"LinkText" detailText:@"属性链接文本显示" destVcClass:[LinkTextViewController class]];
    
    [self addTableItemWithTitle:@"ImageText" detailText:@"属性文本和Image混排显示" destVcClass:[ImageTextViewController class]];
    
    [self addTableItemWithTitle:@"AddViewText" detailText:@"属性文本和UIView混排显示" destVcClass:[AddViewTextViewController class]];
    
    [self addTableItemWithTitle:@"parseText" detailText:@"自定义排版解析图文混排显示" destVcClass:[ParseTextViewController class]];
}

- (void)addTableItemWithTitle:(NSString *)title detailText:(NSString *)detailText destVcClass:(Class)destVcClass
{
    tableViewItem *item = [[tableViewItem alloc]init];
    item.title = title;
    item.detailText = detailText;
    item.destVcClass = destVcClass;
    
    [self.itemArray addObject:item];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    tableViewItem *item = self.itemArray[indexPath.row];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.detailText;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableViewItem *item = self.itemArray[indexPath.row];
    
    if (item.destVcClass ) {
        UIViewController *vc = [[item.destVcClass alloc]init];
        vc.view.backgroundColor = [UIColor whiteColor];
        vc.title = item.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
