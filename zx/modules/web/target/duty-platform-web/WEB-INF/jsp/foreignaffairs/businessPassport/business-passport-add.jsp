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

                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                            <label class="col-sm-4 control-label"
                                                                   for="form-field-empName">姓名(中文)：</label>

                                                            <div class="col-sm-8">
                                                                    <input class="form-control" name="empName"
                                                                           id="form-field-empName" type="text"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-4">
                                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                            <label class="col-sm-4 control-label"
                                                                   for="form-field-deptId">工作单位：</label>

                                                            <div class="col-sm-8 deptDiv">
                                                                <input type="text" id="form-field-deptId" name="deptId"
                                                                       class="hide" value=""/>
                                                                <input type="text" class="form-control" id="form-field-deptName"
                                                                       name="deptName" value="" style="cursor: pointer;" readonly/>
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
                <%--<div class="row">
                    <div class="col-xs-12">
                        <div class="btn-group pull-right contacts-exportBtn">
                            <button class="btn btn-info btn-sm" type="button" id="jumpBtn"
                                    style="top: 6px;right: 15px;">
                                <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                扫描
                            </button>
                        </div>
                    </div>
                </div>--%>
                <div class="row">
                    <div class="col-xs-12">
                        <div class="btn-group pull-right contacts-exportBtn">
                            <button class="btn btn-info btn-sm" type="button" id="backBtn" style="top: 6px;right: 15px;">
                                <span class="ace-icon fa fa-undo icon-on-right bigger-110"></span>
                                返回
                            </button>
                        </div>
                        <%--<div class="pull-right">
                            <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue bigger-150 mar_r_10 mar_t_5"></i>
                        </div>--%>
                    </div>
                </div>
                <%--<div class="row">
                    <div class="col-xs-12">
                        <div class="header-table-th">呈批件流转登记</div>
                        <div class="table-content col-md-12">
                            <div class="col-md-12 jqgrid_box" style="padding: 0px;background: #fff;">
                                <table id="grid-table" class="table_list"></table>
                            </div>
                        </div>

                    </div>
                </div>--%>
                <div class="row">
                    <div class="col-xs-12">
                        <div class="header-table-th">人员列表</div>
                        <div class="table-content col-md-12">
                            <div class="col-md-12 jqgrid_box" style="padding: 0px;background: #fff;">
                                <table id="grid-table" class="table_list"></table>
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

        G.initDept('deptDiv',true,null,TREE_NODE);

        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $backBtn = $("#backBtn");

        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");

        var loadUrl = '${basePath}/business-passport/load-user.do';
        var isCanTransactUrl = '${basePath}/business-passport/business-passport-is-can-transact.do';
        var transactUrl = '#page/business-passport/business-passport-transact';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'empName', header: '姓名', index: 'empName', sortable: true},
            {name: 'sexStr', header: '性别', index: 'sexStr', sortable: true,width: 80},
            {name: 'nation', header: '民族', index: 'nation', sortable: true},
            {name: 'birthday', header: '出生日期', index: 'birthday', sortable: true},
            {name: 'birthplace', header: '出生地', index: 'birthplace', sortable: true},
            {name: 'phone', header: '电话', index: 'phone', sortable: true},
            {name: 'deptName', header: '工作单位', index: 'deptName', sortable: true},
            {name: 'mainDuty', header: '主要职务', index: 'mainDuty', sortable: true},
            {name: 'rankName', header: '行政级别', index: 'rankName', sortable: true},
            {name: 'transactStatus', header: '办理状态', hidden: true},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 100,
                fixed: true,
                formatter: basicOperationFormatter
            }
        ];

        function basicOperationFormatter(cellvalue, options, rowData, action) {

            var operations = [];

            var isTransact = rowData.transactStatus;

            if (isTransact) {
                operations.push("<div style='margin-left:8px;font-size: 20px;'>");
                operations.push(' <button title="办理" class="btn btn-minier btn-white btn-purple row-record-view">');
                operations.push('<i class="ace-icon fa fa-book blue row-record-view"></i> 已办理');
                operations.push('</button>');
                operations.push("</div>");
            } else {
                operations.push("<div style='margin-left:8px;font-size: 20px;'>");
                operations.push(' <button title="办理" class="btn btn-minier btn-white btn-purple row-record-transactUrl">');
                operations.push('<i class="ace-icon fa fa-book blue row-record-transactUrl"></i> 办理');
                operations.push('</button>');
                operations.push("</div>");
            }
            cellvalue = operations.join('');
            return cellvalue;
        }

        $gridTable.tjGrid({
            loadUrl: loadUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            sortname: 'createDate',
            sortorder: 'desc',
            onSelectRow: function (id, stat, e) {

                if (e === undefined) {
                    return false;
                }
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }

                if (className.indexOf('row-record-transact') !== -1) {
                    var userId = id;
                    $.post(isCanTransactUrl, {userId: userId}, function (map) {
                        if (map.result) {
                            G.pjaxLoadPageContentDiv(transactUrl + '?userId=' + id);
                        } else {
                            G.alert({message: '该人员已经办理过因公护照!'});
                        }
                    });
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        var $empName = $("#form-field-empName");
        var $deptId = $("#form-field-deptId");

        $searchBtn.click(function () {
            search();
        });

        function search() {
            var empName = $empName.val();
            var deptId = $deptId.val();
            $gridTable.tjGrid('setPostData', {
                empName: empName,
                searchDeptId: deptId
            });
            reloadGrid();
        }

        function reloadGrid() {
            $gridTable.tjGrid('reloadGrid');
        }

        $resetBtn.click(function () {
            $searchForm.resetForm();
            search();
        });

        $backBtn.click(function () {
            G.pjaxLoadPageContentDiv('#page/business-passport/business-passport-list?SubSecPopeDomViewId=68');
        });

        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy("#grid-table");
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

    });
</script>