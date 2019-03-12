<%--
  Created by IntelliJ IDEA.
  User: pengyx
  Date: 2018/6/14
  Time: 16:12
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
                                    <form class="form-horizontal" role="form" id="searchForm">
                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label no-padding-right"
                                                           for="form-field-dutyNum">期数:</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" id="form-field-dutyNum"
                                                               name="dutyNum">
                                                        </input>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px; margin-bottom: 5px">
                                                    <label class="col-sm-2 control-label no-padding-right">日期:</label>
                                                    <div class="col-sm-10 ">
                                                        <div class="input-daterange input-group">
                                                            <input class="form-control date-picker"
                                                                   name="startTime"
                                                                   id="form-field-startTime"
                                                                   data-date-format="yyyy-mm-dd"
                                                                   placeholder="开始日期" type="text"/>
                                                            <span class="input-group-addon">
                                                                <i class="fa fa-exchange"></i>
                                                            </span>
                                                            <input class="form-control date-picker"
                                                                   name="endTime"
                                                                   id="form-field-endTime"
                                                                   data-date-format="yyyy-mm-dd"
                                                                   placeholder="结束日期" type="text"/>
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
                    <button class="btn btn-info btn-sm" id="backBtn"
                            style="top: 6px;right: 15px;">
                        <i class="ace-icon fa fa-arrow-left  bigger-120"></i>
                        返回
                    </button>
                    <button class="btn btn-info btn-sm" id="addBtn"
                            style="top: 6px;right: 100px;">
                        <i class="ace-icon fa fa-plus  bigger-120"></i>
                        新增
                    </button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="header-table-th">日报文件列表</div>
                <div class="table-content  col-md-12">
                    <div class="col-md-12" style="padding: 0px;background: #fff;">
                        <table id="grid-table"></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="edit-dialog" class="hide"></div>
<div id="view-dialog" class="hide">
    <div class="row">
        <div class="col-xs-12">
            <div class="profile-user-info profile-user-info-striped">
                <div class="profile-info-row">
                    <div class="profile-info-name"> 期数</div>

                    <div class="profile-info-value">
                        <span class="editable " id="dutyNum"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 日期</div>

                    <div class="profile-info-value">
                        <span class="editable " id="dutyTimeStr"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 上传者</div>

                    <div class="profile-info-value">
                        <span class="editable " id="uploader"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 附件</div>

                    <div class="profile-info-value">
                        <span class="editable " id="realName"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="hidden">
    <input type="text" name="realName" id="hidden_realName" value="">
    <input type="text" name="uuidName" id="hidden_uuidName" value="">
</div>
<!-- ace scripts -->
<script src="${basePath}/plugin/ace/assets/js/ace/elements.fileinput.js"></script>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        $('.input-daterange').datepicker({
                format: 'yyyy-mm-dd',
                autoclose: true
            }
        );

        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        //元素类全局变量
        var $startTime = $("#form-field-startTime");
        var $endTime = $("#form-field-endTime");
        var $dutyNum = $("#form-field-dutyNum");
        var $keyword = $("#form-field-keyword");

        var $idDutyNum = $('#id-dutyNum');
        var $idDutyTimeStr = $('#id-dutyTimeStr');
        var $idUploader = $('#id-uploader');
        var $dutyId = $('#id-duty');
        var $uploadDuty = $('#from-uploadDuty');

        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");
        var $backBtn = $("#backBtn");

        //表单类全局变量
        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");
        var $viewDialog = $("#view-dialog");
        var $editDialog = $("#edit-dialog");
        var $saveForm = $("#saveForm");

        //隐藏域
        var $realName = $("#hidden_realName");
        var $uuidName = $("#hidden_uuidName");

        // 存放上传文件 FormData
        var fd = new FormData();
        //编辑是否修改文件的标识
        var isUpload = 0;

        var loadUrl = '${basePath}/duty-daily-file/load-duty-file-list.do';
        var saveUrl = '${basePath}/duty-daily-file/duty-file-edit-save.do';
        var editUrl = '${basePath}/duty-daily-file/duty-file-edit.do';
        var viewUrl = '${basePath}/duty-daily-file/duty-file-view.do';
        var uploadUrl = '${basePath}/duty-daily-file/duty-file-upload.do';
        var deleteUrl = '${basePath}/duty-daily-file/duty-file-delete.do';

        var colModel = [
            {
                name: 'id',
                index: 'id',
                hidden: true,
                editable: true,
                editrules: {edithidden: false},
                formoptions: {rowpos: 1, colpos: 1}
            },
            {
                name: 'dutyNum',
                header: '期数',
                index: 'dutyNum',
                sortable: true,
                editable: true,
                edittype: 'text',
                editrules: {required: true},
                formoptions: {rowpos: 2, colpos: 1}
            },
            {
                name: 'realName',
                header: '文件',
                index: 'realName',
                hidden: false,
                editable: false,
                editrules: {edithidden: false},
                formoptions: {rowpos: 3, colpos: 1}
            },
            {
                name: 'dutyTimeStr',
                header: '日期',
                index: 'dutyTime',
                sortable: true,
                sorttype: "date",
                editable: true,
                editrules: {required: true, date: true},
                formoptions: {rowpos: 4, colpos: 1}
            },
            {
                name: 'uploader',
                header: '上传者',
                index: 'uploader',
                sortable: true,
                editable: true,
                edittype: 'text',
                editrules: {required: true},
                formoptions: {rowpos: 5, colpos: 1}
            },
            {
                name: 'publishStatus',
                header: '状态',
                index: 'publishStatus',
                hidden: true,
                sortable: false,
                editable: true,
                editrules: {edithidden: false},
                formoptions: {rowpos: 6, colpos: 1}
            },
            {
                name: 'uuidName',
                header: '文件路径',
                index: 'uuidName',
                hidden: true,
                editable: true,
                editrules: {edithidden: false},
                formoptions: {rowpos: 7, colpos: 1}
            },
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                fixed: true,
                width: 220,
                formatter: basicOperationFormatter
            },
            {
                name: 'work',
                header: '业务操作',
                width: 160,
                sortable: true,
                fixed: true,
                formatter: workOperationFormatter
            }
        ];

        function basicOperationFormatter(cellvalue, options, rowData, action) {

            var operations = [];

            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out bigger-120"></i> 查看');
            operations.push('</button>');
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
            operations.push('<i class="ace-icon fa fa-pencil bigger-120"></i> 编辑');
            operations.push('</button>');
            operations.push(' <button title="删除" class="btn btn-minier btn-white btn-danger row-record-delete">');
            operations.push(' <i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
            operations.push('</button>');
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        function workOperationFormatter(cellvalue, options, rowData, action) {

            var operations = [];

            var status = rowData.publishStatus;

            // operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            // if (status == '0') {
            //     operations.push(' <button title="发布" class="btn btn-minier btn-white btn-primary reportDuty">');
            //     operations.push('<i class="ace-icon glyphicon glyphicon-arrow-up"></i> 发布');
            //     operations.push('</button>');
            // } else if (status == '1') {
            //     operations.push(' <button title="已发布" class="btn btn-minier btn-white btn-primary backDuty">');
            //     operations.push('<i class="ace-icon glyphicon "></i> 已发布');
            //     operations.push('</button>');
            // }
            // operations.push("</div>");

            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            operations.push(' <button title="下载" class="btn btn-minier fa fa-download btn-white btn-primary downloadDuty">');
            operations.push('<i class="ace-icon "></i> 下载');
            operations.push('</button>');
            operations.push("</div>");

            cellvalue = operations.join('');
            return cellvalue;
        }

        $gridTable.tjGrid({
            loadUrl: loadUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            postData: {
                startTime: $startTime.val(),
                endTime: $endTime.val(),
                dutyNum: $dutyNum.val(),
                keyword: $keyword.val()
            },
            sortname: 'dutyNum',
            sortorder: 'desc',
            onSelectRow: function (id, stat, e) {

                if (e == undefined) {
                    return false;
                }
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }
                var rowData = $gridTable.jqGrid('getRowData', id);
                //查看
                if (className.indexOf('row-record-view') != -1) {
                    viewDutyFile(rowData);

                } else if (className.indexOf('row-record-delete') != -1) {
                    G.confirm({
                        message: '确认删除此条值班日报存档吗？',
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
                } else if (className.indexOf('row-record-edit') != -1) {

                    editDutyFile(id);
                    // var editHash = editUrl + "?id=" + id + '&date=' + new Date().getTime();
                    // G.pjaxLoadPageContentDiv(editHash);
                } else if (className.indexOf('downloadDuty') != -1) {
                    handleDutyFile(id, '0');
                }
            },

        });

        $gridTable.tjGrid("triggerResizeGrid");

        function viewDutyFile(rowData) {
            //为弹出框赋值
            $viewDialog.find('.editable').each(function () {

                $(this).html(rowData[$(this).attr('id')]);

            });

            initViewDialog($viewDialog);
        }

        function initViewDialog($container) {
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看日报文件</h4></div>",
                title_html: true,
                close: function () {
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

        function editDutyFile(id) {
            var loadId = G.showAjaxLoading();
            $.ajax({
                url: editUrl,
                type: "GET",
                data: {id: id},
                dataType: "html",
                success: function (String) {
                    $editDialog.html(String);
                    G.doneAjaxLoading(loadId);
                    //初始化弹出框
                    initEditDialog($editDialog);
                },
                error: function () {
                    G.doneAjaxLoading(loadId);
                    G.alert({message: "操作失败！"});
                }
            });
        }

        var enableClick = true;
        // 初始化新增/编辑弹出框
        function initEditDialog($container) {
            var $form = $("#saveForm");
            var $uploadDuty = $form.find(".form-field-upload-file");
            // var $uploadDuty = $form.find("#form-field-uploadDuty");
            //文件上传的数据
            var postData = null;
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 500,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-fire green'></i> 新增/编辑</h4></div>",
                title_html: true,
                close: function () {
                    $form.resetForm();
                    $('.ace-file-name').attr('data-title', ' ... ');
                },

                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-warning commitBtn",
                        click: function () {
                            $container.dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check  bigger-110'></i>&nbsp; 提交",
                        "class": "btn btn-success",
                        click: function () {
                            if ($form.validate().form()) {
                                if (enableClick) {
                                    enableClick = false;
                                    postData = getRecord($form);
                                    postData.realName = $realName.val();
                                    postData.uuidName = $uuidName.val();
                                    postData.isUpload = isUpload;

                                    postRecord(postData);
                                }
                            }
                        }
                    }
                ]
            });
            // 读取文件
            $uploadDuty.bind('change', function () {
                var fieldName;
                $uploadDuty.each(function () {
                    fieldName = $(this).attr('name');
                    var files = $(this).data('ace_input_files');
                    if (files && files.length > 0) {
                        for (var i = 0; i < files.length; i++) {
                            fd.append(fieldName, files[i]);
                        }
                    }
                });
                $uploadDuty.empty();
                var html = [];
                html.push('<ul class="list-unstyled list-striped pricing-table-header">');
                html.push('<li class="blue"  style="cursor:pointer;margin-top:5px;background-color: white;">');
                html.push('<a class="filePreview" style="color:#478FCA;font-family:仿宋, Arial, Helvetica, sans-serif;font-size: 18px;">');
                html.push(fieldName);
                html.push('</a>');
                html.push('</li>');
                html.push('</ul>');
                $uploadDuty.append(html.join(""));
            });

            //文件上传至临时位置
            $uploadDuty.bind('change', function (){
                var loadId = G.showAjaxLoading();
                $.ajax({
                    url: uploadUrl,
                    type: 'post',
                    processData: false,//important
                    contentType: false,//important
                    dataType: 'json',
                    data: fd, // FormData object
                    async: true
                }).done(function (map) {
                    G.doneAjaxLoading(loadId);
                    if (map.result) {
                        $realName.val(map.realName);
                        $uuidName.val(map.uuidName);
                        isUpload = 1;
                        fd.delete('uploadDuty');
                    }
                });
            });
        }

        //操作值班日报
        function handleDutyFile(id, type) {
            var rowData = $gridTable.jqGrid('getRowData', id);
            var operName = "";
            var downloadUrl = '${basePath}/duty-daily-file/duty-file-download.do';
            if (type == '0') {
                operName = '下载';
                var realName = rowData.realName;
                var uuidName = rowData.uuidName;
                var arr = uuidName.split('/');
                uuidName = arr[arr.length - 1]
                // var filePath = downloadUrl + '?uuidName=' + uuidName + '&realName=' + realName;

                var $downloadForm = $("<form method='post'></form>");
                $downloadForm.attr("action", downloadUrl);
                $downloadForm.append("<input name=uuidName value='" + uuidName + "' />");
                $downloadForm.append("<input name=realName value='" + realName + "' />");
                $(document.body).append($downloadForm);
                $downloadForm.submit();
            }
        }

        $searchBtn.click(function () {
            search();
        });

        function search() {
            var startTime = $startTime.val();
            var endTime = $endTime.val();
            var dutyNum = $dutyNum.val();
            var keyword = $keyword.val();

            $gridTable.tjGrid('setPostData', {
                startTime: startTime,
                endTime: endTime,
                dutyNum: dutyNum,
                keyword: keyword
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
            editDutyFile();
        });

        function getRecord($form) {
            var dutyNum = $form.find('#form-field-dutyNum').val();
            var dutyTimeStr = $form.find('#form-field-dutyTimeStr').val();
            var uploader = $form.find('#form-field-uploader').val();
            var dutyId = $form.find('#form-field-id').val();

            var records = {
                'id': dutyId,
                'dutyNum': dutyNum,
                'dutyTimeStr': dutyTimeStr,
                'uploader': uploader
            };

            return records;
        }

        // 发送文件记录表单
        function postRecord(postData) {
            var loadId = G.showAjaxLoading();
            $.ajax({
                url: saveUrl,
                type: 'post',
                dataType: 'json',
                data: postData, // 表单数据
                async: true
            }).done(function (map) {
                G.doneAjaxLoading(loadId);
                enableClick = true;
                if (map.result) {
                    G.showGritterSuccess("保存成功！");
                    $editDialog.dialog('close');
                    isUpload = 0;
                } else {
                    G.showGritterFail("保存失败,请稍后重试！");
                }
                //更新表格数据
                search();
            });
        }

        // 返回至值班日报页面
        $backBtn.click(function () {
            G.pjaxLoadPageContentDiv('#page/duty-daily/duty-daily-list');
        });

        $(document).one('ajaxloadstart.page', function (e) {

            $.jgrid.gridDestroy('#grid-table');
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>