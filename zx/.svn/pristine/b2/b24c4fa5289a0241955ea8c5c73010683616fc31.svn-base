<%--
  Created by IntelliJ IDEA.
  User: BT4900
  Date: 2018/8/15
  Time: 17:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                                    <form class="form-horizontal" role="form" id="searchForm" autocomplete="off">
                                        <input value="${activityPlanIndexMain}" class="hidden" id="activityPlanIndexMain" name="activityPlanIndexMain">
                                        <div class="row">
                                            <div class="col-xs-4 hide">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-feedbackDeptId">单位名称:</label>
                                                    <div class="col-sm-8 ">
                                                        <c:choose>
                                                            <c:when test="${fn:contains(curOperateAuth,'53_14')}">
                                                                <input type="text" id="form-field-feedbackDeptId" name="feedbackDeptId"
                                                                       value=""/>
                                                                <input type="text" id="form-field-status" name="status"
                                                                       value="0,1"/>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <input type="text" id="form-field-feedbackDeptId" name="feedbackDeptId"
                                                                       value="${curDept.id}"/>
                                                                <input type="text" id="form-field-status" name="status"
                                                                       value="1"/>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label">下发日期: </label>
                                                    <div class="col-sm-8">
                                                        <div class="input-daterange input-group"
                                                             data-date-format="yyyy-mm-dd">
                                                            <input type="text" class="form-control"
                                                                   name="createDateStart" id="createDateStart"/>
                                                            <span class="input-group-addon">
												            <i class="fa fa-exchange"></i>
											                </span>
                                                            <input type="text" class="form-control"
                                                                   name="createDateEnd" id="createDateEnd"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-3 pull-right"
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
                <div class="btn-group pull-right contacts-exportBtn">
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'53_1' eq curOpertate}">
                            <button class="btn btn-info btn-sm" type="button" id="addBtn" style="top: 6px;right: 15px;">
                                <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                会议通知录入
                            </button>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="header-table-th">领导活动安排浏览</div>
                <div class="table-content col-md-12">
                    <div class="col-md-12" style="padding: 0px;background: #fff;">
                        <table id="grid-table"></table>
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
                    <div class="profile-info-name"> 是否开会</div>

                    <div class="profile-info-value">
                        <span class="editable " id="meetingFlagName"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 会议内容</div>

                    <div class="profile-info-value">
                        <span class="editable " id="content"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 状态</div>

                    <div class="profile-info-value">
                        <span class="editable " id="status"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 下发时间</div>

                    <div class="profile-info-value">
                        <span class="editable " id="sendTimeStr"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 创建时间</div>

                    <div class="profile-info-value">
                        <span class="editable " id="createTimeStr"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 创建人</div>

                    <div class="profile-info-value">
                        <span class="editable " id="createName"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

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
        var $deptId = $("#form-field-feedbackDeptId");
        var $startDate = $("#createDateStart");
        var $endDate = $("#createDateEnd");
        var $status = $("#form-field-status");

        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");

        //表单类全局变量
        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");

        //弹窗类全局变量
        var $viewDialog = $("#view-dialog");

        //本页面url
        var loadUrl = '${basePath}/activity-plan/load-plan-list.do';
        var editUrl = '#page/activity-plan/load-plan-edit';
        var feedbackEditUrl = '#page/activity-plan/load-work-feedback';
        var feedbackViewUrl = '#page/plan-receipt/load-receipt-list';
        var deleteUrl = '${basePath}/activity-plan/plan-delete.do';

        var colModel = [{name: 'id', index: 'id', hidden: true},
            {name: 'createTimeStr', header: '发起日期', index: 'createTime', sortable: true},
            {name: 'deptName', header: '发起单位', index: 'dicDept.deptName', sortable: false},
            {name: 'createName', header: '填报人', index: 'createName', sortable: true},
            {name: 'tel', header: '联系电话', index: 'tel', sortable: false},
            {name: 'meetingFlag', header: '是否开会', index: 'meetingFlag', sortable: true, hidden: true},
            {name: 'meetingFlagName', header: '是否开会', index: 'meetingFlagName', sortable: false},
            {name: 'createTimeStr', header: '创建时间', index: 'createTimeStr', sortable: false, hidden: true},
            {name: 'sendTimeStr', header: '下发时间', index: 'sendTimeStr', sortable: false, hidden: true},
            {name: 'content', header: '通知内容', index: 'content', sortable: false, hidden: true},
            {
                name: 'status',
                header: '状态',
                index: 'status',
                align: 'center',
                sortable: false,
                formatter: statusOperationFormatter
            },
            {name: 'sendTimeStr', header: '下发日期', index: 'sendTime', sortable: true},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 220,
                fixed: true,
                formatter: basicOperationFormatter
            },
            {name: 'work', header: '业务操作', sortable: false, width: 170, fixed: true, formatter: workOperationFormatter}
        ];

        $gridTable.tjGrid({
            initParam : initParam,
            loadUrl: loadUrl,
            height: '100%',
            width:'100%',
            autowidth: true,
            colModel: colModel,
            sortname: 'a.updateTime',
            sortorder: 'desc',
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

                    viewPlan(rowData);

                } else if (className.indexOf('row-record-edit') !== -1) {

                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm,$gridTable);
                    }

                    G.pjaxLoadPageContentDiv(editUrl + "?id=" + id + '&date=' + new Date().getTime());

                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条记录吗！',
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
                } else if (className.indexOf('row-record-send') !== -1) {
                    //下发领导活动会议通知
                    sendPlan(id);
                } else if (className.indexOf('view-feedback') !== -1) {

                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm,$gridTable);
                    }

                    var feedbackDeptId = $deptId.val();
                    G.pjaxLoadPageContentDiv(feedbackViewUrl + "?id=" + id + '&feedbackDeptId=' + feedbackDeptId + '&date=' + new Date().getTime());
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        //会议通知查看
        function viewPlan(rowData) {

            //为弹出框赋值
            $viewDialog.find('.editable').each(function () {

                $(this).html(rowData[$(this).attr('id')]);
            });
            initViewDialog($viewDialog);
        }

        //初始化查看会议通知弹出框
        function initViewDialog($container) {

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看会议通知</h4></div>",
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

        //下发会议通知
        function sendPlan(id) {

            var sendUrl = '${basePath}/activity-plan/send-activity-plan.do';

            G.confirm({
                message: '确认下发领导活动会议通知吗？',
                callback: function (result) {
                    if (result) {
                        $.ajax({
                            type: 'post',
                            dataType: 'json',
                            url: sendUrl,
                            data: {id: id},
                            async: true
                        }).done(function (map) {

                            if (map.result) {
                                G.showGritterSuccess("会议通知下发成功!");
                            } else {
                                G.showGritterFail("会议通知下发失败,请稍后重试!");
                            }
                            //更新表格数据
                            search();
                        });
                    }
                }
            });
        }

        //新增页面跳转
        $addBtn.unbind('click').bind('click', function () {
            G.pjaxLoadPageContentDiv(editUrl);
        });

        $searchBtn.click(function () {
            search();
        });

        function search() {

            var startDate = $startDate.val();
            var endDate = $endDate.val();
            var status = $status.val();
            var deptId = $deptId.val();

            $gridTable.tjGrid('setPostData', {
                startDateStr: startDate,
                endDateStr: endDate,
                status : status,
                deptId : deptId
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

        function statusOperationFormatter(cellvalue, options, rowData, action) {

            var status = _.trim(rowData.status);

            var operations = [];

            if (status == '0') {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-warning">未下发</span>');
            } else if (status == '1') {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-success">已下发</span>');
            } else {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-info">已反馈</span>');
            }
            operations.push('</div>');
            cellvalue = operations.join('');
            return cellvalue;
        }

        function basicOperationFormatter(cellvalue, options, rowData, action) {

            var operations = [];
            var status = rowData.status;

            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'53_2' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
            operations.push('</button>');
            </c:if>
            <c:if test="${'53_3' eq curOpertate}">
            if (status === '0') {
                operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
                operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'53_4' eq curOpertate}">
            if (status === '0') {
                operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete">');
                operations.push(' <i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
                operations.push('</button>');
            }
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        function workOperationFormatter(cellvalue, options, rowData, action) {

            var operations = [];

            var status = rowData.status;

            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'53_5' eq curOpertate}">
            if (status === '0') {
                operations.push(' <button title="下发" class="btn btn-minier btn-white btn-primary row-record-send">');
                operations.push('<i class="ace-icon glyphicon glyphicon-arrow-down"></i> 下发');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'53_10' eq curOpertate}">
            if (status === '1') {
                operations.push(' <button title="查看反馈" class="btn btn-minier btn-white btn-primary view-feedback">');
                operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out view-feedback"></i> 查看反馈');
                operations.push('</button>');
            }
            </c:if>
            <%--<c:if test="${'51_6' eq curOpertate}">--%>
            <%--if (status === '1') {--%>
            <%--operations.push(' <button title="反馈" class="btn btn-minier btn-white btn-warning row-record-feedback">');--%>
            <%--operations.push('<i class="ace-icon glyphicon glyphicon-arrow-down"></i> 反馈');--%>
            <%--operations.push('</button>');--%>
            <%--}--%>
            <%--</c:if>--%>
            <%--<c:if test="${'53_9' eq curOpertate}">--%>
            <%--if (status == '1') {--%>
                <%--operations.push(' <button title="查收" class="btn btn-minier btn-white btn-primary checkDuty">');--%>
                <%--operations.push('<i class="ace-icon glyphicon glyphicon-check"></i> 查收');--%>
                <%--operations.push('</button>');--%>
            <%--}--%>
            <%--</c:if>--%>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        $(document).one('ajaxloadstart.page', function (e) {

            $.jgrid.gridDestroy('#grid-table');
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>
