<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>

<title>履职支撑平台</title>
<link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/chosen.css"/>

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
                            <div class="widget-main">
                                <div class="col-xs-12">
                                    <form class="form-horizontal" id="searchForm">

                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label"
                                                           for="search-empName">用户姓名:</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" type="text" id="search-empName">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label"
                                                           for="search-empName">登录名:</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" type="text" id="search-userId">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label"
                                                           for="search-empName">部门:</label>
                                                    <div class="col-sm-8 deptDiv">
                                                        <input type="text" id="form-search-deptId" name="searchOrgId"
                                                               class="hide" value=""/>
                                                        <input type="text" class="form-control"
                                                               id="form-search-deptName"
                                                               name="deptName_" value="" style="cursor: pointer;" readonly="readonly"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-rankId">职级:</label>
                                                    <div class="col-sm-8 ">
                                                        <select class="form-control" id="form-field-rankId"
                                                                name="rankId">
                                                            <option value="">--请选择--</option>
                                                            <c:forEach items="${dicParamList}" var="dicParam">
                                                                <option value="${dicParam.id}">${dicParam.name}</option>
                                                            </c:forEach>
                                                        </select>
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
                    <c:if test="${'42_1' eq  curOpertate}">
                        <div class="btn-group pull-right contacts-exportBtn">
                            <button class="btn btn-sm btn-success" id="add-new-user" style="top: 6px;right:15px;">
                                <i class="ace-icon glyphicon glyphicon-user bigger-120"></i>
                                新增用户
                            </button>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="header-table-th">用户信息浏览</div>
                <div class="table-content col-md-12">
                    <div class="col-md-12 jqgrid_box" style="padding: 0px;background: #fff;">
                        <table id="grid-table"></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="col-xs-12">
    <div id="modal-user" class="modal" style="padding: 0px">
        <div class="modal-user" style="width: 100%">
            <div id="modal-wizard-user">
                <div class="modal-header">
                    <ul class="steps">
                        <li data-step="1" class="active">
                            <span class="step">1</span>
                            <span class="title">用户信息</span>
                        </li>

                        <li data-step="2">
                            <span class="step">2</span>
                            <span class="title">角色分配</span>
                        </li>

                    </ul>
                </div>
                <form id="role-info-form" action="${basePath}/user/saveUser.do" method="post"
                      class="form-horizontal" role="form">
                    <div class="modal-body step-content" style="height: 450px">
                        <div class="step-pane active" data-step="1">
                            <div class="row scrollable" data-size="430">
                                <div class="col-xs-12">
                                    <input type="hidden" id="user-id" name="id">
                                    <h4 class="smaller header lighter blue"
                                        style="margin-top: 0px;margin-bottom:10px ">
                                        <i class="ace-icon fa fa-user"></i>
                                        基本信息
                                    </h4>

                                    <div class="row">
                                        <div class="col-xs-4">
                                            <div class="form-group">
                                                <label class="col-xs-6 control-label">用户姓名：<span
                                                        class="red">*</span></label>

                                                <div class="col-xs-6 ">
                                                    <input type="text" id="role-name" name="empName"
                                                           class="form-control"
                                                           placeholder="用户姓名"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-4">
                                            <div class="form-group">
                                                <label class="col-xs-6 control-label">登录名：<span
                                                        class="red">*</span></label>

                                                <div class="col-xs-6">
                                                    <input type="text" id="userId" name="userId"
                                                           class="form-control remote"
                                                           placeholder="登录名"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-4">
                                            <div class="form-group">
                                                <label class="col-xs-6 control-label">性别：<span
                                                        class="red">*</span></label>

                                                <div class="col-xs-6 ">
                                                    <label>
                                                        <input name="sex" class="ace input-lg" checked
                                                               value="0" type="radio">
                                                        <span class="lbl bigger-120"> 男</span>
                                                    </label>
                                                    &nbsp;&nbsp;
                                                    <label>
                                                        <input name="sex" class="ace input-lg" value="1"
                                                               type="radio">
                                                        <span class="lbl bigger-120"> 女</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <div class="form-group">
                                                <label class="col-xs-6 control-label">
                                                    电话：
                                                </label>

                                                <div class="col-xs-6">
                                                    <input type="text" id="mobile" name="mobile"
                                                           class="form-control"
                                                           placeholder="电话"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-4">
                                            <div class="form-group">
                                                <label class="col-xs-6 control-label">
                                                    邮箱：
                                                </label>

                                                <div class="col-xs-6">
                                                    <input type="text" id="email" name="email"
                                                           class="form-control"
                                                           placeholder="邮箱"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-4">
                                            <div class="form-group">
                                                <label class="col-xs-6 control-label">职级：<span
                                                        class="red">*</span></label>

                                                <div class="col-xs-6 ">
                                                    <select id="rank_id" name="rankId" class="form-control">
                                                        <c:if test="${dicUser.rankId ne null}">
                                                            <option value="">--请选择--</option>
                                                            <c:forEach items="${dicParamList}" var="dicParam">
                                                                <option value="${dicParam.id}"
                                                                        <c:if test="${dicParam.id eq dicUser.rankId}">selected</c:if>>${dicParam.name}</option>
                                                            </c:forEach>
                                                        </c:if>
                                                        <c:if test="${dicUser.rankId eq null}">
                                                            <option value="${dicUser.rankId}">--请选择--</option>
                                                            <c:forEach items="${dicParamList}" var="dicParam">
                                                                <option value="${dicParam.id}">${dicParam.name}</option>
                                                            </c:forEach>
                                                        </c:if>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <div class="form-group">
                                                <label class="col-xs-6 control-label">
                                                    出生日期：<span class="red hide">*</span>
                                                </label>

                                                <div class="col-xs-6">
                                                    <input type="text" id="birthdayStr" name="birthdayStr"
                                                           class="form-control"
                                                           placeholder="出生日期"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-4">
                                            <div class="form-group">
                                                <label class="col-xs-6 control-label">
                                                    出生地：<span class="red hide">*</span>
                                                </label>

                                                <div class="col-xs-6">
                                                    <input type="text" id="birthplace" name="birthplace"
                                                           class="form-control"
                                                           placeholder="出生地"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-4">
                                            <div class="form-group">
                                                <label class="col-xs-6 control-label">民族：<span
                                                        class="red"> </span></label>

                                                <div class="col-xs-6 ">
                                                    <select class="form-control" id="form-field-nation"
                                                            name="nation">
                                                        <c:if test="${dicUser.nation ne null}">
                                                            <option value="">--请选择--</option>
                                                            <c:forEach items="${nationalityList}" var="nationality">
                                                                <option value="${nationality.id}"
                                                                        <c:if test="${nationality.id eq dicUser.nation}">selected</c:if>>${nationality.name}</option>
                                                            </c:forEach>
                                                        </c:if>
                                                        <c:if test="${dicUser.nation eq null}">
                                                            <option value="${dicUser.nation}">--请选择--</option>
                                                            <c:forEach items="${nationalityList}" var="nationality">
                                                                <option value="${nationality.id}">${nationality.name}</option>
                                                            </c:forEach>
                                                        </c:if>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <div class="form-group">
                                                <label class="col-xs-6 control-label">
                                                    主要职务：
                                                </label>

                                                <div class="col-xs-6">
                                                    <input type="text" id="mainDuty" name="mainDuty"
                                                           class="form-control"
                                                           placeholder="主要职务"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-4">
                                            <div class="form-group">
                                                <label class="col-xs-6 control-label">
                                                    证件号码：<span class="red hide">*</span>
                                                </label>

                                                <div class="col-xs-6">
                                                    <input type="text" id="cardNumber" name="cardNumber"
                                                           class="form-control"
                                                           placeholder="证件号码"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-4" id="password-div">
                                            <div class="form-group">
                                                <label id="password-label" class="col-xs-6 control-label">初始密码：<span
                                                        class="red">*</span></label>

                                                <div class="col-xs-6 ">
                                                    <input type="text" id="password" name="password" value="123456"
                                                           readonly="readonly"
                                                           class="form-control"/>
                                                </div>
                                            </div>
                                        </div>
                                        <%--<div class="col-xs-4">--%>
                                        <%--<div class="form-group">--%>
                                        <%--<label class="col-xs-6 control-label">确认密码：<span--%>
                                        <%--class="red">*</span></label>--%>

                                        <%--<div class="col-xs-6 ">--%>
                                        <%--<input type="password" name="repassword" class="form-control"--%>
                                        <%--placeholder="确认密码"/>--%>
                                        <%--</div>--%>
                                        <%--</div>--%>
                                        <%--</div>--%>
                                    </div>
                                    <h4 class="smaller header lighter blue"
                                        style="margin-top: 0px;margin-bottom:10px ">
                                        <i class="ace-icon fa fa-list"></i>
                                        职能信息
                                    </h4>

                                    <div class="row">
                                        <div class="col-xs-4">
                                            <div class="form-group">
                                                <label class="col-xs-6 control-label">所属部门：<span
                                                        class="red">*</span></label>

                                                <div class="col-sm-6 deptDiv">
                                                    <input type="text" id="form-field-deptId" name="deptId"
                                                           class="hide" value=""/>
                                                    <input type="text" class="form-control" id="form-field-deptName"
                                                           name="deptName" value="" style="cursor: pointer;" readonly/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-4">
                                            <div class="form-group">
                                                <label class="col-xs-6 control-label">
                                                    传真：
                                                </label>

                                                <div class="col-xs-6 ">
                                                    <input type="text" id="fax" name="fax" class="form-control"
                                                           placeholder="传真"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-4">
                                            <div class="form-group">
                                                <label class="col-xs-6 control-label">
                                                    办公电话：
                                                </label>

                                                <div class="col-xs-6">
                                                    <input type="text" id="phone" name="phone" class="form-control"
                                                           placeholder="办公电话"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="step-pane" data-step="2">
                            <div class="col-xs-12">
                                <div class="col-sm-6">
                                    <div class="widget-box widget-color-blue2" style="margin-top: 20px">
                                        <div class="widget-header">
                                            <h5 class="widget-title bigger lighter" style="color: cadetblue">
                                                <i class="ace-icon fa fa-table"></i>
                                                角色列表
                                            </h5>
                                        </div>
                                        <div class="widget-body">
                                            <div class="widget-main padding-8 scrollable" data-size="345"style="height: 350px">
                                                <ul id="role-list" class="pro-ul">

                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="widget-box widget-color-blue2" style="margin-top: 20px">
                                        <div class="widget-header">
                                            <h5 class="widget-title bigger lighter" style="color: cadetblue">
                                                <i class="ace-icon fa fa-check-square-o "></i>
                                                已选角色
                                            </h5>
                                        </div>
                                        <div class="widget-body">
                                            <div class="widget-main padding-8 scrollable" data-size="345" style="height: 350px">
                                                <input type="hidden" id="checked-role-name" name="userRoles">
                                                <input type="hidden" id="checked-role-id" name="roleIds">
                                                <ul id="checked-role-list" class="pro-ul">

                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer wizard-actions">
                <button class="btn btn-sm btn-prev">
                    <i class="ace-icon fa fa-arrow-left"></i>
                    上一步
                </button>

                <button class="btn btn-success btn-sm btn-next" data-last="保存">
                    下一步
                    <i class="ace-icon fa fa-arrow-right icon-on-right"></i>
                </button>

                <button class="btn btn-danger btn-sm pull-left" id="user-cancel" data-dismiss="modal">
                    <i class="ace-icon fa fa-times"></i>
                    取消
                </button>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-xs-12">
        <div id="profession-dialog scrollable"  data-size="420" class="hide">
            <ul class="pro-ul">
                <c:forEach items="${dicPositionList}" var="pro">
                    <li>
                        <div class="checkbox">
                            <label>
                                <input value="${pro.id}" proname="${pro.postName}" name="profession-check"
                                       class="ace" type="checkbox">
                                <span class="lbl"> ${pro.postName}</span>
                            </label>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.initDept('deptDiv', true, [null, null], TREE_NODE);

        G.datepicker();
        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });
        //滚动条
        $('.scrollable').each(function () {
            var $this = $(this);
            $(this).ace_scroll({
                size: $this.attr('data-size') || 100
                //styleClass: 'scroll-left scroll-margin scroll-thin scroll-dark scroll-light no-track scroll-visible'
            });
        });

        //查询
        var $searchDeptId = $("#form-search-deptId");
        var $searchEmpName = $("#search-empName");
        var $searchUserId = $("#search-userId");
        var $searchBtn = $("#searchBtn");

        //grid
        var $gridTable = $('#grid-table');

        //新增
        var $addNewUser = $("#add-new-user");
        var $modelUserDialog = $("#modal-user");
        var $orgId = $("#org-id");
        var $deptId = $("#form-field-deptId");
        var $deptName = $("#form-field-deptName");
        var $profession = $("#profession");
        var $professionId = $("#profession-id");
        var $professionDialog = $("#profession-dialog");
        var $roleForm = $("#role-info-form");
        var $roleList = $("#role-list");
        var $checkedRoleList = $("#checked-role-list");
        var $checkedRoleName = $("#checked-role-name");
        var $checkedRoleId = $("#checked-role-id");
        var $userId = $("#userId");//登录名
        var $user = $("#user-id");//用户id
        var $roleName = $("#role-name");//用户姓名
        var $email = $("#email");//邮箱
        var $mobile = $("#mobile");//手机
        var $fax = $("#fax");//传真
        var $professionalId = $("#professionalId");//专业类别
        var $phone = $("#phone");//办公电话
        var $position = $("#position");//单位职务
        var $notes = $("#notes");//NOTES
        var $passwordDiv = $("#password-div");
        var $userCancel = $("#user-cancel");

        var $rankId = $("#rank_id");//职级
        var $birthdayStr = $("#birthdayStr");//出生日期
        var $birthplace = $("#birthplace");//出生地
        var $nation = $("#form-field-nation");//民族
        var $mainDuty = $("#mainDuty");//主要职务
        var $cardNumber = $("#cardNumber");//身份证号


        var colModel = [
            {name: 'id', header: 'id', hidden: true, width: 60},
            {name: 'empName', header: '用户姓名', formatter: titleFormatter, width: 100},
            {name: 'deptName', header: '所属部门', sortable: false},
            {name: 'userId', header: '登录名称', sortable: false},
            {name: 'isactive', header: '激活状态', formatter: isActiveFormatter, align: "center"},
            {name: 'roleStr', header: '用户角色', sortable: false},
            {name: 'op', header: '操作', width: 250, sortable: false, formatter: operationFormatter}

        ];

        function operationFormatter(cellvalue, options, rowData, action) {
            cellvalue = '';
            var isactive = rowData.isactive;
            var operations = [];
            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'42_2' eq  curOpertate}">
            operations.push(' <button class="btn btn-minier btn-white btn-purple editUser">');
            operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
            operations.push('</button>');
            if (isactive != 1) {
                operations.push(' <button class="btn btn-minier btn-white btn-pink isActive">');
                operations.push('<i class="ace-icon glyphicon glyphicon-ok bigger-120"></i> 激活');
                operations.push('</button>');
            } else {
                operations.push(' <button class="btn btn-minier btn-white btn-primary rePassword">');
//            operations.push('<i class="ace-icon glyphicon glyphicon-refresh "></i> 重置密码');
                operations.push(' 重置密码');
                operations.push('</button>');
                operations.push(' <button class="btn btn-minier btn-white btn-warning isActive">');
                operations.push('<i class="ace-icon glyphicon glyphicon-remove"></i> 禁用');
                operations.push('</button>');
            }
            operations.push(' <button class="btn btn-minier btn-white btn-danger delete">');
            operations.push(' <i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
            operations.push('</button>');
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        //绑定标题点击触发时间轴浏览功能
        function titleFormatter(cellvalue, options, rowData, action) {
            var id = rowData.id;
            var empName = rowData.empName;
            // var date_url = "page/user/detail?id=" + id;
            var operations = [];
            // operations.push('<a class="blue" data-rel="tooltip" data-placement="top">');
            operations.push('<span class="blue">' + empName + '</span>');
            // operations.push('</a>');
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
            loadUrl: '${basePath}/user/load.do',
            height: '100%',
            autowidth: true,
            colModel: colModel,
            sortname: 'createDate',
            sortorder: 'desc',
            // caption     : "用户信息浏览",
            onSelectRow: function (id, stat, e) {
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }
                if (className.indexOf('editUser') != -1) {

                    loadEditUser(id)
                }
                if (className.indexOf('rePassword') != -1) {

                    G.confirm({
                        message: '确定重置为初始密码？',
                        callback: function (result) {
                            if (result) {
                                rePassword(id);
                            }
                        }
                    })
                }
                //激活
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

                //删除
                if (className.indexOf('delete') != -1) {
                    G.confirm({
                        message: '确定执行操作？',
                        callback: function (result) {
                            if (result) {
                                deleteUser(id);
                            }
                        }
                    })
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
        });

        var $searchForm = $("#searchForm");
        var $resetBtn = $("#resetBtn");
        $resetBtn.click(function () {
            $searchForm.resetForm();
            search();
        });

        function search() {
            var searchDeptId = $searchDeptId.val();
            var searchUserId = $searchUserId.val();
            var searchEmpName = $searchEmpName.val();
            var rankId = $("#form-field-rankId").val();
            $gridTable.tjGrid('setPostData', {
                searchDeptId: searchDeptId,
                empName: searchEmpName,
                searchUserId: searchUserId,
                rankId: rankId
            });
            reloadGrid();
        }

        //激活
        function isActive(id) {
            $.post('${basePath}/user/isActive.do', {id: id}, function (response) {
                if (response.result) {
                    reloadGrid();
                    G.showGritterSuccess();
                }
            })
        }

        //用户同步
        function videoSync(id) {
            $.post('${basePath}/user/videoSync.do', {id: id}, function (response) {
                var msg = response.msg;
                if (response.result) {
                    reloadGrid();
                    G.showGritterSuccess(msg);
                } else {
                    G.showGritterFail(msg);
                }
            })
        }

        //重置密码
        function rePassword(id) {
            $.post('${basePath}/user/rePassword.do', {id: id}, function (response) {
                if (response.result) {
                    reloadGrid();
                    G.showGritterSuccess();
                }
            })
        }

        function deleteUser(id) {
            $.post('${basePath}/user/deleteUser.do', {id: id}, function (response) {
                if (response.result) {
                    reloadGrid();
                    G.showGritterSuccess();
                } else {
                    G.alert({message: '该用户已有操作不能删除!'});
                }
            })
        }

        //新增用户
        $addNewUser.click(function () {
            // openNewUser(null);
            addUserDialog();
        });

        function loadEditUser(id) {
            $.post('${basePath}/user/loadEditUser.do?', {id: id}, function (response) {
                if (response.result) {
                    var user = response.user;
                    var secRoleList = response.secRoleList;
                    var orgId = user.deptId;
                    $deptId.val(orgId);
                    // $deptId.prop('disabled', true);
                    // appendDept(orgId);
                    $roleName.val(user.empName);
                    $user.val(user.id);
                    $userId.val(user.userId);
                    $('input[name="sex"]').each(function () {
                        var $this = $(this);
                        if ($this.val() == user.sex) {
                            $this.prop("checked", true);
                        }
                    });
                    $email.val(user.email);
                    $mobile.val(user.mobile);
                    $fax.val(user.fax);
                    $professionalId.val(user.professionalId);
                    $phone.val(user.phone);
                    $position.val(user.position);
                    $notes.val(user.notes);
                    $profession.val(user.dutynames);
                    $professionId.val(user.dutyids);
                    $passwordDiv.addClass('hide');

                    $rankId.val(user.rankId);
                    $birthdayStr.val(user.birthday);
                    $birthplace.val(user.birthplace);
                    $nation.val(user.nation);
                    $mainDuty.val(user.mainDuty);
                    $cardNumber.val(user.cardNumber);

                    var dept = response.curDept;
                    $("#form-field-deptId").val(dept.id);
                    $("#form-field-deptName").val(dept.deptName);

                    var roleNames = [];
                    var roleIds = [];
                    var dataArray = [];
                    for (var i in secRoleList) {
                        var role = secRoleList[i];
                        var roleId = role.id;
                        var roleName = role.roleName;
                        roleIds.push(roleId);
                        roleNames.push(roleName);
                        dataArray.push({
                            id: roleId,
                            roleName: roleName
                        })
                    }
                    $checkedRoleId.val(roleIds.join(","))
                    $checkedRoleName.val(roleNames.join(","))
                    editUserDialog(dept);
                    // openNewUser(dept);
                    appendCheckedRoleView(dataArray);

                }
            })
        }

        $roleForm.tjValidate({
            focusInvalid: false,
            rules: {
                empName: {
                    required: true,
                    maxlength: 32
                },
                userId: {
                    required: true,
                    remote: {
                        url: "${basePath}/user/checkUnique.do?rd=" + Math.random(),
                        type: "post",               //数据发送方式
                        dataType: "json",           //接受数据格式
                        async: false,	        //防止重复提交
                        data: {                     //要传递的数据
                            checkValue: function () {
                                return $userId.val()

                            },
                            id: function () {
                                return $user.val() == "" ? "" : $user.val();
                            },
                            checkKey: "userId"
                        }
                    },
                    maxlength: 32
                },
                email: {
                    email: true,
                    maxlength: 100
                },
                mobile: {
                    maxlength: 32
                },
                fax: {
                    maxlength: 100
                },
                phone: {
                    maxlength: 32
                },
                position: {
                    maxlength: 255
                },
                notes: {
                    maxlength: 255
                },
                rankId: {
                    required: true,
                    maxlength: 32
                },
                deptName: {
                    required: true
                }
            },
            messages: {
                empName: {
                    required: "用户名称必须填写"
                },
                userId: {
                    required: "登录名必须填写",
                    remote: "登录名重复"
                },
                rankId: {
                    required: "职级必须填写"
                },
                deptName: {
                    required: "所属部门必须填写"
                }
            }
        });
        $('#modal-user .wizard-actions .btn[data-dismiss=modal]').removeAttr('disabled');
        $('#modal-wizard-user').ace_wizard().on('actionclicked.fu.wizard', function (e, info) {
            if (info.step == 1) {

                if (!$roleForm.validate().form())
                    e.preventDefault();
                var orgId = $deptId.val();
                $.post('${basePath}/user/getRoleList.do', function (response) {
                    if (response.result) {
                        var roleList = response.secRoleList;
                        appendRoleList(roleList);
                    }
                })

            }
            else if (info.step == 2) {
                if (info.direction != "previous") {
                    var checkedRoleId = $checkedRoleId.val();
                    if (checkedRoleId == '') {
                        G.alert({message: "请选择角色！"});
                    } else {
                        $roleForm.tjForm('submit');
                    }
                }
            }
        });

        $roleForm.tjForm({
            form: {
                success: function (data) {
                    if (data.result) {
                        G.showGritterSuccess();
                        $modelUserDialog.dialog("close");
                        reloadGrid();
                        clearPreviousValue();
                    }
                    else {
                        G.showGritterFail("保存失败");
                    }
                }
            }
        });

        function clearPreviousValue() {
            if ($(".remote").data("previousValue")) {
                $(".remote").removeData("previousValue");
            }
        };

        //显示角色信息
        function appendRoleList(roleList) {
            $roleList.empty();
            var html = [];
            for (var i = 0; i < roleList.length; i++) {
                var role = roleList[i];
                html.push('<li>');
                html.push('<div class="checkbox ">');
                html.push('<label>');
                html.push('<input value=' + role.id + ' proname=' + role.roleName + ' name="role-check" class="ace" type="checkbox">');
                html.push('<span class="lbl"> <i class="ace-icon fa fa-user blue"></i>&nbsp;' + role.roleName + '</span>');
                html.push('</label>');
                html.push('</div>');
                html.push('</li>');
            }
            $roleList.append(html.join(''));
            clickRoleView();
            checkedRole();
        }

        function checkedRole() {
            var roleIds = $checkedRoleId.val();
            if (roleIds != '') {
                var roleIdArry = roleIds.split(",");
                $("#role-list").find('input[name="role-check"]').each(function () {
                    var $this = $(this);
                    var value = $this.val();
                    for (var i = 0; i < roleIdArry.length; i++) {
                        if (value == roleIdArry[i]) {
                            $this.prop("checked", true)
                        }
                    }
                });
            }
        }

        //角色信息checkbox选择事件
        function clickRoleView() {
            $('input[name="role-check"]').click(function () {
                var dataArray = [];
                var dataIds = [];
                var dataNames = [];
                $("#role-list").find('input[name="role-check"]').each(function () {
                    var $this = $(this);
                    if ($this.prop("checked")) {
                        var value = $this.val();
                        var proname = $this.attr("proname");
                        dataArray.push({
                            id: value,
                            roleName: proname
                        })
                        dataIds.push(value);
                        dataNames.push(proname);
                    }
                });
                $checkedRoleName.val(dataNames.join(','));
                $checkedRoleId.val(dataIds.join(','));
                appendCheckedRoleView(dataArray);
            });
        }

        //展示选中角色
        function appendCheckedRoleView(dataArray) {
            $checkedRoleList.empty();
            var html = [];
            for (var i = 0; i < dataArray.length; i++) {
                var role = dataArray[i];
                html.push('<li class="roleView" style="cursor: pointer" roleId="' + role.id + '" roleName ="' + role.roleName + '">');
                html.push('<label>');
                html.push('<span class="lbl"> <i class="ace-icon fa fa-user green"></i>&nbsp;' + role.roleName + '</span>');
                html.push('</label>');
                html.push('</li>');
            }
            $checkedRoleList.append(html.join(''));
            uncheckRoleView();
        }

        //单机取消选中角色
        function uncheckRoleView() {
            $(".roleView").click(function () {
                var $this = $(this);
                var roleId = $this.attr("roleId");
                var dataIds = [];
                var dataNames = [];
                $("#role-list").find('input[name="role-check"]').each(function () {
                    var $this = $(this);
                    if ($this.prop("checked")) {
                        var value = $this.val();
                        var roleName = $this.attr('proname');
                        if (value == roleId) {
                            $this.prop("checked", false);
                        } else {
                            dataIds.push(value);
                            dataNames.push(roleName);
                        }

                    }
                });
                $this.remove();
                $checkedRoleName.val(dataNames.join(','));
                $checkedRoleId.val(dataIds.join(','));
            })
        }

        //打开新增对话框
        function openNewUser(dept) {
            $modelUserDialog.removeClass('hide').dialog({
                resizable: false,
                height: 655,
                width: 1000,
                modal: true,
                close: function () {
                    var wizard = $('#modal-wizard-user').data('fu.wizard');
                    wizard.currentStep = 1;
                    wizard.setState();
                    $roleForm.tjValidate('resetForm');
                    $roleForm.tjForm('resetForm');
                    $passwordDiv.removeClass('hide');
                    $orgId.prop('disabled', false);
                    $user.val('');
                    // $deptName.val('');
                    $checkedRoleId.val('');
                    $checkedRoleList.empty();
                    $roleList.empty();
                },
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon glyphicon glyphicon-volume-up green'></i> 新增/编辑用户信息</h4></div>",
                title_html: true
            });
        }

        function addUserDialog() {
            $modelUserDialog.removeClass('hide').dialog({
                resizable: false,
                height: 655,
                width: 1000,
                modal: true,
                close: function () {
                    var wizard = $('#modal-wizard-user').data('fu.wizard');
                    wizard.currentStep = 1;
                    wizard.setState();
                    $roleForm.tjValidate('resetForm');
                    $roleForm.tjForm('resetForm');
                    $passwordDiv.removeClass('hide');
                    $orgId.prop('disabled', false);
                    $user.val('');
                    $checkedRoleId.val('');
                    $checkedRoleList.empty();
                    $roleList.empty();
                },
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon glyphicon glyphicon-volume-up green'></i> 新增/编辑用户信息</h4></div>",
                title_html: true
            });
        }

        function editUserDialog(dept) {
            $modelUserDialog.removeClass('hide').dialog({
                resizable: false,
                height: 655,
                width: 1000,
                modal: true,
                close: function () {
                    var wizard = $('#modal-wizard-user').data('fu.wizard');
                    wizard.currentStep = 1;
                    wizard.setState();
                    $roleForm.tjValidate('resetForm');
                    $roleForm.tjForm('resetForm');
                    $passwordDiv.removeClass('hide');
                    $orgId.prop('disabled', false);
                    $user.val('');
                    $deptName.val('');
                    $checkedRoleId.val('');
                    $checkedRoleList.empty();
                    $roleList.empty();

                },
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon glyphicon glyphicon-volume-up green'></i> 新增/编辑用户信息</h4></div>",
                title_html: true
            });
        }

        //org change事件
        // $orgId.bind('change', function () {
        //     var orgId = $orgId.val();
        //     appendDept(orgId);
        // });

        $userCancel.click(function () {
            G.confirm({
                message: '确定取消操作？',
                callback: function (result) {
                    if (result) {
                        $modelUserDialog.dialog('close');
                    }
                }
            })
        })

        //加载dept
        <%--function appendDept(orgId) {--%>
        <%--$.post('${basePath}/user/getDeptList.do', function (response) {--%>
        <%--if (response.result) {--%>
        <%--$deptId.empty();--%>
        <%--var deptList = response.deptList;--%>
        <%--var html     = [];--%>
        <%--for (var i = 0; i < deptList.length; i++) {--%>
        <%--var dept = deptList[i];--%>
        <%--html.push(' <option value="' + dept.id + '">' + dept.deptName + '</option>');--%>
        <%--}--%>
        <%--$deptId.append(html.join(''));--%>
        <%--}--%>
        <%--})--%>
        <%--}--%>

        //人员职责点击
        $profession.click(function () {
            appendCheckProfession();
            $professionDialog.removeClass('hide').dialog({
                resizable: false,
                height: 400,
                width: 250,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i> 选择人员职责</h4></div>",
                title_html: true,
                close: function () {
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 确定",
                        "class": "btn btn-success",
                        click: function () {
                            getCheckedProfession();
                            $(this).dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-warning",
                        click: function () {
                            $(this).dialog("close");
                        }
                    }
                ]
            });
        });

        //选中人员职责
        function appendCheckProfession() {
            var professionId = $professionId.val();
            professionId = professionId.split(",");
            $(".pro-ul").find('input[name="profession-check"]').each(function () {
                var $this = $(this);
                var value = $this.val();
                for (var i in professionId) {
                    if (value == professionId[i]) {
                        $this.prop("checked", true);
                    }
                }
            });
        }

        //获取选择的人员职责
        function getCheckedProfession() {
            var proIds = [];
            var proName = [];
            $(".pro-ul").find('input[name="profession-check"]').each(function () {
                var $this = $(this);
                if ($this.prop('checked')) {
                    var value = $this.val();
                    var name = $this.attr('proname');
                    proIds.push(value);
                    proName.push(name);
                }
            });
            $profession.val(proName.join(","));
            $professionId.val(proIds.join(","));
        }

        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy('#grid-table');
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

    });
</script>