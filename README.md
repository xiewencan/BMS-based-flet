# BMS-base-flet
A simple book management system based on Flet (MySQL database course project)

一个基于Flet框架的简单数据库关联系统（MySQL数据库课程设计）

包含文件：

+ `readme.md`：介绍文件
+ `bms.sql`：MySQL数据库数据备份文件，可以直接通过UI界面的恢复按钮导入，默认路径为D盘，用来示范使用。
+ `bms_ui.py`：该系统的UI界面，使用前将`[请输入你的密码]`修改自己数据库的登录密码。

使用方法：

+ 下载项目文件`git clone git@github.com:xiewencan/BMS-based-flet.git`
+ 将示例用的`bms.sql`文件放置到D盘，也可以自己修改``bms_ui.py`中的地址，不过注意修改后的格式
+ 打开`bms_ui.py`文件，安装必要的库`flet`,`pymysql`
	+ pip安装：`pip install [库名]`
	+ conda安装：`conda install [库名]`
