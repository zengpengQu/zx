<%--
  Created by IntelliJ IDEA.
  User: yx
  Date: 2018/7/31
  Time: 15:51
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

<div class="row" style="margin-top: 30px;">
    <div class="col-xs-12">
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <h4 align="left" style="font-weight: bold;">陪同人员名单</h4>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right">
                    <button class="btn btn-primary btn-sm" type="button" id="importAccompany">
                        <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                        导入（内部人员）
                    </button>
                    <button class="btn btn-primary btn-sm" type="button" id="addAccompanyRow">
                        <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                        新增（外部人员）
                    </button>
                </div>
                <div class="pull-right">
                    <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue bigger-150 mar_r_10 mar_t_5"></i>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <table id="grid-table-accompany"></table>
            </div>
        </div>

        <div class="row">
            <div class="space-10"></div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <h4 align="left" style="font-weight: bold;">来访人员名单</h4>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right">
                    <button class="btn btn-info btn-sm" type="button" id="addVisitorBtn">
                        <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                        新增
                    </button>

                    <button class="btn btn-info btn-sm" type="button" id="exportVisitorBtn">
                        <span class="ace-icon fa fa-cloud-download icon-on-right bigger-110"></span>
                        导出
                    </button>
                </div>
                <div class="pull-right">
                    <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue bigger-150 mar_r_10 mar_t_5"></i>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <table id="grid-table-visitor"></table>
            </div>
        </div>
    </div>
</div>

<div id="edit-accompany-dialog" class="hide">
    <div class="row">
        <div class="col-xs-12">
            <form id="accompanyForm" role="form" class="form-horizontal">
                <input class="hide editable" type="text" name="id"/>
                <input class="hide editable isDelete" type="text" name="delFlag"/>

                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="form-field-accompanyName">姓名：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-8">
                                <input class="form-control editable" id="form-field-accompanyName" type="text" name="name"/>
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="form-field-accompanySex">性别：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-8">
                                <select class="form-control editable"
                                        id="form-field-accompanySex"
                                        name="sex">
                                    <option value="">-----请选择-----</option>
                                    <option value="0">男</option>
                                    <option value="1">女</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="form-field-accompanyTel">电话：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-8">
                                <input class="form-control editable" id="form-field-accompanyTel" type="text" name="tel"/>
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="form-field-accompanyBirthday">出生日期：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-8">
                                <div class="input-group">
                                    <input class="editable form-control date-picker" id="form-field-accompanyBirthday"
                                           data-date-format="yyyy-mm-dd" type="text" name="birthdayStr"/>
                                    <span class="input-group-addon">
                                        <i class="fa fa-calendar bigger-110"></i>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="form-field-mainDuty">主要职务：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-8">
                                <input class="form-control editable" id="form-field-mainDuty" type="text" name="mainDuty"/>
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="form-field-otherDuty">其他职务：<span
                                    class="red"> </span>
                            </label>

                            <div class="col-sm-8">
                                <input class="form-control editable" id="form-field-otherDuty" type="text" name="otherDuty"/>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="form-field-accompanyOrg">工作单位：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-8">
                                <input class="form-control editable" id="form-field-accompanyOrg" type="text" name="personnelOrg"/>
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="form-field-adminLevel">行政级别：<span
                                    class="red"> </span>
                            </label>

                            <div class="col-sm-8">
                                <input class="form-control editable" id="form-field-adminLevel" type="text" name="adminLevel"/>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">

                            <label class="col-sm-4 control-label" for="form-field-politicsStatus">政治面貌：<span
                                    class="red"> </span>
                            </label>

                            <div class="col-sm-8">
                                <input class="form-control editable" id="form-field-politicsStatus" type="text" name="politicsStatus"/>
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-6">
                        <div class="form-group">

                            <label class="col-sm-4 control-label" for="form-field-cppccFlag">是否政协：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-8">
                                <select class="form-control editable" id="form-field-cppccFlag" name="cppccFlag">
                                    <option value="">-----请选择-----</option>
                                    <option value="0">是</option>
                                    <option value="1" selected>否</option>
                                </select>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="form-field-accompanyForeignIdentity">对外身份：<span
                                    class="red"> </span>
                            </label>

                            <div class="col-sm-8">
                                <input class="editable form-control" id="form-field-accompanyForeignIdentity" type="text" name="foreignIdentity"/>
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="form-field-accompanyRole">角色：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-8">

                                <select class="form-control editable" id="form-field-accompanyRole" name="roleId">
                                    <option value="">-----请选择-----</option>
                                    <c:forEach items="${accompanyRoles}" var="role">
                                        <option value="${role.id}">${role.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="form-field-accompanyNotes">备注：<span
                                    class="red"> </span>
                            </label>

                            <div class="col-sm-10">
                                <textarea id="form-field-accompanyNotes" style="min-height: 100px" name="notes"
                                          class="autosize-transition form-control editable"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div id="view-accompany-dialog" class="hide">

    <div class="row">
        <div class="col-xs-12">
            <div class="profile-user-info profile-user-info-striped">
                <div class="profile-info-row">
                    <div class="profile-info-name" style="width: 15%"> 姓名</div>
                    <div class="profile-info-value" style="width: 35%">
                        <span class="editable " id="name"></span>
                    </div>

                    <div class="profile-info-name" style="width: 15%"> 性别</div>
                    <div class="profile-info-value" style="width: 35%">
                        <span class="editable " id="sexStr"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 电话</div>
                    <div class="profile-info-value">
                        <span class="editable " id="tel"></span>
                    </div>

                    <div class="profile-info-name"> 出生日期</div>
                    <div class="profile-info-value">
                        <span class="editable " id="birthdayStr"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 主要职务</div>
                    <div class="profile-info-value">
                        <span class="editable " id="mainDuty"></span>
                    </div>

                    <div class="profile-info-name"> 其他职务</div>
                    <div class="profile-info-value">
                        <span class="editable " id="otherDuty"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 工作单位</div>
                    <div class="profile-info-value">
                        <span class="editable " id="personnelOrg"></span>
                    </div>

                    <div class="profile-info-name"> 职务(职称)</div>
                    <div class="profile-info-value">
                        <span class="editable " id=""></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 行政级别</div>
                    <div class="profile-info-value">
                        <span class="editable " id="adminLevel"></span>
                    </div>

                    <div class="profile-info-name"> 政治面貌</div>
                    <div class="profile-info-value">
                        <span class="editable " id="politicsStatus"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 对外身份</div>
                    <div class="profile-info-value">
                        <span class="editable " id="foreignIdentity"></span>
                    </div>

                    <div class="profile-info-name"> 角色</div>
                    <div class="profile-info-value">
                        <span class="editable " id="roleName"></span>
                    </div>
                </div>
            </div>
            <div class="profile-user-info profile-user-info-striped" style="border-top: none">
                <div class="profile-info-row">
                    <div class="profile-info-name" style="width: 15% !important;"> 备注</div>
                    <div class="profile-info-value">
                        <span class="editable " id="notes" style="word-break: normal;max-width: 500px;display: block;white-space: pre-wrap;
                        word-wrap: break-word;overflow: hidden"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<div id="import-accompany-dialog" class="hide"></div>

<div id="edit-visitor-dialog" class="hide">
    <div class="row">
        <div class="col-xs-12">
            <form id="visitorForm" role="form" class="form-horizontal">
                <input class="hide editable" type="text" name="id"/>
                <input class="hide editable isDelete" type="text" name="delFlag"/>

                <div class="row">

                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="form-field-visitorCnName">中文名：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-8">
                                <input class="editable form-control" id="form-field-visitorCnName" type="text" name="cnName"/>
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="form-field-visitorName">外文名：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-8">
                                <input class="editable form-control" id="form-field-visitorname" type="text" name="name"/>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">

                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="form-field-visitorDuty">职务(职称)：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-8">
                                <input class="editable form-control" id="form-field-visitorDuty" type="text" name="duty"/>
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="form-field-visitorRole">角色：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-8">
                                <select class="form-control editable" id="form-field-visitorRole" name="roleId">
                                    <option value="">-----请选择-----</option>
                                    <c:forEach items="${visitorRoles}" var="role">
                                        <option value="${role.id}">${role.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="form-field-visitorBirthday">出生日期：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-8">
                                <div class="input-group">
                                    <input class="date-picker editable form-control" id="form-field-visitorBirthday"
                                           data-date-format="yyyy-mm-dd" type="text" name="birthdayStr"/>
                                    <span class="input-group-addon">
                                        <i class="fa fa-calendar bigger-110"></i>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="form-field-visitorName">性别：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-8">
                                <select class="form-control editable"
                                        id="form-field-visitorSex"
                                        name="sex">
                                    <option value="">-----请选择-----</option>
                                    <option value="0">男</option>
                                    <option value="1">女</option>
                                </select>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="form-field-visitorTel">电话：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-8">
                                <input class="editable form-control" id="form-field-visitorTel" type="text" name="tel"/>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="row">
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="form-field-visitorNotes">备注：<span
                                    class="red"> </span>
                            </label>

                            <div class="col-sm-10">
                                <textarea class="form-control editable" id="form-field-visitorNotes" style="min-height: 100px;"
                                       name="notes"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div id="view-visitor-dialog" class="hide">
    <div class="row">
        <div class="col-xs-12">
            <div class="profile-user-info profile-user-info-striped" style="border-top: none">
                <div class="profile-info-row">
                    <div class="profile-info-name"> 中文名</div>
                    <div class="profile-info-value">
                        <span class="editable " name="cnName"></span>
                    </div>

                    <div class="profile-info-name"> 外文名</div>
                    <div class="profile-info-value">
                        <span class="editable " name="name"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 职务</div>
                    <div class="profile-info-value">
                        <span class="editable " name="duty"></span>
                    </div>

                    <div class="profile-info-name"> 角色</div>
                    <div class="profile-info-value">
                        <span class="editable " name="roleName"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 性别</div>
                    <div class="profile-info-value">
                        <span class="editable " name="sexStr"></span>
                    </div>

                    <div class="profile-info-name"> 出生日期</div>
                    <div class="profile-info-value">
                        <span class="editable " name="birthdayStr"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 电话</div>
                    <div class="profile-info-value">
                        <span class="editable " name="tel"></span>
                    </div>

                    <div class="profile-info-name"> 备注</div>
                    <div class="profile-info-value">
                        <span class="editable " name="notes"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    G.datepicker({
        autoclose: true,
        todayHighlight: true
    });

    var importUrl = '${basePath}/abroad-group-user/abroad-user-list.do';
    var loadAccompanyUrl = '${basePath}/come/come-nameBook/load-accompany-list.do';
    var deleteAccUrl = '${basePath}/come/come-nameBook/accompany-delete.do';

    var loadVisitorUrl = '${basePath}/come/come-visitor/load-visitor-list.do';
    var deleteVisUrl = '${basePath}/come/come-nameBook/visitor-delete.do';

    var comeInfoId = '${comeInfoId}';

    // 陪同人员
    var $accompanyGrid = $("#grid-table-accompany");
    var $addAccompanyRow = $("#addAccompanyRow");
    var $accompanyDialog = $("#edit-accompany-dialog");
    var $accompanyDialogForm = $("#accompanyForm");
    var $viewAccompanyDialog = $("#view-accompany-dialog");
    var accompanyNum;

    var $importAccompanyBtn = $("#importAccompany");
    var $importAccompanyDialog = $("#import-accompany-dialog");

    // 来访人员
    var $visitorGrid = $("#grid-table-visitor");
    var $addVisitorRow = $("#addVisitorBtn");
    var $exportVisitorBtn = $("#exportVisitorBtn");
    var $visitorDialog = $("#edit-visitor-dialog");
    var $visitorDialogForm = $("#visitorForm");
    var $viewVisitorDialog = $("#view-visitor-dialog");
    var visitorNum;


    var accompanyColModel = [
        {name: 'id', index: 'id', hidden: true},
        {name: 'name', header: '姓名', index: 'name', sortable: true},
        {name: 'sexStr', header: '性别', index: 'sex', sortable: true},
        {name: 'sex', header: '性别', hidden: true},
        {name: 'tel', header: '电话', index: 'tel', sortable: true},
        {name: 'birthdayStr', header: '出生日期', index: 'birthday', sortable: false},
        {name: 'personnelOrg', header: '工作单位', index: 'personnelOrg', sortable: true},
        {name: 'mainDuty', header: '职务(职称)', index: 'mainDuty', sortable: true},
        {name: 'otherDuty', header: '其他职务', index: 'otherDuty', hidden: true},
        {name: 'politicsStatus', header: '政治面貌', index: 'politicsStatus', hidden: true},
        {name: 'adminLevel', header: '行政级别', index: 'adminLevel', hidden: true},
        {name: 'cppccFlagStr', header: '是否政协', index: 'cppccFlag', sortable: true},
        {name: 'cppccFlag', header: '是否政协', hidden: true},
        {name: 'foreignIdentity', header: '对外身份', index: 'foreignIdentity', sortable: true},
        {name: 'roleName', header: '角色', index: 'dicParam.id', sortable: true},
        {name: 'roleId', header: '角色Id', hidden: true},
        {name: 'notes', header: '备注', hidden: true},
        {name: 'basic', header: '基本操作', sortable: false, width: 200, fixed: true, formatter: basicOperationFormatter}
    ];

    var visitorColModel = [
        {name: 'id', index: 'id', hidden: true},
        {name: 'cnName', header: '中文名', index: 'cnName', sortable: true},
        {name: 'name', header: '外文名', index: 'name', sortable: true},
        {name: 'duty', header: '职务(职称)', index: 'duty', sortable: true},
        {name: 'roleName', header: '角色', index: 'dicParam.id', sortable: true},
        {name: 'roleId', header: '角色Id', hidden: true},
        {name: 'sexStr', header: '性别', index: 'sex', sortable: true},
        {name: 'sex', header: '性别', hidden: true},
        {name: 'tel', header: '电话', index: 'tel', sortable: true},
        {name: 'birthdayStr', header: '出生日期', index: 'birthday', sortable: true},
        {name: 'notes', header: '备注', hidden: true},
        {name: 'basic', header: '基本操作', sortable: false, width: 200, fixed: true, formatter: basicOperationFormatter}
    ];

    function basicOperationFormatter(cellvalue, options, rowData, action) {
        var operations = [];

        operations.push("<div style='margin-left:5px;font-size: 20px;'>");
        operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
        operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
        operations.push('</button>');

        operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
        operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
        operations.push('</button>');

        operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete">');
        operations.push(' <i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
        operations.push('</button>');

        operations.push("</div>");
        cellvalue = operations.join('');
        return cellvalue;
    }

    $accompanyGrid.tjGrid({
        loadUrl: loadAccompanyUrl,
        height: '100%',
        autowidth: true,
        colModel: accompanyColModel,
        postData: {
            comeInfoId: comeInfoId
        },
        sortname: 'dicParam',
        sortorder: 'asc',
        rowNum: -1,
        pgbuttons: false,
        pginput: false,
        gridComplete: function () {
            // 内部人员人数
            accompanyNum = $(this).jqGrid('getGridParam', 'records');

            //调整表格宽度
            var parent_column = $accompanyGrid.closest('[class*="col-"]');
            $accompanyGrid.tjGrid("triggerResizeGrid");
            $accompanyGrid.closest(".ui-jqgrid-bdiv").css({"width": parent_column.width() * 1.00093});
        },
        onSelectRow: function (id, stat, e) {

            if (e === undefined) {
                return false;
            }
            var className = $(e.target).attr('class');
            if (!className) {
                return false;
            }
            var rowData = $accompanyGrid.jqGrid('getRowData', id);

            if (className.indexOf('row-record-view') !== -1) {
                viewAccompany(rowData);
            } else if (className.indexOf('row-record-delete') !== -1) {
                G.confirm({
                    message: '确认删除此条人员信息吗？',
                    callback: function (result) {
                        if (result) {
                            $.post(deleteAccUrl, {id: id}, function (data) {
                                if (data.result) {
                                    G.showGritterSuccess("删除成功");
                                    $accompanyGrid.tjGrid('reloadGrid');
                                }
                            });
                        }
                    }
                });
            } else if (className.indexOf('row-record-edit') !== -1) {
                editAccompanyRow($accompanyDialogForm, rowData, $accompanyDialog);
            }
        }
    });

    // 陪同人员名单换行
    $accompanyGrid.sortableRows({
        update : function(event, ui){
            var id = $(ui.item).attr("id");
            var rowIndex = ui.item.context.rowIndex;
            updateRowIndex(id, rowIndex, "in");
        }
    });

    // 拖拽换行，更新相关记录的排序号
    function updateRowIndex(id, rowIndex, flag) {
        var updateUrl = '${basePath}/come/come-nameBook/update-row-index.do';

        $.ajax({
            url: updateUrl,
            type: "POST",
            data: {id: id, rowIndex: rowIndex, flag: flag},
            dataType: "json",
            success: function () {

            },
            error: function () {
                G.alert({message: "换行失败！"});
            }
        });
    }

    $accompanyGrid.tjGrid("triggerResizeGrid");

    $visitorGrid.tjGrid({
        loadUrl: loadVisitorUrl,
        height: '100%',
        autowidth: true,
        colModel: visitorColModel,
        postData: {
            comeInfoId: comeInfoId
        },
        sortname: 'dicParam',
        sortorder: 'asc',
        rowNum: -1,
        pgbuttons: false,
        pginput: false,
        gridComplete: function () {
            // 内部人员人数
            visitorNum = $(this).jqGrid('getGridParam', 'records');

            //调整表格宽度
            var parent_column = $accompanyGrid.closest('[class*="col-"]');
            $accompanyGrid.tjGrid("triggerResizeGrid");
            $accompanyGrid.closest(".ui-jqgrid-bdiv").css({"width": parent_column.width() * 1.00093});
        },
        onSelectRow: function (id, stat, e) {

            if (e === undefined) {
                return false;
            }
            var className = $(e.target).attr('class');
            if (!className) {
                return false;
            }
            var rowData = $visitorGrid.jqGrid('getRowData', id);

            if (className.indexOf('row-record-view') !== -1) {
                viewVisitor(rowData);
            } else if (className.indexOf('row-record-delete') !== -1) {
                G.confirm({
                    message: '确认删除此条人员信息吗？',
                    callback: function (result) {
                        if (result) {
                            $.post(deleteVisUrl, {id: id}, function (data) {
                                if (data.result) {
                                    G.showGritterSuccess("删除成功");
                                    $visitorGrid.tjGrid('reloadGrid');
                                }
                            });
                        }
                    }
                });
            } else if (className.indexOf('row-record-edit') !== -1) {
                editVisitorRow($visitorDialogForm, rowData, $visitorDialog);
            }
        }
    });

    $visitorGrid.tjGrid("triggerResizeGrid");

    // 添加一行陪同人员
    $addAccompanyRow.unbind('click').bind('click', function (e) {
        e.preventDefault();
        accompanyDialog($accompanyDialogForm, $accompanyDialog, 'add');
    });

    // 编辑陪同人员
    function editAccompanyRow($form, rowData, $dialog) {
        $form.find('.editable').each(function () {
            $(this).val(rowData[$(this).attr('name')]);
        });

        accompanyDialog($form, $dialog, 'edit')
    }

    // 批量导入陪同人员
    $importAccompanyBtn.unbind('click').bind('click', function (e) {
        e.preventDefault();
        $.ajax({
            url: importUrl,
            type: "GET",
            data: {comeInfoId: comeInfoId},
            dataType: "html",
            success: function (String) {
                $importAccompanyDialog.html(String);
                importAccompanyDialog($importAccompanyDialog);
            },
            error: function () {
                G.alert({message: "操作失败！"});
            }
        });
    });

    $exportVisitorBtn.unbind('click').bind('click', function (e) {
        e.preventDefault();

        var exportUrl = '${basePath}/come/come-nameBook/come-visitor-export.do?comeInfoId=' + $comeInfoId.val();

        var $downloadForm = $("<form method='post'></form>");
        $downloadForm.attr("action", exportUrl);
        $(document.body).append($downloadForm);
        $downloadForm.submit();
    });

    // 添加一行来访人员
    $addVisitorRow.unbind('click').bind('click', function (e) {
        e.preventDefault();
        visitorDialog($visitorDialogForm, $visitorDialog, 'add');
    });

    // 编辑来访人员
    function editVisitorRow($form, rowData, $dialog) {
        $form.find('.editable').each(function () {
            $(this).val(rowData[$(this).attr('name')]);
        });

        visitorDialog($form, $dialog, 'edit')
    }

    var enableClick = true;
    // 新增陪同人员弹窗
    function accompanyDialog($form, $dialog, flag) {

        var saveRowUrl = '${basePath}/come/come-nameBook/add-accompany-row.do';

        $dialog.removeClass('hide').dialog({
            resizable: false,
            height: 'auto',
            width: 800,
            maxHeight: 600,
            modal: true,
            title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>新增/编辑陪同人员</h4></div>",
            title_html: true,
            close: function () {
                $form.tjValidate("resetForm");
            },
            buttons: [
                {
                    html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                    "class": "btn btn-warning",
                    click: function () {
                        $dialog.dialog("close");
                    }
                },
                {
                    html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 确定",
                    "class": "btn btn-success",
                    click: function () {
                        if ($form.validate().form()) {

                            if (enableClick) {
                                enableClick = false;
                                var data = $form.serializeObject();
                                data.comeInfoId = comeInfoId;
                                if (flag === 'add') {
                                    data.seq = accompanyNum + 1;
                                }
                                var loadId = G.showAjaxLoading();
                                $.ajax({
                                    url: saveRowUrl,
                                    type: 'post',
                                    dataType: 'json',
                                    data: data,
                                    async: true
                                }).done(function (map) {
                                    enableClick = true;
                                    G.doneAjaxLoading(loadId);
                                    if (map.result) {
                                        G.showGritterSuccess("操作成功！");
                                        $accompanyGrid.tjGrid('reloadGrid');
                                        $dialog.dialog('close');
                                    } else {
                                        G.showGritterFail("操作失败,请稍后重试！");
                                    }
                                });
                            }
                        }
                    }
                }
            ]
        });

        $form.tjValidate({
            focusInvalid: true,
            rules: {
                name: {required: true, maxlength: 32},
                sex: {required: true},
                tel: {required: true, maxlength: 20},
                birthdayStr: {required: true},
                mainDuty: {required: true, maxlength: 50},
                otherDuty: {required: false, maxlength: 50},
                personnelOrg: {required: true, maxlength: 50},
                adminLevel: {required: false, maxlength: 50},
                politicsStatus: {required: false, maxlength: 50},
                foreignIdentity: {required: false, maxlength: 50},
                notes: {required: false, maxlength: 1500},
                roleId: {required: true},
                cppccFlag: {required: true}
            },
            messages: {
                name: {required: "姓名不能为空"},
                sex: {required: "性别不能为空"},
                tel: {required: "电话不能为空"},
                birthdayStr: {required: "出生日期不能为空"},
                mainDuty: {required: "主要职务不能为空"},
                personnelOrg: {required: "工作单位不能为空"},
                roleId: {required: "角色不能为空"},
                cppccFlag: {required: "是否政协不能为空"}
            }
        });
    }

    var enableImportClick = true;
    // 批量导入陪同人员名单
    function importAccompanyDialog($container) {

        var saveImportUrl = '${basePath}/come/come-nameBook/import-save.do';

        $container.removeClass('hide').dialog({
            resizable: false,
            height: 'auto',
            maxHeight: 600,
            width: 850,
            modal: true,
            title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-fire green'></i> 导入</h4></div>",
            title_html: true,
            close: function () {
                $container.empty();
            },

            buttons: [
                {
                    html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                    "class": "btn btn-warning commitBtn",
                    click: function () {
                        $container.dialog("close");
                    }
                },
                {
                    html: "<i class='ace-icon fa fa-check  bigger-110'></i>&nbsp; 提交",
                    "class": "btn btn-success",
                    click: function () {
                        if (item_selected.length > 0) {

                            if (enableImportClick) {
                                enableImportClick = false;
                                var loadId = G.showAjaxLoading();
                                var postData = {
                                    'comeInfoId': comeInfoId,
                                    'userIds': JSON.stringify(item_selected)
                                };
                                $.ajax({
                                    url: saveImportUrl,
                                    type: 'post',
                                    dataType: 'json',
                                    data: postData,
                                    async: true
                                }).done(function (map) {
                                    enableImportClick = true;
                                    G.doneAjaxLoading(loadId);
                                    if (map.result) {
                                        G.showGritterSuccess("导入成功！");
                                        $accompanyGrid.tjGrid('reloadGrid');
                                        $container.dialog('close');
                                    } else {
                                        G.showGritterFail("导入失败,请稍后重试！");
                                    }
                                });
                            }
                        } else {
                            G.alert({message: "请先选择要导入的人员"});
                        }
                    }
                }
            ]
        });
    }

    var enableVisitorClick = true;
    // 来访人员弹窗
    function visitorDialog($form, $dialog, flag) {

        var saveRowUrl = '${basePath}/come/come-nameBook/add-visitor-row.do';
        $dialog.removeClass('hide').dialog({
            resizable: false,
            height: 'auto',
            width: 800,
            modal: true,
            title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>新增/编辑来访人员</h4></div>",
            title_html: true,
            close: function () {
                $form.tjValidate("resetForm");
            },
            buttons: [
                {
                    html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                    "class": "btn btn-warning",
                    click: function () {
                        $dialog.dialog("close");
                    }
                },
                {
                    html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 确定",
                    "class": "btn btn-success",
                    click: function () {
                        if ($form.validate().form()) {
                            if (enableVisitorClick) {
                                enableVisitorClick = false;

                                var data = $form.serializeObject();
                                data.comeInfoId = comeInfoId;
                                if (flag === 'add') {
                                    data.seq = visitorNum + 1;
                                }

                                var loadId = G.showAjaxLoading();
                                $.ajax({
                                    url: saveRowUrl,
                                    type: 'post',
                                    dataType: 'json',
                                    data: data,
                                    async: true
                                }).done(function (map) {
                                    enableVisitorClick = true;
                                    G.doneAjaxLoading(loadId);
                                    if (map.result) {
                                        G.showGritterSuccess("操作成功！");
                                        $visitorGrid.tjGrid('reloadGrid');
                                        $dialog.dialog('close');
                                    } else {
                                        G.showGritterFail("操作失败,请稍后重试！");
                                    }
                                });
                            }

                        }
                    }
                }
            ]
        });

        $form.tjValidate({
            focusInvalid: true,
            rules: {
                name: {required: true, maxlength: 50},
                cnName: {required: true, maxlength: 50},
                sex: {required: true},
                duty: {required: true, maxlength: 50},
                tel: {required: false, maxlength: 20},
                role: {required: true},
                notes: {required: false, maxlength: 200}
            },
            messages: {
                name: {required: "外文名不能为空"},
                cnName: {required: "中文名不能为空"},
                sex: {required: "性别不能为空"},
                duty: {required: "职位不能为空"},
                role: {required: "角色不能为空"}
            }
        });

    }

    // 查看陪同人员
    function viewAccompany(rowData) {
        $viewAccompanyDialog.find('.editable').each(function () {
            $(this).html(rowData[$(this).attr('id')]);
        });

        initViewDialog($viewAccompanyDialog);
    }

    // 查看来访人员
    function viewVisitor(rowData) {
        $viewVisitorDialog.find('.editable').each(function () {
            $(this).html(rowData[$(this).attr('name')]);
        });

        initViewDialog($viewVisitorDialog);
    }

    // 查看人员弹窗
    function initViewDialog($container) {
        $container.removeClass('hide').dialog({
            resizable: false,
            height: 'auto',
            maxHeight: 600,
            width: 800,
            modal: true,
            title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看人员信息</h4></div>",
            title_html: true,
            close: function () {
                $container.addClass('hide');
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

    $(document).ready( function (e) {

        $('.ui-jqdialog').remove();
        $('.ui-dialog').remove();
    });

</script>