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
                                    <form class="form-horizontal" role="form" autocomplete="off" id="searchForm">
                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label no-padding-right"
                                                           for="form-field-groupName">团组名称：</label>
                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" name="groupName"
                                                                   id="form-field-groupName" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label">出国(境)起止时间: </label>
                                                    <div class="col-sm-8">
                                                            <div class="input-daterange input-group"
                                                                 data-date-format="yyyy-mm-dd">
                                                                <input type="text" class="form-control"
                                                                       name="startTime" id="form-field-startTime"/>
                                                                <span class="input-group-addon">
												            <i class="fa fa-exchange"></i>
											                </span>
                                                                <input type="text" class="form-control"
                                                                       name="endTime" id="form-field-endTime"/>
                                                            </div>
                                                        </div>
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
                        <c:if test="${'90_1' eq curOpertate}">
                            <button class="btn btn-info btn-sm" type="button" id="addBtn" style="top: 6px;right: 15px;">
                                <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                新增
                            </button>
                        </c:if>
                        <input type="file" id="importExcel" class="hide" accept=".xls, .xlsx"
                               multiple="multiple"/>
                        <c:if test="${'90_5' eq curOpertate}">
                            <button class="btn btn-sm btn-purple" id="importBtn"
                                    style="margin-bottom: 5px;top: 6px;right: 100px;">
                                <i class="ace-icon glyphicon glyphicon-import icon-on-right bigger-110"></i>
                                导入
                            </button>
                        </c:if>
                        <c:if test="${'90_5' eq curOpertate}">
                            <button class="btn btn-sm btn-success" id="exportBtn"
                                    style="float: right;margin-bottom: 5px;top: 6px;right: 185px;">
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
                <div class="header-table-th">因私出国(境)列表</div>
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
        <div class="form-group">
            <div class="profile-user-info profile-user-info-striped">
                <div class="profile-info-row">
                    <div class="profile-info-name" style="width: 15%; text-align: center">姓名</div>
                    <div class="profile-info-value" style="width: 35%;text-align: center">
                        <span class="editable" id="empName"></span>
                    </div>
                    <div class="profile-info-name" style="width: 15%;text-align: center">工作部门</div>
                    <div class="profile-info-value" style="width: 35%;text-align: center">
                        <span class="editable" id="department"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name" style="text-align: center">出国开始时间</div>
                    <div class="profile-info-value" style="text-align: center">
                        <span class="editable" id="startTime"></span>
                    </div>
                    <div class="profile-info-name" style="text-align: center">出国结束时间</div>
                    <div class="profile-info-value" style="text-align: center">
                        <span class="editable" id="endTime"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name" style="text-align: center">团组名称</div>
                    <div class="profile-info-value" style="text-align: center">
                        <span class="editable" id="groupName"></span>
                    </div>
                    <div class="profile-info-name" style="text-align: center">组团单位</div>
                    <div class="profile-info-value" style="text-align: center">
                        <span class="editable" id="groupDepartment"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name" style="text-align: center">创建时间</div>
                    <div class="profile-info-value" style="text-align: center">
                        <span class="editable" id="createTime"></span>
                    </div>
                    <div class="profile-info-name" style="text-align: center">备注</div>
                    <div class="profile-info-value" style="text-align: center">
                        <span class="editable" id="notes"></span>
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
        var $groupName = $("#form-field-groupName");
        var $startTime = $("#form-field-startTime");
        var $endTime = $("#form-field-endTime");

        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");
        var $importExcel = $("#importExcel");
        var $importBtn = $("#importBtn");
        //表单类全局变量
        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");

        var loadUrl = '${basePath}/private-abroad/load-private-abroad-list.do';
        var editUrl = '#page/private-abroad/private-abroad-edit';
        //var viewUrl = '#page/private-abroad/private-abroad-view';
        var deleteUrl = '${basePath}/private-abroad/private-abroad-delete.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'empName', header: '姓名', index: 'empName', sortable: true},
            {name: 'department', header: '工作部门', index: 'department', sortable: true},
            {name: 'startEndTime', header: '出国(境)时间', index: 'startEndTime', sortable: true, width: 300},
            {name: 'groupName', header: '团组名称(事由)', index: 'groupName', sortable: true},
            {name: 'groupDepartment', header: '组团部门', index: 'groupDepartment', sortable: true},
            {name: 'notes', header: '备注', index: 'notes', sortable: true},
            {name: 'startTime', header: '出国开始时间', hidden: true},
            {name: 'endTime', header: '出国结束时间', hidden: true},
            {name: 'createTime', header: '创建时间', hidden: true},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 220,
                fixed: true,
                formatter: basicOperationFormatter
            }
        ];

        function basicOperationFormatter(cellvalue, options, rowData, action) {

            var operations = [];

            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'90_2' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
            operations.push('</button>');
            </c:if>
            <c:if test="${'90_3' eq curOpertate}">
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
            operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
            operations.push('</button>');
            </c:if>
            <c:if test="${'90_4' eq curOpertate}">
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
                if (className.indexOf('row-record-view') !== -1) {
                    viewInfo(rowData);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条因私出国(境)信息吗？',
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
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        var $viewDialog = $("#view-dialog");

        function viewInfo(rowData) {
            //为弹出框赋值
            $viewDialog.find('.editable').each(function () {
                $(this).html(rowData[$(this).attr('id')]);
            });

            initViewDialog($viewDialog);
        }

        //初始化查看因私出国弹出框
        function initViewDialog($container) {

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看因私出国（境）信息</h4></div>",
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

        $searchBtn.click(function () {
            search();
        });

        $importBtn.click(function () {
            $importExcel.trigger('click');
        });
        $importExcel.unbind('change').bind('change', function () {
            uploadExcel(this);
        });

        function uploadExcel(obj) {
            var excelUrl = '${basePath}/private-abroad/upload-excel.do';

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
                } else if (map.result === true) {
                    G.showGritterSuccess();
                    var url = '${basePath}/private-abroad/export-excel.do?name=true';
                    location.href=url;
                    search();
                }else {
                    G.showGritterSuccess(map.result);
                    search();
                }
                $importExcel.val("");
            });

        }


        function search() {
            var groupName = $groupName.val();
            var startTime = $startTime.val();
            var endTime = $endTime.val();
            $gridTable.tjGrid('setPostData', {
                groupName: groupName,
                startTime: startTime,
                endTime: endTime
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

        /*--------导出start--------*/
        var $exportBtn = $('#exportBtn');

        $exportBtn.click(function () {
            G.confirm({
                message: '确认导出因私出国(境)信息吗?',
                callback: function (result) {
                    if (result) {
                        var groupName = $groupName.val();
                        var startTime = $startTime.val();
                        var endTime = $endTime.val();
                        location.href='${basePath}/private-abroad/export-excel.do?name=' + groupName + '&date1=' + startTime + '&date2=' + endTime, "_blank";
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