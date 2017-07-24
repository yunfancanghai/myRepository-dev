<%@ page contentType="text/html;charset=UTF-8" import="java.util.*" language="java" %>

<div class="easyui-panel" title="搜索" style="width:100%;height:80px">
    <input class="easyui-searchbox" data-options="menu:'#choice',prompt:'输入搜索关键字',searcher:doSearch"/>
    <div id="choice">
        <div data-options="name:'users_account'">账号</div>
        <div data-options="name:'users_pwd'">密码</div>
    </div>
</div>

<div id="user_main"></div>
<!-- 角色分配弹框 -->
<div id="roles_window" class="easyui-window"
     style="width:300px;height:400px;" data-options="closed:true,modal:true">
    <ul id="roles_tree" class="easyui-tree"
        data-options="url:'findAllRoles.do',checkbox:true">
    </ul>
    <div data-options="required:true,validType:'users_account'">
        <input type="text" name="roles_name" class="easyui-validatebox"/><br/>
        <a class="easyui-linkbutton" href="javascript:dofenp()">分配</a>
    </div>
</div>
<%--添加用户--%>
<div id="user_windows" class="easyui-window"
     style="width:400px;height:500px;" data-options="closed:true,modal:true,title:'添加用户'">
    <div style="width: 100%;height:100%;display:flex;justify-content:center;align-items:center;background-color: greenyellow;">
        <form id="user_form" action="addUsers.do" method="post">
            <input type="hidden" name="id"/>
            &nbsp;&nbsp;用 &nbsp;户&nbsp;名:<input type="text" name="users_account" class="easyui-validatebox"
                                                data-options="required:true,validType:'users_account'"/><br/>
            <br/>
            &nbsp;&nbsp;密 &nbsp;&nbsp;&nbsp;&nbsp;码:<input id="users_pwd" type="password" name="users_pwd"
                                                           class="easyui-validatebox"
                                                           data-options="required:true"/><br/>
            再次确认密码:<input id="rusers_pwd" type="password" name="rusers_pwd" class="easyui-validatebox"
                          required="required" validType="equals['#users_pwd']"/><br/>
            <br/>
            <div>
                <a class="easyui-linkbutton" href="javascript:saveUser()">保存</a>
            </div>
        </form>
    </div>
</div>
<%--修改用户--%>
<div id="users_windows" class="easyui-window"
     style="width:400px;height:500px" data-options="closed:true,modal:true,title:'修改用户'">
    <div style="width: 100%;height:100%;display:flex;justify-content:center;align-items:center;background-color: greenyellow;">
        <form id="users_form" action="updateUsers.do" method="post">
            <input type="hidden" name="id"/>
            用户名:<input type="text" name="users_account"/><br/>
            <br/>
            密 &nbsp;&nbsp;码:<input type="password" name="users_pwd"/><br/>
            <br/>
            <div>
                <a class="easyui-linkbutton" href="javascript:saveUsers()">保存</a>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
    function init() {
        $("#user_main").datagrid({

            pagination: true,
            columns: [[
                {
                    field: "id",
                    title: "序号",
                    checkbox: true,
                    width: 80
                },
                {
                    field: "users_account",
                    title: "账号",
                    width: 100
                },
                {
                    field: "roles_name",
                    title: "角色",
                    width: 100
                }

            ]],
            toolbar: [
                {
                    text: "添加",
                    iconCls: "icon_add",
                    handler: function () {
                        addUsers();
                    }
                },
                {
                    text: "删除",
                    iconCls: "icon_remove",
                    handler: function () {
                        removeUsersByStatus();
                    }
                },
                {
                    text: "修改",
                    iconCls: "icon_edit",
                    handler: function () {
                        updateUsers();
                    }
                },
                {
                    text: "分配用户角色",
                    iconCls: "icon-search",
                    handler: function () {
                        fenp();
                    }
                }
            ]

        })
        ;
        load1(1, 5);
    }
    //数据加载
    function load1(page, pagesize) {
        $.getJSON("findAllUsers.do", {
            page: page,
            pagesize: pagesize
        }, function (d) {
            //解析json字符串
            var json = JSON.stringify(d.users);
            var datas = d.users;
            //填充数据
            $("#user_main").datagrid("loadData", datas);
            //获取分页组件
            var pager = $("#user_main").datagrid("getPager");
            pager.pagination({
                total: d.total,
                pageSize: pagesize,
                pageList: [5, 10, 20],
                pageNumber: page,
                onSelectPage: function (page, pagesize) {

                    load1(page, pagesize);
                },
                beforePageText: '第',
                afterPageText: '页  共{pages}页',
                displayMsg: '共 {total} 条记录',

            });
        });
    }
    //        添加用户的操作
    function addUsers() {
        $("#user_form").form("clear");
        $("#user_form").form("load", {
            id: 0
        });
        $("#user_windows").window("open");
    }
    function saveUser() {
        $("#user_form").form("submit", {
            success: function (xhr) {
                alert(xhr);
                if (xhr == 0) {
                    $.messager.alert("系统提示", "成功添加用户");
                    //再添加完新用户后重新加载数据
                    load1(1, 5);
                    //当添加完用户后，关闭该界面（窗口）
                    $("#user_windows").window("close");
                }
                if (xhr < 0) {
                    $.messager.alert("系统提示", "添加用户失败");

                }
            }
        });
    }
    //        删除用户的操作，一次可以删除多条
    function removeUsersByStatus() {
        //获取选择删除的数据
        var data = $("#user_main").datagrid("getSelections");
        //把得到的数据id放入数组
        var ids = [];
        for (i = 0; i < data.length; i++) {
            ids[i] = data[i].id;
        }
        //把ids数组封装成json数据
        var romveUserId = JSON.stringify(ids);
        $.ajax({
            url: "removeUsersByStatus.do",
            method: "post",
            data: romveUserId,
            contentType: "application/json",
            success: function (d) {
                $.messager.alert("系统提示", d);
                //删除完用户后，重新加载页面
                load1(1, 5);
            }
        });
    }
    //对用户进行修改操作
    function updateUsers() {
        var dataUsers = $("#user_main").datagrid("getSelected");
        $("#users_form").form("load", {
            id: dataUsers.id,
            users_account: dataUsers.users_account,
            users_pwd: dataUsers.users_pwd,

        });
        $("#users_windows").window("open");
    }
    function saveUsers() {
        alert("修改1");
        $("#users_form").form("submit", {
            success: function (xhr) {
                alert("修改2" + xhr);
                if (xhr == 1) {
                    $.messager.alert("系统提示", "修改用户成功");
                    //再修改完用户数据后重新加载数据
                    load1(1, 5);
                    //当添加完用户后，关闭该界面（窗口）
                    $("#users_windows").window("close");
                }
                if (xhr == -1) {
                    $.messager.alert("系统提示", "用户修改失败");
                }
            }
        });
    }
    //搜索
    function doSearch(key, type) {
        $.getJSON("searchUsersBylike.do", {type: type, key: key}, function (d) {
            alert(key);
            if (d != null) {
                $("#user_main").datagrid("loadData", d);
            } else {
                //最好指定一个错误的页面，即发生异常时跳转的页面
                $.messager.alert("系统提示", "服务器崩溃了")
            }

        });
    }

    // 分配用户角色
    function fenp() {
        $("#roles_window").window("open");
        var user = $("#user_main").datagrid("getSelected");
        //判断是否选择好账号
        if (user) {
            $("roles_window").window("open");
        } else {
            $.message.alert("系统提示", "请选择需要分配角色的账号");
        }
    }
    function dofenp() {
        //获取选择的用户
        var user = $("#user_main").datagrid("getSelected");
        //获取用户选择的角色
        var data = $("#roles_tree").tree("getChecked");
        var as = [user.id];
        for (i = 0; i < data.length; i++) {
            as[i + 1] = data[i].id;
        }
        //将数组转化为json字符串
        var json = JSON.stringify(as);
        $.ajax({
            url: "fenp.do",
            method: "post",
            data: json,
            contentType: "application/json",
            //服务端返回的数据
            success: function (d) {
                //刷新页面重新加载用户的角色
                window.location.reload();
                alert(d);
            }
        });
    }
    $(init);
</script>

