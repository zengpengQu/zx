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
                        <h5 class="group-header accordion-header" style="width: 160px;">
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
                                                <div class="form-group"
                                                     style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-xs-4 control-label no-padding-left"
                                                           for="form-title-leaName">姓名：</label>
                                                    <div class="col-xs-8 ">
                                                        <input class="form-control" type="text"
                                                               id="form-title-leaName" name="leaName">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group"
                                                     style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-xs-4 control-label no-padding-left"
                                                           for="form-field-tel">办公电话：</label>
                                                    <div class="col-xs-8 ">
                                                        <input class="form-control" type="text"
                                                               id="form-field-tel"
                                                               name="tel">
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-xs-4 pull-right"
                                                 style="margin-top: 5px;margin-bottom: 5px">
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
            </div>
        </div>
        <div class="row">
            <div class="space-10"></div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right contacts-exportBtn">
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'81_4' eq curOpertate}">
                            <button class="btn btn-info btn-sm" type="button" id="addBtn" style="top: 6px;right: 15px;">
                                <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                新增
                            </button>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="header-table-th">领导信息列表</div>
                <div class="table-content  col-md-12">
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
                    <div class="profile-info-name"> 姓名</div>

                    <div class="profile-info-value">
                        <span class="editable " id="leaName"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 职务</div>

                    <div class="profile-info-value">
                        <span class="editable " id="duName"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 性别</div>

                    <div class="profile-info-value">
                        <span class="editable " id="sexStr"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 出生年月</div>

                    <div class="profile-info-value">
                        <span class="editable " id="birthday"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 秘书</div>

                    <div class="profile-info-value">
                        <span class="editable " id="secretart"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 手机号码</div>

                    <div class="profile-info-value">
                        <span class="editable " id="phone"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 办公电话</div>

                    <div class="profile-info-value">
                        <span class="editable " id="tel"></span>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    var scripts = [null, null];
    $('.grid_tab').on('shown.bs.tab', function () {
        $($(this).attr('href')).find('.table_list').jqGrid(
            'setGridWidth', $($(this).attr('href')).find('.jqgrid_box').width());
    });

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
        var $leaName = $("#form-title-leaName");
        var $tel = $("#form-field-tel");


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
        var loadUrl = '${basePath}/manage-batch/load-batch-manage-list.do';
        var addUrl = '#page/manage-batch/batch-leader-add'
        var editUrl = '#page/manage-batch/batch-leader-edit';
        var deleteUrl = '${basePath}/manage-batch/batch-leader-delete.do';

        var colModel = [{name: 'id', index: 'id', hidden: true},
            {name: 'leaName', header: '姓名'},
            {name: 'duName', header: '职务'},
            {name: 'sexStr', header: '性别'},
            {name: 'birthday', header: '出生年月'},
            {name: 'secretart', header: '秘书'},
            {name: 'phone', header: '手机号码'},
            {name: 'tel', header: '办公电话'},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 200,
                fixed: true,
                formatter: basicOperationFormatter
            },
            {
                name:'adjust',
                header:'等级调整',
                index:'',
                width:100,
                fixed:true,
                sortable:false,
                resize:false,
                formatter:adjustFormatter
            }
        ];

        function adjustFormatter(cellvalue,options,rowData,action) {
            cellvalue = '';
            var operations = [];
            operations.push("<div style='margin-left: 8px;font-size: 20px;'>");
            operations.push("<span title='上移' class='ace-icon purple glyphicon glyphicon-upload row-record-up'></span>&nbsp;&nbsp;&nbsp;");
            operations.push("<span title='下移' class='ace-icon purple glyphicon glyphicon-download row-record-down'></span>");
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
            sortname: 'seq',
            sortorder: 'asc',
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
                }
            },
            gridComplete:function(){
                $(".row-record-up").click(function(e){
                    e.preventDefault();
                    var id = $(this).parents("tr").prop("id");
                    moveUp(id);
                });
                $(".row-record-down").click(function(e){
                    e.preventDefault();
                    var id = $(this).parents("tr").prop("id");
                    moveDown(id);
                });

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

        function moveUp(id){
            $.post('${basePath}/manage-batch/moveUp.do',{id:id},function(response){
                if(response.result){
                    G.search($searchForm, $gridTable);
                }/*else{
                    G.showGritterFail();
                }*/
            },'json')
        }
        function moveDown(id){
            $.post('${basePath}/manage-batch/moveDown.do',{id:id},function(response){
                if(response.result){
                    G.search($searchForm, $gridTable);
                }/*else{
                    G.showGritterFail();
                }*/
            },'json')
        }

        $gridTable.tjGrid("triggerResizeGrid");

        //新增页面跳转
        $addBtn.unbind('click').bind('click', function () {
            G.pjaxLoadPageContentDiv(addUrl);
        });
        $searchBtn.click(function () {
            search();
        });
        $resetBtn.click(function () {
            $searchForm.resetForm();
            search();
        });

        function search() {
            var leaName = $leaName.val();
            var tel = $tel.val();
            $gridTable.tjGrid('setPostData', {
                leaName: leaName,
                tel: tel
            });
            reloadGrid();
        }

        function reloadGrid() {
            $gridTable.tjGrid('reloadGrid');
        }

        //领导信息的查看
        function viewWeekWork(rowData) {

            //为弹出框赋值
            $viewDialog.find('.editable').each(function () {

                $(this).html(rowData[$(this).attr('id')]);
            });

            initViewDialog($viewDialog);
        }

        //领导信息查看的确定按钮
        function initViewDialog($container) {

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>领导信息查看</h4></div>",
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
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'81_1' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
            operations.push('</button>');
            </c:if>
            <c:if test="${'81_2' eq curOpertate}">
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
            operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
            operations.push('</button>');
            </c:if>
            <c:if test="${'81_3' eq curOpertate}">
            operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete">');
            operations.push(' <i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
            operations.push('</button>');
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

    });
</script>