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
                                                    <label class="col-sm-4 control-label no-padding-right"
                                                           for="form-field-empName">姓名：</label>
                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" name="empName" id="form-field-empName"type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label no-padding-right"
                                                           for="form-field-cardNumber">身份证号：</label>
                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" name="cardNumber" id="form-field-cardNumber" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label">护照时间: </label>
                                                    <div class="col-sm-8">
                                                        <div class="input-daterange input-group"
                                                             data-date-format="yyyy-mm-dd">
                                                            <input type="text" class="form-control" placeholder="签发日期"
                                                                   name="signDate" id="form-field-signDate"/>
                                                            <span class="input-group-addon">
												            <i class="fa fa-exchange"></i>
											                </span>
                                                            <input type="text" class="form-control" placeholder="有效期至"
                                                                   name="validDate" id="form-field-validDate"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-xs-12 pull-right"
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
        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right contacts-exportBtn">
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'85_5' eq curOpertate}">
                            <button class="btn btn-info btn-sm" type="button" id="addBtn" style="right: 100px;top:24px;">
                                <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                新增
                            </button>
                        </c:if>
                        &nbsp;
                        <c:if test="${'85_8' eq curOpertate}">
                        <button class="btn btn-sm btn-success" id="exportBtn"
                                style="float: right;margin-bottom: 5px;top: 24px;right: 15px;">
                            <i class="ace-icon glyphicon glyphicon-export icon-on-right bigger-110"></i>
                            导出
                        </button>
                        </c:if>
                    </c:forEach>
                </div>
                <%--<div class="pull-right">--%>
                    <%--<i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue bigger-150 mar_r_10 mar_t_5"></i>--%>
                <%--</div>--%>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="header-table-th">因私护照列表</div>
                <div class="table-content col-md-12">
                    <div class="col-md-12" style="padding: 0px;background: #fff;">
                        <table id="grid-table"></table>
                    </div>

                </div>


            </div>
        </div>
    </div>
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
                        <input type="text" id="borrower" name="borrower"
                               class="form-control " placeholder="借取人"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" >备注：
                        <span class="required">*</span></label>
                    <div class="col-sm-8">
                    <textarea class="form-control limited" id="borrowNotes"
                              name="borrowNotes" maxlength="200" style="min-height: 100px;" placeholder="备注"></textarea>
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
                    <label class="col-sm-4 control-label text-right" >归还人：
                        <span class="required">*</span></label>

                    <div class="col-sm-8 ">
                        <input type="text" id="returnPeople" name="returnPeople"
                               class="form-control " placeholder="归还人"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" >备注：
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

<div id="ask-return-dialog" class="hidden">
    <form id="askReturnForm" autocomplete="off" role="form">
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" >催还内容：
                        <span class="required">*</span></label>
                    <div class="col-sm-8">
                    <textarea class="form-control limited" id="askContent"
                              name="askContent" maxlength="200" style="min-height: 100px;" placeholder="催还内容"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" >备注：
                        <span class="required">*</span></label>
                    <div class="col-sm-8">
                    <textarea class="form-control limited" id="askReturnNotes"
                              name="askReturnNotes" maxlength="200" style="min-height: 100px;" placeholder="备注"></textarea>
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
        // 没有编辑权限的用户，只能查看个人的因私护照
        if (curOperateAuth.indexOf('85_2') === -1) {
            $("#curUserId").val('${curUser.id}');
        }

        var initParam = G.initGridParam($("#searchForm"));

        $('.input-daterange').datepicker({autoclose: true, todayHighlight: true});

        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        //元素类全局变量
        var $curUserId = $("#curUserId");
        var $empName = $("#form-field-empName");
        var $cardNumber = $("#form-field-cardNumber");
        var $signDate = $("#form-field-signDate");
        var $validDate = $("#form-field-validDate");

        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");

        //表单类全局变量
        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");

        var loadUrl = '${basePath}/private-passport/load-private-passport-list.do';
        var addUrl = '#page/private-passport/private-passport-add';
        var editUrl = '#page/private-passport/private-passport-edit';
        var viewUrl = '#page/private-passport/private-passport-view';
        var deleteUrl = '${basePath}/private-passport/private-passport-delete.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'empName', header: '姓名', index: 'empName', sortable: true, width: 100},
            {name: 'sexStr', header: '性别', index: 'sexStr', sortable: true, hidden: true},
            {name: 'passportCode', header: '证件号码', index: 'passportCode', sortable: true},
            {name: 'department', header: '工作部门', index: 'department', sortable: true},
            {name: 'birthday', header: '出生日期', index: 'birthday', sortable: true, hidden: true},
            {name: 'birthplace', header: '出生地', index: 'birthplace', sortable: true, hidden: true},
            {name: 'signDate', header: '签发日期', index: 'signDate', sortable: true},
            {name: 'validDate', header: '有效期至', index: 'validDate', sortable: true},
            {name: 'signOrg', header: '签发机关', index: 'signOrg', sortable: true, hidden: true},
            {name: 'useStatus', header: '使用状态', index: 'useStatus', sortable: true, hidden: true},
            {name: 'storeStatus', header: '保管状态', index: 'storeStatus', sortable: true, hidden: true},
            {name: 'outOfDate', header: '是否逾期Or过期', index: 'outOfDate', sortable: true, hidden: true},
            {
                header: '状态',
                sortable: false,
                editable: false,
                width:270,
                formatter: statusFormatter
            },
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 340,
                fixed: true,
                formatter: basicOperationFormatter
            }
        ];

        function statusFormatter(cellvalue, options, rowData, action) {
            var storeStatus = rowData.storeStatus;
            var outOfDate = rowData.outOfDate;
            var operations = [];
            if ('0' == storeStatus) {
                operations.push("<span class='label label-success arrowed arrowed-right'>" + '在库' + "</span>");
            } else {
                operations.push("<span class='label label-info arrowed arrowed-right'>" + '借出' + "</span>");
            }
            if ('outed' == outOfDate) {//已过期
                operations.push("<span class='label label-inverse arrowed arrowed-in'>" + '已过期' + "</span>");
            } else if ('out10' == outOfDate) {//10个工作日
                operations.push("<span class='label label-danger arrowed arrowed-in'>" + '临近逾期(职)' + "</span>");
            } else if ('out20' == outOfDate) {//20个工作日
                operations.push("<span class='label label-danger arrowed arrowed-in'>" + '临近逾期(局离退)' + "</span>");
            } else if  ('out180' == outOfDate) {//六个月
                operations.push("<span class='label label-warning arrowed arrowed-in'>" + '临近过期' + "</span>");
            } else {//正常
                operations.push("<span class='label label-success arrowed arrowed-in'>" + '正常' + "</span>");
            }
            cellvalue = operations.join('');
            return cellvalue;
        }

        function basicOperationFormatter(cellvalue, options, rowData, action) {
            var storeStatus = rowData.storeStatus;
            var outOfDate = rowData.outOfDate;
            var operations = [];
            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'85_6' eq curOpertate}">
            if ('0' == storeStatus) {
                if ('outed' != outOfDate) {
                    operations.push(' <button title="借出" class="btn btn-minier btn-white btn-primary row-record-borrow">');
                    operations.push('<i class="ace-icon fa fa-share blue"></i> 借出');
                    operations.push('</button>');
                }
            }
            </c:if>
            <c:if test="${'85_7' eq curOpertate}">
            if ('1' == storeStatus) {
                operations.push(' <button title="归还" class="btn btn-minier btn-white btn-success row-record-return">');
                operations.push('<i class="ace-icon fa fa-check blue"></i> 归还');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'85_4' eq curOpertate}">
            if ('1' == storeStatus) {
                operations.push(' <button title="催还" class="btn btn-minier btn-white btn-warning row-record-askReturn">');
                operations.push('<i class="ace-icon fa fa-bell blue"></i> 催还');
                operations.push('</button>');
            }
            //operations.push('&nbsp;');
            </c:if>
            <c:if test="${'85_1' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
            operations.push('</button>');
            </c:if>
            <c:if test="${'85_2' eq curOpertate}">
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
            operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
            operations.push('</button>');
            </c:if>
            <c:if test="${'85_3' eq curOpertate}">
            operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete">');
            operations.push(' <i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
            operations.push('</button>');
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
            // caption: "因私护照列表",
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

                if (className.indexOf('row-record-borrow') !== -1) {
                    G.confirm({
                        message: '确认借出该护照吗?',
                        callback: function (result) {
                            if (result) {
                                openBorrowDialog(id);
                            }
                        }
                    });
                } else  if (className.indexOf('row-record-return') !== -1) {
                    G.confirm({
                        message: '确认归还该护照吗?',
                        callback: function (result) {
                            if (result) {
                                openReturnDialog(id);
                            }
                        }
                    });
                } else  if (className.indexOf('row-record-askReturn') !== -1) {
                    G.confirm({
                        message: '确认催还该护照吗?',
                        callback: function (result) {
                            if (result) {
                                openAskReturnDialog(id)
                            }
                        }
                    });
                } else if (className.indexOf('row-record-view') !== -1) {
                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm,$gridTable);
                    }
                    var viewHash = viewUrl + "?id=" + id + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(viewHash);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条因私护照信息吗？',
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
                        $gridTable.jqGrid('setRowData',rows[i],false, { color:'white',weightfont:'bold',background:'red'});
                    } else if (status === "out10") {
                        $gridTable.jqGrid('setRowData',rows[i],false, { weightfont:'bold',background:'#ffcc00'});
                    } else if (status === "out20") {
                        $gridTable.jqGrid('setRowData',rows[i],false, { color:'white',weightfont:'bold',background:'#f1ff94'});
                    } else if (status === "out180") {
                        $gridTable.jqGrid('setRowData',rows[i],false, {  color:'white',weightfont:'bold',background:'#3399ff'});
                    }
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        $searchBtn.click(function () {
            search();
        });

        function search() {
            var curUserId = $curUserId.val();
            var empName = $empName.val();
            var cardNumber = $cardNumber.val();
            var signDate = $signDate.val();
            var validDate = $validDate.val();
            $gridTable.tjGrid('setPostData', {
                curUserId: curUserId,
                empName: empName,
                cardNumber: cardNumber,
                signDate: signDate,
                validDate: validDate
            });
            reloadGrid();
        }

        function reloadGrid() {
            $gridTable.tjGrid('reloadGrid');
        }

        $resetBtn.click(function () {
            var curUserId = $curUserId.val();
            $searchForm.resetForm();
            $curUserId.val(curUserId);
            search();
        });

        $addBtn.click(function () {
            G.pjaxLoadPageContentDiv(addUrl);
        });

        /*--------借出start--------*/
        var $borrowDialog = $('#borrow-dialog');
        var $borrowForm = $('#borrowForm');
        var $borrower = $('#borrower');
        var $borrowNotes = $('#borrowNotes');

        function openBorrowDialog(id) {
            $borrowDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 340,
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
                                var url = '${basePath}/private-passport/private-passport-borrow.do';
                                $.post(url,
                                    {
                                        id: id,
                                        borrower: $borrower.val(),
                                        borrowNotes: $borrowNotes.val()
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
                borrower: {required: true},
                borrowNotes: {required: true}
            },
            messages: {
                borrower: {required: "借出人必须填写"},
                borrowNotes: {required: "备注必须填写"}
            }
        });
        /*--------借出end--------*/

        /*--------归还start--------*/
        var $returnDialog = $('#return-dialog');
        var $returnForm = $('#returnForm');
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
                                var url = '${basePath}/private-passport/private-passport-return.do';
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
        })
        /*--------归还end--------*/

        /*--------催还start--------*/
        var $askReturnDialog = $('#ask-return-dialog');
        var $askReturnForm = $('#askReturnForm');
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
                                var url = '${basePath}/private-passport/private-passport-ask-return.do';
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
        })
        /*--------催还end--------*/

        /*--------导出start--------*/
        var $exportBtn = $('#exportBtn');

        $exportBtn.click(function () {
            G.confirm({
                message: '确认导出因私护照信息吗?',
                callback: function (result) {
                    if (result) {
                        var empName = $empName.val();
                        var cardNumber = $cardNumber.val();
                        var signDate = $signDate.val();
                        var validDate = $validDate.val();
                        location.href='${basePath}/private-passport/export-excel.do?name=' +
                            empName + '&number=' + cardNumber + '&date1=' + signDate + '&date2=' + validDate;
                    }
                }
            });
        });
        /*--------导出end--------*/

        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy("#grid-table");
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

    });
</script>