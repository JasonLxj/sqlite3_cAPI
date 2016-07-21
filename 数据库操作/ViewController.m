//
//  ViewController.m
//  数据库操作
//
//  Created by 李晓杰 on 16/7/20.
//  Copyright © 2016年 李晓杰. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        //创建表
    sqlite3 *db;
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES).firstObject;
    const char *cpath = [path UTF8String];
    if (sqlite3_open( cpath,&db) != SQLITE_OK){
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败");
    }else{

        char *err ;
        if (sqlite3_exec(
                     db,
                     [@"CREATE TABLE IF NOT EXISTS t_test(name TEXT PRIMARY KEY, sex TEXT NOT NULL);" UTF8String],
                     NULL,
                     NULL,
                         &err) != SQLITE_OK){
            sqlite3_close(db);
            printf("%s",err);
            NSAssert(NO, @"表创建失败");
        }

        NSLog(@"表创建成功");
        sqlite3_close(db);
        
    }





        //修改数据
    if (sqlite3_open(cpath, &db) != SQLITE_OK){
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败");
    }else{
        NSString *sql = @"INSERT OR REPLACE INTO t_test(name, sex) VALUES(?,?)";
        const char *csql = [sql UTF8String];

        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(db, csql, -1, &statement, NULL) == SQLITE_OK ){
            const char *name = [@"jason" UTF8String];
            const char *sex = [@"boy" UTF8String];

            sqlite3_bind_text(statement, 1, name, -1, NULL);
            sqlite3_bind_text(statement, 2, sex, -1, NULL);

            if (sqlite3_step(statement) != SQLITE_DONE){//代表执行完成
                NSAssert(NO, @"插入数据失败");
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }


        //查询
    if (sqlite3_open(cpath, &db) != SQLITE_OK){
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败");
    }else{
        NSString *sql = @"SELECT name, sex FROM t_test where name = ?";
        const char *csql = [sql UTF8String];

        sqlite3_stmt *statement;

            //预处理
        if (sqlite3_prepare_v2(db, csql, -1, &statement, NULL) == SQLITE_OK){//将SQL语句编译为二进制代码,提高SQL语句的额执行速度,第三个参数代表全部SQL字符串的长度,第四个参数是sqlite3_stmt指针的地址,第五个参数是SQlite语句没有执行的部分语句


            const char *cname = [@"jason" UTF8String];

            sqlite3_bind_text(statement, 1, cname, -1, NULL);//用于绑定SQL语句的参数,第二个参数为序号(从1开始),第三个参数为字符串值,第四个参数为字符串长度,第五个参数为一个函数指针<如果SQL语句中带有问号(即占位符),那么就要绑定参数>

            if (sqlite3_step(statement) == SQLITE_ROW){//返回值为SQLITE_ROW说明还有没有遍历的行
                char *cname = (char *)sqlite3_column_text(statement, 0);//提取字段数据,高函数用来读取字符串类型的字段,第二个参数用于指定select字段的索引(从0开始)
                /* 类似的函数
                 sqlite3_column_blob()
                 sqlite3_column_doubleb()
                 sqlite3_column_int()
                 sqlite3_column_int64()
                 sqlite3_column_text()
                 sqlite3_column_text16()
                 */
                char *csex = (char *)sqlite3_column_text(statement, 1);

                NSString *name = [[NSString alloc] initWithUTF8String:cname];
                NSString *sex = [[NSString alloc] initWithUTF8String:csex];
                NSLog(@"===%@,sex == %@",name, sex);
            }
        }
        sqlite3_finalize(statement);//释放资源
        sqlite3_close(db);
    }



        //修改数据
    if (sqlite3_open(cpath, &db) != SQLITE_OK){
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败");
    }else{
        NSString *sql = @"INSERT OR REPLACE INTO t_test(name, sex) VALUES(?,?)";
        const char *csql = [sql UTF8String];

        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(db, csql, -1, &statement, NULL) == SQLITE_OK ){
            const char *name = [@"jason" UTF8String];
            const char *sex = [@"girl" UTF8String];

            sqlite3_bind_text(statement, 1, name, -1, NULL);
            sqlite3_bind_text(statement, 2, sex, -1, NULL);

            if (sqlite3_step(statement) != SQLITE_DONE){//代表执行完成
                NSAssert(NO, @"插入数据失败");
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }


        //查询
    if (sqlite3_open(cpath, &db) != SQLITE_OK){
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败");
    }else{
        NSString *sql = @"SELECT name, sex FROM t_test where name = ?";
        const char *csql = [sql UTF8String];

        sqlite3_stmt *statement;

            //预处理
        if (sqlite3_prepare_v2(db, csql, -1, &statement, NULL) == SQLITE_OK){//将SQL语句编译为二进制代码,提高SQL语句的额执行速度,第三个参数代表全部SQL字符串的长度,第四个参数是sqlite3_stmt指针的地址,第五个参数是SQlite语句没有执行的部分语句


            const char *cname = [@"jason" UTF8String];

            sqlite3_bind_text(statement, 1, cname, -1, NULL);//用于绑定SQL语句的参数,第二个参数为序号(从1开始),第三个参数为字符串值,第四个参数为字符串长度,第五个参数为一个函数指针<如果SQL语句中带有问号(即占位符),那么就要绑定参数>

            if (sqlite3_step(statement) == SQLITE_ROW){//返回值为SQLITE_ROW说明还有没有遍历的行
                char *cname = (char *)sqlite3_column_text(statement, 0);//提取字段数据,高函数用来读取字符串类型的字段,第二个参数用于指定select字段的索引(从0开始)
                /* 类似的函数
                 sqlite3_column_blob()
                 sqlite3_column_doubleb()
                 sqlite3_column_int()
                 sqlite3_column_int64()
                 sqlite3_column_text()
                 sqlite3_column_text16()
                 */
                char *csex = (char *)sqlite3_column_text(statement, 1);

                NSString *name = [[NSString alloc] initWithUTF8String:cname];
                NSString *sex = [[NSString alloc] initWithUTF8String:csex];
                NSLog(@"===%@,sex == %@",name, sex);
            }
        }
        sqlite3_finalize(statement);//释放资源
        sqlite3_close(db);
    }

        //修改数据
    if (sqlite3_open(cpath, &db) != SQLITE_OK){
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败");
    }else{
        NSString *sql = @"DELETE FROM t_test WHERE NAME = ?";
        const char *csql = [sql UTF8String];

        NSLog(@"查询结束");
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(db, csql, -1, &statement, NULL) == SQLITE_OK ){
            const char *name = [@"jason" UTF8String];
            const char *sex = [@"girl" UTF8String];

            sqlite3_bind_text(statement, 1, name, -1, NULL);
            sqlite3_bind_text(statement, 2, sex, -1, NULL);

            if (sqlite3_step(statement) != SQLITE_DONE){//代表执行完成
                NSAssert(NO, @"删除数据失败");
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }


        //查询
    if (sqlite3_open(cpath, &db) != SQLITE_OK){
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败");
    }else{
        NSString *sql = @"SELECT name, sex FROM t_test where name = ?";
        const char *csql = [sql UTF8String];

        sqlite3_stmt *statement;

            //预处理
        if (sqlite3_prepare_v2(db, csql, -1, &statement, NULL) == SQLITE_OK){//将SQL语句编译为二进制代码,提高SQL语句的额执行速度,第三个参数代表全部SQL字符串的长度,第四个参数是sqlite3_stmt指针的地址,第五个参数是SQlite语句没有执行的部分语句


            const char *cname = [@"jason" UTF8String];

            sqlite3_bind_text(statement, 1, cname, -1, NULL);//用于绑定SQL语句的参数,第二个参数为序号(从1开始),第三个参数为字符串值,第四个参数为字符串长度,第五个参数为一个函数指针<如果SQL语句中带有问号(即占位符),那么就要绑定参数>

            if (sqlite3_step(statement) == SQLITE_ROW){//返回值为SQLITE_ROW说明还有没有遍历的行
                char *cname = (char *)sqlite3_column_text(statement, 0);//提取字段数据,高函数用来读取字符串类型的字段,第二个参数用于指定select字段的索引(从0开始)
                /* 类似的函数
                 sqlite3_column_blob()
                 sqlite3_column_doubleb()
                 sqlite3_column_int()
                 sqlite3_column_int64()
                 sqlite3_column_text()
                 sqlite3_column_text16()
                 */
                char *csex = (char *)sqlite3_column_text(statement, 1);

                NSString *name = [[NSString alloc] initWithUTF8String:cname];
                NSString *sex = [[NSString alloc] initWithUTF8String:csex];
                NSLog(@"===%@,sex == %@",name, sex);
            }
        }
        sqlite3_finalize(statement);//释放资源
        sqlite3_close(db);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
