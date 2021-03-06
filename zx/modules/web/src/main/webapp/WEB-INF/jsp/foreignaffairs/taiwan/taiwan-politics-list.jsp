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
                <!-- 搜索栏 -->
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
                                        <!--姓名-->
                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-mainName">姓名:</label>
                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" id="form-field-mainName"
                                                               name="mainName" />
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
                                        <!--空格-->

                                        <!--条件查询按钮-->
                                        <%--<div class="row">--%>

                                        <%--</div>--%>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--空格-->
        <div class="row">
            <div class="space-10"></div>
        </div>
        <!--新增按钮-->
      <%--  <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right contacts-exportBtn">
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'92_4' eq curOpertate}">
                            <button class="btn btn-info btn-sm" type="button" id="addBtn" style="top: 6px;right:15px;">
                                <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                新增
                            </button>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>--%>
        <!--表格-->
        <div class="row">
            <div class="col-xs-12">
                <div class="header-table-th">台湾主要人士信息</div>
                <div class="table-content col-md-12">
                    <div class="col-md-12" style="padding: 0px;background: #fff;">
                        <table id="grid-table"></table>
                    </div>

                </div>


            </div>
        </div>
        <!--查看详情信息(未改)-->
        <div id="view-dialog" class="hide">
            <div class="row">
                <div class="col-xs-12">
                    <div class="profile-user-info profile-user-info-striped">
                        <!--姓名-->
                        <div class="profile-info-row">
                            <div class="profile-info-name"> 姓名 </div>
                            <div class="profile-info-value">
                                <span class="editable " id="mainName"></span>
                            </div>
                        </div>
                        <!--性别-->
                        <div class="profile-info-row">
                            <div class="profile-info-name"> 性别 </div>
                            <div class="profile-info-value">
                                <span class="editable " id="gender"></span>
                            </div>
                        </div>
                        <!--社团名称-->
                        <div class="profile-info-row">
                            <div class="profile-info-name"> 社团名称 </div>
                            <div class="profile-info-value">
                                <span class="editable " id="partyNameStr"></span>
                            </div>
                        </div>
                        <!--出生日期-->
                        <div class="profile-info-row">
                            <div class="profile-info-name"> 出生日期 </div>
                            <div class="profile-info-value">
                                <span class="editable " id="birthday"></span>
                            </div>
                        </div>
                        <!--单位-->
                        <div class="profile-info-row">
                            <div class="profile-info-name"> 单位 </div>
                            <div class="profile-info-value">
                                <span class="editable " id="belongOrg"></span>
                            </div>
                        </div>
                        <!--职务-->
                        <div class="profile-info-row">
                            <div class="profile-info-name"> 职务 </div>
                            <div class="profile-info-value">
                                <span class="editable " id="duty"></span>
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

        var initParam = G.initGridParam($("#searchForm"));

        //搜索条件
        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        //元素类全局变量
        var $mainName = $("#form-field-mainName");

        //按钮全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");

        //表单全局变量
        var $gridTable = $("#grid-table");
        var $viewDialog = $("#view-dialog");
        var $searchForm = $("#searchForm");

        //存放用户选择的表格列
        var item_selected = [];

        //本页面url
        var loadUrl = '${basePath}/taiwan-politics/load-taiwan-politics-list.do';
        var editUrl = '#page/taiwan-politics/load-taiwan-politics-edit';
        var deleteUrl = '${basePath}/taiwan-politics/load-taiwan-politics-delete.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'mainName', header: '姓名', index: 'mainName', sortable: true},
            {name: 'gender',header: '性别', index: 'gender', sortable: true},
            {name: 'partyId', header: '社团ID', index: 'partyId', hidden: true, sortable: true},
            {name: 'partyNameStr', header: '社团名称', index: 'partyNameStr', sortable: true},
            {name: 'birthday', header: '出生日期', index: 'birthday', sortable: true},
            {name: 'belongOrg', header: '单位', index: 'belongOrg', sortable: true},
            {name: 'duty', header: '职务', index: 'duty', sortable: true},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 220,
                fixed: true,
                formatter: basicOperationFormatter
            }
        ];

        function basicOperationFormatter(cellvalue,options,rowData,action){
            var operations = [];
            var status = rowData.status;
            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'92_1' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
            operations.push('</button>');
            </c:if>
            <c:if test="${'92_2' eq curOpertate}">
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
            operations.push('<i class="ace-icon fa fa-pencil bigger-120"></i> 编辑');
            operations.push('</button>');
            </c:if>
            <c:if test="${'92_3' eq curOpertate}">
            operations.push(' <button title="删除" class="btn btn-minier btn-white btn-danger row-record-delete">');
            operations.push(' <i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
            operations.push('</button>');
            </c:if>
            </c:forEach>
            operations.push("<div>");
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
                mainName: $mainName.val()
            },
            sortname: 'updateTime',
            sortorder: 'desc',
            // caption: "台湾主要人士信息",
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
                    viewDutyDaily(rowData);
                }else if(className.indexOf('row-record-edit') !== -1){

                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm,$gridTable);
                    }
                    //编辑
                    var editHash = editUrl + "?id=" + id + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(editHash);
                }else if(className.indexOf('row-record-delete') !== -1){
                    //删除
                    G.confirm({
                        message: '确认删除记录!',
                        callback: function (result) {
                            if (result){
                                $.post(
                                    deleteUrl,{id: id},function (data) {
                                        if (data.result){
                                            $gridTable.tjGrid('reloadGrid');
                                        }
                                    }
                                );
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

        //查看台湾主要人士
        function viewDutyDaily(rowData) {
            //为弹出框赋值
            $viewDialog.find('.editable').each(function () {
                $(this).html(rowData[$(this).attr('id')]);
            });
            initViewDialog($viewDialog);
        }
        //初始化查看弹框
        function initViewDialog($container) {
            $container.removeClass('hide').dialog({
                resizable:  false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal:  true,
                title:  "<div class='widget-header header-bg'><h4 class='smaller' style='margin-top: 12px'><i class='ace-icon fa fa-globe green'></i>查看台湾主要人士</h4></div>",
                title_html: true,
                close:  function () {
                    $container.addClass("hide");
                },
                buttons: [
                    {
                        html:   "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp;  确定",
                        "class":"btn btn-success",
                        click: function () {
                            $(this).dialog("close");
                        }
                    }
                ]
            });
        }

        //查询条件
        $searchBtn.click(function () {
            search();
        });

        function search() {
            var mainName = $mainName.val();
            $gridTable.tjGrid('setPostData',{
                mainName: mainName
            });
            reloadGrid();
        }
        function reloadGrid() {
            $gridTable.tjGrid('reloadGrid');
        }

        //重置
        $resetBtn.click(function () {
            $searchForm.resetForm();
            item_selected = [];
            search();
        });

        //新增或编辑页面跳转
        $addBtn.unbind('click').bind('click',function (e) {
            G.pjaxLoadPageContentDiv(editUrl);
        });

        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy("#view-dialog");
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>
