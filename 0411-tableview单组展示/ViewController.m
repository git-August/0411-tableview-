//
//  ViewController.m
//  0411-tableview单组展示
//
//  Created by Ibokan on 15/4/11.
//  Copyright (c) 2015年 focus. All rights reserved.
//

#import "ViewController.h"
#import "cellShow.h"
@interface ViewController () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
//    NSArray * _cellarr;
    //可变数组,添加动态数据
    NSMutableArray * _cellarr;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#pragma mark 设置数据源－－－－－－－tableview－－－－－datasource－－－－－viewcontroller
//    _tableview.dataSource = self;
    
    //tableviewcell 上显示的数据抽取成一个类.
    _cellarr = [NSMutableArray arrayWithObjects:
                [cellShow cellWithtitle:@"图书/音像" andSubtitle:@"开导,育人,启迪,节奏" andIcon:@"001.png"],
                [cellShow cellWithtitle:@"母婴孕品" andSubtitle:@"孕育,成长,呵护" andIcon:@"002.png"],
                [cellShow cellWithtitle:@"器械" andSubtitle:@"运动,健身" andIcon:@"003.png"],
                 nil];
    for (int i = 0; i < 20; i++) {
        NSString * title = [NSString stringWithFormat:@"产品---%d",i];
        NSString * subtitle = [NSString stringWithFormat:@"产品－－%d好",i];
        NSString * imgname = [NSString stringWithFormat:@"00%d.png",i % 9 + 1];
        [_cellarr addObject:[cellShow cellWithtitle:title andSubtitle:subtitle andIcon:imgname]];
    }
    
}
//default is 1;
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    NSLog(@"----");
//    return 1;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellarr.count;
}
#pragma mark tableview告诉viewcontroller:"cell要被显示".
#pragma mark cell相当于贴在tableview(excel表格)单元格中的数据,需要数据源支持.
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"cellForRowAtIndexPath---%ld",indexPath.row);
    //1.添加tableviewcell
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    //2.添加头像/文字/描述
    cellShow * cellshowcontent = _cellarr[indexPath.row];
    //看到readonly,找找该属性下面的属性
    cell.textLabel.text = cellshowcontent.title;
    cell.detailTextLabel.text = cellshowcontent.subtitle;
//    NSString * imgname = [NSString stringWithFormat:@"00%ld.png",indexPath.row % 9 + 1];
    cell.imageView.image = [UIImage imageNamed:cellshowcontent.icon];
//        [_tableview addSubview:cell];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma mark tableview告诉viewcontroller:"tableview（excel表格单元格）要被调整高度"
#pragma mark－－－－－－－tableviewcell－－delegate－－viewcontroller
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
#pragma mark tableview就告诉viewcontroller:"tableview被人点了".
#pragma mark 由delegate来处理tableview身上的事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectRowAtIndexPath---%ld",indexPath.row);
    cellShow * cellshowcontent = _cellarr[indexPath.row];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"产品信息展示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
//    NSLog(@"%@",alert);//此处的地址和下面的alerView地址一模一样.局部变量不释放,还被self引用
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].text = cellshowcontent.title;
    alert.tag = indexPath.row;
    [alert show];//显示弹窗信息
}

#pragma mark 先调用tableview代理方法,然后才调用alertview的代理方法
#pragma mark 由viewcontroller来处理发生在alert身上的事件
#pragma mark alertview是view的子控件?cell是不是也是view的子控件?不是！tableview是self.view的子控件.
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        return;
    }
//    NSLog(@"%ld",buttonIndex);
//    NSLog(@"%@",alertView);
    //1.修改alertview的textfield中的内容,将此内容返给数组,由模型对象的title属性接收修改值.
#pragma mark 使用buttonindex检索数组了 ,ERROR!应该使用indexPath.row,提取方法:alertview的tag或全局变量
//    cellShow * cellshowcontent = _cellarr[buttonIndex];
    cellShow * cellshowcontent = _cellarr[alertView.tag];
//    NSLog(@"%@",[alertView textFieldAtIndex:0].text);

    //若为空,不生效
    //方法一：
//    if ([[alertView textFieldAtIndex:0].text  isEqual: @""]) return;
    //方法二:未实现
//    NSLog(@"%@",alertView.subviews);
//    UIButton * okbutton = alertView.subviews[1];
//    if ([[alertView textFieldAtIndex:0].text  isEqual: @""]) okbutton.enabled = NO;
//    else okbutton.enabled = YES;
    cellshowcontent.title = [alertView textFieldAtIndex:0].text;

//    [_cellarr replaceObjectAtIndex:buttonIndex withObject:cellshowcontent];
    //2.刷新cell的textlable中的数据－－当前窗口整体刷新
//    [_tableview reloadData];
    //2.局部刷新方式
    //2.1创建nsarray,创建indexpath类,放入数组中,效率高于整体刷新.
    NSArray * indexpathsarr = @[[NSIndexPath indexPathForRow:[alertView tag] inSection:0]];
    [_tableview reloadRowsAtIndexPaths:indexpathsarr withRowAnimation:UITableViewRowAnimationLeft];
}

























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
