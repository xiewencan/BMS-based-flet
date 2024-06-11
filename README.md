# BMS-base-flet
A simple book management system based on Flet (MySQL database course project)

一个基于Flet框架的简单数据库关联系统（MySQL数据库课程设计）

包含文件：

+ `readme.md`：介绍文件
+ `bms.sql`：MySQL数据库数据备份文件，可以直接通过UI界面的恢复按钮导入，默认路径为D盘，用来示范使用。
+ `bms_ui.py`：该系统的UI界面，使用前将`[请输入你的密码]`修改自己数据库的登录密码。


## 使用方法：


+ 下载项目文件`git clone git@github.com:xiewencan/BMS-based-flet.git`
+ 将示例用的`bms.sql`文件放置到D盘，也可以自己修改``bms_ui.py`中的地址，不过注意修改后的格式
+ 打开`bms_ui.py`文件，安装必要的库`flet`,`pymysql`
	+ pip安装：`pip install [库名]`
	+ conda安装：`conda install [库名]`


## 功能介绍：

#### 当前功能实现：

1) 图书基本情况的录入、修改、删除等基本操作；
2) 办理借书卡模块；
3) 实现借书功能；
4) 实现还书功能；
5) 能方便的对图书进行查询；
6) 对超期的情况能自动给出提示信息；
7) 具有数据备份和数据恢复功能。

<img src="https://spade-photos.oss-cn-beijing.aliyuncs.com/blog/202406111138800.png" alt="img" style="zoom:67%;" />

#### 概念结构设计：

图书实体属性图

 

<img src="https://spade-photos.oss-cn-beijing.aliyuncs.com/blog/202406111134085.jpg" alt="img" style="zoom:50%;" />

<p align="center">图1-1图书类实体属性图<p>

图书实体属性图

 

<img src="https://spade-photos.oss-cn-beijing.aliyuncs.com/blog/202406111134467.jpg" alt="img" style="zoom:50%;" />

<p align="center">图1-2图书实体属性图<p>

借阅信息实体属性图

<img src="https://spade-photos.oss-cn-beijing.aliyuncs.com/blog/202406111134399.png" alt="9d1d0e9e16fafe69ef4a5efc89f21d9" style="zoom:50%;" />

<p align="center">图1-3借阅信息实体图<p>

借书卡实体属性图

<img src="https://spade-photos.oss-cn-beijing.aliyuncs.com/blog/202406111134735.jpg" alt="3120b3cd73ccd53daf8700000267c69" style="zoom:50%;" />

<p align="center">图1-4借书卡实体属性表<p>

实体联系图

<img src="https://spade-photos.oss-cn-beijing.aliyuncs.com/blog/202406111134091.jpg" alt="img" style="zoom:50%;" />

<p align="center">图1-5实体联系图<p>

完整E-R图

<img src="https://spade-photos.oss-cn-beijing.aliyuncs.com/blog/202406111135081.jpg" alt="img" style="zoom:50%;" />

<p align="center">图1-6完整E-R图<p>
#### 系统逻辑设计

<img src="https://spade-photos.oss-cn-beijing.aliyuncs.com/blog/202406111145226.png" alt="8494f5db21a37ff22baf73ae58cdd42" style="zoom:67%;" />

#### 示例数据字典

##### Books表数据项

###### 索书号

- 数据项名：索书号
- 数据项含义：唯一标识每本图书
- 别名：图书编号
- 数据类型：字符型
- 长度：25
- 取值范围：任意长度在25以内的字符串
- 取值含义：数据类比所对应的编号
- 与其他数据项的逻辑关系：（无）

###### 书名

- 数据项名：书名
- 数据项含义：图书的名称
- 别名：（无）
- 数据类型：字符型
- 长度：25
- 取值范围：根据实际书名长度设定
- 取值含义：图书的正式名称
- 与其他数据项的逻辑关系：（无）

###### 作者

- 数据项名：作者
- 数据项含义：图书作者的姓名
- 别名：（无）
- 数据类型：字符型
- 长度：25
- 取值范围：根据实际作者名称长度设定
- 取值含义：图书作者的姓名或笔名
- 与其他数据项的逻辑关系：（无）

###### 可借阅数量

- 数据项名：可借阅（剩余）数量
- 数据项含义：当前可供借阅的图书数量
- 别名：（无）
- 数据类型：字符型
- 长度：25
- 取值范围：000000000000000000000000000-9999999999999999999999999
- 取值含义：表示当前可借阅的图书数量
- 与其他数据项的逻辑关系：（无）

###### 总数量

- 数据项名：总数量
- 数据项含义：图书的总库存数量
- 别名：（无）
- 数据类型：字符型
- 长度：25
- 取值范围：000000000000000000000000000-9999999999999999999999999
- 取值含义：图书的总库存数量
- 与其他数据项的逻辑关系：（无）



##### 借阅记录表

- 数据项名：借阅记录号
- 数据项含义：唯一标识每条借阅记录
- 别名：（无）
- 数据类型：字符型
- 长度：25
- 取值范围：000000000000000000000000000-9999999999999999999999999
- 取值含义：用于追踪和管理借阅活动的编号
- 与其他数据项的逻辑关系：（无）

###### 借阅书书键

- 数据项名：书键
- 数据项含义：与图书名表中图书的关联键
- 别名：（无）
- 数据类型：字符型
- 长度：25
- 取值范围：根据实际编号规则设定
- 取值含义：与图书名表中的索书号相对应
- 与其他数据项的逻辑关系：与BS_NUMBER相关联

###### 借阅表卡键

- 数据项名：卡键
- 数据项含义：与借书卡表中借书卡的关联键
- 别名：（无）
- 数据类型：整型
- 长度：根据系统设计设定
- 取值范围：根据实际编号规则设定
- 取值含义：借书卡的唯一编号，用于识别持卡人
- 与其他数据项的逻辑关系：与CARD表的C_KEY相关联

###### 借书时间

- 数据项名：借书时间
- 数据项含义：借书的具体日期
- 别名：（无）
- 数据类型：日期型
- 长度：根据系统设计设定
- 取值范围：有效日期范围
- 取值含义：记录借书的具体日期
- 与其他数据项的逻辑关系：（无）

###### 还书状态

- 数据项名：还书状态
- 数据项含义：表示图书是否已经归还
- 别名：（无）
- 数据类型：整型
- 长度：根据系统设计设定
- 取值范围：0（未归还），1（已归还）
- 取值含义：0表示未归还，1表示已归还
- 与其他数据项的逻辑关系：（无）

###### 剩余时间

- 数据项名：剩余时间
- 数据项含义：图书归还的剩余天数
- 别名：（无）
- 数据类型：整型
- 长度：根据系统设计设定
- 取值范围：根据借阅期限设定
- 取值含义：表示图书归还的剩余天数
- 与其他数据项的逻辑关系：（无）

##### 借书卡表 (CARD) 数据项

###### 卡键

- 数据项名：卡键
- 数据项含义：借书卡持有者的账号
- 别名：（无）
- 数据类型：字符型
- 长度：25
- 取值范围：根据实际账号长度设定
- 取值含义：持卡人的账号，用于登录系统
- 与其他数据项的逻辑关系：（无）

###### 姓名

- 数据项名：学生姓名
- 数据项含义：借书卡持有者的姓名
- 别名：（无）
- 数据类型：字符型
- 长度：25
- 取值范围：根据实际姓名长度设定
- 取值含义：持卡人的姓名
- 与其他数据项的逻辑关系：（无）

###### 余额

- 数据项名：余额
- 数据项含义：借书卡中的余额
- 别名：（无）
- 数据类型：整型
- 长度：根据系统设计设定
- 取值范围：根据余额规则设定
- 取值含义：借书卡中的余额，可能与罚款或借阅次数相关
- 与其他数据项的逻辑关系：（无）

###### 身份标识

- 数据项名：身份标识
- 数据项含义：借书卡持有者的身份标识
- 别名：（无）
- 数据类型：字符型
- 长度：25
- 取值范围：根据实际标识长度设定
- 取值含义：用于标识持卡人身份的信息
- 与其他数据项的逻辑关系：（无）

###### 密码

- 数据项名：密码
- 数据项含义：借书卡持有者设置的密码
- 别名：（无）
- 数据类型：字符型
- 长度：25
- 取值范围：根据密码规则设定
- 取值含义：持卡人设置的密码，用于登录系统
- 与其他数据项的逻辑关系：（无）

##### 图书表 (BOOK) 数据项

###### 书键

- 数据项名：书键
- 数据项含义：唯一标识每本图书
- 别名：（无）
- 数据类型：字符型
- 长度：25
- 取值范围：根据实际编号规则设定
- 取值含义：与图书名表中的索书号相对应
- 与其他数据项的逻辑关系：与BOOKS表的BS_NUMBER相关联

###### 书表索书号

- 数据项名：书表索书号
- 数据项含义：图书的唯一标识号码
- 别名：图书编号
- 数据类型：字符型
- 长度：25
- 取值范围：根据实际编号规则设定
- 取值含义：图书的唯一标识号码
- 与其他数据项的逻辑关系：引用了BOOKS表的BS_NUMBER

###### 可借状态

- 数据项名：是否能够借阅
- 数据项含义：表示图书是否处于可借阅状态
- 别名：（无）
- 数据类型：整型
- 长度：根据系统设计设定
- 取值范围：0（不可借阅），1（可借阅）
- 取值含义：0表示不可借阅，1表示可借阅
- 与其他数据项的逻辑关系：（无）

