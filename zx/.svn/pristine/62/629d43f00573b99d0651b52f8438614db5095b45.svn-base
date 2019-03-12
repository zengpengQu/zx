<%--
  Created by IntelliJ IDEA.
  User: admin
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
                                    <form class="form-horizontal" role="form" id="searchForm">
                                        <div class="row">
                                            <div class="control-group col-xs-4">
                                                <div class="radio"
                                                     style="float: left;padding-left: 5px;paddign-right: 5px;margin-left: 55px;margin-bottom: 18px;">
                                                    <label>
                                                        <input name="form-field-radio" type="radio" id="dradio"
                                                               checked="checked">
                                                        <span class="lbl"> 按日期</span>
                                                    </label>
                                                </div>

                                                <div class="radio"
                                                     style="float: left;padding-left: 20px;margin-left: 5px;">
                                                    <label>
                                                        <input name="form-field-radio" type="radio" id="mradio">
                                                        <span class="lbl"> 按月份</span>
                                                    </label>
                                                </div>

                                                <div class="radio" style="float: left;margin-left: 5px;">
                                                    <label>
                                                        <input name="form-field-radio" type="radio" id="yradio">
                                                        <span class="lbl"> 按年度</span>
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="col-xs-4" style="margin-bottom: 10px;">
                                                <label class="col-xs-4 control-label">上报时间: </label>
                                                <div class="col-xs-8" id="timeDiv">
                                                    <div class="input-daterange input-group"
                                                         data-date-format="yyyy-mm-dd">
                                                        <input type="text" class="form-control"
                                                               name="sendTimeStr" id="sendTimeStr"/>
                                                        <span class="input-group-addon">
												            <i class="fa fa-exchange"></i>
											                </span>
                                                        <input type="text" class="form-control"
                                                               name="endTime" id="endTime"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <label class="col-xs-4 control-label"
                                                       for="form-field-keyword">标题关键字: </label>
                                                <div class="col-xs-8">
                                                    <input class="form-control" type="text"
                                                           id="form-field-keyword" name="keyWord">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-xs-4" style="margin-bottom: 18px;">
                                                <label class="col-xs-4 control-label"
                                                       for="form-title-leader">报送领导: </label>
                                                <div class="col-xs-8">
                                                    <input class="form-control" type="text"
                                                           id="form-title-leader"
                                                           name="leader">
                                                </div>
                                            </div>
                                            <div class="col-xs-4 deptDiv">
                                                <label class="col-xs-4 control-label"
                                                       for="form-field-dept"> 报送单位: </label>
                                                <div class="col-xs-8 deptDiv">
                                                    <input type="text" id="form-field-department" name="department"
                                                           class="hide" value=""/>
                                                    <input type="text" class="form-control" id="form-field-dept"
                                                           name="dept" value="" style="cursor: pointer;" readonly="readonly"/>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <label class="col-xs-4 control-label"
                                                > 是否会签： </label>
                                                <div class="col-xs-8" style="margin-top: 3px;">
                                                    <input type="radio" name="counterSignFlag"
                                                           class="control-label" style="font-weight: bold;"
                                                           value="1"
                                                    />是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input type="radio" name="counterSignFlag"
                                                           class="control-label"
                                                           style="font-weight: bold;margin-top: 5px;margin-bottom: 5px"
                                                           value="0"
                                                    />否
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="pull-right" style="margin-top: 5px;margin-bottom: 5px">
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
                <div class="btn-group pull-right contacts-exportBtn">
                    <button class="btn btn-info btn-sm" type="button" id="deptExcelBtn"
                            style="top: 6px;right: 15px;">
                        <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                        各部门上报呈批件导出
                    </button>
                    <button class="btn btn-info btn-sm" type="button" id="leaderExcelBtn" style="top: 6px;">
                        <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                        领导批示导出
                    </button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="header-table-th">呈批件汇总数据</div>
                <div class="table-content col-md-12">
                    <div class="col-md-12" style="padding: 0px;background: #fff;">
                        <table id="grid-table" class="table_list"></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="view-dialog" class="hide">
    <div class="row">
        <div class="col-xs-12">
            <div class="profile-user-info profile-user-info-striped">
                <div class="profile-info-row">
                    <div class="profile-info-name"> 标题</div>

                    <div class="profile-info-value">
                        <span class="editable " id="title"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 报送单位</div>

                    <div class="profile-info-value">
                        <span class="editable " id="orgName"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 报送领导</div>

                    <div class="profile-info-value">
                        <span class="editable " id="leaName"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 上报时间</div>

                    <div class="profile-info-value">
                        <span class="editable " id="sendTime"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 签报人</div>

                    <div class="profile-info-value">
                        <span class="editable " id="signature"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 是否会签</div>

                    <div class="profile-info-value">
                        <span class="editable " id="counterSignFlagStr"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 会签单位</div>

                    <div class="profile-info-value">
                        <span class="editable " id="counterSignUnit"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    var scripts = [null, null];
    //当通过标签切换显示的时候,第二个jqgrid的宽度不能自适应。
    //解决:当标签切换完成的时候,重新设置jqgrid的宽度值等于其父元素的宽度值即可。
    $('.grid_tab').on('shown.bs.tab', function () {
        $($(this).attr('href')).find('.table_list').jqGrid(
            'setGridWidth', $($(this).attr('href')).find('.jqgrid_box').width());
    });

    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        $(".input-daterange").datepicker({
            startView: 0,
            format: 'yyyy-mm-dd',
            maxViewMode: 2,
            minViewMode: 0,
            autoclose: true
        });

        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        G.initDept('deptDiv', true, null, TREE_NODE);

        //元素类全局变量
        var $startDate = $("#sendTimeStr");
        var $endDate = $("#endTime");
        var $keyword = $("#form-field-keyword");
        var $leader = $("#form-title-leader");
        var $dept = $("#form-field-dept");
        var $deptId = $("#form-field-department");

        var $deptExcelBtn = $("#deptExcelBtn");
        var $leaderExcelBtn = $("#leaderExcelBtn");


        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");

        //表单类全局变量
        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");
        //弹窗类全局变量
        var $viewDialog = $("#view-dialog");

        //本页面url
        var loadUrl = '${basePath}/data-batch/load-batch-data-list.do';

        //选择日的
        $("#dradio").click(function () {
            $(".input-daterange").remove();
            var operations = [];
            operations.push('<div class="input-daterange input-group" data-date-format="yyyy-mm-dd"> ');
            operations.push('<input type="text" class="form-control name="sendTimeStr" id="sendTimeStr"/>');
            operations.push('<span class="input-group-addon"><i class="fa fa-exchange"></i></span>');
            operations.push('<input type="text" class="form-control" name="endTime" id="endTime"/>');
            operations.push('</div>');
            $("#timeDiv").append(operations.join(''));
            $(".input-daterange").datepicker({
                startView: 0,
                format: 'yyyy-mm-dd',
                maxViewMode: 2,
                minViewMode: 0,
                autoclose: true
            });
            $startDate = $("#sendTimeStr");
            $endDate = $("#endTime");
        });
        //选择月
        $("#mradio").click(function () {
            $(".input-daterange").remove();
            var operations = [];
            operations.push('<div class="input-daterange input-group" data-date-format="yyyy-mm-dd"> ');
            operations.push('<input type="text" class="form-control name="sendTimeStr" id="sendTimeStr"/>');
            operations.push('<span class="input-group-addon"><i class="fa fa-exchange"></i></span>');
            operations.push('<input type="text" class="form-control" name="endTime" id="endTime"/>');
            operations.push('</div>');
            $("#timeDiv").append(operations.join(''));
            $(".input-daterange").datepicker({
                startView: 1,
                format: 'yyyy-mm-dd',
                maxViewMode: 2,
                minViewMode: 1,
                autoclose: true
            });
            $startDate = $("#sendTimeStr");
            $endDate = $("#endTime");
        });
        //选择年
        $("#yradio").click(function () {
            $(".input-daterange").remove();
            var operations = [];
            operations.push('<div class="input-daterange input-group" data-date-format="yyyy-mm-dd"> ');
            operations.push('<input type="text" class="form-control name="sendTimeStr" id="sendTimeStr"/>');
            operations.push('<span class="input-group-addon"><i class="fa fa-exchange"></i></span>');
            operations.push('<input type="text" class="form-control" name="endTime" id="endTime"/>');
            operations.push('</div>');
            $("#timeDiv").append(operations.join(''));
            $(".input-daterange").datepicker({
                startView: 2,
                format: 'yyyy-mm-dd',
                maxViewMode: 2,
                minViewMode: 2,
                autoclose: true
            });
            $startDate = $("#sendTimeStr");
            $endDate = $("#endTime");
        });


        var colModel = [{name: 'id', index: 'id', hidden: true},
            {name: 'title', header: '标题', index: 'title'},
            {name: 'orgName', header: '报送单位', index: 'orgName'},
            {name: 'leaName', header: '报送领导', index: 'leaName'},
            {name: 'sendTime', header: '上报时间', index: 'sendTime',sortable: true},
            {name: 'signature', header: '签报人', index: 'signature'},
            {name: 'counterSignFlagStr', header: '是否会签', index: 'counterSignFlagStr'},
            {name: 'counterSignUnit', header: '会签单位', index: 'counterSignUnit'},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                fixed: true,
                formatter: basicOperationFormatter
            }
        ];

        $gridTable.tjGrid({
            loadUrl: loadUrl,
            height: '100%',
            width:'100%',
            autowidth: true,
            colModel: colModel,
            onSelectRow: function (id, stat, e) {
                if (e === undefined) {
                    return false;
                }
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }
                var rowData = $gridTable.jqGrid('getRowData', id);

                if (className.indexOf('row-record-view') !== -1) {
                    viewWeekWork(rowData);
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");
        //新增页面跳转

        //呈批件导出
        $deptExcelBtn.unbind('click').bind('click', function () {
            G.confirm({
                message: '确认导出呈批件吗?',
                callback: function (result) {
                    if (result) {
                        var startDate = $startDate.val();
                        var endDate = $endDate.val();
                        var keyword = $keyword.val();
                        //var dept = $dept.val();
                        var deptId = $deptId.val();
                        var counterSignFlag = $("input[name='counterSignFlag']:checked").val();
                        if (counterSignFlag == undefined) {
                            counterSignFlag = "";
                        }
                        var leader = $leader.val();
                        var url = '${basePath}/data-batch/export-excel.do?startDate=' + startDate
                            + '&endDate=' + endDate + '&keyword=' + keyword +
                            '&deptId=' + deptId + '&type=1' +
                            '&counterSignFlag=' + counterSignFlag +
                            '&leader=' + leader;
                        location.href = url;
                    }
                }
            });
        });
        //领导批示导出
        $leaderExcelBtn.unbind('click').bind('click', function () {
            G.confirm({
                message: '确认导出呈批件吗?',
                callback: function (result) {
                    if (result) {
                        var startDate = $startDate.val();
                        var endDate = $endDate.val();
                        var keyword = $keyword.val();
                        var deptId = $deptId.val();
                        var counterSignFlag = $("input[name='counterSignFlag']:checked").val();
                        if (counterSignFlag == undefined) {
                            counterSignFlag = "";
                        }
                        var leader = $leader.val();
                        var url = '${basePath}/data-batch/export-excel.do?startDate=' + startDate
                            + '&endDate=' + endDate + '&keyword=' + keyword +
                            '&deptId=' + deptId + '&type=0' +
                            '&counterSignFlag=' + counterSignFlag +
                            '&leader=' + leader;
                        location.href = url;
                    }
                }
            });
        });

        function search() {
            var startDate = $startDate.val();
            var endDate = $endDate.val();
            var keyword = $keyword.val();
            var leader = $leader.val();
            var deptId = $deptId.val();
            var counterSignFlag = $("input[name='counterSignFlag']:checked").val();
            if (counterSignFlag == undefined) {
                counterSignFlag = "";
            }

            $gridTable.tjGrid('setPostData', {
                startTime: startDate,
                endTime: endDate,
                keyWord: keyword,
                leader: leader,
                deptId: deptId,
                counterSignFlag: counterSignFlag
            });
            reloadGrid();
        }

        function reloadGrid() {
            $gridTable.tjGrid('reloadGrid');
        }

        $searchBtn.click(function () {
            search();
        });

        $resetBtn.click(function () {
            $searchForm.resetForm();
            search();
        });

        //列表信息的查看
        function viewWeekWork(rowData) {

            //为弹出框赋值
            $viewDialog.find('.editable').each(function () {

                $(this).html(rowData[$(this).attr('id')]);
            });

            initViewDialog($viewDialog);
        }

        //列表信息的查看
        function initViewDialog($container) {

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>汇总列表信息查看</h4></div>",
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


        function basicOperationFormatter(cellvalue, options, rowData, action) {

            var operations = [];
            var status = rowData.status;

            operations.push("<div style='margin-left:8px;font-size: 20px;'>");

            operations.push(' <button title="确定" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
            operations.push('</button>');

            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }
    });
</script>

