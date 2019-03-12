<%--
  Created by IntelliJ IDEA.
  User: sy
  Date: 2018/7/6
  Time: 11:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>
<title>履职支撑平台</title>

<style>
    .left{
        float:left;
        width:30%;
        height:100%;
    }
    .right{
        float:right;
        width:70%;
        height:100%;
        margin-right: -300px;
    }
</style>

<div class="row">
    <div class="col-sm-2" style="padding-right: 8px;">
        <div class="widget-box widget-color-blue2">
            <div class="widget-header">
                <h4 class="widget-title lighter smaller H4-font-Size">通讯录</h4>
            </div>

            <div class="widget-body">
                <div class="widget-main" style="padding: 12px 0px;">
                    <ul id="contacts_tree1" class="ztree" style="min-height: 500px;max-height: 700px;overflow:auto"></ul>
                </div>
            </div>
        </div>
    </div>

    <div class="col-sm-10" style="padding-left: 0px;">
        <div class="row">
            <div class="col-xs-12">
                <div class="row">
                    <div class="col-xs-12 widget-container-col ">
                        <!-- #section:custom/widget-box -->
                        <div class="accordion-style2 accordion">
                            <div class="group group-bottom" style="margin-top: 3px;">
                                <h5 class="group-header accordion-header" style="width: 160px;">
                                        <span class="searchTj">
                                            查询条件
                                        </span>
                                </h5>

                                <div class="widget-body" style="border-top-width: 1px;background: #fff;">
                                    <div class="widget-main">
                                        <div class="col-xs-12">
                                            <form class="form-horizontal" role="form" id="searchForm">
                                                <input class="hide" value="-1" id="form-field-addressTeamId" name="addressTeamId">
                                                <div class="row">

                                                    <div class="col-xs-4">
                                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">

                                                            <label  class="col-xs-4 control-label no-padding-left"
                                                                   for="form-field-deptId">部  门：</label>
                                                            <div class="col-sm-8 deptDiv">
                                                                <input type="text" id="form-field-deptId" name="deptId"
                                                                       class="hide" value="${curDept.id}"/>
                                                                <input type="text" class="form-control" id="form-field-deptName"
                                                                       name="" value="${curDept.absName}" style="cursor: pointer;" readonly="readonly"/>
                                                            </div>

                                                        </div>
                                                    </div>

                                                    <div class="col-xs-4">
                                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                            <label class="col-sm-4 control-label"
                                                                   for="form-field-location">办公室:</label>

                                                            <div class="col-sm-8 ">
                                                                <input class="form-control" type="text" id="form-field-location" name="location">
                                                               <%-- <select class="form-control" id="form-field-deptId"
                                                                        <c:if test="${currentUser.dicDept.id ne '434'}">readonly="readonly"
                                                                        style="background-color: #eeeeee" </c:if>
                                                                        name="deptId">
                                                                    <option value="">-----请选择-----</option>
                                                                    <c:forEach items="${deptList}" var="dept">
                                                                        <option value="${dept.id}"
                                                                                <c:if test="${dept.id eq currentUser.dicDept.id and dept.id ne '434'}">
                                                                                selected</c:if>>${dept.deptName}</option>
                                                                    </c:forEach>
                                                                </select>--%>
                                                            </div>
                                                        </div>
                                                    </div>

                                                   <%-- <div class="col-xs-3">
                                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                            <label class="col-xs-4 control-label no-padding-left"
                                                                   for="form-field-proTypeId">职务：</label>

                                                            <div class="col-xs-8 ">
                                                                <input class="form-control" type="text" id="form-field-proTypeId">
                                                            </div>
                                                        </div>
                                                    </div>--%>
                                                    <%--<div class="col-xs-3">
                                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                            <label class="col-xs-4 control-label no-padding-left"
                                                                   for="form-field-name">姓  名：</label>

                                                            <div class="col-xs-8 ">
                                                                <input class="form-control" type="text" id="form-field-name" name="name">
                                                            </div>
                                                        </div>
                                                    </div>--%>
                                                    <div class="col-xs-4 pull-right"
                                                         style="margin-top: 5px;margin-bottom: 5px">
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

                                                <div class="row">

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
                    <div class="col-xs-12">
                        <div class="btn-group pull-right contacts-exportBtn " >
                           <c:forEach items="${curOperateAuth}" var="curOpertate">
                                <c:if test="${'48_11' eq curOpertate}">

                               <button class="btn btn-sm btn-white btn-primary " id="exportBtn"
                                       style="float: right;margin-bottom: 5px; overflow: hidden;">
                                   <i class="ace-icon glyphicon glyphicon-export icon-on-right bigger-110"></i>
                                   导出通讯录
                               </button>

                                </c:if>
                            </c:forEach>
                        </div>
                        <%--<div class="pull-right">--%>
                            <%--<i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue bigger-150 mar_r_10 mar_t_5"></i>--%>
                        <%--</div>--%>
                    </div>
                </div>

                <div class="row" id="dept-hide">
                    <div class="col-xs-12">
                        <div class="header-table-th">通讯录信息浏览</div>
                        <div class="table-content  col-md-12">
                            <table id="grid-table-dep"></table>
                        </div>

                    </div>
                </div>

                <div class="row">
                    <div class="space-10"></div>
                </div>

            </div>
        </div>
    </div>
</div>

<%--人员信息查看弹出框--%>
<div id="view-user-dialog" class="hide">
    <div class="row">
        <div class="col-xs-12">
            <div class="profile-user-info profile-user-info-striped">
                <div class="profile-info-row">
                    <div class="profile-info-name"> 姓名</div>

                    <div class="profile-info-value">
                        <span class="editable" id="name"></span>
                    </div>

                    <div class="profile-info-name"> 部门</div>

                    <div class="profile-info-value">
                        <span class="editable" id="department"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 所属单位</div>

                    <div class="profile-info-value">
                        <span class="editable" id="orgName"></span>
                    </div>

                    <div class="profile-info-name"> 职务</div>

                    <div class="profile-info-value">
                        <span class="editable" id="proTypeId"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 手机号码</div>

                    <div class="profile-info-value">
                        <span class="editable " id="mobile"></span>
                    </div>

                    <div class="profile-info-name"> 邮箱</div>

                    <div class="profile-info-value">
                        <span class="editable " id="email"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 办公室</div>

                    <div class="profile-info-value">
                        <span class="editable " id="location"></span>
                    </div>

                    <div class="profile-info-name"> 办公电话</div>

                    <div class="profile-info-value">
                        <span class="editable " id="jobTel"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 秘书姓名</div>

                    <div class="profile-info-value">
                        <span class="editable " id="secName"></span>
                    </div>

                    <div class="profile-info-name"> 秘书电话</div>

                    <div class="profile-info-value">
                        <span class="editable " id="secMobile"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 司机姓名</div>

                    <div class="profile-info-value">
                        <span class="editable " id="driName"></span>
                    </div>

                    <div class="profile-info-name"> 司机电话</div>

                    <div class="profile-info-value">
                        <span class="editable " id="driMobile"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 创建时间</div>

                    <div class="profile-info-value">
                        <span class="editable " id="createTime"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>



</div>

<%-- ztree添加修改--%>
<div id="edit-dialog" class="hide"></div>
<div id="update-dialog" class="hide"></div>

<%-- 新增编辑 页面跳转 隐藏div  通讯录，用户，部门--%>
<div id="user-edit-dialog" class="hide"></div>
<div id="dept-edit-dialog" class="hide"></div>

<%-- ztree右键菜单--%>
        <ul id="rMenu">
            <li class="ui-state-disabled ui-menu-item">请选择</li>
            <c:forEach items="${curOperateAuth}" var="curOpertate">
                <c:if test="${'48_1' eq curOpertate}">
                    <li id="onclickAddTree" >添加通讯录分组</li>
                </c:if>
                <c:if test="${'48_2' eq curOpertate}">
                    <li id="onclickDelTree" >删除通讯录分组</li>
                </c:if>
                <c:if test="${'48_3' eq curOpertate}">
                    <li id="onclickUpTree" >修改通讯录分组</li>
                </c:if>
                <c:if test="${'48_4' eq curOpertate}">
                    <li id="onclickLoadTree" >添加部门信息</li>
                </c:if>
            </c:forEach>
        </ul>
<style>
    #rMenu {
        position: absolute;
        z-index: 2222;
        visibility: hidden;
        top:0;
        text-align: left;
        padding: 4px;
    }
    #rMenu a{
        padding:3px 15px 3px 15px;
        background-color: #cad4e6;
        vertical-align: middle;
    }
</style>

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


        var curOperateAuth = '${curOperateAuth}';

        if (curOperateAuth.indexOf('48_12') !== -1) {

            G.initDept('deptDiv',true,['{}'],TREE_NODE);
        } else {
            G.initDept('deptDiv',false,['${curDept}'],TREE_NODE);
        }

        var initParam = G.initGridParam($("#searchForm"));




        //部门表格
        var $userEditDialog = $("#user-edit-dialog");
        var $viewUser = $("#view-user-dialog");
        $( "#rMenu" ).menu();
        var $gridTableDep = $("#grid-table-dep");
        //user添加弹出框
        var $deptIdd = 0;
        var $deptEditDialog = $("#dept-edit-dialog");
        //user添加按钮
        //导出
        var $exportBtn = $("#exportBtn");
        //存放用户选择的表格列
        var item_selected = [];

        //页面跳转URL
        //var toUserEditUrl = '${basePath}/contacts/contacts-edit-user.do';
        var toDeptEditUrl = '${basePath}/contacts-dep/contacts-edit-dept.do';

        //查询条件
        var $deptName = $("#form-field-deptName");
        var $location = $("#form-field-location");
        var $deptId = $("#form-field-deptId");
        var $addressTeamId = $("#form-field-addressTeamId");
        //重置按钮
        var $resetBtn = $("#resetBtn");
        //查询表单
        var $searchForm = $("#searchForm");
        //查询按钮
        var $searchBtn = $("#searchBtn");

        $("#onclickAddTree").click(function(){ exupDate("add");});
        $("#onclickUpTree").click(function() {exupDate("up");});
        $("#onclickDelTree").click(function() {exupDate("del");});
        $("#onclickLoadTree").click(function() { exupDate("load");});
        var loadUrl = '${basePath}/contacts/load-contacts-list.do';
        //var deleteUrl = '${basePath}/contacts/contacts-delete.do';

        var loadDepUrl = '${basePath}/contacts-dep/load-contacts-depList.do';
        var deleteDepUrl = '${basePath}/contacts-dep/contacts-delete.do';

        var colModelDep = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'deptName', header: '部门', index: 'deptName',sortable: false},
            {name: 'orgName', header: '所属单位名称',  hidden: true,index: 'orgName',hidden: true,sortable: false},
            {name: 'location', header: '办公室', index: 'location',sortable: false},
            {name: 'deptJobTel', header: '办公电话', index: 'deptJobTel',sortable: false},
            //隐藏属性
            {name: 'deptId', header: '单位', index: 'dicDept.id',hidden: true},
            {name: 'teamId', header: '分组编码', index: 'addressTeam.id',hidden: true},
            {name: 'seq', header: '排序', index: 'seq', hidden: true,sortable: true},
            {name: 'delFlag', header: '删除标志', index: 'delFlag',hidden: true},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width:200,
                fixed: true,
                formatter: BasicOperationFormatter
            }
        ];

        function BasicOperationFormatter(cellvalue, options, rowData, action) {

            var operations = [];

            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'48_5' eq curOpertate}">
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-primary row-record-edit">');
            operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
            operations.push('</button>');

            </c:if>
            <c:if test="${'48_6' eq curOpertate}">

            operations.push(' <button class="btn btn-minier btn-white btn-primary row-record-delete">');
            operations.push(' <i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
            operations.push('</button>');

            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        function BasicOperationFormatterUser(cellvalue, options, rowData, action) {

            var operations = [];
            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'48_8' eq curOpertate}">
            operations.push(' <button class="btn btn-minier btn-white btn-primary row-record-chak-user">');
            operations.push(' <i class="ace-icon glyphicon glyphicon-zoom-out blue row-record-chak-user"></i> 查看');
            operations.push('</button>');

            </c:if>
            <c:if test="${'48_9' eq curOpertate}">
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-primary row-record-edit-user">');
            operations.push('<i class="ace-icon fa fa-pencil blue row-record-edit-user"></i> 编辑');
            operations.push('</button>');

            </c:if>
            <c:if test="${'48_91' eq curOpertate}">

            operations.push(' <button class="btn btn-minier btn-white btn-primary row-record-delete-user">');
            operations.push(' <i class="ace-icon orange fa fa-trash-o blue row-record-delete-user"></i> 删除');
            operations.push('</button>');

            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }
        var openSubgridTableId = "";
        //部门表格数据加载
        $gridTableDep.tjGrid({
            initParam:initParam,
            subGrid : true,
            subGridOptions : {
                plusicon : "ace-icon fa fa-plus center bigger-110 blue",
                minusicon  : "ace-icon fa fa-minus center bigger-110 blue"
                //openicon : "ace-icon fa fa-chevron-right center orange"
            },
            loadUrl: loadDepUrl,
            height: '100%',
            width:'100%',
            autowidth: true,
            colModel: colModelDep,
            sortname: 't.dicDept.id',
            sortorder: 'asc',
            multiselect: true,
            // caption: "部门通讯录信息浏览",
            subGridRowExpanded: function (subgridDivId, rowId) {
                var subgridTableId = subgridDivId + "_t";
                //添加按钮的Class
                var subTableAddUser = "subTableAddUser"+subgridDivId + "_c";
                var str = "";
                str += "<div style='margin-left: -25px;margin-top: 30px;margin-right: 70px;margin-bottom: 30px;'><div class='row'>" +
                    "   <div class='col-xs-12'>" +
                    "       <div class='btn-group pull-right contacts-exportBtn ' >";
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                    <c:if test="${'48_7' eq curOpertate}">
                str +="           <button class='btn btn-sm btn-white btn-primary "+subTableAddUser+"'" +
                    "                   id='exportBtn' " +
                    "                   style='float: right;margin-top: -6px;margin-right: 10px; border-radius: 8px;overflow: hidden;'>" +
                    "           <i class='ace-icon fa fa-plus icon-on-right bigger-110'></i>" +
                    "               新增人员通讯录信息 " +
                    "           </button>" ;
                    </c:if>
                    </c:forEach>
                str +=  "       </div>" +
                    "   </div>" +
                    "</div>" +
                    "<div class='row'>" +
                    "   <div class='col-xs-12'>" +
                    "       <div class='header-table-th'><span style='color:darkolivegreen'>通讯录人员信息浏览</span></div>" +
                    "               <div class='table-content col-md-12'>" +
                    "                   <table id='" + subgridTableId + "' >" ;
                str +=   "               </table></div>" +
                    "       </div>" +
                    "   </div>" +
                    "</div></div>";
            $("#" + subgridDivId).html(str);
                var item_selecteds = [];
                $("#"+subgridTableId).jqGrid({
                    url:loadUrl,
                    height: '100%',
                    width:'100%',
                    autowidth: true,
                    colNames:['id','姓名','职务','手机号码','所属单位','部门','办公电话', '办公室','邮箱',
                        '秘书姓名','秘书电话','司机姓名','司机电话','创建时间','基本操作'],
                    colModel: [
                        {name: 'id', index: 'id',hidden: true},
                        {name: 'name', index: 'name',sortable: false},
                        {name: 'proTypeId', index: 'proTypeId',sortable: false},
                        {name: 'mobile', index: 'mobile',sortable: false},
                        {name: 'orgName', index: 'orgName',sortable: false},

                        {name: 'department', index: 'department',hidden: true},
                        {name: 'jobTel', index: 'jobTel',hidden: true},
                        {name: 'location', index: 'location',hidden: true},
                        {name: 'email', index: 'email',hidden: true},
                        {name: 'secName', index: 'secName',hidden: true},
                        {name: 'secMobile', index: 'secMobile',hidden: true},
                        {name: 'driName', index: 'driName',hidden: true},
                        {name: 'driMobile', index: 'driMobile',hidden: true},
                        {name: 'createTime', index: 'createTime',hidden: true},

                        {
                            name: 'basic',
                            sortable: false,
                            width:220,
                            fixed: true,
                            formatter: BasicOperationFormatterUser
                        }
                        ],
                    postData: {
                        id: rowId
                    },
                    onSelectRow: function (id, stat, e) {
                        var table =  $("#"+subgridTableId);
                        if (e == undefined) {
                            return false;
                        }
                        var className = $(e.target).attr('class');

                        if (!className) {
                            return false;
                        }
                        var rowData = table.jqGrid('getRowData', id);
                        //查看
                        if (className.indexOf('row-record-chak-user') !== -1) {
                            viewUser(rowData);
                        } else if (className.indexOf('row-record-delete-user') !== -1) {
                            G.confirm({
                                message: '确认删除此条部门通讯录信息吗？',
                                callback: function (result) {
                                    if (result) {
                                        $.post('${basePath}/contacts/contacts-delete.do', {id: id}, function (data) {
                                            if (data.result) {
                                                G.showGritterSuccess("删除成功");
                                                table.trigger("reloadGrid");
                                            }
                                        });
                                    }
                                }
                            });
                        } else if (className.indexOf('row-record-edit-user') !== -1) {
                            userEditAddressList(id,0,subgridTableId);
                        }
                    },
                    gridComplete: function () {
                        var _this = this;
                        if (item_selecteds.length > 0) {
                            for (var i = 0; i < item_selecteds.length; i++) {
                                $(_this).tjGrid('setSelection', item_selecteds[i]);
                            }
                        }
                        //调整表格宽度
                        var $subGridTable = $("#"+subgridTableId);
                        var parent_column = $subGridTable.closest('[class*="col-"]');
                        $subGridTable.tjGrid("triggerResizeGrid");
                        $subGridTable.closest(".ui-jqgrid-bdiv").css({"width": parent_column.width() * 1.00093});
                    },
                    onSelectAll: function (aRowIds, status) {
                        if (status) {
                            item_selecteds = _.union(item_selecteds, aRowIds);
                        } else {
                            item_selecteds = _.difference(item_selecteds, aRowIds);
                        }
                    }
                });
                //添加
                $("."+subTableAddUser).click(function () {
                   userAdd(subgridTableId,rowId);
                });

            },
            onSelectRow: function (id, stat, e) {
                if (e == undefined) {
                    return false;
                }
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }
                var rowData = $gridTableDep.jqGrid('getRowData', id);
                //查看
                if (className.indexOf('row-record-view') !== -1) {
                   // viewDept(rowData);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条部门通讯录信息吗？',
                        callback: function (result) {
                            if (result) {
                                $.post(deleteDepUrl, {id: id}, function (data) {
                                    if (data.result) {
                                        $gridTableDep.tjGrid('reloadGrid');
                                    }
                                });
                            }
                        }
                    });
                } else if (className.indexOf('row-record-edit') !== -1) {
                    deptEditAddressList(id,"0");
                }
            },
            gridComplete: function () {
                var _this = this;
                if (item_selected.length > 0) {
                    for (var i = 0; i < item_selected.length; i++) {
                        $(_this).tjGrid('setSelection', item_selected[i]);
                    }
                }
                //调整表格宽度
                var parent_column = $gridTableDep.closest('[class*="col-"]');
                $gridTableDep.tjGrid("triggerResizeGrid");
                $gridTableDep.closest(".ui-jqgrid-bdiv").css({"width": parent_column.width() * 1.00093});
            },
            onSelectAll: function (aRowIds, status) {
                if (status) {
                    item_selected = _.union(item_selected, aRowIds);
                } else {
                    item_selected = _.difference(item_selected, aRowIds);
                }
            },
            beforeSelectRow: function (rowId,e) {
                var index = _.indexOf(item_selected, rowId);
                if (index == -1) {
                    item_selected.push(rowId);
                } else {
                    item_selected = _.pull(item_selected, rowId);
                }
            }
        });
        $gridTableDep.tjGrid("triggerResizeGrid");

        //查看按钮
        function viewUser(rowData) {
            //为弹出框赋值
            $viewUser.find('.editable').each(function () {
                $(this).html(rowData[$(this).attr('id')]);
            });
            initViewDialog($viewUser);
        }
        //初始化查看通讯录用户
        function initViewDialog($container) {
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'>" +
                "<h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>" +
                "查看通讯录用户信息</h4></div>",
                title_html: true,
                close: function () {
                    $container.addClass("hide");
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 确定",
                        "class": "btn btn-success",
                        click: function () {
                            $(this).dialog("close");
                        }
                    }
                ]
            });

        }
        //新增 subgridTableId表格的ID ，row1点击+号时 当前行的部门信息ID
        function userAdd(subgridTableId,row1) {
            userEditAddressList("",row1,subgridTableId);
        }

        //  编辑 用户通讯信息，id（用户信息ID）新增时ID为""，psId(当前行的部门信息ID，编辑时 psId为‘0’)
        //  subgridTableId(新增时为 表格ID)，编辑时为当前td的ID，用来显示编辑后的数据显示
        function userEditAddressList(id,psId,subgridTableId) {
            var loadId = G.showAjaxLoading();
            $.ajax({
                url: "${basePath}/contacts/contacts-edit-user.do",
                type: "GET",
                data: {id: id,psId:psId},
                dataType: "html",
                success: function (String) {
                    $userEditDialog.html(String);
                    G.doneAjaxLoading(loadId);
                    //初始化弹出框
                    initUserEditDialog($userEditDialog,subgridTableId,id);
                },
                error: function () {
                    G.doneAjaxLoading(loadId);
                    G.alert({message: "操作失败！"});
                }
            });
        }
        //用户页面初始化
        //id为当前用户ID 即表格td的ID
        //  subgridTableId(新增时为 表格ID)，编辑时为当前td的ID，用来显示编辑后的数据显示
        var enablePeopleClick = true;
        function initUserEditDialog($container,subgridTableId,id) {
            var $form = $("#saveForm");
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'>" +
                "<i class='ace-icon fa  fa-globe green'></i>添加/修改 人员通讯录信息</h4></div>",
                title_html: true,
                close: function () {
                    $container.empty();
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-warning",
                        click: function () {
                            $container.dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 提交",
                        "class": "btn btn-success",
                        click: function () {
                            if ($form.validate().form()) {
                                if (enablePeopleClick) {
                                    enablePeopleClick = false;
                                    $form.ajaxSubmit({
                                        success: function (map) {
                                            enablePeopleClick = true;
                                            if (map.result) {
                                                G.showGritterSuccess("用户通讯录信息已保存!");
                                                $container.dialog("close");
                                                //更新表格数据
                                                var table =  $("#"+subgridTableId);
                                                table.trigger("reloadGrid");
                                            } else {
                                                G.showGritterFail("信息提交失败,请稍后重试!");
                                            }
                                        },
                                        error: function () {
                                            enablePeopleClick = true;
                                        }
                                    });
                                }
                            }
                        }
                    }
                ]
            });
        }


        //新增  编辑通讯信息（部门）
        function deptEditAddressList(id,psId) {
            var loadId = G.showAjaxLoading();
            $.ajax({
                url: toDeptEditUrl,
                type: "GET",
                data: {id: id,psId:psId},
                dataType: "html",
                success: function (String) {
                    $deptEditDialog.html(String);
                    G.doneAjaxLoading(loadId);
                    //初始化弹出框
                    initDeptEditDialog($deptEditDialog);
                },
                error: function () {
                    G.doneAjaxLoading(loadId);
                    G.alert({message: "操作失败！"});
                }
            });
        }

        var enableClick = true;
        function initDeptEditDialog($container) {
            var $form = $("#saveForm");
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'>" +
                "</i>添加/修改 部门通讯录信息</h4></div>",
                title_html: true,
                close: function () {
                    $container.empty();
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-warning",
                        click: function () {
                            $container.dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 提交",
                        "class": "btn btn-success",
                        click: function () {
                            if ($form.validate().form()) {
                                if (enableClick) {
                                    enableClick = false;
                                    $form.ajaxSubmit({
                                        success: function (map) {
                                            enableClick = true;
                                            if (map.result) {
                                                G.showGritterSuccess("保存成功!");
                                                $container.dialog("close");
                                                //更新表格数据
                                                var timid = map.teamId;
                                                $gridTableDep.tjGrid('setPostData', {
                                                    addressTeamId: timid
                                                });
                                                reloadGrid();
                                                G.search($searchForm, $gridTableDep);
                                            } else {
                                                G.showGritterFail("保存失败,请稍后重试!");
                                            }
                                        },
                                        error: function () {
                                            enableClick = true;
                                        }
                                    });
                                }
                            }
                        }
                    }
                ]
            });
        }

        //导出通讯录数据
        $exportBtn.unbind('click').on('click', function (e) {
            e.preventDefault();
            G.confirm({
                message: '确认导出此通讯录信息吗？',
                callback: function (result) {
                    if (result) {
                        if ($gridTableDep.height() != 0) {
                            if (item_selected.length > 0) {
                                exportContacts(item_selected, 'part');
                            } else {
                                //不选择默认导出全部数据
                                exportContacts("", 'all');
                            }
                        }else {
                            G.showGritterFail("此通讯录信息不存在,请确认后重试!");
                        }
                    }
                }
            });
        });

        //根据所选行导出通讯录
        function exportContacts(data, type) {
            var deptNameExcel = $deptName.val();
            var locationNameExcel = $location.val();
            if($deptIdd!=-1){
                var url = '${basePath}/contacts-address/addressTeam-preview.do?type='+type+'&data='+
                    data+'&deptIdd='+$deptIdd+'&deptName='+deptNameExcel+'&locationName'+locationNameExcel;
                location.href = url;
            }else {
                if(data!=""){
                    var url = '${basePath}/contacts-address/addressTeam-preview.do?type='+type+'&data='+
                        data+'&deptIdd='+$deptIdd+'&deptName='+deptNameExcel+'&locationName'+locationNameExcel;
                    location.href = url;
                }else {
                    G.showGritterFail("请选择通讯录信息，在进行导出!");
                }
            }
        }


        $searchBtn.click(function () {
            $deptIdd=-1;
            search();
        });
        $resetBtn.click(function () {
            $searchForm.resetForm();
            item_selected = [];
            search();
        });

        function reloadGrid() {
            $gridTableDep.tjGrid('reloadGrid');
        }

        function search() {
            var addressTeamId = $addressTeamId.val();
            var deptId =$deptId.val();
            var location = $location.val();
            $gridTableDep.tjGrid('setPostData', {
                location: location,
                deptId:deptId,
                addressTeamId:addressTeamId
            });
            reloadGrid();
        }

        <%-- Ztree树状图的增删改查  --%>
        //zTree变量
        var zTree;
        var event001, treeId001, treeNode001 ;
        var $editDialog = $("#edit-dialog");
        var $upDateDialog = $("#update-dialog");
        var setting = {
            view: {
                showIcon: true,
                dblClickExpand: false,
                showLine: true,
                selectedMulti: false
            },
            data: {
                simpleData: {
                    enable:true,
                    idKey: "id",
                    pIdKey: "pId",
                    rootPId: "",
                    isNodeKey:"isNode",
                    isDeptOrUser:"isFlag"
                },
                key:{
                    checked:"checked"
                }
            },
            callback: {
                onRightClick: zTreeOnRightClick,
                onClick:zTreeOnClick
            }
        };

        //通讯录数据
        var zNodes =[
            <c:forEach items="${addressList}" var="addrelist" varStatus="status">
            {id:"${addrelist.id}", pId:"${addrelist.addressTeam.id}",
                name:"${addrelist.teamName}",isNode:"${addrelist.isLeaf}", open:true},
            </c:forEach>

        ];
        //初始化通讯录组
        $(document).ready(function(){
            var t = $("#contacts_tree1");
            $.fn.zTree.init(t, setting, zNodes);
            zTree = $.fn.zTree.getZTreeObj("contacts_tree1");
            rMenu = $("#rMenu");
        });

        /*右击事件 */
        function zTreeOnRightClick(event, treeId, treeNode) {
            event001 = event;
            treeId001 = treeId;
            treeNode001 = treeNode;
            if(!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0){
                showRMenu("root",event.clientX,event.clientY,event, treeId, treeNode001);
            }else if(treeNode && !treeNode.noR){
                showRMenu("node",event.clientX,event.clientY,event, treeId, treeNode001);
            }
        }

        /*显示右键菜单*/
        function showRMenu(type,x,y,event, treeId, treeNode) {
            $("#rMenu ul").show();
            rMenu.css({"top":(y*0.54)+"px","left":(x*0.32)+"px","visibility":"visible"});
            $("body").bind("mousedown",onBodyMouseDown);

            if(type=="root"){
                $("#rMenu").hide();
            }
           // 设置右键显示菜单，为跟目录只能添加通讯录操作，根据跟目录ID 进行比较

            if(treeNode.id==="2" || treeNode.id === "01" ){
                $("#rMenu").show();
                $("#onclickLoadTree").hide();
                $("#onclickDelTree").hide();
                $("#onclickUpTree").hide();
            }else {
                $("#rMenu").show();
                $("#onclickLoadTree").show();
                $("#onclickDelTree").show();
                $("#onclickUpTree").show();
            }
        }

        //隐藏右键菜单
        function hideRMenu() {
            if(rMenu) rMenu.css({"visibility":"hidden"});
            $("body").unbind("mousedown",onBodyMouseDown);
        }

        //鼠标按下事件
        function onBodyMouseDown(event) {
            if(!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length>0)){
                rMenu.css({"visibility":"hidden"});
            }
        }

        //通讯录增删改查
        function exupDate(upda){
            var pssId = treeNode001.pId;
            var psId = treeNode001.id;
            var isNode = treeNode001.isNode;
            if(upda == "add"){
                var editUrl = '${basePath}/contacts-address/addressTeam-add.do';
                var loadId = G.showAjaxLoading();
                $.ajax({
                    url: editUrl,
                    type: "POST",
                    data: {"id": psId, "parentId":pssId,"isNode":isNode},
                    dataType:"html",
                    success: function (String) {
                        $editDialog.html(String);
                        G.doneAjaxLoading(loadId);
                        initEditDialog($editDialog);
                    },
                    error: function () {
                        G.doneAjaxLoading(loadId);
                        G.showGritterSuccess("操作失败!");
                    }
                });
            }else if(upda == "del"){
                    var delUrl = '${basePath}/contacts-address/addressTeam-delete.do';

                    if(isNode === "0" ){
                        var messages = "确认删除此通讯录分组？";
                    }else{
                        var messages = "此分组下有子目录，确认删除此通讯录分组？";
                    }
                    G.confirm({
                        message: messages,
                        callback: function (result) {
                            if (result) {
                                $.post(delUrl, {id: psId}, function (data) {
                                    if (data.result) {
                                        G.showGritterSuccess("删除成功!");
                                        G.pjaxLoadPageContentDiv('#page/contacts/contacts-list');
                                    }
                                });
                            }
                        }
                    });
            }else if(upda == "load"){
                    deptEditAddressList("",psId);
            }else if(upda == "up"){
                //修改通讯录名字
                var updateUrl = '${basePath}/contacts-address/addressTeam-up.do';
                var loadId = G.showAjaxLoading();
                $.ajax({
                    url: updateUrl,
                    type: "POST",
                    data: {"id": psId, "parentId":pssId},
                    dataType:"html",
                    success: function (String) {
                        $upDateDialog.html(String);
                        G.doneAjaxLoading(loadId);
                        initupDateDialog($upDateDialog);
                    },
                    error: function () {
                        G.doneAjaxLoading(loadId);
                        G.showGritterSuccess("操作失败!");
                    }
                });
            }
        }
        //初始化新增通讯录分组
        function initEditDialog($container) {
            var $form = $("#saveForm");
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'>" +
                "<i class='ace-icon fa  fa-globe green'></i>新增通讯录分组</h4></div>",
                title_html: true,
                close: function () {
                    $container.empty();
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-warning",
                        click: function () {
                            $container.dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 提交",
                        "class": "btn btn-success",
                        click: function () {
                            if ($form.validate().form()) {
                                $form.ajaxSubmit({
                                    success: function (map) {
                                        if (map.result) {
                                            G.showGritterSuccess("保存成功!");
                                            $container.dialog("close");
                                            G.pjaxLoadPageContentDiv('#page/contacts/contacts-list');
                                        } else {
                                            G.showGritterFail("保存失败,请稍后重试!");
                                        }
                                    }
                                });
                            }
                        }
                    }
                ]
            });
        }
        //初始化通讯录修改页面
        function initupDateDialog($container) {
            var $form = $("#deptUpDateForm");
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'>" +
                "<i class='ace-icon fa  fa-globe green'></i>通讯录分组修改</h4></div>",
                title_html: true,
                close: function () {
                    $container.empty();
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-warning",
                        click: function () {
                            $container.dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 提交",
                        "class": "btn btn-success",
                        click: function () {
                            if ($form.validate().form()) {
                                $form.ajaxSubmit({
                                    success: function (map) {
                                        if (map.result) {
                                            G.showGritterSuccess("修改成功!");
                                            $container.dialog("close");
                                            G.pjaxLoadPageContentDiv('#page/contacts/contacts-list');
                                        } else {
                                            G.showGritterFail("修改失败,请稍后重试!");
                                        }
                                    }
                                });
                            }
                        }
                    }
                ]
            });
        }
        //点击通讯录树 左击事件
        function  zTreeOnClick(){
            $deptIdd = zTree.getSelectedNodes()[0].id;
                if($deptIdd!=0) {
                    var deptId = $deptId.val();
                    $addressTeamId.val($deptIdd);
                    $gridTableDep.tjGrid('setPostData', {
                    addressTeamId: $deptIdd,
                        deptId:deptId
                    });
                    if($deptIdd==01 ){
                        $deptIdd = 0;
                    }
                }
            reloadGrid();
        }
        <%-- Ztree树状图的增删改查   结束  --%>

            $(document).one('ajaxloadstart.page', function (e) {

                $.jgrid.gridDestroy('#grid-table-dep');
                $('.ui-jqdialog').remove();
                $('.ui-dialog').remove();
            });
    });


</script>










