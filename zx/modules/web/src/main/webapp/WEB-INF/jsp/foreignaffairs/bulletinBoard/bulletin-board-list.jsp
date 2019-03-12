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
                                        <input value="${bulletinIndexMainId}" id="bulletinIndexMainId"
                                               name="bulletinIndexMainId" class="hidden">
                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-title">标题:</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" id="form-field-title"
                                                               name="title"
                                                        />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px; margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-publishTime">发布时间:</label>
                                                    <div class="col-sm-8 ">
                                                        <div class="input-group" style="width: 100%;">
                                                            <input class="form-control date-picker"
                                                                   name="publishTime"
                                                                   id="form-field-publishTime"
                                                                   data-date-format="yyyy-mm-dd" type="text"/>
                                                            <span class="input-group-addon"><i
                                                                    class="fa fa-calendar bigger-110"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-publisher">发布人:</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" id="form-field-publisher"
                                                               name="publisher"
                                                        />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
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
            </div>
        </div>

        <div class="row">
            <div class="space-10"></div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right contacts-exportBtn">
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'71_4' eq curOpertate}">
                            <button class="btn btn-info btn-sm" type="button" id="addBtn" style="top: 6px;right:15px;">
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
                <div class="header-table-th">公告栏信息浏览</div>
                <div class="table-content col-md-12">
                    <div class="col-md-12" style="padding: 0px;background: #fff;">
                        <table id="grid-table"></table>
                    </div>

                </div>

            </div>
        </div>

        <div id="view-dialog" class="hide">
            <div class="row">
                <div class="col-xs-12">
                    <div class="profile-user-info profile-user-info-striped">
                        <div class="profile-info-row">
                            <div class="profile-info-name"> 标题 </div>

                            <div class="profile-info-value">
                                <span class="editable " id="title"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 发布时间 </div>

                            <div class="profile-info-value">
                                <span class="editable " id="publishTimeStr"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 发布人 </div>

                            <div class="profile-info-value">
                                <span class="editable " id="publisher"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 内容 </div>

                            <div class="profile-info-value">
                                <span class="editable " id="content"></span>
                            </div>
                        </div>

                    </div>

                    <div class="row">
                        <div class="form-group form-horizontal" id="uploadedDiv">
                            <label class="col-sm-2 control-label" for="download-view"
                                   style="font-weight: bold;color: deepskyblue;">
                                已上传的附件：
                            </label>
                            <div class="col-sm-10">
                                <span id="download-view"></span>
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
        //元素类全局变量
        var $title = $("#form-field-title");
        var $createTime = $("#form-field-publishTime");
        var $publisher = $("#form-field-publisher");

        var $bulletinIndexMainId = $("#bulletinIndexMainId");

        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");

        //表单类全局变量
        var $gridTable = $("#grid-table");
        var $viewDialog = $("#view-dialog");
        var $searchForm = $("#searchForm");

        //存放用户选择的表格列
        var item_selected = [];

        //本页面url
        var loadUrl = '${basePath}/bulletin-board/load-bulletin-board-list.do';
        var deleteUrl = '${basePath}/bulletin-board/load-bulletin-board-delete.do';
        //新增或编辑的跳转url
        var editUrl = '#page/bulletin-board/load-bulletin-board-edit';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'title', header: '标题', index: 'title', sortable: true},
            {name: 'name', index: 'name', hidden: true},
            {name: 'publishTimeStr', header: '发布时间', index: 'publishTime', sortable: true},
            {name: 'publisher', header: '发布人', index: 'publisher', sortable: true},
            {name: 'content', header: '内容', index: 'content', sortable: true, hidden: true},
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
            <c:if test="${'71_1' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
            operations.push('</button>');
            </c:if>
            <c:if test="${'71_2' eq curOpertate}">
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
            operations.push('<i class="ace-icon fa fa-pencil bigger-120"></i> 编辑');
            operations.push('</button>');
            </c:if>
            <c:if test="${'71_3' eq curOpertate}">
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
                title: $title.val(),
                publishTime: $createTime.val(),
                publisher: $publisher.val(),
                bulletinIndexMainId:$bulletinIndexMainId.val()
            },
            sortname: 'publishTime',
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
                    //查看
                    viewDutyDaily(rowData);
                }else if(className.indexOf('row-record-edit') !== -1){
                    //编辑
                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm,$gridTable);
                    }
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

            }
        });
        //页面自适应
        $gridTable.tjGrid("triggerResizeGrid");
        
        //查看公告栏信息
        function viewDutyDaily(rowData) {

            var fileUrl = '${basePath}/bulletin-board/get-bulletin-file-list.do';
            var $fileList = $viewDialog.find('#download-view');
            var id = rowData.id;

            //为弹出框赋值
            $viewDialog.find('.editable').each(function () {
                $(this).html(rowData[$(this).attr('id')]);
            });

            $.ajax({
                url: fileUrl,
                type: "POST",
                data: {id: id},
                dataType: "json",
                success: function (result) {
                    appendAttach($fileList, result.fileList);
                    initViewDialog($viewDialog, result.fileList);
                },
                error: function () {
                    G.alert({message: "操作失败！"});
                }
            });
        }
        //初始化查看公告栏弹框
        function initViewDialog($container) {
            $container.removeClass('hide').dialog({
                resizable:  false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal:  true,
                title:  "<div class='widget-header header-bg'><h4 class='smaller' style='margin-top: 12px'><i class='ace-icon fa fa-globe green'></i>查看公告栏</h4></div>",
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

        // 显示附件信息
        function appendAttach($div, jsonFileObject) {

            $div.empty();
            var html = [];
            if (_.isEmpty(jsonFileObject)) {
                html.push('<ul class="list-unstyled list-striped pricing-table-header"><li style="margin-top:5px">');
                html.push('暂无上传附件！');
                html.push('</li></ul>');
            } else {
                html.push('<ul class="list-unstyled list-striped pricing-table-header">');
                for (var i = 0; i < jsonFileObject.length; i++) {
                    html.push('<li class="blue"  style="cursor:pointer;background-color: white;">');
                    html.push('<a class="filePreview" fileId="' + jsonFileObject[i].id + '" style="color:#478FCA;font-family:仿宋, Arial, Helvetica, sans-serif;font-size: 18px;">');
                    html.push(jsonFileObject[i].fileName);
                    html.push('</a>&nbsp&nbsp&nbsp');
                    html.push('<a style="color:grey" href="${basePath}/file/download.action?id=' + jsonFileObject[i].id + '&type=0">');
                    html.push('<i class="ace-icon fa fa-download grey bigger-130"></i>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;');
                    html.push('</li>');
                }
                html.push('</ul>');
            }
            $div.append(html.join(""));
        }

        //查询条件
        $searchBtn.click(function () {
            search();
        });

        function search() {
            var title = $title.val();
            var publishTime = $createTime.val();
            var publisher = $publisher.val();
            $gridTable.tjGrid('setPostData',{
                title: title,
                publishTime: publishTime,
                publisher:  publisher
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
