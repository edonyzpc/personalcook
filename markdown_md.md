##### .md文件格式编辑

###### 转载自[http://blog.csdn.net/kaitiren/article/details/38513715](http://blog.csdn.net/kaitiren/article/details/38513715)
--------
md是markdown的缩写，markdown是一种编辑博客的语言。用惯了可视化的博客编辑器（比如CSDN博客，囧），<br>
这种编程式的博客编辑方案着实让人眼前一亮。不过GitHub支持的语法在标准markdown语法的基础上做了修改，<br>
称为Github Flavored Markdown，简称GFM。<br>
###### 可不是[GFW](http://baike.baidu.com/link?url=-Rv9pbmmc0s_FyL7izxb-bggGPNhLJwJ-yMF1itfS6fdJmP7COjY-MhZGMEYp8ytWouGP-G2nzITt7j85Pb_y-hfG9UHgkFRC0Tc9mjOmAW)呀!<br>
--------
##### 关于标题

规范的README文件开头都写上一个标题，这被称为大标题。<br>
在文本下面加上 等于号 = ，那么上方的文本就变成了大标题。等于号的个数无限制，但一定要大于0个哦。
![](https://github.com/edonyM/personalcook/blob/master/pic/1.PNG)
比大标题低一级的是中标题，也就是显示出来比大标题小点。 在文本下面加上 下划线 - ，那么上方的文本就变成了中标题，同样的 下划线个数无限制。<br>
![](https://github.com/edonyM/personalcook/blob/master/pic/2.png)
除此之外，你也会发现大，中标题下面都有一条横线，没错这就是 = 和 - 的显示结果。<br>
如果你只输入了等于号=，但其上方无文字，那么就只会显示一条直线。如果上方有了文字，但你又只想显示一条横线，而不想把上方的文字转义成大标题的话，那么你就要在等于号=和文字直接补一个空行。<br>
补空行：是很常用的用法，当你不想上下两个不同的布局方式交错到一起的时候，就要在两种布局之间补一个空行。<br>
 如果你只输入了短横线（减号）-，其上方无文字，那么要显示直线，必须要写三个减号以上。<br>
 不过与等于号的显示效果不同，它显示出来时虚线而不是实线。<br>
 同减号作用相同的还有星号*和下划线_，同样的这两者符号也要写三个以上才能显示一条虚横线。<br>
除此以外，关于标题还有等级表示法，分为六个等级，显示的文本大小依次减小。<br>
 不同等级之间是以井号  #  的个数来标识的。一级标题有一个 #，二级标题有两个# ，以此类推。
![](https://github.com/edonyM/personalcook/blob/master/pic/3.png)
注意井号#和标题名称要并排写作一行，显示效果如图：
![](https://github.com/edonyM/personalcook/blob/master/pic/4.png)
--------
##### 显示文本

输入的文字就是普通文本。需要注意的是要换行的时候不能直接通过回车来换行，需要使用/<br>(或者/<br/>)。<br>
也就是html里面的标签。事实上，markdown支持一些html标签，你可以试试。<br>
当然如果你完全使用html来写的话，就丧失意义了，毕竟markdown并非专门做前端的，然而仅实现一般效果的话，它会比html写起来要简洁得多得多啦。<br>

###### 单行文本

使用两个Tab符实现单行文本。<br>
###### 多行文本

多行文本和单行文本异曲同工，只要在每行行首加两个Tab。<br>
###### 部分文字的高亮

如果你想使一段话中部分文字高亮显示，来起到突出强调的作用，那么可以把它用 `  ` 包围起来。<br>
注意这不是单引号，而是Tab上方，数字1左边的按键（注意使用英文输入法）。<br>
###### 文字超链接

给一段文字加入超链接的格式是这样的[要显示的文字](链接的地址)。<br>
你还可以给他加上一个鼠标悬停显示的文本。即在URL之后 用双引号括起来一个字符串。同样要注意这里是英文双引号。<br>
--------
##### 插入符号
###### 圆点符

在GitHub的markdown语法里也支持使用圆点符。编辑的时候使用的是星号 *,要注意的是星号* 后面要有一个空格。否则显示为普通星号。此外还有二级圆点和三级圆点。就是多加一个Tab。

###### 缩进

缩进的含义是很容易理解的。

![](https://github.com/edonyM/personalcook/blob/master/pic/8.png)<br>
当然比这个更一般的用法是这样。常常能在书籍里面看到的效果，比如引用别人的文章。直接看效果。

![](https://github.com/edonyM/personalcook/blob/master/pic/9.png)<br>

##### 插入图片
###### 来源于网络的图片

叹号! + 方括号[]+ 括号()其中叹号里是图片的URL。如果不加叹号! ,就会变成普通文本baidu了。在方括号里可以加入一些 标识性的信息，比如:
        ![baidu](http://www.baidu.com/img/bdlogo.gif)

这个方括号里的baidu并不会对图像显示造成任何改动，如果你想达到鼠标悬停显示提示信息，那么可以仿照前面介绍的文本中的方法。

###### GitHub仓库里的图片

有时候我们想显示一个GitHub仓库(或者说项目)里的图片而不是一张其他来源网络图片因为其他来源的URL很可能会失效。那么如何显示一个GitHub项目里的图片呢？

其实与上面的格式基本一致的，所不同的就是括号里的URL该怎么写。

        https://github.com/ 你的用户名 / 你的项目名 / raw / 分支名 / 存放图片的文件夹 / 该文件夹下的图片

##### 给图片加上超链接

如果你想使图片带有超链接的功能，即点击一个图片进入一个指定的网页。那么可以这样写：

[![baidu]](http://www.baidu.com)
[baidu]:http://www.baidu.com/img/bdlogo.gif "Logo"

###### 插入代码片段

我们需要在代码的上一行和下一行用` `` 标记。``` 不是三个单引号，而是数字1左边，Tab键上面的键。要实现语法高亮那么只要在 ``` 之后加上你的编程语言即可(忽略大小写),c++可以写成c++或者cpp。

![](https://github.com/edonyM/personalcook/blob/master/pic/6.png)<br>

![](https://github.com/edonyM/personalcook/blob/master/pic/7.png)<br>
