<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- 角色搜索框 -->
<div class="easyui-panel" title="搜索用户对应角色" style="width:100%;height:100px">
    <input class="easyui-searchbox" data-options="menu:'#choice',prompt:'请输入搜索账号',searcher:doSearch"/>
    <div id="choice">
        <div data-options="name:'users_account'">账号</div>
        <div data-options="name:'roles_name'">角色</div>
    </div>
</div>
<div id="roles"></div>
<!-- 添加角色框-->
<div id="addroles_window" class="easyui-window" style="width: 300px;height: 400px"
     data-options="closed:true,modal:true">
    <div style="width: 100%;height:100%;display:flex;justify-content:center;align-items:center">
        <form id="roles_form" action="/addRole.do">
            <input type="hidden" name="id"/>
            <input id="roles_name" type="text" name="roles_name" class="textbox" placeholder="角色名"/><br/>
            <input type="roles_status" name="roles_status" class="textbox" placeholder="是否开启角色"/>
        </form>
        <br/>

        <div>
            <a class="easyui-linkbutton" href="javascript:save()">保存</a>
        </div>
    </div>
</div>
<!-- 角色分配弹框 -->
<%--<div id="roles_window" class="easyui-window"
     style="width:300px;height:400px;" data-options="closed:true,modal:true">
    <ul id="roles_tree" class="easyui-tree"
        data-options="url:'findAllRole.do',checkbox:true">
    </ul>
    <div>
        <a class="easyui-linkbutton" href="javascript:dofenp()">分配</a>
    </div>
</div>--%>
<script type="text/javascript">
    function init() {
        $("#roles").datagrid({
            title: "角色管理",
            pagination: true,
            columns: [[
                {
                    field: "id",
                    title: "id",
                    checkbox: true
                },
                {
                    field: "roles_name",
                    title: "角色",
                    width: 100
                    /*formatter:function (value,row,index) {
                     return row.users.account;
                     }*/
                },
                 {
                     field: "users_account",
                     title:"账号"    ,
                     width:100,
                     formatter:function (value,row,index) {
                        // var jsons = JSON.stringify(row.user)
                      //return jsons;
                         if (row.user){
                             return row.user.users_account;
                         } else {
                             return value;
                         }
                      }

                 }
            ]],
        toolbar: [
            {
                text: "删除角色",
                iconCls: "icon-remove",
                handler: function () {
                    remove();
                }
            },
            {
                text: "添加角色",
                iconCls: "icon-add",
                handler: function () {
                    addRole();
                }
            }
            /*{
             text: "分配用户角色",
             iconCls: "icon-search",
             handler: function () {
             fenp();
             }
             }*/
        ]
    });
        load2(1, 5);
    }
    $(init);
    //加载数据
    function load2(p, size) {
        //获取服务端的json数据
        $.getJSON("findAllRoles.do", {
            page: p,
            pagesize: size
        }, function (d) {
            var jsons = JSON.stringify(d.allroles)
            // alert(jsons)
            var datas = d.allroles;
            //填充数据
            $("#roles").datagrid("loadData", datas);
            var pager = $("#roles").datagrid("getPager");
            pager.pagination({
                total: d.total,
                pageSize: 5,
                pageList: [5, 10],
                pageNumber: p,
                onSelectPage: function (page, size) {
                    load2(page, size);
                },
                beforePageText: '第',
                afterPageText: '页,共{pages}页',
                displayMsg: '共{total}条数据'
            });

        });
    }

    //删除
    function remove() {
        var data = $("#roles").datagrid("getSelections");
        var ids = [];
        for (var i = 0; i < data.length; i++) {
            ids[i] = data[i].id;
        }
        //数组转换为字符串
        var x = JSON.stringify(ids);
        //alert(x)
        //发送json数据
        $.ajax({
            url: "deleteRoles.do",
            method: "post",
            data: x,
            contentType: "application/json",
            success: function (d) {
                $.messager.alert("系统提示", d);
                load2(1, 5);
            }
        });
    }

    //添加角色
    function addRole() {
        $("#roles_form").form("clear");
        $("#roles_form").form("load", {
            id: "0",
        });
        $("#addroles_window").window("open");
    }
    function save() {
        //异步提交form表单
        $("#roles_form").form("submit", {
            success: function (d) {
                if (d == 0) {
                    $.messager.alert("系统提示", "成功添加用户");
                    //当添加完用户后，关闭该界面（窗口）
                    $("#addroles_window").window("close");
                    //再添加完新用户后重新加载数据
                    load2(1, 5);
                }
                if (d < 0) {
                    $.messager.alert("系统提示", "添加用户失败");

                }
            }
        });
    }

    /* // 分配角色
     function fenp() {
     $("roles_window").window("open");
     var user = $("#roles").datagrid("getSelected");
     //判断是否选择好账号
     if (user) {
     $("roles_window").window("open");
     } else {
     $.message.alert("系统提示", "请选择需要分配角色的账号");
     }
     }
     function dofenp() {
     //获取选择的用户
     var user = $("#roles").datagrid("getSelected");
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
     }*/
    //搜索
    function doSearch(key, type) {
        $.getJSON("search.do", {type: type, key: key}, function (d) {
            alert(key);
            if (d != null) {
                alert(d);
                $("#roles").datagrid("loadData", d);
            } else {
                //最好指定一个错误的页面，即发生异常时跳转的页面
                $.messager.alert("系统提示", "您的查询有误")
            }
        });

    }
</script>

