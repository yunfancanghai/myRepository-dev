<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML >
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="css/icon.css">
    <link rel="stylesheet" type="text/css" href="css/easyui.css">
    <link rel="stylesheet" type="text/css" href="css/top.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/easyui.js"></script>
    <script>
        function init() {
           /* $("#menu_tree").treegrid({
                url: "findAllResources.do",
                idField: 'id',           //定义标识树节点的键名字段
                treeField: 'name',       //定义树节点的字段
                fit: true,               //网格自动撑满
                fitColumns: true,        //设置为 true，则会自动扩大或缩小列的尺寸以适应网格的宽度并且防止水平滚动。
                columns: [[
                    {field: 'name', title: '导航目录', width: 120}
                ]]
            });*/
            $("#menu_tree").treegrid({
                onClickRow:function (row) {
                    //判断是否存在
                    var had=$("#work").tabs("exists",row.name);
                    var node1=  JSON.stringify(row);
                   // alert(node1)
                    if(!had) {
                        $("#work").tabs("add", {
                            title: row.name,
                            closable: true,
                            href: row.path
                        });
                    }
                       else{
                        $("#work").tabs("select",row.name);
                    }
                }
            })
        }
        $(init);
    </script>
</head>
<body>
    <div class="easyui-layout" style="width: 100%;height:800px">
        <!--头部-->
        <div class="container" data-options="region:'north'" style="height:115px">
            <div class="logo"><a href="./index.html">X-ADMIN V1.1</a></div>
            <div class="open-nav"><i class="iconfont">&#xe699;</i></div>
            <ul class="layui-nav right" >
                <li class="layui-nav-item">
                    <div >
                        <span class="easyui-menubutton glyphicon glyphicon-user" data-options="menu:'#mm1'">admin</span>

                        <div id="mm1" style="width: 100px">
                            <!-- 二级菜单 -->
                            <div><a href="">个人信息</a></div>
                            <div><a href="">切换帐号</a></div>
                            <div><a href="">切换帐号</a></div>
                            <div><a href="">退出</a></div>
                        </div>
                    </div>
                </li>
                <li class="layui-nav-item"><a href="/">前台首页</a></li>
            </ul>

        </div>

        <!--导航栏-->
        <div data-options="region:'west',split:true" title="导航栏" style="width:220px;">
            <div id="menu_tree" class="easyui-treegrid" data-options="url: 'findAllResources.do',
				method: 'get',
				rownumbers: true,
				showFooter: true,
				 idField: 'id',
                treeField: 'name',
                columns: [[
                    {field: 'name', title: '导航目录', width: 120}
                ]]
				<%--treeField: 'region'--%>">


            </div>

        </div>

        <!--主界面-->
        <div data-options="region:'center',title:'主界面',iconCls:'icon-ok'">
            <div id="work" class="easyui-tabs">

            </div>
        </div>
        <!--底部-->
        <div data-options="region:'south',split:true" style="height:50px;">
        </div>
    </div>
</body>
</html>
