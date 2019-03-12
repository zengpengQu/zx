<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>
<title>履职支撑平台</title>

<div class="row">
    <div class="col-xs-12">
        <!-- 查询条件 -->
        <div class="row">
            <div class="col-xs-12 widget-container-col ">
                <!-- 查询条件 -->
                <div class="accordion-style2 accordion">
                    <div class="group group-bottom">
                        <h5 class="group-header accordion-header">
                           <span class="searchTj">
                                查询条件
                            </span>
                        </h5>
                        <div class="widget-body" style="border-top-width: 1px;background: #fff;">
                            <div class="widget-main">
                                <div class="col-xs-12">
                                    <form class="form-horizontal" role="form" id="searchForm">
                                        <input hidden name="curUserId" id="curUserId">

                                        <div class="row">
                                            <!-- 姓名 -->
                                            <div class="col-xs-4">
                                                <label class="col-sm-4 control-label" for="form-field-empName"
                                                       style="padding-left: 0px;">
                                                    姓名(中文)：
                                                </label>
                                                <div class="col-sm-8 ">
                                                    <input type="text" id="form-field-empName" name="empName"
                                                           class="form-control " value=""/>
                                                </div>
                                            </div>
                                            <!-- 证件号码 -->
                                            <div class="col-xs-4">
                                                <label class="col-sm-4 control-label" for="form-field-permitCode">
                                                    证件号码：
                                                </label>
                                                <div class="col-sm-8 ">
                                                    <input type="text" id="form-field-permitCode" name="permitCode"
                                                           class="form-control " value=""/>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="space-10"></div>
                                        </div>
                                        <!-- 查询按钮 -->
                                        <div class="row">
                                            <!-- 有效时间 -->
                                            <div class="col-xs-4">
                                                <label class="col-sm-4 control-label"
                                                       for="form-field-signDate">
                                                    签发日期：
                                                </label>
                                                <div class="col-sm-8 ">
                                                    <div class="input-group date date-picker"
                                                         data-date-format="yyyy-mm-dd">
                                                        <input class="form-control" name="signDate"
                                                               id="form-field-signDate"
                                                               type="text"/>
                                                        <span class="input-group-addon">
                                                                <i class="fa fa-calendar bigger-110"></i>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- 至 -->
                                            <div class="col-xs-4">
                                                <label class="col-sm-4 control-label"
                                                       for="form-field-validDate">
                                                    有效日期至：
                                                </label>
                                                <div class="col-sm-8 ">
                                                    <div class="input-group date date-picker"
                                                         data-date-format="yyyy-mm-dd">
                                                        <input class="form-control" name="validDate"
                                                               id="form-field-validDate"
                                                               type="text"/>
                                                        <span class="input-group-addon">
                                                                <i class="fa fa-calendar bigger-110"></i>
                                                            </span>
                                                    </div>
                                                </div>
                                            </div>
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
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--<div class="row">--%>
        <%--<div class="space-10"></div>--%>
        <%--</div>--%>

        <!-- 新增&导出 -->
        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right contacts-exportBtn">
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'83_4' eq curOpertate}">
                            <button class="btn btn-info btn-sm" type="button" id="addBtn"
                                    style="right: 100px;top: 24px;">
                                <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                新增
                            </button>
                        </c:if>
                        &nbsp;
                        <c:if test="${'83_8' eq curOpertate}">
                            <button class="btn btn-sm btn-success" id="exportBtn"
                                style="float: right;margin-bottom: 5px;    top: 24px;right: 15px;">
                                <i class="ace-icon glyphicon glyphicon-export icon-on-right bigger-110"></i>导出
                            </button>
                        </c:if>
                    </c:forEach>

                </div>
                <%--<div class="pull-right">--%>
                <%--<i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue bigger-150 mar_r_10 mar_t_5"></i>--%>
                <%--</div>--%>
            </div>
        </div>
        <!-- 表格 -->
        <div class="row">
            <div class="col-xs-12">
                <div class="header-table-th">港澳通行证管理列表</div>
                <div class="table-content col-md-12">
                    <div class="col-md-12" style="padding: 0px;background: #fff;">
                        <table id="grid-table"></table>
                    </div>

                </div>


            </div>
        </div>
    </div>
</div>
<!--借取填写信息-->
<div id="borrow-dialog" class="hidden">
    <form id="borrowForm" role="form">
        <div class="space-8"></div>
        <!-- 借取人 -->
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" >
                        借取人： <span class="required">*</span>
                    </label>
                    <div class="col-sm-8 ">
                        <input type="text" id="borrower" name="borrower"
                               class="form-control " placeholder="借取人"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>
        <!-- 借出日期 -->
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" >
                        借出日期：<span class="required">*</span>
                    </label>
                    <div class="col-sm-8 ">
                        <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                            <input class="form-control" name="borrowTime" id="borrowTime"
                                   type="text" placeholder="借出日期"/>
                            <span class="input-group-addon">
                                <i class="fa fa-calendar bigger-110"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>
    </form>
</div>
<!--归还填写信息-->
<div id="return-dialog" class="hidden">
    <form id="returnForm" role="form">
        <div class="space-8"></div>
        <!-- 归还人 -->
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-5 control-label text-right" >
                        归还人：<span class="required">*</span>
                    </label>
                    <div class="col-sm-7 ">
                        <input type="text" id="returnPeople" name="returnPeople"
                               class="form-control " placeholder="归还人"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>
        <!-- 实际归还日期 -->
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-5 control-label text-right" >
                        实际归还日期：<span class="required">*</span>
                    </label>
                    <div class="col-sm-7 ">
                        <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                            <input class="form-control" name="returnTime" id="returnTime"
                                   type="text" placeholder="实际归还日期"/>
                            <span class="input-group-addon">
                                <i class="fa fa-calendar bigger-110"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<!--销毁填写理由-->
<div id="destroy-dialog" class="hidden">
    <form id="destroyForm" role="form">
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" >销毁理由：
                        <span class="required">*</span></label>
                    <div class="col-sm-8 ">
                    <textarea class="form-control limited" id="destroyReason"
                              name="destroyReason" maxlength="200" style="min-height: 100px;" placeholder="销毁理由"></textarea>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<script src="${basePath}/plugin/ace/assets/js/ace/elements.fileinput.js"></script>
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {
        //初始化页面
        var curOperateAuth = '${curOperateAuth}';
        // 没有编辑权限的用户，只能查看个人的证件
        if (curOperateAuth.indexOf('83_2') === -1) {
            $("#curUserId").val('${curUser.id}')
        }

        var initParam = G.initGridParam($("#searchForm"));

        //时间控件校验
        $('.input-daterange').datepicker({
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayHighlight: true
            }
        );

        G.datepicker();

        //搜索条件
        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        //元素类全局变量(搜索条件)
        var $curUserId = $("#curUserId");
        var $empName = $("#form-field-empName");
        var $permitCode = $("#form-field-permitCode");
        var $signDate = $("#form-field-signDate");
        var $validDate = $("#form-field-validDate");

        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");

        // 表单类全局变量
        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");

        //存放用户选择的表格列
        var item_selected = [];

        //访问路径
        var loadUrl = '${basePath}/hk-macao/load-hk-macao-list.do';
        var addUrl = '#page/hk-macao/hk-macao-add';
        var editUrl = '#page/hk-macao/hk-macao-edit';
        var deleteUrl = '${basePath}/hk-macao/load-hk-macao-delete.do';
        var viewUrl = '#page/hk-macao/hk-macao-view';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'dicUser', header: '姓名', index: 'dicUser', sortable: true, width: 100},
            {name: 'sexStr', header: '性别', index: 'sexStr', sortable: true, hidden: true},
            {name: 'permitCode', header: '证件号码', index: 'permitCode', sortable: true},
            {name: 'department', header: '工作部门', index: 'department', sortable: true},
            {name: 'signDateStr', header: '签发日期', index: 'signDateStr', sortable: true},
            {name: 'validDateStr', header: '有效期至', index: 'validDateStr', sortable: true},
            {name: 'birthday', header: '出生日期', index: 'birthday', sortable: true, hidden: true},
            {name: 'birthplace', header: '出生地', index: 'birthplace', sortable: true, hidden: true},
            {name: 'signOrg', header: '签发机关', index: 'signOrg', sortable: true},
            {name: 'useStatus', header: '使用状态', index: 'useStatus', sortable: true, hidden: true},
            {name: 'storeStatus', header: '保管状态', index: 'storeStatus', sortable: true, hidden: true},
            {name: 'destroy', header: '销毁状态', index: 'destroy', sortable: true, hidden: true},
            /*{name: 'storeStatus', header: '借出人', index: 'storeStatus', sortable: true, hidden: true},
            {name: 'storeStatus', header: '借出经办人', index: 'storeStatus', sortable: true, hidden: true},*/
            {
                header: '使用状态',
                sortable: false,
                editable: false,
                width:200,
                formatter: useStatusFormatter
            },
            {
                header: '保管状态',
                sortable: false,
                editable: false,
                width:200,
                formatter:storeStatusFormatter
            },
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 200,
                fixed: true,
                formatter: basicOperationFormatter
            },
            {
                header: '业务操作',
                sortable: false,
                width: 160,
                fixed: true,
                formatter: workOperationFormatter
            }
        ];

        function useStatusFormatter(cellvalue, options, rowData, action) {
            var useStatus = rowData.useStatus;
            var destroy = rowData.destroy;
            var operations = [];
            if(destroy == '0'){
                if ('0' == useStatus) {
                    operations.push("<span class='label label-success arrowed arrowed-right'>" + '正常' + "</span>");
                } else if ('1' == useStatus) {
                    operations.push("<span class='label label-danger arrowed arrowed-right'>" + '临近逾期' + "</span>");
                } else if ('2' == useStatus)  {
                    operations.push("<span class='label label-inverse arrowed arrowed-right'>" + '已逾期' + "</span>");
                }
            }else if(destroy == '1'){
                operations.push("<span class='label label-inverse arrowed arrowed-right'>" + '已销毁' + "</span>");
            }
            cellvalue = operations.join('');
            return cellvalue;
        }
        function storeStatusFormatter(cellvalue, options, rowData, action) {
            var storeStatus = rowData.storeStatus;
            var operations = [];
            if ('0' == storeStatus) {
                operations.push("<span class='label label-success arrowed arrowed-right'>" + '在库' + "</span>");
            } else {
                operations.push("<span class='label label-info arrowed arrowed-right'>" + '借出' + "</span>");
            }
            cellvalue = operations.join('');
            return cellvalue;
        }

        function basicOperationFormatter(cellvalue, options, rowData, action) {
            var destroy = rowData.destroy;
            var useStatus = rowData.useStatus;
            var operations = [];
            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
                <c:if test="${'83_1' eq curOpertate}">
                    operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
                    operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
                    operations.push('</button>');
                </c:if>
                <c:if test="${'83_2' eq curOpertate}">
                    if(destroy == '0') {
                        operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
                        operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
                        operations.push('</button>');
                    }
                </c:if>
                <c:if test="${'83_3' eq curOpertate}">
                    operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete">');
                    operations.push(' <i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
                    operations.push('</button>');
                </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        function workOperationFormatter(cellvalue, options, rowData, action){
            var destroy = rowData.destroy;
            var storeStatus = rowData.storeStatus;
            var useStatus = rowData.useStatus;

            var operations = [];
            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
                <c:if test="${'83_5' eq curOpertate}">
                    if(storeStatus == '0' && destroy == '0' && useStatus != '2'){
                        operations.push(' <button title="借出" class="btn btn-minier btn-white btn-primary row-record-borrow">');
                        operations.push('<i class="ace-icon fa fa-share blue"></i> 借出');
                        operations.push('</button>');
                    }
                </c:if>
                <c:if test="${'83_6' eq curOpertate}">
                    if(storeStatus == '1') {
                        operations.push(' <button title="归还" class="btn btn-minier btn-white btn-success row-record-return">');
                        operations.push('<i class="ace-icon fa fa-check blue"></i> 归还');
                        operations.push('</button>');
                    }
                </c:if>
                <c:if test="${'83_7' eq curOpertate}">
                    if(destroy == '0') {
                        operations.push(' <button title="销毁" class="btn btn-minier btn-white btn-warning row-record-destroy">');
                        operations.push('<i class="ace-icon fa fa-exclamation-triangle icon-on-right bigger-110"></i> 销毁');
                        operations.push('</button>');
                    }
                </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        //表格展示
        $gridTable.tjGrid({
            initParam : initParam,
            loadUrl: loadUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            postData: {
                curUserId: $curUserId.val(),
                empName: $empName.val(),
                permitCode: $permitCode.val(),
                signDate: $signDate.val(),
                validDate: $validDate.val()
            },
            sortname: 'validDate',
            sortorder: 'asc',
            multiselect: false,
            // caption: "港澳通行证管理列表",
            onSelectRow: function (id, stat, e) {
                if (e === undefined) {
                    return false;
                }
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }
                if (className.indexOf('row-record-view') !== -1) {

                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm,$gridTable);
                    }
                    //查看
                    var viewHash = viewUrl + "?id=" + id + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(viewHash);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    //删除
                    G.confirm({
                        message: '确认删除此条港澳通行证信息吗？',
                        callback: function (result) {
                            if (result) {
                                $.post(deleteUrl, {id: id}, function (data) {
                                    if (data.result) {
                                        $gridTable.tjGrid('reloadGrid');
                                    }
                                });
                            }
                        }
                    });
                } else if (className.indexOf('row-record-edit') !== -1) {

                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm,$gridTable);
                    }
                    //编辑
                    var editHash = editUrl + "?id=" + id + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(editHash);
                } else if (className.indexOf('row-record-borrow') !== -1) {
                    //借出
                    var ids = JSON.stringify(item_selected);
                    openBorrowDialog(ids);

                } else if (className.indexOf('row-record-return') !== -1) {
                    //归还
                    var ids = JSON.stringify(item_selected);
                    openReturnDialog(ids);

                } else if (className.indexOf('row-record-destroy') !== -1) {
                    //销毁
                    var ids = JSON.stringify(item_selected);
                    openDestroyDialog(ids);

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
                var parent_column = $gridTable.closest('[class*="col-"]');
                $gridTable.tjGrid("triggerResizeGrid");
                $gridTable.closest(".ui-jqgrid-bdiv").css({"width": parent_column.width() * 1.00093});

                if (initParam === undefined) {
                    $gridTable.setSelection(0, false);
                } else {
                    $gridTable.setSelection(initParam.rowIndex, false);
                }

                // 根据状态设置行颜色
                var rows = $gridTable.getDataIDs();
                for (var i = 0; i < rows.length; i++)
                {
                    var status = $gridTable.getCell(rows[i], "useStatus");
                    if(status === "2") {
                        $gridTable.jqGrid('setRowData',rows[i],false, { color:'white',weightfont:'bold',background:'red'});
                    } else if (status === "1") {
                        $gridTable.jqGrid('setRowData',rows[i],false, { weightfont:'bold',background:'#3399ff'});
                    }
                }
            },
            onSelectAll: function (aRowIds, status) {
                if (status) {
                    item_selected = _.union(item_selected, aRowIds);
                } else {
                    item_selected = _.difference(item_selected, aRowIds);
                }
            },
            beforeSelectRow: function (rowId) {
                var index = _.indexOf(item_selected, rowId);
                if (index == -1) {
                    item_selected.push(rowId);

                } else {
                    item_selected = _.pull(item_selected, rowId);
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        //条件查询
        $searchBtn.click(function () {
            search();
        });

        function search() {
            $gridTable.tjGrid('setPostData', {
                curUserId: $curUserId.val(),
                empName: $empName.val(),
                permitCode: $permitCode.val(),
                signDate: $signDate.val(),
                validDate: $validDate.val()
            });
            reloadGrid();
        }

        function reloadGrid() {
            item_selected = [];
            $gridTable.tjGrid('reloadGrid');
        }

        //重置
        $resetBtn.click(function () {
            var curUserId = $curUserId.val();
            $searchForm.resetForm();
            $curUserId.val(curUserId);
            search();
        });

        //新增按钮操作
        $addBtn.click(function () {
            G.pjaxLoadPageContentDiv(addUrl);
        });

        /*----------借出start----------*/
        var $borrowDialog = $('#borrow-dialog');
        var $borrowForm = $('#borrowForm');
        var $borrower = $('#borrower');
        var $borrowTime = $('#borrowTime');

        function openBorrowDialog(ids) {
            $borrowDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 410,
                width: 450,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-share blue'></i>借出</div>",
                title_html: true,
                close: function () {
                    $borrowForm.resetForm();
                    reloadGrid();
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn",
                        click: function () {
                            $(this).dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 确定",
                        "class": "btn btn-success",
                        click: function () {
                            var $this = $(this);
                            if($borrowForm.validate().form()) {
                                var url = '${basePath}/hk-macao/hk-macao-borrow.do';
                                $.post(url,
                                    {
                                        ids: ids,
                                        borrower: $borrower.val(),
                                        borrowTimeStr : $borrowTime.val()
                                    },
                                    function (response) {
                                        if (response.result) {
                                            reloadGrid();
                                            G.alertSuccess({message: '借出成功!'});
                                            $this.dialog("close");
                                        } else {
                                            G.alert({message: '借出失败!'});
                                        }
                                    }
                                );
                            }
                        }
                    }
                ]
            });
            $borrowDialog.dialog('open');
        }
        //数据校验
        $borrowForm.tjValidate({
            focusInvalid: true,
            rules: {
                borrower: {required: true,maxlength: 32},
                borrowTime: {required: true}
            },
            message: {
                borrower: {required: "请填写借取人"},
                borrowTime: {required: "请填写借出时间"}
            }
        });
        /*----------借出end----------*/

        /*----------归还start----------*/
        var $returnDialog = $('#return-dialog');
        var $returnForm = $('#returnForm');
        var $returnPeople = $('#returnPeople');
        var $returnTime = $('#returnTime');

        function openReturnDialog(ids) {
            $returnDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 280,
                width: 450,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-check green'></i>归还</div>",
                title_html: true,
                close: function () {
                    $returnForm.resetForm();
                    reloadGrid();
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn",
                        click: function () {
                            $(this).dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 确定",
                        "class": "btn btn-success",
                        click: function () {
                            var $this = $(this);
                            if($returnForm.validate().form()) {
                                var url = '${basePath}/hk-macao/business-hk-macao-back.do';
                                $.post(url,
                                    {
                                        ids: ids,
                                        returnPeople: $returnPeople.val(),
                                        returnTimeStr : $returnTime.val()
                                    },
                                    function (response) {
                                        if (response.result) {
                                            reloadGrid();
                                            G.alertSuccess({message: '归还成功!'});
                                            $this.dialog("close");
                                        } else {
                                            G.alert({message: '归还失败!'});
                                        }
                                    }
                                );
                            }
                        }
                    }
                ]
            });
            $returnDialog.dialog('open');
        }
        //数据校验
        $returnForm.tjValidate({
            focusInvalid: true,
            rules: {
                returnPeople: {required: true,maxlength: 32},
                returnTime: {required: true}
            },
            messages: {
                returnPeople: {required: "归还人必须填写"},
                returnTime: {required: "实际归还日期必须填写"}
            }
        });
        /*----------归还end----------*/
        /*----------销毁start----------*/
        var $destroyDialog = $('#destroy-dialog');
        var $destroyForm = $('#destroyForm');
        var $destroyReason = $('#destroyReason');

        function openDestroyDialog(ids) {
            $destroyDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 280,
                width: 450,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-exclamation-triangle red'></i>销毁</div>",
                title_html: true,
                close: function () {
                    $destroyForm.resetForm();
                    reloadGrid();
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn",
                        click: function () {
                            $(this).dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 确定",
                        "class": "btn btn-success",
                        click: function () {
                            var $this = $(this);
                            if($destroyForm.validate().form()) {
                                var url = '${basePath}/hk-macao/hk-macao-destroy.do';
                                $.post(url, {ids: ids, destroyReason: $destroyReason.val()}, function (response) {
                                    if (response.result == true) {
                                        reloadGrid();
                                        G.alertSuccess({message: '销毁成功!'});
                                        $this.dialog("close");
                                    } else {
                                        G.alert({message: '销毁失败!'});
                                    }
                                });
                            }
                        }
                    }
                ]
            });
            $destroyDialog.dialog('open');
        }

        $destroyForm.tjValidate({
            focusInvalid: true,
            rules: {
                destroyReason: {required: true}
            },
            messages: {
                destroyReason: {required: "销毁理由必须填写"}
            }
        });
        /*----------销毁end----------*/

        /*--------导出start--------*/
        var $exportBtn = $("#exportBtn");
        $exportBtn.click(function () {
            G.confirm({
                message: '确认导出来往港澳证件信息吗?',
                callback: function (result) {
                    if (result) {
                        var empName = $empName.val();
                        var permitCode = $permitCode.val();
                        var signDate = $signDate.val();
                        var validDate = $validDate.val();
                        location.href='${basePath}/hk-macao/export-excel.do?empName='
                            + empName + '&permitCode=' + permitCode + '&date1=' + signDate + '&date2=' + validDate, "_blank";
                    }
                }
            });
        });
        /*--------导出end--------*/

        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy('#grid-table');
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>