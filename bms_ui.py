import flet
import pymysql
from flet import Page, Text, TextField, ElevatedButton, Column
import flet as ft
from datetime import datetime
import os
import subprocess
# 全局账号参数，无须修改
use_name = 0
real_name = ''
# 连接数据库，BMS_R为备份数据库，内容为空，BMS为主数据库
root_db = pymysql.connect(
    host='localhost',
    user='root',
    passwd='[请输入你的密码]',
    port=3306,
    db='BMS_R')
root_cursor = root_db.cursor()
borrow_list = []
def main(page: Page):
    global use_name
    global real_name
    global root_db
    global root_cursor
    use_sql = "use BMS"
    root_cursor.execute(use_sql)
    root_db.commit()
    # 登陆界面------------------------------------------------------------------------------
    def close_recover(e):
        recover_modal.open = False
        page.update()
    recover_modal = ft.AlertDialog(
        modal=True,
        title=ft.Text("通知"),
        actions=[
            ft.TextButton("确定", on_click=close_recover),
            ft.TextButton("取消", on_click=close_recover),
        ],
        actions_alignment=ft.MainAxisAlignment.END,
    )
    
    def show_recover():
        page.dialog = recover_modal
        recover_modal.open = True
        page.update()

    def login_click(e):
        global use_name
        global root_cursor
        global real_name
        find_pw = f"SELECT * FROM card WHERE 卡键 = '{user.value}'"
        root_cursor.execute(find_pw)
        keys = root_cursor.fetchall()
        if len(keys) < 1:
            pw = None
            admin = None
        else:
            print(keys)
            print(password.value)
            pw = keys[0][4]
            admin = keys[0][3]
            real_name = keys[0][1]
        if admin == '0' and password.value == str(pw):
            use_name = user.value
            page.clean()  # 清除当前页面内容
            admin_page()  # 跳转到管理员页面
        elif admin == '1' and password.value == str(pw):
            use_name = user.value
            page.clean()  # 清除当前页面内容
            user_page()  # 跳转到用户页面
        else:
            page.add(Text(value="用户名或密码错误！"))

    def login_form(e):
        global use_name
        global real_name
        use_name = 0
        user.value = ''
        password.value = ''
        real_name = ''
        page.clean()

        def main(): return ft.Row(
            alignment=ft.MainAxisAlignment.CENTER,
            controls=[
                ft.Container(
                    width=400,
                    height=200,
                    content=ft.Column(
                        controls=[
                            user,
                            password,
                            ft.Row(
                                alignment=ft.MainAxisAlignment.CENTER,
                                controls=[
                            login_button,
                            ft.ElevatedButton(text="恢复", on_click=recover),]),
                        ],
                        horizontal_alignment=ft.CrossAxisAlignment.CENTER,
                    ),
                )])
        page.add(main())
    def recover(e):
        # 连接数据库
        re_db = pymysql.connect(
            host='localhost',
            user='root',
            passwd='[请输入你的密码]',
            port=3306,
            db='BMS_R'
        )

        re_cursor = re_db.cursor()

        # 删除数据库
        delete_sql = "DROP DATABASE IF EXISTS BMS"
        re_cursor.execute(delete_sql)
        re_db.commit()
        # 创建数据库
        create_sql = "CREATE DATABASE BMS"
        re_cursor.execute(create_sql)
        re_db.commit()
        re_cursor.close()
        re_db.close()
        ## 备份和恢复文件在D盘
        recover_flag= os.system("mysql -uroot -p[请输入你的密码] -D bms < \"D:\\bms.sql\"")
        print(recover_flag)
        if recover_flag==0:
            recover_modal.content=ft.Text("恢复成功")
        else:
            recover_modal.content = ft.Text("恢复失败")
        show_recover()
        global root_db
        global root_cursor
        use_sql= "use BMS"
        root_cursor.execute(use_sql)
        root_db.commit()


    user = TextField(label="用户名", autofocus=True)
    password = TextField(label="密码", on_submit=login_click)
    login_button = ElevatedButton(text="登录", on_click=login_click,)
    page.add(
        ft.Row(
            alignment=ft.MainAxisAlignment.CENTER,
            controls=[
                ft.Container(
                    width=400,
                    height=200,
                    content=ft.Column(
                        controls=[
                            user,
                            password,
                            ft.Row(
                                alignment=ft.MainAxisAlignment.CENTER,
                                controls=[
                            login_button,
                            ft.ElevatedButton(text="恢复", on_click=recover),]),
                        ],
                        horizontal_alignment=ft.CrossAxisAlignment.CENTER,
                    ),
                )]))

    # 普通用户页面----------------------------------------------------------------------------
    def user_page():
        # 左侧借阅表------------------------------------------------
        global root_cursor
        global use_name
        global real_name
        use_sql = "use BMS"
        root_cursor.execute(use_sql)
        root_db.commit()
        print(use_name)
        left_sql = f"select * from borrow where 借阅表卡键='{use_name}' and 还书状态=0"
        root_cursor.execute(left_sql)
        show_data = root_cursor.fetchall()
        show_col_names = [desc[0] for desc in root_cursor.description]

        show_table = ft.DataTable(
            columns=[
                ft.DataColumn(
                    ft.Text(col)) for col in show_col_names],
            rows=[
                ft.DataRow(
                    cells=[
                        ft.DataCell(
                            ft.Text(
                                cell.replace(
                                    " ",
                                    "") if isinstance(
                                    cell,
                                    str) else cell)) for cell in row]) for row in show_data],
            data_row_max_height=40,
            column_spacing=10,
        )
        data_show_container = ft.Container(
            width=600,
            height=500,
            content=ft.ListView(
                controls=[
                    show_table,
                ],
                expand=20,
                spacing=10,
                padding=20,
                auto_scroll=True,
            ),
            border_radius=20,
            border=ft.border.all(2),)
        # bgcolor=ft.colors.BLACK38)
        # 根页面欢迎---------------------------------------------------------

        def close_welcome(e):
            welcome.open = False
            page.update()
        welcome = ft.AlertDialog(
            modal=True,
            title=ft.Text("通知"),
            content=ft.Text(f"用户:{real_name}，成功登录"),
            actions=[
                ft.TextButton("确定", on_click=close_welcome),
                ft.TextButton("取消", on_click=close_welcome),
            ],
            actions_alignment=ft.MainAxisAlignment.END,

        )
        page.dialog = welcome
        welcome.open = True
        page.update()

    # 书籍搜索显示显示表-----------------------------------------------------------
        def on_row_selected_changed(e: ft.ControlEvent):
            global borrow_list
            e.control.selected = not e.control.selected
            e.page.update()
            borrow_list.append(e.control.cells[0].content.value)
            print(e.control.cells[0].content.value)

        inputs = ft.TextField(width=400)
        page.horizontal_alignment = ft.CrossAxisAlignment.CENTER
        search_type = ft.Dropdown(
            options=[
                ft.dropdown.Option("书名"),
                ft.dropdown.Option("索书号"),
            ],
            width=100,
        )

        col_names = []
        data = []
        table = ft.DataTable(
            show_checkbox_column=True,
            columns=[
                ft.DataColumn(
                    ft.Text(col)) for col in col_names],
            rows=[
                ft.DataRow(
                    cells=[
                        ft.DataCell(
                            ft.Text(
                                cell.replace(
                                    " ",
                                    "") if isinstance(
                                        cell,
                                        str) else cell)) for cell in row],
                    on_select_changed=on_row_selected_changed) for row in data],
            data_row_max_height=40,
            column_spacing=10,
        )

        def search_buttom(e):
            global data, col_names
            global root_cursor
            if search_type.value == "书名":
                sql = f"select * from books where 书名='{inputs.value}'"
            elif search_type.value == "索书号":
                sql = f"select * from books where 索书号='{inputs.value}'"
            else:
                sql = f"select * from books where 书名='{inputs.value}'"
            print(sql)
            root_cursor.execute(sql)
            data = root_cursor.fetchall()
            print(data)
            col_names = [desc[0] for desc in root_cursor.description]
            new_columns = [
                ft.DataColumn(
                    ft.Text(col)) for col in col_names]
            new_rows = [
                ft.DataRow(
                    cells=[
                        ft.DataCell(
                            ft.Text(
                                cell.replace(
                                    " ",
                                    "") if isinstance(
                                    cell,
                                    str) else cell)) for cell in row],
                    on_select_changed=on_row_selected_changed,
                ) for row in data]
            table.columns = new_columns
            table.rows = new_rows
            page.update()

        search_container = ft.Container(width=600, height=500, content=ft.ListView(
            controls=[table, ],
            expand=20, spacing=10, padding=20, auto_scroll=True,
        ))

        # 登录欢迎窗口--------------------------------------------------------------


        # 还书警告显示表-----------------------------------------------------------------

        alert_sql = f"select 用户姓名,书名,剩余天数 from overdue_borrow_records where 用户账号='{use_name}' and 还书状态=0 "
        root_cursor.execute(alert_sql)
        alert_data = root_cursor.fetchall()
        alert_col_names = [desc[0] for desc in root_cursor.description]

        alert_table = ft.DataTable(
            columns=[
                ft.DataColumn(
                    ft.Text(col)) for col in alert_col_names],
            rows=[
                ft.DataRow(
                    cells=[
                        ft.DataCell(
                            ft.Text(
                                cell.replace(
                                    " ",
                                    "") if isinstance(
                                    cell,
                                    str) else cell)) for cell in row]) for row in alert_data],
            data_row_max_height=40,
            column_spacing=10,
        )
        alert_container = ft.Container(
            width=600,
            height=500,
            content=ft.ListView(
                controls=[
                    alert_table,
                ],
                expand=20,
                spacing=10,
                padding=20,
                auto_scroll=True,
            ),
            border_radius=20,
            border=ft.border.all(2),)
        # bgcolor=ft.colors.BLACK38)

        def update_data(e):
            global root_cursor
            global root_db
            update_sql = "UPDATE borrow SET 剩余时间 = 剩余时间 - 1"
            root_cursor.execute(update_sql)
            root_db.commit()
            update_view(e)
            update_view1(e)

        def update_view1(e):
            global root_cursor
            global root_db
            global use_name
            alert_sql = f"select * from overdue_borrow_records where 用户账号='{use_name}' and 还书状态=0 "
            root_cursor.execute(alert_sql)
            alert_data = root_cursor.fetchall()
            new_rows = [
                ft.DataRow(
                    cells=[
                        ft.DataCell(
                            ft.Text(
                                cell.replace(
                                    " ",
                                    "") if isinstance(
                                    cell,
                                    str) else cell)) for cell in row]) for row in alert_data]
            alert_table.rows = new_rows
            page.update()

        def update_view(e):
            global root_cursor
            global root_db
            global use_name
            left_sql = f"select * from borrow where 借阅表卡键='{use_name}' and 还书状态=0"
            root_cursor.execute(left_sql)
            show_data = root_cursor.fetchall()
            new_rows = [
                ft.DataRow(
                    cells=[
                        ft.DataCell(
                            ft.Text(
                                cell.replace(
                                    " ",
                                    "") if isinstance(
                                    cell,
                                    str) else cell)) for cell in row]) for row in show_data]
            show_table.rows = new_rows
            page.update()

        def return_book(e):
            global root_cursor
            global borrow_list
            # count_sql = f"select count(*) from borrow"
            # root_cursor.execute(count_sql)
            # ikey = root_cursor.fetchall()
            # print(ikey)
            # search_borrow_key_sql=f"select 借阅记录号,还书状态 from borrow where 借阅表书键={int(return_id.value)} and 借阅表卡键={use_name}"
            search_borrow_key_sql = f"select 还书状态 from borrow where 借阅记录号={int(return_id.value)}"
            root_cursor.execute(search_borrow_key_sql)
            content = root_cursor.fetchall()
            print(content)
            state = content[-1][0]
            # state=content[-1][1]
            if state == 1:
                print("已经还过了")
            else:
                return_sql = f"update borrow set 还书状态=1 where 借阅记录号={return_id.value}"
                root_cursor.execute(return_sql)
                root_db.commit()
                print("还书成功")
                update_balance(e)
                update_view(e)
                update_view1(e)
                page.update()
            pass
        return_id = ft.TextField(
            hint_text="请输入书籍的ID",
            width=500,
            autofocus=True,
            on_submit=return_book)
        return_buttom = ft.ElevatedButton("还书", on_click=return_book)
        update_buttom = ft.ElevatedButton("更新", on_click=update_data)

        def update_balance(e):
            global root_cursor
            global root_db
            global use_name
            balance_sql = f"select 余额 from card where 卡键={use_name}"
            root_cursor.execute(balance_sql)
            balance = root_cursor.fetchall()[0][0]
            count_show.value = f"{balance}        "

        balance_sql = f"select 余额 from card where 卡键={use_name}"
        root_cursor.execute(balance_sql)
        balance = root_cursor.fetchall()[0][0]
        name_head = ft.Text("姓名:")
        id_head = ft.Text("账号:")
        count_head = ft.Text("余额:")
        name_show = ft.Text("张三")
        id_show = ft.Text("123456")
        count_show = ft.Text(f"{balance}        ")

        def borrow_book(e):
            global root_cursor
            global borrow_list
            global use_name
            global root_db
            print(borrow_list)
            count_sql = f"select count(*) from borrow"
            root_cursor.execute(count_sql)
            ikey = root_cursor.fetchall()[0][0]
            print(ikey)
            current_date = datetime.now().date()
            formatted_date = current_date.strftime('%Y-%m-%d')
            adds = 1
            for i in range(len(borrow_list)):
                book_key_sql = f"select 书键 from book where 书表索书号='{borrow_list[i]}' and 可借状态=1"
                root_cursor.execute(book_key_sql)
                book_keys = root_cursor.fetchall()[0]
                print(book_keys)
                if len(book_keys) == 0:
                    page.add(Text(value="书籍不存在或者已经全被借走"))
                    page.update()
                    return
                else:
                    book_key = book_keys[0]
                    borrow_sql = f"insert into borrow(借阅记录号,借阅表书键,借阅表卡键,借书时间,还书状态,剩余时间) values('{int(ikey) + adds}',{book_key},{use_name},'{formatted_date}',0,30)"
                    print(borrow_sql)
                    root_cursor.execute(borrow_sql)
                    root_db.commit()
                    adds += 1
                    print("借书成功")
                search_buttom(e)
                borrow_list = []
                page.update()

        # 路由切换-------------------------------------------------------------------

        def route_change(route):
            page.views.clear()
            page.views.append(
                ft.View(
                    "/",
                    [
                        ft.AppBar(
                            title=ft.Row(
                                controls=[
                                    ft.Text(f"{real_name}"),
                                    ft.ElevatedButton(
                                        "borrow",
                                        on_click=lambda _: page.go("/search")),
                                ]),
                            bgcolor=ft.colors.SURFACE_VARIANT,
                            actions=[
                                count_head,
                                count_show],
                        ),
                        ft.Row(
                            controls=[
                                return_id,
                                return_buttom, update_buttom],
                            spacing=20,
                            alignment=ft.MainAxisAlignment.CENTER),
                        ft.Row(
                            controls=[
                                data_show_container,
                                alert_container]),
                        # ft.ElevatedButton("返回登录界面", on_click=login_form),

                    ],

                ))
            if page.route == "/search":
                page.views.append(
                    ft.View(
                        "/search",
                        [
                            ft.Column(
                                controls=[
                                    ft.Container(
                                        content=ft.Row(
                                            controls=[
                                                inputs,
                                                search_type,
                                                ft.ElevatedButton(
                                                    "搜索",
                                                    on_click=search_buttom),
                                                ft.ElevatedButton(
                                                    "借阅",
                                                    on_click=borrow_book),
                                            ],
                                            alignment=ft.MainAxisAlignment.CENTER)),
                                    search_container,
                                ],
                                horizontal_alignment=ft.CrossAxisAlignment.CENTER),
                            ft.ElevatedButton(
                                "Go Home",
                                on_click=lambda _: page.go("/")),
                        ],
                    ))
            page.update()

        def view_pop(view):
            try:
                page.views.pop()
                top_view = page.views[-1]
                page.go(top_view.route)
            except BaseException:
                # 如果在 try 块中引发 SomeException，将执行这里的代码
                print(f"An error occurred")

        page.on_route_change = route_change
        page.go(page.route)

    # 管理员页面--------------------------------------------------------

    def admin_page():
        global use_name
        global real_name
        global root_db
        global root_cursor
        use_sql = "use BMS"
        root_cursor.execute(use_sql)
        root_db.commit()

        # 欢迎窗口----------------------------------------------------------------

        def close_welcome(e):
            welcome.open = False
            page.update()
        # page.add(Text(value="欢迎, 管理员！"))
        welcome = ft.AlertDialog(

            modal=True,
            title=ft.Text("欢迎"),
            content=ft.Text(f"管理员:{real_name}，成功登录"),
            actions=[
                ft.TextButton("确定", on_click=close_welcome),
                ft.TextButton("取消", on_click=close_welcome),
                 ],
            actions_alignment=ft.MainAxisAlignment.END,
            on_dismiss=lambda e: print("Modal dialog dismissed!"),
        )
        page.dialog = welcome
        welcome.open = True
        page.update()

        # 表格显示-------------------------------------------------------------

        update_data = []
        update_col_names = []
        update_table = ft.DataTable(
            columns=[
                ft.DataColumn(
                    ft.Text(col)) for col in update_col_names],
            rows=[
                ft.DataRow(
                    cells=[
                        ft.DataCell(
                            ft.Text(
                                cell.replace(
                                    " ",
                                    "") if isinstance(
                                    cell,
                                    str) else cell)) for cell in row]) for row in update_data],
            data_row_max_height=40,
            column_spacing=10,
        )
        dataview_container = ft.Container(
            width=600,
            height=350,
            content=ft.ListView(
                controls=[
                    update_table,
                ],
                expand=20,
                spacing=10,
                padding=20,
                auto_scroll=True,
            ),
            border=ft.border.all(1),
            border_radius=20,)

        def add(e):
            global root_cursor, root_db, update_data, update_col_names
            sql1 = f"insert into books values('{ISBN.value}','{book_name.value}','{writer.value}',{quantity.value},{quantity.value})"
            root_cursor.execute(sql1)
            root_db.commit()
            sql2 = f"select * from books where 索书号='{ISBN.value}'"
            root_cursor.execute(sql2)
            update_data = root_cursor.fetchall()
            admin_update(e)

            search_count = f"select count(*) from book"
            root_cursor.execute(search_count)
            count = root_cursor.fetchall()[0][0]
            for i in range(int(quantity.value)):
                add_sql = f"insert into book values({count +i +1},'{ISBN.value}',1)"
                root_cursor.execute(add_sql)
                root_db.commit()

        def delete(e):
            global root_cursor, root_db, update_data, update_col_names
            sql2 = f"delete from book where 书表索书号='{ISBN.value}'"
            root_cursor.execute(sql2)
            root_db.commit()
            sql1 = f"delete from books where 索书号='{ISBN.value}'"
            root_cursor.execute(sql1)
            root_db.commit()
            sql2 = f"select * from books"
            root_cursor.execute(sql2)
            update_data = root_cursor.fetchall()
            admin_update(e)

        def update(e):
            global root_cursor, root_db, update_data, update_col_names
            search_count = f"select 总数量 from books where 索书号='{ISBN.value}'"
            root_cursor.execute(search_count)
            count = root_cursor.fetchall()[0][0]
            sql1 = f"update books set 书名='{book_name.value}',作者='{writer.value}',总数量={quantity.value} where 索书号='{ISBN.value}'"
            root_cursor.execute(sql1)
            root_db.commit()
            search_kc = f"select 可借阅数量 from books where 索书号='{ISBN.value}'"
            root_cursor.execute(search_kc)
            kcount = root_cursor.fetchall()[0][0]
            sql3 = f"select count(*) from book"
            root_cursor.execute(sql3)
            base = root_cursor.fetchall()[0][0]
            print(count, quantity.value)
            if count < int(quantity.value):
                print("已执行1")
                for i in range(int(quantity.value) - count):
                    add_sql = f"insert into book values({base +i +1},'{ISBN.value}',1)"
                    root_cursor.execute(add_sql)
                    root_db.commit()
                update_k = f"update books set 可借阅数量={kcount + int(quantity.value) - count} where 索书号='{ISBN.value}'"
                root_cursor.execute(update_k)
                root_db.commit()
            elif count > int(quantity.value):
                print("已执行2")
                for i in range(count - int(quantity.value)):
                    delete_sql = f"delete from book where 书表索书号='{ISBN.value}' and 可借状态=1 limit 1"
                    root_cursor.execute(delete_sql)
                    root_db.commit()
                update_k = f"update books set 可借阅数量={kcount + int(quantity.value) - count} where 索书号='{ISBN.value}'"
                root_cursor.execute(update_k)
                root_db.commit()
            else:
                pass

            sql2 = f"select * from books where 索书号='{ISBN.value}'"
            root_cursor.execute(sql2)
            update_data = root_cursor.fetchall()
            update_col_names = [desc[0] for desc in root_cursor.description]
            admin_update(e)

        def select(e):
            global root_cursor, root_db, update_data, update_col_names
            if ISBN.value != "":
                sql1 = f"select * from books where 索书号='{ISBN.value}'"
            elif book_name.value != "":
                sql1 = f"select * from books where 书名='{book_name.value}'"
            elif writer.value != "":
                sql1 = f"select * from books where 作者='{writer.value}'"
            else:
                sql1 = f""
            print(sql1)
            root_cursor.execute(sql1)
            update_col_names = [desc[0] for desc in root_cursor.description]
            update_data = root_cursor.fetchall()
            print(update_data)
            admin_update(e)

        def admin_update(e):
            global update_data, update_col_names
            print(update_data)
            new_columns = [
                ft.DataColumn(
                    ft.Text(col)) for col in update_col_names]
            new_rows = [
                ft.DataRow(
                    cells=[
                        ft.DataCell(
                            ft.Text(
                                cell.replace(
                                    " ",
                                    "") if isinstance(
                                    cell,
                                    str) else cell)) for cell in row]) for row in update_data]

            update_table.rows = new_rows
            update_table.columns = new_columns
            page.update()

        page.title = "AlertDialog examples"

        def close_dlg(e):
            dlg_modal.open = False
            print(students.value, name.value)
            page.update()

        def certain_dlg(e):
            global root_cursor
            global root_db
            register_sql = f"insert into card values({int(students.value)},'{name.value}',0,'{admin.value}','{password.value}') "
            root_cursor.execute(register_sql)
            root_db.commit()
            students.value = None
            name.value = None
            password.value = None
            admin.value = None
            close_dlg(e)
            welcome.content=ft.Text("添加成功")
            page.dialog = welcome
            welcome.open = True
            page.update()

        students = ft.TextField(hint_text="请输入学号", autofocus=True)
        name = ft.TextField(hint_text="请输入姓名", autofocus=True)
        password = ft.TextField(hint_text="请输入密码", autofocus=True)
        admin = ft.TextField(hint_text="请输入身份，1为普通，0为管理员", autofocus=True)
        dlg_modal = ft.AlertDialog(

            modal=True,
            title=ft.Text("请输入待添加人员的消息"),
            content=(ft.Container(ft.Column(controls=[students,
                                                      name, password, admin]))),
            actions=[
                ft.TextButton("确定", on_click=certain_dlg),
                ft.TextButton("取消", on_click=close_dlg),
            ],
            actions_alignment=ft.MainAxisAlignment.END,
            on_dismiss=lambda e: print("Modal dialog dismissed!"),
        )

        def open_dlg_modal(e):
            page.dialog = dlg_modal
            dlg_modal.open = True
            page.update()

        ISBN = ft.TextField(hint_text="请输入ISBN码", width=300, autofocus=True)
        book_name = ft.TextField(hint_text="请输入书名", width=300)
        writer = ft.TextField(hint_text="请输入作者", width=300)
        quantity = ft.TextField(hint_text="请输入总数量", width=300)

        add_buttom = ft.ElevatedButton(text="add", on_click=add)
        delete_buttom = ft.ElevatedButton(text="delete", on_click=delete)
        upadate_buttom = ft.ElevatedButton(text="update", on_click=update)
        select_buttom = ft.ElevatedButton(text="select", on_click=select)
        def backup(e):
            flag=os.system('mysqldump -uroot -p[请输入你的密码] BMS > d:bms.sql')
            if flag==0:
                print("备份成功")
                welcome.content = ft.Text("备份成功")
            else:
                print("备份失败")
                welcome.content = ft.Text("备份失败")
            welcome.open = True
            page.update()
        # page.add(ft.Row(controls=[ft.Column(controls=[ISBN,book_name,writer,quantity],ft.Column(controls=[add_buttom,delete_buttom,upadate_buttom,select_buttom])]))
        page.add(
            ft.AppBar(
                title=ft.Row(
                    controls=[
                        ft.Text(
                            f"{real_name}"),
                    ]),
                bgcolor=ft.colors.SURFACE_VARIANT),
        )
        page.add(
            ft.Row(
                alignment=ft.MainAxisAlignment.CENTER,
                controls=[
                    ft.Container(
                        ft.Column(
                            controls=[
                                ft.Text("请输入需要输入的消息"),
                                ISBN,
                                book_name,
                                writer,
                                quantity],
                            horizontal_alignment=ft.CrossAxisAlignment.CENTER,
                            alignment=ft.MainAxisAlignment.CENTER,
                            spacing=10),
                        border=ft.border.all(1),
                        border_radius=ft.border_radius.all(20),
                        width=350,
                        height=350,
                    ),
                    ft.Container(
                        ft.Column(
                            controls=[
                                ft.Text("请选择操作"),
                                add_buttom,
                                delete_buttom,
                                upadate_buttom,
                                select_buttom],
                            horizontal_alignment=ft.CrossAxisAlignment.CENTER,
                            alignment=ft.MainAxisAlignment.CENTER,
                            spacing=30
                        ),
                        border=ft.border.all(1),
                        border_radius=ft.border_radius.all(10),
                        width=100,
                        height=350,
                    ),
                    dataview_container,
                ]))
        page.add(
            ft.Row(
                alignment=ft.MainAxisAlignment.CENTER,
                spacing=25,
                controls=[
                    ft.ElevatedButton("添加用户", on_click=open_dlg_modal),
                    ft.ElevatedButton("返回登录界面", on_click=login_form),
                    ft.ElevatedButton("备份", on_click=backup),
                ]
            ),
        )


    # login_form()  # 显示登录表单
flet.app(target=main)
