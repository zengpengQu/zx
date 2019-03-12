<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath =  path;
    pageContext.setAttribute("basePath", basePath);
%>

<title>履职支撑平台</title>
<link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/chosen.css"/>
<link type="text/css" rel="stylesheet" href="${basePath}/plugin/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>

<div class="row">
    <div class="col-xs-12">
        <div class="row">
            <div class="col-xs-12 widget-container-col ">
                <!-- #section:custom/widget-box -->
                <div class="accordion-style2 accordion">
                    <div class="group group-bottom">
                        <h5 class="group-header accordion-header" style="width: 160px;">
                            <span class="searchTj">
                                查询条件
                            </span>
                        </h5>

                        <div class="widget-body" style="border-top-width: 1px;background: #fff;">
                            <div class="widget-main" >
                                <div class="col-xs-12" >
                                    <form class="form-horizontal" id="searchForm">
                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label"
                                                           for="search-roleName">角色名称:</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" type="text" id="search-roleName">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4 pull-right" style="margin-top: 5px;margin-bottom: 5px">
                                                <div class="btn-group pull-right">
                                                    <button class="btn btn-success btn-sm" type="button"
                                                            id="searchBtn">
                                                        <span class="ace-icon fa fa-search icon-on-right bigger-110"></span>
                                                        查询
                                                    </button>
                                                    <button class="btn btn-warning btn-sm" type="button" id="resetBtn">
                                                        <span class="ace-icon fa fa-retweet icon-on-right bigger-110"></span>
                                                        重置
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /section:custom/widget-box -->
            </div>
        </div>
        <div class="row">
            <div class="space-10"></div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <c:forEach items="${curOperateAuth}" var="curOpertate">
                    <c:if test="${'43_1' eq  curOpertate}">
                        <div class="btn-group pull-right contacts-exportBtn">
                            <button class="btn btn-sm btn-success" id="add-new-role" style="top:6px;right:15px;">
                                <i class="ace-icon glyphicon glyphicon-user bigger-120"></i>
                                新增角色
                            </button>
                        </div>

                    </c:if>
                </c:forEach>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="header-table-th">角色信息浏览</div>
                <div class="table-content col-md-12">
                    <div class="col-md-12 jqgrid_box" style="padding: 0px;background: #fff;">
                        <table id="grid-table"></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <div id="new-role-dialog" class="hide">
            <div class="col-sm-7">
                <div class="widget-box widget-color-blue2" style="margin-top: 20px">
                    <div class="widget-header">
                        <h5 class="widget-title bigger lighter">
                            <i class="ace-icon fa fa-table"></i>
                            角色信息
                        </h5>
                    </div>
                    <div class="widget-body">
                        <div class="widget-main padding-8" style="height: 400px">
                            <form class="form-horizontal" id="new-role-form" role="form" method="post">
                                <input id="role-id" type="hidden">

                                <div class="form-group">
                                    <label class="col-xs-3 control-label">角色名称：<span class="red">*</span></label>

                                    <div class="col-xs-9 ">
                                        <input type="text" id="role-name" name="roleName" class="form-control remote"
                                               placeholder="角色名称"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3 control-label">角色描述：<span class="red">*</span></label>

                                    <div class="col-xs-9 ">
                                            <textarea class="form-control limited" id="role-dscr" name="dscr"
                                                      placeholder="角色描述"></textarea>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-5">
                <div class="widget-box widget-color-blue2" style="margin-top: 20px">
                    <div class="widget-header">
                        <h5 class="widget-title bigger lighter">
                            <i class="ace-icon fa fa-check-square-o "></i>
                            功能树
                        </h5>
                    </div>
                    <div class="widget-body">
                        <div class="widget-main padding-8" style="height: 400px">
                            <div class="scrollable" data-size="380" id="org">
                                <ul id="dic-role-list" class="ztree"></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.datepicker();
        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });


        //查询
        var $searchOrgId = $("#search-orgId");
        var $searchRoleName = $("#search-roleName");
        var $searchBtn = $("#searchBtn");


        var $addNewRole = $("#add-new-role");
        var $newRoleDialog = $("#new-role-dialog");
        var $newRoleForm = $("#new-role-form");
        var $orgId = $("#org-id");
        var $orgList = $("#dic-role-list");
        var $roleName = $("#role-name");
        var $dscr = $("#role-dscr");
        var $roleId = $("#role-id");
        //菜单设置
        var orgSetting = {
            data: {
                simpleData: {
                    enable: true,
                    idKey: "id",
                    pIdKey: "pId"
                }
            },
            check: {
                enable: true,
                chkboxType : {
                    "Y" : 'p',
                    "N" : 's'
                }
            }
        };

        //grid
        var $gridTable = $('#grid-table');

        var colModel = [
            {name: 'id', header: 'id', hidden: true},
            {name: 'orgId', header: 'orgId', hidden: true},
            {name: 'roleName', header: '角色名称',width:80},
            // {name: 'orgName', header: '所属机构', sortable: false},
            {name: 'roleDesc', header: '角色描述', sortable: false},
            {name: 'isactive', header: '激活状态', formatter: isActiveFormatter,width:80,align:'center'},
            {name: 'op', header: '操作', sortable: false, formatter: operationFormatter,width:80}

        ];

        function operationFormatter(cellvalue, options, rowData, action) {
            cellvalue = '';
            var isactive = rowData.isactive;
            var operations = [];
            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'43_2' eq  curOpertate}">
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple editRole">');
            operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
            operations.push('</button>');
            </c:if>
            <c:if test="${'43_3' eq  curOpertate}">
            if (isactive != 1) {
                operations.push(' <button class="btn btn-minier btn-white btn-pink isActive">');
                operations.push('<i class="ace-icon glyphicon glyphicon-ok"></i> 激活');
                operations.push('</button>');
            } else {
                operations.push(' <button class="btn btn-minier btn-white btn-danger isActive">');
                operations.push('<i class="ace-icon glyphicon glyphicon-remove"></i> 禁用');
                operations.push('</button>');
            }
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        //绑定标题点击触发时间轴浏览功能
        function titleFormatter(cellvalue, options, rowData, action) {
            var id = rowData.id;
            var roleName = rowData.roleName;
            var date_url = "page/user/detail?id=" + id;
            var operations = [];
            operations.push('<a class="blue" data-rel="tooltip" data-placement="top" data-url="' + date_url + '" href="#' + date_url + '">');
            operations.push('<span class="blue">' + roleName + '</span>');
            operations.push('</a>');
            cellvalue = operations.join('');
            return cellvalue;
        }

        function isActiveFormatter(cellvalue, options, rowData, action) {
            cellvalue = '';
            var isactive = rowData.isactive;

            var operations = [];

            if (isactive == '1') {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-success">已激活</span>');
            }
            else {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-warning">未激活</span>');

            }
            operations.push('</div>');
            cellvalue = operations.join('');
            return cellvalue;
        }

        $gridTable.tjGrid({
            loadUrl: '${basePath}/role/load.do',
            height: '100%',
            autowidth : true,
            colModel: colModel,
            // caption: "角色信息浏览",
            onSelectRow: function (id, stat, e) {
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }
                //删除
                if (className.indexOf('isActive') != -1) {
                    G.confirm({
                        message: '确定执行操作？',
                        callback: function (result) {
                            if (result) {
                                isActive(id);
                            }
                        }
                    })
                }
                if (className.indexOf('editRole') != -1) {
                    var rowData = $gridTable.jqGrid('getRowData',id);
                    var roleName = rowData.roleName;
                    var orgId = rowData.orgId;
                    var dscr = rowData.roleDesc;
                    $orgId.val(orgId);
                    $orgId.prop("disabled","disabled");
                    $roleName.val(roleName);
                    $dscr.val(dscr);
                    $roleId.val(id);
                    openNewDialog();
                }
            },
            gridComplete: function () {
                $('[data-rel="popover"]').popover({html: true});
                //调整表格宽度
                var parent_column = $gridTable.closest('[class*="col-"]');
                $gridTable.tjGrid("triggerResizeGrid");
                $gridTable.closest(".ui-jqgrid-bdiv").css({"width": parent_column.width() * 1.00093});
            }
        });
        $gridTable.tjGrid("triggerResizeGrid");
        function reloadGrid() {
            $gridTable.tjGrid('reloadGrid');
        }

        $searchBtn.click(function () {
            search();
        })

        var $searchForm = $("#searchForm");
        var $resetBtn = $("#resetBtn");
        $resetBtn.click(function () {
            $searchForm.resetForm();
            search();
        })

        function search() {
            var searchOrgId = $searchOrgId.val(),
                    searchRoleName = $searchRoleName.val();
            $gridTable.tjGrid('setPostData', {
                orgId: searchOrgId,
                roleName: searchRoleName
            });
            reloadGrid();
        }


        function isActive(id) {
            $.post('${basePath}/role/isActive.do', {id: id}, function (response) {
                if (response.result) {
                    reloadGrid();
                    G.showGritterSuccess();
                }
            })
        }

        $addNewRole.click(function () {
            openNewDialog();
        })

        function openNewDialog() {
            getRoleViewBy();
            $newRoleDialog.removeClass('hide').dialog({
                resizable: false,
                height: 600,
                width: 900,
                modal: true,
                close: function () {
                    $orgId.prop("disabled","");
                    $roleId.val('');
                    $newRoleForm.tjValidate('resetForm');
                },
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-fire green'></i> 新增/编辑角色</h4></div>",
                title_html: true,

                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-warning",
                        click: function () {
                            G.confirm({
                                message: '确定取消操作？',
                                callback: function (result) {
                                    if (result) {

                                        $newRoleDialog.dialog("close");
                                    }
                                }
                            })

                        }
                    },
                    {
                        html: "<i class='ace-icon glyphicon	glyphicon-tag  bigger-110'></i>&nbsp; 提交",
                        "class": "btn btn-success",
                        click: function () {
                            saveRole();
                        }
                    }
                ]
            });
        }

        //机构下拉
        $orgId.bind('change', function () {
            getRoleViewBy();
        });

        //获取机构菜单
        function getRoleViewBy(){
            var orgId = $orgId.val();
            var roleId = $roleId.val();
            loadRoleView(orgId, roleId);
        }

        //加载本机构权限菜单
        function loadRoleView(id, roleId) {
            $.post('${basePath}/role/getRoleViewByOrgId.do', {orgId: id, roleId: roleId}, function (response) {
                if (response.result) {
                    var viewIds = response.viewIds;
                    loadSelectDicOrg(viewIds);
                }
            })
        }

        //添加已经选中的菜单项
        function loadSelectDicOrg(viewIds) {
            $.fn.zTree.init($orgList, orgSetting, viewIds);
        }

        //表单校验
        $newRoleForm.tjValidate({
            focusInvalid: false,
            rules        : {
                roleName : {
                    required : true,
                    maxlength:100,
                    remote: {
                        url: "${basePath}/role/checkSecRole.do",
                        type: "post",               //数据发送方式
                        dataType: "json",           //接受数据格式
                        async: false,	        //防止重复提交
                        data: {                     //要传递的数据
                            checkValue: function () {
                                return $roleName.val()

                            },
                            id: function () {
                                return $roleId.val() == "" ? "" : $roleId.val();
                            },
                            orgId: function(){
                                return $orgId.val();
                            },
                            checkKey: "roleName"
                        }
                    },
                },
                dscr : {
                    required : true,
                    maxlength:255
                }
            },
            messages     : {
                roleName   : {
                    required : "角色名称必须填写",
                    remote:"角色名称重复!"
                },
                dscr   : {
                    required : "角色描述必须填写"
                }
            }
        });

        function clearPreviousValue(){
            if($(".remote").data("previousValue")){
                $(".remote").removeData("previousValue");
            }
        };
        //保存角色信息
        function saveRole(){
            var array = getCheckedRoleView();
            if($newRoleForm.validate().form()){
                if(array.length == 0){
                    G.alert({
                        message:"请选择角色权限！"
                    });
                    return;
                }else{
                    var roleName = $roleName.val();
                    var dscr = $dscr.val();
                    var roleId = $roleId.val();
                    var data = {
                        roleName:roleName,
                        dscr:dscr,
                        roleId:roleId,
                        array:array
                    };
                    G.confirm({
                        message  : '确定保存操作？',
                        callback : function (result) {
                            if (result) {

                                $.post('${basePath}/role/saveRoleView.do',data,function(response){
                                    if(response.result){
                                        G.showGritterSuccess();
                                        $newRoleDialog.dialog('close');
                                        reloadGrid();
                                        $newRoleForm.tjValidate('resetForm');
                                        clearPreviousValue();
                                    }
                                },'json')
                            }
                        }
                    })

                }
            }

        }

        //滚动条
        $('.scrollable').each(function () {
            var $this = $(this);
            $(this).ace_scroll({
                size: $this.attr('data-size') || 100
            });
        });

        //获取角色选择权限
        function getCheckedRoleView(){
            var treeObj = $.fn.zTree.getZTreeObj("dic-role-list");
            var nodes = treeObj.getCheckedNodes();
            var array = [];
            for(var i=0, l=nodes.length; i<l; i++){
                var node = nodes[i];
                array.push(node.id);
            }
            return array;
        }

        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy('#grid-table');
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

    });
</script>