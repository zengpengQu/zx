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
                <!-- #section:custom/widget-box -->
                <div class="accordion-style2 accordion">
                    <div class="group group-bottom">
                        <h5 class="group-header accordion-header" style="width: 160px;">
                            <span class="searchTj">
                                查询条件
                            </span>
                        </h5>
                        <%--查询条件--%>
                        <div class="widget-body" style="border-top-width: 1px;background: #fff;">
                            <div class="widget-main">
                                <div class="col-xs-12">
                                    <form class="form-horizontal" role="form" id="searchForm" autocomplete="off">
                                        <%--隐藏域--%>
                                        <div class="hidden">
                                            <c:choose>
                                                <c:when test="${fn:contains(curOperateAuth,'74_12')}">
                                                    <input type="text" id="form-field-status" name="status" value="0,1"/>
                                                    <%--具有查看其他部门记录的权限，则向后台传入 viewOthers 参数，不具有则留空--%>
                                                    <input type="text" name="viewOthers" value="yes"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="text" id="form-field-status" name="status" value="1,2"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="row">
                                            <%--督查事项--%>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-supMatter">督查事项:</label>
                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" type="text"
                                                               id="form-field-supMatter" style="width: 100%"
                                                               name="supMatter" value=""/>
                                                    </div>
                                                </div>
                                            </div>
                                            <%--主办单位--%>
                                            <%--<div class="col-xs-4" hidden>--%>
                                            <%--<div class="form-group" style="margin-top: 5px;margin-bottom: 5px">--%>
                                            <%--<label class="col-sm-4 control-label"--%>
                                            <%--for="form-field-hostUnitId">主办单位:</label>--%>
                                            <%--<div class="col-sm-8 ">--%>
                                            <%--<c:choose>--%>
                                            <%--<c:when test="${fn:contains(roleStr,'1') or fn:contains(roleStr,'6')}">--%>
                                            <%--<select class="form-control" id="form-field-hostUnitId"--%>
                                            <%--name="hostUnitId">--%>
                                            <%--<option value="">-----请选择-----</option>--%>
                                            <%--<c:forEach items="${deptList}" var="dept">--%>
                                            <%--<option value="${dept.id}">${dept.deptName}</option>--%>
                                            <%--</c:forEach>--%>
                                            <%--</select>--%>
                                            <%--</c:when>--%>
                                            <%--<c:otherwise>--%>
                                            <%--<input type="text" id="form-field-hostUnitId"--%>
                                            <%--name="hostUnitId"--%>
                                            <%--class="hide" value="${curDept.id}"/>--%>
                                            <%--<input type="text" id="form-field-deptName"--%>
                                            <%--readonly="readonly" style="width: 100%"--%>
                                            <%--name="deptName" value="${curDept.deptName}"/>--%>
                                            <%--</c:otherwise>--%>
                                            <%--</c:choose>--%>
                                            <%--</div>--%>
                                            <%--</div>--%>
                                            <%--</div>--%>

                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-hostUnitId">主办单位:</label>
                                                    <div class="col-sm-8 deptDiv">
                                                        <input type="text" id="form-field-hostUnitId" name="hostUnitId"
                                                               class="hide" value="${curDept.id}"/>
                                                        <input type="text" class="form-control" id="form-field-hostUnitName"
                                                               name="hostUnitName" value="${curDept.absName}" style="cursor: pointer;" readonly="readonly"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <%--协办单位--%>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label">协办单位:</label>

                                                    <div class="col-sm-8 deptDiv">
                                                        <input type="text" id="form-field-cooperativeId" name="cooperativeId"
                                                               class="hide" value="${curDept.id}"/>
                                                        <input type="text" class="form-control"
                                                               id="form-field-cooperative"
                                                               name="deptName" value="${curDept.absName}" style="cursor: pointer;" readonly="readonly"/>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>

                                        <div class="row">
                                            <%--督查事项编号--%>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-serialNumber">督查事项编号:</label>
                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" type="text"
                                                               id="form-field-serialNumber"
                                                               style="width: 100%"
                                                               name="serialNumber" value=""/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label">下发日期:</label>
                                                    <div class="col-sm-8 ">
                                                        <div class="input-daterange input-group"
                                                             data-date-format="yyyy-mm-dd">
                                                            <input type="text" class="form-control"
                                                                   name="beginTime" id="beginTime"/>
                                                            <span class="input-group-addon">
												            <i class="fa fa-exchange"></i>
											                </span>
                                                            <input type="text" class="form-control"
                                                                   name="endTime" id="endTime"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-3 pull-right" style="margin-top: 5px;margin-bottom: 5px">
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
        <%--空格--%>
        <div class="row">
            <div class="space-10"></div>
        </div>
        <%--按钮--%>
        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right contacts-exportBtn">
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'74_1' eq curOpertate}">
                            <button class="btn btn-info btn-sm" type="button" id="addBtn" style="top: 6px;right: 15px;">
                                <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                新增
                            </button>
                        </c:if>
                    </c:forEach>
                </div>

            </div>
        </div>
        <%--列表--%>
        <div class="row">
            <div class="col-xs-12">
                <div class="header-table-th">督查事项浏览</div>
                <div class="table-content col-md-12">
                    <div class="col-md-12 " style="padding: 0px;background: #fff;">
                        <table id="grid-table"></table>
                    </div>

                </div>

            </div>
        </div>
    </div>
</div>
<%--查看--%>
<div id="view-dialog" class="hide">
    <div class="row">
        <div class="col-xs-12">
            <div class="profile-user-info profile-user-info-striped">
                <%--督查事项编号--%>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 督查事项编号</div>
                    <div class="profile-info-value">
                        <span class="editable " id="serialNumber"></span>
                    </div>
                </div>
                <%--主办单位--%>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 主办单位</div>
                    <div class="profile-info-value">
                        <span class="editable " id="hostUnitName"></span>
                    </div>
                </div>
                <%--协办单位--%>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 协办单位</div>
                    <div class="profile-info-value">
                        <span class="editable " id="cooperativeName"></span>
                    </div>
                </div>
                <%--签发时间--%>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 签发时间</div>
                    <div class="profile-info-value">
                        <span class="editable " id="issuedDate"></span>
                    </div>
                </div>
                <%--督查事项--%>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 督查事项</div>
                    <div class="profile-info-value">
                        <span class="editable " id="supMatter"
                              style="word-break: normal;max-width: 500px;display: block;white-space: pre-wrap;
                        word-wrap: break-word;overflow: hidden"></span>
                    </div>
                </div>
                <%--办理要求--%>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 办理要求</div>
                    <div class="profile-info-value">
                        <span class="editable " id="requirements"
                              style="word-break: normal;max-width: 500px;display: block;white-space: pre-wrap;
                        word-wrap: break-word;overflow: hidden"></span>
                    </div>
                </div>
                <%--状态--%>
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
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        //初始化页面
        var curOperateAuth = '${curOperateAuth}';
        // 非督察室用户，只能查看主办单位、协办单位为其所属单位的事项
        if (curOperateAuth.indexOf('74_12') !== -1) {
            G.initDept('deptDiv',true,['{}', '{}'],TREE_NODE);
        } else {
            G.initDept('deptDiv',false,['${curDept}', '${curDept}'],TREE_NODE);
        }

        var initParam = G.initGridParam($("#searchForm"));

        //时间控件
        $('.input-daterange').datepicker({autoclose: true, todayHighlight: true});
        //搜索栏
        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        //表单类全局变量
        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");
        var $viewDialog = $("#view-dialog");

        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");

        //查询条件的变量
        var $supMatter = $("#form-field-supMatter");
        var $hostUnitId = $("#form-field-hostUnitId");
        var $cooperativeId = $("#form-field-cooperativeId");
        var $cooperative = $("#form-field-cooperative");
        var $serialNumber = $("#form-field-serialNumber");
        var $beginTime = $("#beginTime");
        var $endTime = $("#endTime");
        var $status = $("#form-field-role");

        var loadUrl = '${basePath}/supervision-matter/load-matter-list.do';
        var editUrl = '#page/supervision-matter/load-matter-edit';
        var deleteUrl = '${basePath}/supervision-matter/matter-delete.do';
        var feedbackViewUrl = '#page/supervision-feedback/load-feedback-list';

        var colModel = [{name: 'id', index: 'id', hidden: true},
            {name: 'serialNumber', header: '督查事项编号', width: 50, index: 'serialNumber', sortable: true},
            {name: 'hostUnitId', header: '主办单位ID', width: 50, index: 'hostUnitId', sortable: true, hidden: true},
            {name: 'hostUnitName', header: '主办单位', width: 50, index: 'hostUnitName', sortable: true},
            {name: 'cooperativeName', header: '协办单位', width: 50, index: 'cooperativeName', sortable: true},
            {name: 'issuedDate', header: '下发日期', width: 50, index: 'issuedDate', sortable: true},
            {name: 'supMatter', header: '督查事项', width: 50, index: 'supMatter', sortable: true},
            {name: 'requirements', header: '办理要求', width: 50, index: 'requirements', sortable: true, hidden: true},
            {name: 'status', header: '状态', index: 'status', sortable: false, hidden: true},
            {
                name: 'statusName',
                header: '状态',
                width: 50,
                index: 'statusName',
                align: 'center',
                sortable: false,
                formatter: statusOperationFormatter
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
                name: 'work',
                header: '业务操作',
                sortable: false,
                width: 150,
                fixed: true,
                formatter: workOperationFormatter
            }
        ];

        function statusOperationFormatter(cellvalue, options, rowData, action) {
            var status = rowData.status;
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
            <c:if test="${'74_2' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue row-record-view"></i> 查看');
            operations.push('</button>');
            </c:if>
            <c:if test="${'74_3' eq curOpertate}">
            if (status === '0') {
                operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
                operations.push('<i class="ace-icon fa fa-pencil blue row-record-edit"></i> 编辑');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'74_4' eq curOpertate}">
            if (status === '0') {
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

        function workOperationFormatter(cellvalue, options, rowData, action) {
            var operations = [];
            var status = rowData.status;
            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'74_6' eq curOpertate}">
            if (status === '0') {
                operations.push(' <button title="下发" class="btn btn-minier btn-white btn-info lowerHair">');
                operations.push('<i class="ace-icon glyphicon glyphicon-arrow-down lowerHair"></i> 下发');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'74_9' eq curOpertate}">
            if (status === '1') {
                operations.push(' <button title="查看反馈" class="btn btn-minier btn-white btn-primary backCheckLowerHair">');
                operations.push('<i class="ace-icon glyphicon glyphicon-check backCheckLowerHair"></i> 查看反馈');
                operations.push('</button>');
            }
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        $gridTable.tjGrid({
            initParam: initParam,
            loadUrl: loadUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            sortname: 'updateTime',
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
                //查看
                if (className.indexOf('row-record-view') !== -1) {
                    viewSupervisionMatter(rowData);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    //删除
                    G.confirm({
                        message: '确认删除此条督查事项信息吗？',
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
                    //编辑
                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm, $gridTable);
                    }
                    G.pjaxLoadPageContentDiv(editUrl + "?id=" + id);
                } else if (className.indexOf('lowerHair') !== -1) {
                    //下发
                    handleSupervisionMatter(id, '1');
                } else if (className.indexOf('backCheckLowerHair') !== -1) {
                    //查看反馈
                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm, $gridTable);
                    }
                    var hostUnitId = rowData.hostUnitId;
                    G.pjaxLoadPageContentDiv(feedbackViewUrl + "?id=" + id + "&hostUnitId=" + hostUnitId + '&date=' + new Date().getTime());
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        //查询
        $searchBtn.click(function () {
            search();
        });

        function search() {
            G.search($searchForm,$gridTable);
        }

        //重置
        $resetBtn.click(function () {
            $searchForm.resetForm();
            search();
        });

        //新增
        $addBtn.click(function () {
            G.pjaxLoadPageContentDiv(editUrl);
        });

        //查看信息
        function viewSupervisionMatter(rowData) {
            //为弹出框赋值
            $viewDialog.find('.editable').each(function () {
                $(this).html(rowData[$(this).attr('id')]);
            });
            initViewDialog($viewDialog);
        }

        //初始化查看督查事项弹出框
        function initViewDialog($container) {
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='height: 39px;line-height: 39px;'>查看督查事项</h4></div>",
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

        //下发&查收&反馈后查收
        function handleSupervisionMatter(id, type) {
            var operName = "";
            var reportUrl = '${basePath}/supervision-matter/handle-matter.do';
            if (type === '1') {
                operName = '下发';
            } else if (type === '2') {
                operName = '查收';
            } else if (type === '5') {
                //反馈后查收
                operName = '查收';
            }
            G.confirm({
                message: '确认' + operName + '此条督查事项信息吗？',
                callback: function (result) {
                    if (result) {
                        var loadId = G.showAjaxLoading();
                        $.ajax({
                            type: 'post',
                            dataType: 'json',
                            url: reportUrl,
                            data: {id: id, type: type},
                            async: true
                        }).done(function (map) {
                            G.doneAjaxLoading(loadId);
                            if (map.result) {
                                G.showGritterSuccess("督查事项" + operName + "成功!");
                            } else {
                                G.showGritterFail("督查事项" + operName + "失败,请稍后重试!");
                            }
                            //更新表格数据
                            G.search($searchForm, $gridTable);
                        });
                    }
                }
            });
        }

        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy('#grid-table');
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>