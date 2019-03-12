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
        <div class="row">
            <div class="col-xs-12 widget-container-col ">
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
                                    <form class="form-horizontal" role="form" autocomplete="off" id="searchForm">
                                        <input hidden name="curUserId" id="curUserId">

                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-userName">姓名(中文)：</label>
                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" name="userName"
                                                                   id="form-field-userName" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-passportNo">护照号：</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" name="passportNo"
                                                                   id="form-field-passportNo" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-validDate">护照有效期：</label>

                                                    <div class="col-sm-8 ">
                                                        <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                            <input class="form-control" name="validDate" id="form-field-validDate"
                                                                   type="text"/>
                                                            <span class="input-group-addon">
                                                                <i class="fa fa-calendar bigger-110"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-batchNumber">任务批件号：</label>
                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" id="form-field-batchNumber"
                                                                name="batchNumber"/>
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
        <div class="row">
            <div class="space-10"></div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <c:forEach items="${curOperateAuth}" var="curOpertate">
                    <c:if test="${'68_5' eq curOpertate}">
                    <div class="btn-group">
                        <button class="btn btn-warning btn-sm" type="button" id="cancelBtn">
                            <span class="ace-icon fa fa-times icon-on-right bigger-110"></span>
                            注销
                        </button>
                    </div>
                    </c:if>

                    <c:if test="${'68_5' eq curOpertate}">
                    <div class="btn-group">
                        <button class="btn btn-danger btn-sm" type="button" id="destroyBtn">
                            <span class="ace-icon fa fa-exclamation-triangle icon-on-right bigger-110"></span>
                            销毁
                        </button>
                    </div>
                    </c:if>
                    <c:if test="${'68_5' eq curOpertate}">
                    <div class="btn-group">
                        <button class="btn btn-inverse btn-sm" type="button" id="cancelAndDestroyBtn">
                            <span class="ace-icon fa fa-trash-o icon-on-right bigger-110"></span>
                            注销并销毁
                        </button>
                    </div>
                    </c:if>
                    <c:if test="${'68_5' eq curOpertate}">
                    <div class="btn-group">
                        <button class="btn btn-primary btn-sm" type="button" id="borrowBtn">
                            <span class="ace-icon fa fa-share icon-on-right bigger-110"></span>
                            借出
                        </button>
                    </div>
                    </c:if>
                    <c:if test="${'68_5' eq curOpertate}">
                    <div class="btn-group">
                        <button class="btn btn-success btn-sm" type="button" id="returnBtn">
                            <span class="ace-icon fa fa-check icon-on-right bigger-110"></span>
                            归还
                        </button>
                    </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right contacts-exportBtn">
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'68_1' eq curOpertate}">
                            <button class="btn btn-info btn-sm" type="button" id="addBtn" style="right:15px;top: 21px;">
                                <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                个人护照新增
                            </button>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12" style="margin-top: 15px;">
                <div class="header-table-th">因公护照列表</div>
                <div class="table-content col-md-12">
                    <div class="col-md-12" style="padding: 0px;background: #fff;">
                        <table id="grid-table"></table>
                    </div>

                </div>

            </div>
        </div>
    </div>
</div>

<div id="cancel-dialog" class="hidden">
    <form id="cancelForm" autocomplete="off" role="form">
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" >注销理由：
                        <span class="required">*</span></label>
                    <div class="col-sm-8 ">
                    <textarea class="form-control limited" id="cancelReason"
                              name="cancelReason" maxlength="200" style="min-height: 100px;" placeholder="注销理由"></textarea>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<div id="destroy-dialog" class="hidden">
    <form id="destroyForm" autocomplete="off" role="form">
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

<div id="cancel-and-destroy-dialog" class="hidden">
    <form id="cancelAndDestroyForm" autocomplete="off" role="form">
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-2 control-label text-right" >注销并销毁理由：
                        <span class="required">*</span></label>
                    <div class="col-sm-10 ">
                    <textarea class="form-control limited" id="cancelAndDestroyReason"
                              name="cancelAndDestroyReason" maxlength="200" style="min-height: 100px;" placeholder="注销并销毁理由"></textarea>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<div id="borrow-dialog" class="hidden">
    <form id="borrowForm" autocomplete="off" role="form">
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" >借取人：
                        <span class="required">*</span></label>

                    <div class="col-sm-8 ">
                        <input type="text" id="borrowPerson" name="borrowPerson"
                               class="form-control " placeholder="借取人"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" >借取人电话：
                        <span class="required">*</span></label>

                    <div class="col-sm-8 ">
                        <input type="text" id="borrowPersonTel" name="borrowPersonTel"
                               class="form-control " placeholder="借取人电话"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" >应归还日期：
                        <span class="required">*</span></label>

                    <div class="col-sm-8 ">
                        <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                            <input class="form-control" name="returnDate" id="returnDate"
                                   type="text" placeholder="应归还日期"/>
                            <span class="input-group-addon">
                                <i class="fa fa-calendar bigger-110"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" >借出经办人：
                        <span class="required">*</span></label>

                    <div class="col-sm-8 ">
                        <input type="text" id="borrowAgent" name="borrowAgent"
                               class="form-control " placeholder="借出经办人"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" >任务批件号：
                        <span class="required">&nbsp;</span></label>

                    <div class="col-sm-8 ">
                        <input type="text" id="borrowBatch" name="borrowBatch"
                               class="form-control " placeholder="任务批件号"/>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<div id="return-dialog" class="hidden">
    <form id="returnForm" autocomplete="off" role="form">
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-5 control-label text-right" >
                        归还经办人：<span class="required">*</span></label>

                    <div class="col-sm-7 ">
                        <input type="text" id="returnAgent" name="returnAgent"
                               class="form-control " placeholder="归还经办人"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-5 control-label text-right" >
                        实际归还日期：<span class="required">*</span></label>

                    <div class="col-sm-7 ">
                        <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                            <input class="form-control" name="actualReturnDate" id="actualReturnDate"
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

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {
        //初始化页面
        var curOperateAuth = '${curOperateAuth}';
        if (curOperateAuth.indexOf('68_5') === -1) {
            $("#curUserId").val('${curUser.id}')
        }

        var initParam = G.initGridParam($("#searchForm"));

        G.datepicker({todayHighlight: true});

        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        //元素类全局变量
        var $curUserId = $("#curUserId");
        var $userName = $("#form-field-userName");
        var $passportNo = $("#form-field-passportNo");
        var $validDate = $("#form-field-validDate");
        var $batchNumber = $("#form-field-batchNumber");

        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");
        var $cancelBtn = $("#cancelBtn");
        var $destroyBtn = $("#destroyBtn");
        var $cancelAndDestroyBtn = $("#cancelAndDestroyBtn");
        var $borrowBtn = $("#borrowBtn");
        var $returnBtn = $("#returnBtn");

        //表单类全局变量
        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");

        //存放用户选择的表格列
        var item_selected = [];

        var loadUrl = '${basePath}/business-passport/load-business-passport-list.do';
        var addUrl = '#page/business-passport/business-passport-add';
        var viewUrl = '#page/business-passport/business-passport-view';
        var editUrl = '#page/business-passport/business-passport-edit';
        var deleteUrl = '${basePath}/business-passport/business-passport-delete.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'userName', header: '姓名', index: 'userName', sortable: true},
            {name: 'passportNo', header: '护照号', index: 'passportNo', sortable: true},
            {name: 'issuePlace', header: '签发地', index: 'issuePlace', sortable: true},
            {name: 'issueDate', header: '签发日期', index: 'issueDate', sortable: true},
            {name: 'validDate', header: '护照有效期', index: 'validDate', sortable: true},
            {name: 'borrowPerson', header: '借取人', index: 'borrowPerson', sortable: true, hidden: true},
            {name: 'borrowPersonTel', header: '借取人电话', index: 'borrowPersonTel', sortable: true, hidden: true},
            {name: 'returnDate', header: '应归还日期', index: 'returnDate', sortable: true, hidden: true},
            {name: 'borrowAgent', header: '借出经办人', index: 'borrowAgent', sortable: true, hidden: true},
            {name: 'returnAgent', header: '归还经办人', index: 'returnAgent', sortable: true, hidden: true},
            {name: 'actualReturnDate', header: '实际归还日期', index: 'actualReturnDate', sortable: true, hidden: true},
            {name: 'isCancel', header: '是否注销', index: 'isCancel', sortable: true, hidden: true},
            {name: 'isDestroy', header: '是否销毁', index: 'isCancel', sortable: true, hidden: true},
            {name: 'isBorrow', header: '是否借出', index: 'isBorrow', sortable: true, hidden: true},
            {
                header: '状态',
                sortable: false,
                editable: false,
                width:220,
                formatter: statusFormatter
            },
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 220,
                fixed: true,
                formatter: basicOperationFormatter
            }
        ];

        function statusFormatter(cellvalue, options, rowData, action) {
            var isCancel = rowData.isCancel;
            var isDestroy = rowData.isDestroy;
            var isBorrow = rowData.isBorrow;
            var operations = [];
            if ('0' == isCancel && '0' == isDestroy) {//正常
                operations.push("<span class='label label-success arrowed arrowed-right'>" + '正常' + "</span>");
                if ("1" == isBorrow) {
                    operations.push("<span class='label label-info arrowed arrowed-in'>" + '已借出' + "</span>");
                }
            } else if ('1' == isCancel && '0' == isDestroy) {//已注销
                operations.push("<span class='label label-warning arrowed arrowed-right'>" + '已注销' + "</span>");
            } else if ('0' == isCancel && '1' == isDestroy) {//已销毁
                operations.push("<span class='label label-danger arrowed arrowed-right'>" + '已销毁' + "</span>");
            } else if ('1' == isCancel && '1' == isDestroy) {//注销并销毁
                operations.push("<span class='label label-inverse arrowed arrowed-right'>" + '注销并销毁' + "</span>");
            }
            cellvalue = operations.join('');
            return cellvalue;
        }

        function basicOperationFormatter(cellvalue, options, rowData, action) {

            var isCancel = rowData.isCancel;
            var isDestroy = rowData.isDestroy;
            var isBorrow = rowData.isBorrow;

            var operations = [];

            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'68_2' eq curOpertate}">
                operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
                operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue row-record-view"></i> 查看');
                operations.push('</button>');
            </c:if>
            <c:if test="${'68_3' eq curOpertate}">
                if ('0' == isCancel && '0' == isDestroy && '0' == isBorrow) {
                    operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
                    operations.push('<i class="ace-icon fa fa-pencil blue row-record-edit"></i> 编辑');
                    operations.push('</button>');
                }
            </c:if>
            <c:if test="${'68_4' eq curOpertate}">
                if ("0" == isBorrow) {
                    operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete">');
                    operations.push(' <i class="ace-icon orange fa fa-trash-o blue row-record-delete"></i> 删除');
                    operations.push('</button>');
                }
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        $gridTable.tjGrid({
            initParam : initParam,
            loadUrl: loadUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            sortname: 'updateTime',
            sortorder: 'desc',
            multiselect: true,
            postData: {
                curUserId: $curUserId.val()
            },
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

                    var viewHash = viewUrl + "?id=" + id + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(viewHash);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条临时外事活动信息吗？',
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

                    var editHash = editUrl + "?id=" + id + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(editHash);
                }
            },
            gridComplete: function () {
                var _this = this;
                if (item_selected.length > 0) {
                    for (var i = 0; i < item_selected.length; i++) {
                        $(_this).tjGrid('setSelection', item_selected[i]);
                    }
                }
                if (initParam === undefined) {
                    $gridTable.setSelection(0, false);
                } else {
                    $gridTable.setSelection(initParam.rowIndex, false);
                }
                //调整表格宽度
                var parent_column = $gridTable.closest('[class*="col-"]');
                $gridTable.tjGrid("triggerResizeGrid");
                $gridTable.closest(".ui-jqgrid-bdiv").css({"width": parent_column.width() * 1.00093});
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

        $searchBtn.click(function () {
            search();
        });

        function search() {
            var curUserId = $curUserId.val();
            var validDate = $validDate.val();
            var passportNo = $passportNo.val();
            var userName = $userName.val();
            var batchNumber = $batchNumber.val();
            $gridTable.tjGrid('setPostData', {
                curUserId: curUserId,
                validDate: validDate,
                passportNo: passportNo,
                userName: userName,
                batchNumber: batchNumber
            });
            reloadGrid();
        }

        function reloadGrid() {
            item_selected = [];
            $gridTable.tjGrid('reloadGrid');
        }

        $resetBtn.click(function () {
            var curUserId = $curUserId.val();
            $searchForm.resetForm();
            $curUserId.val(curUserId);
            item_selected = [];
            search();
        });

        $addBtn.click(function () {
            G.pjaxLoadPageContentDiv(addUrl);
        });

        /*----------注销start----------*/
        $cancelBtn.click(function () {
            if (item_selected.length > 0) {
                var ids = JSON.stringify(item_selected);
                var url = '${basePath}/business-passport/is-exist-cancel.do';
                $.post(url, {ids: ids}, function (response) {
                    if (response.result == 'canceled' || response.result == 'destroyed' || response.result == 'canceledAndDestroyed') {
                        G.alert({message: '您选择的护照存在已注销、已销毁或者注销并销毁的,请重新选择!'});
                        reloadGrid();
                    } else if (response.result == 'borrowed') {
                        G.alert({message: '您选择的护照存在已借出的,请重新选择!'});
                        reloadGrid();
                    } else if (response.result == true) {
                        G.confirm({
                            message: '确认注销已选择的因公护照吗?',
                            callback: function (result) {
                                if (result) {
                                    openCancelDialog(ids);
                                }
                            }
                        });
                    } else {
                        G.alert({message: '操作失败!'});
                    }
                });
            } else {
                G.alert({message: '请先选择因公护照!'});
            }
        });

        var $cancelDialog = $('#cancel-dialog');
        var $cancelForm = $('#cancelForm');
        var $cancelReason = $('#cancelReason');

        function openCancelDialog(ids) {
            $cancelDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 280,
                width: 450,
                modal: true,
                title: "<div class='widget-header'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-times orange'></i>注销</div>",
                title_html: true,
                close: function () {
                    $cancelForm.resetForm();
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
                            if($cancelForm.validate().form()) {
                                var url = '${basePath}/business-passport/business-passport-cancel.do';
                                $.post(url, {ids: ids, cancelReason: $cancelReason.val()}, function (response) {
                                    if (response.result == true) {
                                        reloadGrid();
                                        G.alertSuccess({message: '注销成功!'});
                                        $this.dialog("close");
                                    } else {
                                        G.alert({message: '注销失败!'});
                                    }
                                });
                            }
                        }
                    }
                ]
            });
            $cancelDialog.dialog('open');
        }

        $cancelForm.tjValidate({
            focusInvalid: true,
            rules: {
                cancelReason: {required: true}
            },
            messages: {
                cancelReason: {required: "注销理由必须填写"}
            }
        });
        /*----------注销end----------*/

        /*----------销毁start----------*/
        $destroyBtn.click(function () {
            if (item_selected.length > 0) {
                var ids = JSON.stringify(item_selected);
                var url = '${basePath}/business-passport/is-exist-destroy.do';
                $.post(url, {ids: ids}, function (response) {
                    if (response.result == 'destroyed') {
                        G.alert({message: '您选择的护照存在已销毁的,请重新选择!'});
                        reloadGrid();
                    } else if (response.result == 'borrowed') {
                        G.alert({message: '您选择的护照存在已借出的,请重新选择!'});
                        reloadGrid();
                    } else if (response.result == true) {
                        G.confirm({
                            message: '确认销毁已选择的因公护照吗?',
                            callback: function (result) {
                                if (result) {
                                    openDestroyDialog(ids);
                                }
                            }
                        });
                    } else {
                        G.alert({message: '操作失败!'});
                    }
                });
            } else {
                G.alert({message: '请先选择因公护照!'});
            }
        });

        var $destroyDialog = $('#destroy-dialog');
        var $destroyForm = $('#destroyForm');
        var $destroyReason = $('#destroyReason');

        function openDestroyDialog(ids) {
            $destroyDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 280,
                width: 450,
                modal: true,
                title: "<div class='widget-header'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-exclamation-triangle red'></i>销毁</div>",
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
                                var url = '${basePath}/business-passport/business-passport-destroy.do';
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

        /*----------注销并销毁start----------*/
        $cancelAndDestroyBtn.click(function () {
            if (item_selected.length > 0) {
                var ids = JSON.stringify(item_selected);
                var url = '${basePath}/business-passport/is-exist-cancel-and-destroy.do';
                $.post(url, {ids: ids}, function (response) {
                    if (response.result == 'canceledAndDestroyed') {
                        G.alert({message: '您选择的护照存在已注销并销毁的,请重新选择!'});
                        reloadGrid();
                    } else if (response.result == 'borrowed') {
                        G.alert({message: '您选择的护照存在已借出的,请重新选择!'});
                        reloadGrid();
                    } else if (response.result == true) {
                        G.confirm({
                            message: '确认注销并销毁已选择的因公护照吗?',
                            callback: function (result) {
                                if (result) {
                                    openCancelAndDestroyDialog(ids);
                                }
                            }
                        });
                    } else {
                        G.alert({message: '操作失败!'});
                    }
                });
            } else {
                G.alert({message: '请先选择因公护照!'});
            }
        });

        var $cancelAndDestroyDialog = $('#cancel-and-destroy-dialog');
        var $cancelAndDestroyForm = $('#cancelAndDestroyForm');
        var $cancelAndDestroyReason = $('#cancelAndDestroyReason');

        function openCancelAndDestroyDialog(ids) {
            $cancelAndDestroyDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 280,
                width: 450,
                modal: true,
                title: "<div class='widget-header'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-trash-o red'></i>注销&销毁</div>",
                title_html: true,
                close: function () {
                    $cancelAndDestroyForm.resetForm();
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
                            if($cancelAndDestroyForm.validate().form()) {
                                var url = '${basePath}/business-passport/business-passport-cancel-and-destroy.do';
                                $.post(url, {ids: ids, cancelAndDestroyReason: $cancelAndDestroyReason.val()}, function (response) {
                                    if (response.result) {
                                        reloadGrid();
                                        G.alertSuccess({message: '注销并销毁成功!'});
                                        $this.dialog("close");
                                    } else {
                                        G.alert({message: '注销并销毁失败!'});
                                    }
                                });
                            }
                        }
                    }
                ]
            });
            $cancelAndDestroyDialog.dialog('open');
        }

        $cancelAndDestroyForm.tjValidate({
            focusInvalid: true,
            rules: {
                cancelAndDestroyReason: {required: true}
            },
            messages: {
                cancelAndDestroyReason: {required: "注销并销毁理由必须填写"}
            }
        });
        /*----------注销并销毁end----------*/

        /*----------借出start----------*/
        $borrowBtn.click(function () {
            if (item_selected.length > 0) {
                var ids = JSON.stringify(item_selected);
                var url = '${basePath}/business-passport/is-exist-cancel.do';
                $.post(url, {ids: ids}, function (response) {
                    if (response.result == 'canceled' || response.result == 'destroyed' || response.result == 'canceledAndDestroyed') {
                        G.alert({message: '您选择的护照存在已注销、已销毁或者注销并销毁的,请重新选择!'});
                        reloadGrid();
                    } else if (response.result == 'borrowed') {
                        G.alert({message: '您选择的护照存在已借出的,请重新选择!'});
                        reloadGrid();
                    } else if (response.result == true) {
                        G.confirm({
                            message: '确认借出已选择的因公护照吗?',
                            callback: function (result) {
                                if (result) {
                                    openBorrowDialog(ids);
                                }
                            }
                        });
                    } else {
                        G.alert({message: '操作失败!'});
                    }
                });
            } else {
                G.alert({message: '请先选择因公护照!'});
            }
        });

        var $borrowDialog = $('#borrow-dialog');
        var $borrowForm = $('#borrowForm');
        var $borrowPerson = $('#borrowPerson');
        var $borrowPersonTel = $('#borrowPersonTel');
        var $returnDate = $('#returnDate');
        var $borrowAgent = $('#borrowAgent');
        var $borrowBatch = $('#borrowBatch');

        function openBorrowDialog(ids) {
            $borrowDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 410,
                width: 450,
                modal: true,
                title: "<div class='widget-header'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-share blue'></i>借出</div>",
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
                                var url = '${basePath}/business-passport/business-passport-borrow.do';
                                $.post(url,
                                    {
                                        ids: ids,
                                        borrowPerson: $borrowPerson.val(),
                                        borrowPersonTel : $borrowPersonTel.val(),
                                        returnDate : $returnDate.val(),
                                        borrowAgent : $borrowAgent.val(),
                                        batchNumber: $borrowBatch.val()
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

        $borrowForm.tjValidate({
            focusInvalid: true,
            rules: {
                borrowPerson: {required: true},
                borrowPersonTel: {required: true, maxlength: 20},
                returnDate: {required: true},
                borrowAgent: {required: true},
                borrowBatch: {maxlength: 64}
            },
            messages: {
                borrowPerson: {required: "借取人必须填写"},
                borrowPersonTel: {required: "借取人电话必须填写"},
                returnDate: {required: "应归还日期必须填写"},
                borrowAgent: {required: "借出经办人必须填写"}
            }
        });
        /*----------借出end----------*/

        /*----------归还end----------*/
        $returnBtn.click(function () {
            if (item_selected.length > 0) {
                var ids = JSON.stringify(item_selected);
                var url = '${basePath}/business-passport/is-exist-return.do';
                $.post(url, {ids: ids}, function (response) {
                    if (response.result == 'returned') {
                        G.alert({message: '您选择的护照存在未借出的,请重新选择!'});
                        reloadGrid();
                    } else if (response.result == true) {
                        G.confirm({
                            message: '确认归还已选择的因公护照吗?',
                            callback: function (result) {
                                if (result) {
                                    openReturnDialog(ids);
                                }
                            }
                        });
                    } else {
                        G.alert({message: '操作失败!'});
                    }
                });
            } else {
                G.alert({message: '请先选择因公护照!'});
            }
        });

        var $returnDialog = $('#return-dialog');
        var $returnForm = $('#returnForm');
        var $returnAgent = $('#returnAgent');
        var $actualReturnDate = $('#actualReturnDate');

        function openReturnDialog(ids) {
            $returnDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 280,
                width: 450,
                modal: true,
                title: "<div class='widget-header'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-check green'></i>归还</div>",
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
                                var url = '${basePath}/business-passport/business-passport-return-back.do';
                                $.post(url,
                                    {
                                        ids: ids,
                                        returnAgent: $returnAgent.val(),
                                        actualReturnDate : $actualReturnDate.val()
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
                returnAgent: {required: true},
                actualReturnDate: {required: true}
            },
            messages: {
                returnAgent: {required: "归还经办人必须填写"},
                actualReturnDate: {required: "实际归还日期必须填写"}
            }
        });
        /*----------归还end----------*/

        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy("#grid-table");
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

    });
</script>