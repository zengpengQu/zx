<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>
<title>履职支撑平台</title>
<%--word导出--%>
<script src="${basePath}/plugin/wordExport/js/FileSaver.js"></script>
<script src="${basePath}/plugin/wordExport/js/jquery.wordexport.js"></script>

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
                                    <!-- 团组名称 -->
                                    <div class="col-xs-4">
                                        <label class="col-sm-4 control-label" for="form-field-groupName" >
                                            团组名称：
                                        </label>
                                        <div class="col-sm-8">
                                            <input type="text" id="form-field-groupName" name="groupName"
                                                   class="form-control " value=""/>
                                        </div>
                                    </div>
                                    <!-- 赴台时间 -->
                                    <div class="col-xs-4">
                                        <div class="form-group" style="margin-top: 5px; margin-bottom: 5px">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-goTime">赴台时间:</label>
                                            <div class="col-sm-8 ">
                                                <div class="input-group" style="width: 100%;">
                                                    <input class="form-control date-picker"
                                                           name="goTime"
                                                           id="form-field-goTime"
                                                           data-date-format="yyyy-mm-dd" type="text"/>
                                                    <span class="input-group-addon"><i
                                                            class="fa fa-calendar bigger-110"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 查询按钮 -->
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
                <c:if test="${'96_3' eq curOpertate}">
                    <button class="btn btn-info btn-sm" type="button" id="addBtn" style="right: 185px;top: 24px;">
                        <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                        新增
                    </button>
                </c:if>
            </c:forEach>
            &nbsp;
            <c:forEach items="${curOperateAuth}" var="curOpertate">
                <c:if test="${'96_6' eq curOpertate}">
                    <input type="file" id="importExcel" class="hide" accept=".xls, .xlsx"
                           multiple="multiple"/>
                    <button class="btn btn-info btn-sm" type="button" id="importBtn" style="right: 100px;top: 24px;">
                        <span class="ace-icon glyphicon glyphicon-import icon-on-right bigger-110"></span>
                        导入
                    </button>
                </c:if>
            </c:forEach>

            &nbsp;
            <c:forEach items="${curOperateAuth}" var="curOpertate">
                <c:if test="${'96_7' eq curOpertate}">
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
<!-- 表格 -->
<div class="row">
    <div class="col-xs-12">
        <div class="header-table-th">因公赴台信息列表</div>
        <div class="table-content col-md-12">
            <div class="col-md-12" style="padding: 0px;background: #fff;">
                <table id="grid-table"></table>
            </div>
        </div>
    </div>
</div>
<!-- 详情 -->
<div id="view-dialog" class="hide">
    <div class="row">
        <div class="col-xs-12">
            <div class="profile-user-info profile-user-info-striped">
                <!-- 团组名称 -->
                <div class="profile-info-row">
                    <div class="profile-info-name"> 团组名称</div>
                    <div class="profile-info-value">
                        <span class="editable " id="groupName"></span>
                    </div>
                </div>
                <!-- 组团部门 -->
                <div class="profile-info-row">
                    <div class="profile-info-name"> 组团部门</div>
                    <div class="profile-info-value">
                        <span class="editable " id="groupDept"></span>
                    </div>
                </div>
                <!-- 赴台时间 -->
                <div class="profile-info-row">
                    <div class="profile-info-name"> 赴台时间</div>

                    <div class="profile-info-value">
                        <span class="editable " id="goTime"></span>
                    </div>
                </div>
                <!-- 姓名 -->
                <div class="profile-info-row">
                    <div class="profile-info-name"> 姓名</div>
                    <div class="profile-info-value">
                        <span class="editable " id="empName"></span>
                    </div>
                </div>
                <!-- 备注 -->
                <div class="profile-info-row">
                    <div class="profile-info-name"> 备注</div>
                    <div class="profile-info-value">
                        <span class="editable " id="notes"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
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

<script src="${basePath}/plugin/ace/assets/js/ace/elements.fileinput.js"></script>
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        var initParam = G.initGridParam($("#searchForm"));

        //时间控件校验
        $('.date-picker').datepicker({
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayHighlight: true
            }
        );

        //搜索条件
        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        //元素类全局变量(搜索条件)
        var $groupName = $("#form-field-groupName");
        var $goTime = $("#form-field-goTime");

        //弹窗类全局变量
        var $previewDialog = $("#preview-dialog");

        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");
        var $importBtn = $("#importBtn");
        var $importExcel = $("#importExcel");
        var $exportBtn = $('#exportBtn');

        // 表单类全局变量
        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");
        var $viewDialog = $("#view-dialog");

        //存放用户选择的表格列
        var item_selected = [];

        //访问路径
        var loadUrl = '${basePath}/taiwan-info/load-taiwan-info-list.do';
        var editUrl = '#page/taiwan-info/load-taiwan-info-edit';
        var deleteUrl = '${basePath}/taiwan-info/taiwan-info-delete.do';
        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'groupName', header: '团组名称', index: 'groupName', sortable: true},
            {name: 'groupDept', header: '组团部门', index: 'groupDept', sortable: true},
            {name: 'goTime', header: '赴台时间', index: 'goTime', sortable: true},
            {name: 'empName', header: '姓名', index: 'empName', sortable: true, width: 100},
            {name: 'department', header: '工作部门', index: 'department', sortable: true,hidden: true},
            {name: 'notes', header: '备注', index: 'notes', sortable: true},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 220,
                fixed: true,
                formatter: basicOperationFormatter
            },
            {
                name: 'basic',
                header: '业务操作',
                sortable: false,
                width: 280,
                fixed: true,
                formatter: basicOperationFormatterYeWu
            }
        ];

        function basicOperationFormatter(cellvalue, options, rowData, action) {
            var operations = [];
            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
                <c:if test="${'96_1' eq curOpertate}">
                    operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
                    operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
                    operations.push('</button>');
                </c:if>
                <c:if test="${'96_2' eq curOpertate}">
                    operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
                    operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
                    operations.push('</button>');
                </c:if>
                <c:if test="${'96_5' eq curOpertate}">
                    operations.push(' <button title="删除" class="btn btn-minier btn-white btn-danger row-record-delete">');
                    operations.push('<i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
                    operations.push('</button>');
                </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }
        function basicOperationFormatterYeWu(cellvalue, options, rowData, action) {
            var operations = [];
            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'96_4' eq curOpertate}">
            operations.push(' <button title="任务件" class="btn btn-minier btn-white btn-primary row-record-file">');
            operations.push('<i class="ace-icon fa fa-share blue"></i> 任务批件');
            operations.push('</button>');
            operations.push(' <button title="任务件" class="btn btn-minier btn-white btn-primary row-record-book">');
            operations.push('<i class="ace-icon fa fa-share blue"></i> 通知书');
            operations.push('</button>');
            operations.push(' <button title="任务件" class="btn btn-minier btn-white btn-primary row-record-confirm">');
            operations.push('<i class="ace-icon fa fa-share blue"></i> 确认件');
            operations.push('</button>');
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        //表格展示
        $gridTable.tjGrid({
            initParam : initParam,
            loadUrl: loadUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            postData: {
                groupName: $groupName.val(),
                goTimeStr: $goTime.val()
            },
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
                    //查看
                    viewTaiwanInfo(rowData);
                } else if (className.indexOf('row-record-edit') !== -1) {

                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm,$gridTable);
                    }

                    //编辑
                    var editHash = editUrl + "?id=" + id + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(editHash);
                } else if (className.indexOf('row-record-file') !== -1) {
                    //生成赴台任务件
                    G.confirm({
                        message: '确认生成赴台任务批件吗?',
                        callback: function (result) {
                            if (result) {
                                openTaskFileDialog(id,"file");
                            }
                        }
                    });
                }else if (className.indexOf('row-record-book') !== -1) {
                    //生成赴台任务通知书
                    G.confirm({
                        message: '确认生成赴台任务通知书?',
                        callback: function (result) {
                            if (result) {
                                openTaskFileDialog(id,"book");
                            }
                        }
                    });
                }else if (className.indexOf('row-record-confirm') !== -1) {
                    //生成赴台任务确认件
                    G.confirm({
                        message: '确认生成赴台确认件吗?',
                        callback: function (result) {
                            if (result) {
                                openTaskFileDialog(id,"confirm");
                            }
                        }
                    });
                }else if (className.indexOf('row-record-delete') !== -1) {
                    //生成赴台任务确认件
                    G.confirm({
                        message: '确认删除赴台信息吗?',
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

        //页面自适应
        $gridTable.tjGrid("triggerResizeGrid");
        //生成赴台任务确认件

        function openTaskFileDialog(id,type) {
            var url = '${basePath}/taiwan-info/taiwan-info-preview.do';
            //不跳转页面，直接将页面嵌入弹出框
            var loadId = G.showAjaxLoading();
            $.ajax({
                url: url,
                type: "GET",
                data: {id: id,"type":type},
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
        //初始化弹框
        function initPreviewDialog($container) {
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 700,
                width: 1200,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>赴台任务件预览</h4></div>",
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
                            $container.wordExport("赴台任务件${sysDate}");
                            $(this).dialog("close");
                        }
                    }
                ]
            });
        }

        //查看
        function viewTaiwanInfo(rowData) {
            //为弹出框赋值
            $viewDialog.find('.editable').each(function () {
                $(this).html(rowData[$(this).attr('id')]);
            });
            initViewDialog($viewDialog);
        }
        //初始化
        function initViewDialog($container) {
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看因公赴台</h4></div>",
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

        //条件查询
        $searchBtn.click(function () {
            search();
        });

        function search() {
            $gridTable.tjGrid('setPostData', {
                groupName: $groupName.val(),
                goTimeStr: $goTime.val()
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
            G.pjaxLoadPageContentDiv(editUrl);
        });

        //导出EXCEL
        $exportBtn.click(function () {
            G.confirm({
                message: '确认导出赴台通行证信息吗?',
                callback: function (result) {
                    if (result) {
                        var groupName = $groupName.val();
                        var goTimeStr = $goTime.val();
                        var url = '${basePath}/taiwan-info/export-excel.do?groupName='+groupName+'&goTimeStr='+ goTimeStr;
                        location.href = url;
                    }
                }
            });
        });

        $importBtn.click(function () {
            $importExcel.trigger('click');
        });
        $importExcel.unbind('change').bind('change', function () {
            uploadExcel(this);
        });

        function uploadExcel(obj) {
            var excelUrl = '${basePath}/taiwan-info/upload-excel.do';

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
                } else {
                    showImportResult(map.result);
                    search();
                }
                $importExcel.val("");
            });

        }

        function showImportResult(result) {
            /*展示数据*/
            var dataList = [];

            $.each(result, function (filename, item) {
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
        }

        //初始化显示 Excel 导入情况弹出框
        function initExcelResultDialog($container) {
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='height: 39px;line-height: 39px;'>导入结果</h4></div>",
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

        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy("#grid-table");
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>
