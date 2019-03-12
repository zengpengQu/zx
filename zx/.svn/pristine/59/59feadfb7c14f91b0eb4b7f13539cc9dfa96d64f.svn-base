<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2018/6/11
  Time: 10:26
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

<%--word导出--%>
<script src="${basePath}/plugin/wordExport/js/FileSaver.js"></script>
<script src="${basePath}/plugin/wordExport/js/jquery.wordexport.js"></script>

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
                            <div class="widget-main" >
                                <div class="col-xs-12" >
                                    <form class="form-horizontal" role="form" id="searchForm" autocomplete="off">
                                        <input hidden value="${dutyDailyIndexMainId}" id="dutyDailyIndexMainId" name="dutyDailyIndexMainId">
                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-deptId">单位名称:</label>
                                                    <div class="col-sm-8 deptDiv">
                                                        <input type="text" id="form-field-deptId" name="deptId"
                                                               class="hide" value="${curDept.id}"/>
                                                        <input type="text" class="form-control" id="form-field-deptName"
                                                               name="deptName" value="${curDept.absName}" style="cursor: pointer;" readonly="readonly"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-sectionId">板块:</label>

                                                    <div class="col-sm-8 ">
                                                        <select class="form-control" id="form-field-sectionId"
                                                                name="sectionId">
                                                            <option value="">-----请选择-----</option>
                                                            <c:forEach items="${sectionList}" var="section">
                                                                <option value="${section.id}">${section.sectionName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-createTime" style="padding-right: 2px;">填报日期：</label>

                                                    <div class="col-sm-8 ">
                                                        <div class="input-group">
                                                            <input class="form-control date-picker"
                                                                   name="createTimeStr"
                                                                   id="form-field-createTime"
                                                                   data-date-format="yyyy-mm-dd"
                                                                    value="" type="text"/>
                                                            <span class="input-group-addon"><i
                                                                    class="fa fa-calendar bigger-110"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-status">状态:</label>

                                                    <div class="col-sm-8 ">
                                                        <select class="form-control" id="form-field-status"
                                                                name="status">
                                                            <c:choose>
                                                                <c:when test="${fn:contains(curOperateAuth,'50_11')}">
                                                                    <option value="1,2">-----请选择-----</option>
                                                                    <option value="1">已上报</option>
                                                                    <option value="2">已查收</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="">-----请选择-----</option>
                                                                    <option value="0">未上报</option>
                                                                    <option value="1">已上报</option>
                                                                    <option value="2">已查收</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4 pull-right" style="margin-top: 5px;margin-bottom: 5px">
                                                <div class="btn-group pull-right">
                                                    <button class="btn btn-success btn-sm" type="button" id="searchBtn">
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
                        <c:if test="${'50_1' eq curOpertate}">
                            <button class="btn btn-info btn-sm" type="button" id="addBtn" style="top: 6px;right: 15px;">
                                <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                新增
                            </button>
                        </c:if>
                    </c:forEach>
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'50_10' eq curOpertate}">
                            <button class="btn btn-sm btn-primary" id="uploadBtn"
                                    style="float: right;margin-bottom: 5px;top: 6px;right: 185px;">
                                <i class="ace-icon fa fa-cloud-upload  bigger-110"></i>
                                存档
                            </button>
                        </c:if>
                    </c:forEach>
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'50_4' eq curOpertate}">
                            <input type="file" id="importExcel" class="hide" accept=".xls, .xlsx"
                                   multiple="multiple"/>
                            <button class="btn btn-sm btn-purple" id="importBtn"
                                    style="margin-bottom: 5px;top: 6px;right: 100px;">
                                <i class="ace-icon glyphicon glyphicon-import icon-on-right bigger-110"></i>
                                导入
                            </button>
                        </c:if>
                    </c:forEach>
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'50_5' eq curOpertate}">
                            <button class="btn btn-sm btn-success" id="exportBtn"
                                    style="margin-bottom: 5px;top: 6px;right:273px;">
                                <i class="ace-icon glyphicon glyphicon-export icon-on-right bigger-110"></i>
                                导出
                            </button>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="header-table-th">板块信息浏览</div>
                <div class="table-content  col-md-12">
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
                    <div class="profile-info-name"> 单位名称</div>

                    <div class="profile-info-value">
                        <span class="editable " id="absName"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 日期</div>

                    <div class="profile-info-value">
                        <span class="editable " id="createTimeStr"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 信息员</div>

                    <div class="profile-info-value">
                        <span class="editable " id="creatorName"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 联系电话</div>

                    <div class="profile-info-value">
                        <span class="editable " id="tel"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 签发领导</div>

                    <div class="profile-info-value">
                        <span class="editable " id="signLeader"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 板块名称</div>

                    <div class="profile-info-value">
                        <span class="editable " id="sectionName"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 内容</div>

                    <div class="profile-info-value">
                        <span class="editable " id="content"
                        style="word-break: normal;max-width: 500px;display: block;white-space: pre-wrap;
                        word-wrap: break-word;overflow: hidden"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 状态</div>

                    <div class="profile-info-value">
                        <span class="editable " id="statusName"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="edit-dialog" class="hide"></div>
<div id="preview-dialog" class="hide" style="background-color: darkseagreen"></div>

<div id="excel-dialog" class="hide">

    <div id="excel-table" style="margin-top: 20px">

    </div>
</div>
<script id="template-excel-result" type="text/x-handlebars-template">
    <table class="table table-striped table-bordered table-hover center">
        <thead>
        <tr>
            <th class="center" width="10%">序号</th>
            <th class="center" width="30%">文件名</th>
            <th class="center" width="60%">导入结果</th>
        </tr>
        </thead>
        <tbody>
        {{#each dataList}}
        <tr class="excelResultItem">
            <td>{{indexAddOne @index}}</td>
            <td>{{filename}}</td>
            <td>{{msg}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        //初始化页面
        var curOperateAuth = '${curOperateAuth}';

        if (curOperateAuth.indexOf('50_11') !== -1) {

            G.initDept('deptDiv',true,['{}'],TREE_NODE);
        } else {
            G.initDept('deptDiv',false,['${curDept}'],TREE_NODE);
        }

        var initParam = G.initGridParam($("#searchForm"));

        G.datepicker();

        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        //元素类全局变量
        var $deptId = $("#form-field-deptId");
        var $sectionId = $("#form-field-sectionId");
        var $createTime = $("#form-field-createTime");
        var $status = $("#form-field-status");
        var $dutyDailyIndexMainId = $("#dutyDailyIndexMainId");

        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");
        var $importBtn = $("#importBtn");
        var $importExcel = $("#importExcel");
        var $exportBtn = $("#exportBtn");
        var $uploadBtn = $("#uploadBtn");

        //表单类全局变量
        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");
        var $viewDialog = $("#view-dialog");

        //弹窗类全局变量
        var $previewDialog = $("#preview-dialog");

        //存放用户选择的表格列
        var item_selected = [];

        var loadUrl = '${basePath}/duty-daily/load-duty-list.do';
        var editUrl = '#page/duty-daily/load-duty-edit';
        var deleteUrl = '${basePath}/duty-daily/duty-delete.do';


        var colModel = [{name: 'id', index: 'id', hidden: true},
            {name: 'absName', header: '单位',index: 'dicDept.absName',sortable: true},
            {name: 'deptName', header: '单位',index: 'dicDept.deptName', hidden: true, sortable: true},
            {name: 'deptId', header: '单位',  index: 'dicDept.id', hidden: true, sortable: true},
            {name: 'createTimeStr', header: '日期',index: 'createTime', sortable: true},
            {name: 'creatorName', header: '信息员',index: 'creatorName', sortable: true},
            {name: 'tel', header: '联系电话',index: 'tel', sortable: true},
            {name: 'signLeader', header: '签发领导',index: 'signLeader', sortable: true},
            {name: 'sectionName', header: '板块名称',index: 'sectionName', sortable: true},
            {name: 'sectionId', header: '板块信息', index: 'section.sectionId', hidden: true},
            {name: 'content', header: '内容', index: 'content', hidden: true},
            {
                name: 'statusName',
                header: '状态',
                index: 'statusName',
                align: 'center',
                sortable: false,
                formatter: statusOperationFormatter
            },
            {name: 'status', header: '状态',index: 'status', hidden: true,},
            {name: 'dataSource', header: '数据来源', index: 'dataSource', hidden: true,},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 200,
                fixed: true,
                formatter: basicOperationFormatter
            },
            {name: 'work', header: '业务操作', sortable: false, width: 150, fixed: true, formatter: workOperationFormatter}
        ];

        function statusOperationFormatter(cellvalue, options, rowData, action) {

            var status = rowData.status;

            var operations = [];

            if (status == '0') {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-warning">未上报</span>');
            } else if (status == '1') {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-success">已上报</span>');
            } else {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-info">已查收</span>');
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

            <c:if test="${'50_3' eq curOpertate}">
            if (status === '0') {
                operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
                operations.push('<i class="ace-icon fa fa-pencil blue row-record-edit"></i> 编辑');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'50_6' eq curOpertate}">
            if (status === '0') {
                operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete">');
                operations.push(' <i class="ace-icon orange fa fa-trash-o blue row-record-delete"></i> 删除');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'50_2' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue row-record-view"></i> 查看');
            operations.push('</button>');
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
            <c:if test="${'50_7' eq curOpertate}">
            if (status === '0') {
                operations.push(' <button title="上报" class="btn btn-minier btn-white btn-info reportDuty">');
                operations.push('<i class="ace-icon glyphicon glyphicon-arrow-up reportDuty"></i> 上报');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'50_8' eq curOpertate}">
            if (status === '1') {
                operations.push(' <button title="撤回" class="btn btn-minier btn-white btn-warning backDuty">');
                operations.push('<i class="ace-icon glyphicon glyphicon-arrow-down backDuty"></i> 撤回');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'50_9' eq curOpertate}">
            if (status === '1') {
                operations.push(' <button title="查收" class="btn btn-minier btn-white btn-primary checkDuty">');
                operations.push('<i class="ace-icon glyphicon glyphicon-check checkDuty"></i> 查收');
                operations.push('</button>');
            }
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;

        }

        $addBtn.click(function () {
            G.pjaxLoadPageContentDiv(editUrl);
        });

        //值班日报导出word文档
        $exportBtn.unbind('click').on('click', function (e) {
            e.preventDefault();
            G.confirm({
                message: '确认导出已查收的值班日报信息吗？',
                callback: function (result) {
                    if (result) {
                        if (item_selected.length > 0) {
                            exportDutyDaily(item_selected, 'part');
                        } else {
                            //不选择默认导出当天值班日报
                            var data = {
                                deptId: $deptId.val(),
                                sectionId: $sectionId.val(),
                                createTime: '${sysDate}'
                            };
                            exportDutyDaily(data, 'all');
                        }
                    }
                }
            });
        });

        //根据所选行导出值班日报
        function exportDutyDaily(data, type) {
            var postData = JSON.stringify(data);
            var url = '${basePath}/duty-daily/duty-daily-preview.do';
            //不跳转页面，直接将页面嵌入弹出框
            var loadId = G.showAjaxLoading();
            $.ajax({
                url: url,
                type: "GET",
                data: {data: postData, type: type},
                dataType: "html",
                success: function (String) {
                    $previewDialog.html(String);
                    G.doneAjaxLoading(loadId);
                    //初始化弹出框
                    initPreviewDialog($previewDialog);
                },
                error: function (e) {
                    G.doneAjaxLoading(loadId);
                    G.alert({message: "操作失败！"});
                }
            });
        }

        //初始化查看值班日报弹出框
        function initViewDialog($container) {

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='height: 39px;line-height: 39px;'><i class='ace-icon fa  fa-globe green'></i>查看值班日报</h4></div>",
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

        //初始化值班日报弹出框
        function initPreviewDialog($container) {

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 700,
                width: 1200,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>值班日报预览</h4></div>",
                title_html: true,
                close: function () {
                    $container.addClass("hide");
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-warning",
                        click: function () {
                            $(this).dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 导出",
                        "class": "btn btn-success",
                        click: function () {
                            $container.wordExport("值班日报${sysDate}");
                            $(this).dialog("close");
                        }
                    }
                ]
            });
        }

        $gridTable.tjGrid({
            initParam : initParam,
            loadUrl: loadUrl,
            height: '100%',
            width:'100%',
            autowidth: true,
            colModel: colModel,
            sortname: 'updateTime',
            sortorder: 'desc',
            multiselect: true,
            onSelectRow: function (id, stat, e) {

                if (e === undefined) {
                    return false;
                }
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }
                var rowData = $gridTable.jqGrid('getRowData', id);
                //查看
                if (className.indexOf('row-record-view') !== -1) {

                    viewDutyDaily(rowData);

                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条值班日报信息吗？',
                        callback: function (result) {
                            if (result) {
                                $.post(deleteUrl, {id: id}, function (data) {
                                    if (data.result) {
                                        G.showGritterSuccess("删除成功");
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

                    G.pjaxLoadPageContentDiv(editUrl + "?id=" + id);
                }
                //上报
                if (className.indexOf('reportDuty') !== -1) {
                    handleDutyDaily(id, '1');
                }
                //查收
                if (className.indexOf('checkDuty') !== -1) {
                    handleDutyDaily(id, '2');
                }
                //撤回
                if (className.indexOf('backDuty') !== -1) {
                    handleDutyDaily(id, '0');
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

        //查看值班日报信息
        function viewDutyDaily(rowData) {

            //为弹出框赋值
            $viewDialog.find('.editable').each(function () {

                $(this).html(rowData[$(this).attr('id')]);

            });
            initViewDialog($viewDialog);
        }

        //操作值班日报
        function handleDutyDaily(id, type) {

            var operName = "";
            var reportUrl = '${basePath}/duty-daily/handle-duty.do';
            if (type === '0') {
                operName = '撤回';
            } else if (type === '1') {
                operName = '上报';
            } else {
                operName = '查收';
            }
            G.confirm({
                message: '确认' + operName + '此条值班日报信息吗？',
                callback: function (result) {
                    if (result) {
                        $.ajax({
                            type: 'post',
                            dataType: 'json',
                            url: reportUrl,
                            data: {id: id, type: type},
                            async: true
                        }).done(function (map) {

                            if (map.result) {
                                G.showGritterSuccess("值班日报" + operName + "成功!");
                            } else {
                                G.showGritterFail("值班日报" + operName + "失败,请稍后重试!");
                            }
                            //更新表格数据
                            search();
                        });
                    }
                }
            });
        }

        $searchBtn.click(function () {
            search();
        });

        function search() {
            var deptId = $deptId.val();
            var sectionId = $sectionId.val();
            var createTime = $createTime.val();
            var status = $status.val();
            $gridTable.tjGrid('setPostData', {
                deptId: deptId,
                sectionId: sectionId,
                createTimeStr: createTime,
                status: status
            });
            reloadGrid();
        }

        function reloadGrid() {
            item_selected = [];
            $gridTable.tjGrid('reloadGrid');
        }

        $resetBtn.click(function () {
            $searchForm.resetForm();
            search();
        });

        $importBtn.click(function () {
            $importExcel.trigger('click');
        });

        $importExcel.unbind('change').bind('change', function () {
            uploadExcel(this);
        });

        function uploadExcel(obj) {
            var excelUrl = '${basePath}/duty-daily/upload-excel.do';

            var files = obj.files;

            var formData = new FormData();

            for (var i = 0; i < files.length; i++) {
                var file = files[i];
                formData.append('uploadExcel', file);
            }

            $.ajax({
                url: excelUrl,
                type: 'post',
                processData: false,
                contentType: false,
                data: formData,
                async: true
            }).done(function (map){
                if (map.result === false) {
                    G.showGritterFail("导入失败");
                    $importExcel.val("");
                } else {
                    /*展示数据*/
                    var dataList = [];

                    $.each(map.result, function (filename, item) {
                        var obj = {};
                        $.each(item, function (row, msg) {
                            obj.filename = filename;
                            obj.row = row;
                            obj.msg = msg;
                            dataList.push(obj);
                        });
                    });

                    var $excelDialog = $("#excel-dialog");
                    var $template = $("#template-excel-result");
                    var $table = $("#excel-table");

                    $table.empty();
                    var sourceHtml = $template.html();
                    var template = Handlebars.compile(sourceHtml);
                    Handlebars.registerHelper('indexAddOne', function (index, options) {
                        return parseInt(index) + 1;
                    });

                    if (null != dataList && dataList.length > 0) {
                        var data = {dataList: dataList};
                        var html = template(data);
                        $table.append(html);
                    }

                    initExcelResultDialog($excelDialog);
                    search();
                }
                $importExcel.val("");
            });

        }

        //初始化显示 Excel 导入情况弹出框
        function initExcelResultDialog($container) {

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                width: 700,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='height: 39px;line-height: 39px;'>日报文件导入结果</h4></div>",
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

        // 跳转页面至值班日报存档页面
        $uploadBtn.click(function () {
            var url = '#page/duty-daily-file/duty-daily-upload-list';
            window.location.href = url;
        });

        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy('#grid-table');
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>
<script src="${basePath}/plugin/xlsx.full.min.js" type="text/javascript"></script>