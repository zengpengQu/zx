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
                                                <label class="col-sm-4 control-label no-padding-right"
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
                                                <label class="col-sm-4 control-label no-padding-right"
                                                       for="form-field-validDate">
                                                    有效期至：
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
        <!-- 新增&导出 -->
        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right contacts-exportBtn">
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'84_3' eq curOpertate}">
                            <button class="btn btn-info btn-sm" type="button" id="addBtn"
                                    style="right: 100px;top: 24px;">
                                <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                新增
                            </button>
                        </c:if>
                    </c:forEach>
                    &nbsp;
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'84_8' eq curOpertate}">
                            <button class="btn btn-sm btn-success" id="exportBtn"
                                    style="float: right;margin-bottom: 5px;top: 24px;right: 15px;">
                                <i class="ace-icon glyphicon glyphicon-export icon-on-right bigger-110"></i>
                                导出
                            </button>
                    </c:if>
                </c:forEach>
                    &nbsp;
                </div>
            </div>
        </div>
        <!-- 表格 -->
        <div class="row">
            <div class="col-xs-12">
                <div class="header-table-th">赴台通行证管理列表</div>
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
                    <label class="col-sm-4 control-label text-right">
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
        <!-- 备注 -->
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right">备注：
                        <span class="required">*</span></label>
                    <div class="col-sm-8">
                    <textarea class="form-control limited" id="borrowNotes"
                              name="borrowNotes" maxlength="200" style="min-height: 100px;" placeholder="备注"></textarea>
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
        <!-- 归还人-->
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right">归还人：
                        <span class="required">*</span></label>
                    <div class="col-sm-8 ">
                        <input type="text" id="returnPeople" name="returnPeople"
                               class="form-control " placeholder="归还人"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>
        <!-- 备注-->
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right">备注：
                        <span class="required">*</span></label>
                    <div class="col-sm-8">
                    <textarea class="form-control limited" id="returnNotes"
                              name="returnNotes" maxlength="200" style="min-height: 100px;" placeholder="备注"></textarea>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<!--催还填写信息-->
<div id="ask-return-dialog" class="hidden">
    <form id="askReturnForm" role="form">
        <div class="space-8"></div>
        <!-- 催还内容 -->
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right">催还内容：
                        <span class="required">*</span></label>
                    <div class="col-sm-8">
                    <textarea class="form-control limited" id="askContent"
                              name="askContent" maxlength="200" style="min-height: 100px;"
                              placeholder="催还内容"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>
        <!-- 备注-->
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right">备注：
                        <span class="required">*</span></label>
                    <div class="col-sm-8">
                    <textarea class="form-control limited" id="askReturnNotes"
                              name="askReturnNotes" maxlength="200" style="min-height: 100px;"
                              placeholder="备注"></textarea>
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
        var $borrowDialog = $("#borrow-dialog");
        var $borrowForm = $("#borrowForm");
        var $returnDialog = $("#return-dialog");
        var $returnForm = $('#returnForm');

        var $askReturnDialog = $('#ask-return-dialog');
        var $askReturnForm = $('#askReturnForm');

        //存放用户选择的表格列
        var item_selected = [];


        //访问路径
        var loadUrl = '${basePath}/taiwan-card/load-taiwan-card-list.do';
        var addUrl = '#page/taiwan-card/load-taiwan-card-add';
        var editUrl = '#page/taiwan-card/load-taiwan-card-edit';
        var viewUrl = '#page/taiwan-card/taiwan-card-view';
        var deleteUrl = '${basePath}/taiwan-card/taiwan-card-delete.do';
        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'empName', header: '姓名', index: 'dicUser.empName', sortable: true, width: 100},
            {name: 'sex', header: '性别', index: 'sex', sortable: true, hidden: true},
            {name: 'permitCode', header: '证件号码', index: 'permitCode', sortable: true},
            {name: 'birthday', header: '出生日期', index: 'birthday', sortable: true,hidden: true},
            {name: 'signSite', header: '签发地点', index: 'signSite', sortable: true},
            {name: 'signDate', header: '签发日期', index: 'signDate', sortable: true},
            {name: 'validDate', header: '有效期至', index: 'validDate', sortable: true},
            {name: 'idNumber', header: '身份证号', index: 'idNumber', sortable: true},
            {name: 'outOfDate', header: '是否过期', index: 'outOfDate', sortable: true,hidden: true},
            {name: 'isBorrow', header: '目前状态', index: 'isBorrow', sortable: true,hidden: true},
            {name: 'deptName', header: '工作部门', index: 'deptName', sortable: false},
            {
                header: '是否过期',
                index: 'validDate',
                sortable: true,
                editable: false,
                width:200,
                formatter: isExpiredFormatter
            },
            {
                header: '目前状态',
                sortable: false,
                editable: false,
                width:200,
                formatter:isBorrowFormatter
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
                width: 200,
                fixed: true,
                formatter: workOperationFormatter
            }
        ];

        function isExpiredFormatter(cellvalue, options, rowData, action) {
            var outOfDate = rowData.outOfDate;
            var operations = [];
            if ('outed' == outOfDate) {//已过期
                operations.push("<span class='center label label-inverse arrowed arrowed-right'>" + '逾期' + "</span>");
            } else if ('out20' == outOfDate) {//20个工作日
                operations.push("<span class='center label label-danger arrowed arrowed-right'>" + '临近逾期' + "</span>");
            } else if  ('out180' == outOfDate) {//六个月
                operations.push("<span class='center label label-warning arrowed arrowed-right'>" + '临近逾期' + "</span>");
            } else {//正常
                operations.push("<span class='center label label-success arrowed arrowed-right'>" + '有效' + "</span>");
            }
            cellvalue = operations.join('');
            return cellvalue;
        }
        function isBorrowFormatter(cellvalue, options, rowData, action) {
            var isBorrow = rowData.isBorrow;
            var operations = [];
            if ('0' == isBorrow.trim()) {
                operations.push("<span class='center label label-info arrowed arrowed-right'>" + '交来' + "</span>");
            } else if ('1' == isBorrow.trim()) {
                operations.push("<span class='center label label-info arrowed arrowed-right'>" + '借出' + "</span>");
            } else if ('2' == isBorrow.trim())  {
                operations.push("<span class='center label label-info arrowed arrowed-right'>" + '归还' + "</span>");
            }
            cellvalue = operations.join('');
            return cellvalue;
        }

        function basicOperationFormatter(cellvalue, options, rowData, action) {
            var operations = [];
            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'84_1' eq curOpertate}">
                operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
                operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
                operations.push('</button>');
            </c:if>
            <c:if test="${'84_2' eq curOpertate}">
                operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
                operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
                operations.push('</button>');
            </c:if>
            <c:if test="${'84_7' eq curOpertate}">
            operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete">');
            operations.push(' <i class="ace-icon orange fa fa-trash-o blue row-record-delete"></i> 删除');
            operations.push('</button>');
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        function workOperationFormatter(cellvalue, options, rowData, action){
            var isExpired = rowData.isExpired;
            var isBorrow = rowData.isBorrow;
            var outOfDate = rowData.outOfDate;
            var operations = [];
            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
                if(isExpired != '2'){
                    <c:if test="${'84_4' eq curOpertate}">
                        if ('1' != isBorrow & 'outed' !== outOfDate ) {
                            operations.push(' <button title="借出" class="btn btn-minier btn-white btn-primary row-record-borrow">');
                            operations.push('<i class="ace-icon fa fa-share blue"></i> 借出');
                            operations.push('</button>');
                        }
                    </c:if>
                    <c:if test="${'84_5' eq curOpertate}">
                        if ('1' == isBorrow) {
                            operations.push(' <button title="归还" class="btn btn-minier btn-white btn-success row-record-return">');
                            operations.push('<i class="ace-icon fa fa-check blue"></i> 归还');
                            operations.push('</button>');
                        }
                    </c:if>
                }
                <c:if test="${'84_6' eq curOpertate}">
                if ('1' == isBorrow) {
                    operations.push(' <button title="催还" class="btn btn-minier btn-white btn-warning row-record-askReturn">');
                    operations.push('<i class="ace-icon fa fa-bell blue"></i> 催还');
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
            loadUrl: loadUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            postData: {
                empName: $empName.val(),
                permitCode: $permitCode.val(),
                signDateStr: $signDate.val(),
                validDateStr: $validDate.val()
            },
            sortname: 'updateTime',
            sortorder: 'desc',
            multiselect: true,
            // caption: "赴台通行证管理列表",
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
                } else if (className.indexOf('row-record-edit') !== -1) {
                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm,$gridTable);
                    }
                    //编辑
                    var editHash = editUrl + "?id=" + id + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(editHash);
                } else if (className.indexOf('row-record-borrow') !== -1) {
                    //借出
                    openBorrowDialog(id);
                } else if (className.indexOf('row-record-return') !== -1) {
                    //归还
                    openReturnDialog(id);

                }  else  if (className.indexOf('row-record-askReturn') !== -1) {
                    // 催还
                    openAskReturnDialog(id);
                }else if (className.indexOf('row-record-delete') !== -1) {
                    //生成赴台任务确认件
                    G.confirm({
                        message: '确认删除赴台通行证吗?',
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
                    var status = $gridTable.getCell(rows[i], "outOfDate");
                    if(status === "outed")
                    {
                        $gridTable.jqGrid('setRowData',rows[i],false, {  color:'white',weightfont:'bold',background:'red'});
                    } else if (status === "out20") {
                        $gridTable.jqGrid('setRowData',rows[i],false, { weightfont:'bold',background:'#ffcc00'});
                    } else if (status === "out180") {
                        $gridTable.jqGrid('setRowData',rows[i],false, {  color:'white',weightfont:'bold',background:'#3399ff'});
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

        /**********************借出start******************************/
        var $borrower = $('#borrower');
        var $borrowNotes = $('#borrowNotes');

        function openBorrowDialog(id) {
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
                                var url = '${basePath}/taiwan-card/taiwan-card-borrow.do';
                                $.post(url,
                                    {
                                        id: id,
                                        borrower: $borrower.val(),
                                        borrowNotes : $borrowNotes.val()
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
                borrower: {required: true},
                borrowNotes: {required: true}
            },
            message: {
                borrower: {required: "请填写借取人"},
                borrowNotes: {required: "请填写备注"}
            }
        });
        /**********************借出end******************************/

        /**********************归还start******************************/
        var $returnPeople = $('#returnPeople');
        var $returnNotes = $('#returnNotes');

        function openReturnDialog(id) {
            $returnDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 340,
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
                                var url = '${basePath}/taiwan-card/taiwan-card-return.do';
                                $.post(url,
                                    {
                                        id: id,
                                        returnPeople: $returnPeople.val(),
                                        returnNotes : $returnNotes.val()
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

        $returnForm.tjValidate({
            focusInvalid: true,
            rules: {
                returnPeople: {required: true},
                returnNotes: {required: true}
            },
            messages: {
                returnPeople: {required: "归还人必须填写"},
                returnNotes: {required: "备注必须填写"}
            }
        });
        /**********************归还end******************************/

        /**********************催还start******************************/
        var $askContent = $('#askContent');
        var $askReturnNotes = $('#askReturnNotes');

        function openAskReturnDialog(id) {
            $askReturnDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 400,
                width: 450,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-bell blue'></i>归还</div>",
                title_html: true,
                close: function () {
                    $askReturnForm.resetForm();
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
                            if($askReturnForm.validate().form()) {
                                var url = '${basePath}/taiwan-card/taiwan-card-ask-return.do';
                                $.post(url,
                                    {
                                        id: id,
                                        askContent: $askContent.val(),
                                        askReturnNotes : $askReturnNotes.val()
                                    },
                                    function (response) {
                                        if (response.result) {
                                            reloadGrid();
                                            G.alertSuccess({message: '催还成功!'});
                                            $this.dialog("close");
                                        } else {
                                            G.alert({message: '催还失败!'});
                                        }
                                    }
                                );
                            }
                        }
                    }
                ]
            });
            $askReturnDialog.dialog('open');
        }

        $askReturnForm.tjValidate({
            focusInvalid: true,
            rules: {
                askContent: {required: true},
                askReturnNotes: {required: true}
            },
            messages: {
                askContent: {required: "催还内容必须填写"},
                askReturnNotes: {required: "备注必须填写"}
            }
        });
        /**********************催还end******************************/

        /**********************导出start******************************/
        var $exportBtn = $('#exportBtn');
        $exportBtn.click(function () {
            G.confirm({
                message: '确认导出赴台通行证信息吗?',
                callback: function (result) {
                    if (result) {
                        var empName = $empName.val();
                        var permitCode = $permitCode.val();
                        var signDateStr = $signDate.val();
                        var validDateStr = $validDate.val();
                        var url = '${basePath}/taiwan-card/export-excel.do?empName=' + empName+'&permitCode='+ permitCode
                        +'&signDateStr=' + signDateStr + '&validDateStr=' + validDateStr;
                        location.href = url;
                    }
                }
            });
        });
        /**********************导出end******************************/

        //条件查询
        $searchBtn.click(function () {
            search();
        });

        function search() {
            $gridTable.tjGrid('setPostData', {
                empName: $empName.val(),
                permitCode: $permitCode.val(),
                signDateStr: $signDate.val(),
                validDateStr: $validDate.val()
            });
            reloadGrid();
        }

        function reloadGrid() {
            item_selected = [];
            $gridTable.tjGrid('reloadGrid');
        }

        //重置
        $resetBtn.click(function () {
            $searchForm.resetForm();
            search();
        });

        //新增按钮操作
        $addBtn.click(function () {
            G.pjaxLoadPageContentDiv(addUrl);
        });

        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy("#grid-table");
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>