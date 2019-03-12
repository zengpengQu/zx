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
                <!-- #section:custom/widget-box -->
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
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-activityName">活动名称:</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" id="form-field-activityName"
                                                               name="activityName" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-applicationPerson">申请人:</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" id="form-field-applicationPerson"
                                                               name="applicationPerson" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label" style="padding-right: 0px;">申请时间：</label>

                                                    <div class="col-sm-8 ">
                                                        <div class="input-group">
                                                            <input id="startTime" type="text"
                                                                   class="form-control" name="start"/>
                                                            <span class="input-group-addon">
																		<i class="fa fa-exchange"></i>
																	</span>

                                                            <input id="endTime" type="text"
                                                                   class="form-control" name="end"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row" >
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
                <!-- /section:custom/widget-box -->
            </div>
        </div>
        <div class="row">
            <div class="space-10"></div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right contacts-exportBtn">
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'93_3' eq curOpertate}">
                            <button class="btn btn-info btn-sm" type="button" id="addBtn" style="top: 6px;right:15px;">
                                <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                新增
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
                <div class="header-table-th">礼品入库管理列表</div>
                <div class="table-content col-md-12">
                    <div class="col-md-12" style="padding: 0px;background: #fff;">
                        <table id="grid-table-outbound"></table>
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

        //元素类全局变量
        var $startTime = $('#startTime');
        var $endTime = $('#endTime');
        var $activityName = $("#form-field-activityName");
        var $applicationPerson = $("#form-field-applicationPerson");

        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");

        //表单类全局变量
        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table-outbound");

        var loadUrl = '${basePath}/giftPurchase/load-purchase-list.do';
        var editUrl = '#page/giftPurchase/load-purchase-edit';
        var viewUrl = '#page/giftPurchase/load-purchase-view';
        var deleteUrl = '${basePath}/giftPurchase/load-purchase-delete.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'outboundCode', header: '入库编码', index: 'outboundCode', sortable: false},
            {name: 'activityType', header: '活动类型', index: 'activityType', sortable: false},
            {name: 'activityName', header: '活动名称', index: 'activityName', sortable: false},
            {name: 'applicationPerson', header: '申请人', index: 'applicationPerson', sortable: false},
            {name: 'applicationTime', header: '申请时间', index: 'applicationTime', sortable: false},
            {name: 'transactor', header: '经办人', index: 'transactor', sortable: false},
            {name: 'outboundTime', header: '入库时间', index: 'outboundTime', sortable: false},
            {name: 'isOutbound', header: '入库状态', index: 'isOutbound', sortable: false, hidden:true},
            {
                header: '入库状态',
                sortable: false,
                editable: false,
                width:100,
                formatter: purchaseStateFormatter
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

        function purchaseStateFormatter(cellvalue, options, rowData, action) {
            var isOutbound = rowData.isOutbound;
            var operations = [];
            if (isOutbound == '未入库' ) {
                operations.push("<span class='label label-success arrowed arrowed-right'>" + '未入库' + "</span>");
            }else if (isOutbound == '已入库') {
                operations.push("<span class='label label-info arrowed arrowed-right'>" + '已入库' + "</span>");
            }
            cellvalue = operations.join('');
            return cellvalue;
        }

        function basicOperationFormatter(cellvalue, options, rowData, action) {
            var isOutbound = rowData.isOutbound;
            var operations = [];
            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'93_1' eq curOpertate}">
                operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
                operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
                operations.push('</button>');
            </c:if>
            <c:if test="${'93_2' eq curOpertate}">
                operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
                operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
                operations.push('</button>');
            </c:if>
            <c:if test="${'93_4' eq curOpertate}">
                operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete">');
                operations.push(' <i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
                operations.push('</button>');
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        $startTime.datepicker({
            autoclose: true,
            format: 'yyyy-mm-dd',
            todayHighlight: true,
            todayBtn: 'linked'
        }).on('change', function () {
            var endDate = $endTime.val();

            if (endDate != '') {
                var startDate = $startTime.val();
                if (compareDate(startDate, endDate)) {
                    $endTime.val(startDate)
                }
            }
        });

        $endTime.datepicker({
            autoclose: true,
            format: 'yyyy-mm-dd',
            todayHighlight: true,
            todayBtn: 'linked'
        }).on('change', function () {
            var startDate = $startTime.val();
            if (startDate != '') {
                var endDate = $endTime.val();
                if (compareDate(startDate, endDate)) {
                    $startTime.val(endDate)
                }
            }
        });

        function compareDate(date1, date2) {
            return (new Date(date1.replace(/-/g, "//"))) >= (new Date(date2.replace(/-/g, "//")));
        }

        $gridTable.tjGrid({
            loadUrl: loadUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            // sortname: 'updateTime',
            // sortorder: 'desc',
            // caption: "礼品入库管理列表",
            onSelectRow: function (id, stat, e) {

                if (e === undefined) {
                    return false;
                }
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }

                if (className.indexOf('row-record-view') !== -1) {
                    var viewHash = viewUrl + "?id=" + id + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(viewHash);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条礼品入库信息吗？',
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
                    var editHash = editUrl + "?id=" + id + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(editHash);
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        $searchBtn.click(function () {
            search();
        });

        function search() {
            var activityName = $activityName.val();
            var applicationPerson = $applicationPerson.val();
            var startTime = $startTime.val();
            var endTime = $endTime.val();

            $gridTable.tjGrid('setPostData', {
                activityName: activityName,
                applicationPerson: applicationPerson,
                startTime: startTime,
                endTime: endTime,
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

        $addBtn.click(function () {
            G.pjaxLoadPageContentDiv(editUrl);
        });

        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy('#grid-table-outbound');
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>