<%--
  Created by IntelliJ IDEA.
  User: yingji
  Date: 2018/8/13
  Time: 9:16
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

<div class="row">
    <div class="col-xs-12">
        <div class="hidden">
            <input type="text" id="form-field-comeInfoId" name="id" value="${comeInfoId}"/>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right">
                    <button class="btn btn-info btn-sm" type="button" id="addReceptionBtn">
                        <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                        新增
                    </button>

                    <button class="btn btn-info btn-sm" type="button" id="exportReceptionBtn">
                        <span class="ace-icon fa fa-cloud-download icon-on-right bigger-110"></span>
                        导出
                    </button>
                </div>

                <div class="pull-right">
                    <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue bigger-150 mar_r_10 mar_t_5"></i>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <table id="grid-table-reception"></table>
            </div>
        </div>
    </div>
</div>

<div id="edit-reception-dialog" class="hide"></div>

<div id="view-reception-dialog" class="hide">
    <div class="row">
        <div class="col-xs-12">
            <div class="profile-user-info profile-user-info-striped">
                <div class="profile-info-row">
                    <div class="profile-info-name"> 标题</div>
                    <div class="profile-info-value">
                        <span class="editable " id="receptionTitle"></span>
                    </div>
                    <%--<div class="profile-info-name"> 陪同人员数</div>--%>
                    <%--<div class="profile-info-value">--%>
                        <%--<span class="editable " id="accompanyNum"></span>--%>
                    <%--</div>--%>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 开始日期</div>
                    <div class="profile-info-value">
                        <span class="editable " id="startDateStr"></span>
                    </div>
                    <div class="profile-info-name"> 结束日期</div>
                    <div class="profile-info-value">
                        <span class="editable " id="endDateStr"></span>
                    </div>
                </div>
            </div>

            <div class="profile-user-info profile-user-info-striped" style="border-top: none">
                <div class="profile-info-row">
                    <div class="profile-info-name"> 具体安排</div>
                    <div class="profile-info-value">
                        <span class="editable " id="activityPlan"
                        style="word-break: normal;max-width: 500px;display: block;white-space: pre-wrap;
                        word-wrap: break-word;overflow: hidden"></span>
                    </div>

                </div>
            </div>

            <%--<div class="profile-user-info profile-user-info-striped" style="border-top: none">--%>
                <%--<div class="profile-info-row">--%>
                    <%--<div class="profile-info-name"> 谈话参考要点</div>--%>
                    <%--<div class="profile-info-value">--%>
                        <%--<span class="editable " id="talkReference"></span>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>

            <div class="row">
                <div class="form-group form-horizontal" id="uploadedDiv">
                    <label class="col-sm-2 control-label" for="download-reception-view"
                           style="text-align: right; font-weight: bold;color: deepskyblue;">
                        已上传附件：
                    </label>
                    <div class="col-sm-10">
                        <span id="download-reception-view"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    G.datepicker({
        autoclose: true,
        todayHighlight: true
    });

    var $comeInfoId = $("#form-field-comeInfoId");

    var $addReceptionBtn = $("#addReceptionBtn");
    var $exportReceptionBtn = $("#exportReceptionBtn");
    var $receptionGrid = $("#grid-table-reception");

    var $editReceptionDialog = $("#edit-reception-dialog");
    var $viewReceptionDialog = $("#view-reception-dialog");

    var loadUrl = '${basePath}/come/come-reception/load-reception-list.do';
    var editUrl = '${basePath}/come/come-reception/load-reception-edit';
    var deleteUrl = '${basePath}/come/come-reception/reception-delete.do';

    var colModel = [
        {name: 'id', index: 'id', hidden: true},
        {name: 'receptionTitle', header: '标题', index: 'receptionTitle', sortable: true},
        {name: 'startDateStr', header: '开始日期', index: 'startDate', sortable: true},
        {name: 'endDateStr', header: '结束日期', index: 'endDate', sortable: true},
        {name: 'activityPlan', header: '具体安排', index: 'activityPlan', sortable: true, cellattr: styleFormatter},
        {name: 'basic', header: '基本操作', sortable: false, width: 200, fixed: true, formatter: basicOperationFormatter}
    ];

    function styleFormatter() {
        return 'style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"';
    }

    function basicOperationFormatter(cellvalue, options, rowData, action) {
        var operations = [];

        operations.push("<div style='margin-left:5px;font-size: 20px;'>");
        operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
        operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
        operations.push('</button>');

        operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
        operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
        operations.push('</button>');

        operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete">');
        operations.push(' <i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
        operations.push('</button>');

        operations.push("</div>");
        cellvalue = operations.join('');
        return cellvalue;
    }

    $receptionGrid.tjGrid({
        loadUrl: loadUrl,
        height: '100%',
        autowidth: true,
        colModel: colModel,
        postData: {
            comeInfoId: $comeInfoId.val()
        },
        sortname: 'updateTime',
        sortorder: 'desc',
        rowNum: -1,
        pgbuttons: false,
        pginput: false,
        onSelectRow: function (id, stat, e) {

            if (e === undefined) {
                return false;
            }
            var className = $(e.target).attr('class');
            if (!className) {
                return false;
            }

            if (className.indexOf('row-record-view') !== -1) {
                var rowData = $receptionGrid.jqGrid('getRowData', id);
                viewReception(rowData);
            } else if (className.indexOf('row-record-delete') !== -1) {
                G.confirm({
                    message: '确认删除此条接待计划吗？',
                    callback: function (result) {
                        if (result) {
                            $.post(deleteUrl, {id: id}, function (data) {
                                if (data.result) {
                                    G.showGritterSuccess("删除成功");
                                    $receptionGrid.tjGrid('reloadGrid');
                                }
                            });
                        }
                    }
                });
            } else if (className.indexOf('row-record-edit') !== -1) {
                editReception(id);
            }
        },

        loadComplete: function () {
            var table = this;
            setTimeout(function () {
                updatePagerIcons(table);
                enableTooltips(table);
                hidePagerSelect(table);
            }, 0);
            $receptionGrid.tjGrid("triggerResizeGrid");
        }
    });

    $receptionGrid.tjGrid("triggerResizeGrid");


    // 新增接待计划
    $addReceptionBtn.unbind('click').bind('click', function (e) {
        e.preventDefault();

        editReception();
    });

    $exportReceptionBtn.unbind('click').bind('click', function (e) {
        e.preventDefault();
        var exportUrl = '${basePath}/come/come-reception/come-reception-export.do?comeInfoId=' + $comeInfoId.val();

        var $downloadForm = $("<form method='post'></form>");
        $downloadForm.attr("action", exportUrl);
        $(document.body).append($downloadForm);
        $downloadForm.submit();
    });

    // 编辑接待计划
    function editReception(id) {
        var loadId = G.showAjaxLoading();
        $.ajax({
            url: editUrl,
            type: "GET",
            data: {id: id},
            dataType: "html",
            success: function (String) {
                $editReceptionDialog.html(String);
                G.doneAjaxLoading(loadId);
                initEditDialog($editReceptionDialog);
            },
            error: function () {
                G.doneAjaxLoading(loadId);
                G.alert({message: "操作失败！"});
            }
        });
    }

    var enableClick = true;
    // 编辑接待计划弹窗
    function initEditDialog($container) {
        var $form = $container.find("#reception-form");
        var saveRowUrl = '${basePath}/come/come-reception/reception-edit.do';
        var $uploadReceptionFile = $container.find("#form-field-reception-file");
        var $downloadReception = $container.find("#download-reception");
        var $messageFileQueue = $container.find('#message-file-queue');

        $container.removeClass('hide').dialog({
            resizable: false,
            height: 'auto',
            width: 850,
            modal: true,
            title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-fire green'></i> 新增/编辑接待计划</h4></div>",
            title_html: true,
            close: function () {
                $form.tjValidate('resetForm');
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
                    html: "<i class='ace-icon fa fa-check  bigger-110'></i>&nbsp; 确定",
                    "class": "btn btn-success",
                    click: function () {
                        if ($form.validate().form()) {
                            if (enableClick) {
                                enableClick = false;
                                var data = $form.serializeObject();
                                data["comeInfoId"] = $comeInfoId.val();
                                data["fileIds"] = JSON.stringify(getFileListArray($messageFileQueue));
                                var loadId = G.showAjaxLoading();
                                $.ajax({
                                    url: saveRowUrl,
                                    type: 'post',
                                    dataType: 'json',
                                    data: data,
                                    async: true
                                }).done(function (map) {
                                    enableClick = true;
                                    G.doneAjaxLoading(loadId);
                                    if (map.result) {
                                        G.showGritterSuccess("操作成功！");
                                        reloadGrid();
                                        $container.dialog('close');
                                    } else {
                                        G.showGritterFail("操作失败,请稍后重试！");
                                    }
                                }).error(function () {
                                    enableClick = true;
                                });
                            }
                        }
                    }
                }
            ]
        });

        bindUpload($uploadReceptionFile, "message-file-queue", $downloadReception);

        $form.tjValidate({
            focusInvalid: true,
            rules: {
                receptionTitle: {required: true},
                startDateStr: {required: true},
                endDateStr: {required: true},
                activityPlan: {required: true}
            },
            messages: {
                receptionTitle: {required: "标题不能为空"},
                startDateStr: {required: "开始日期不能为空"},
                endDateStr: {required: "结束日期不能为空"},
                activityPlan: {required: "具体安排不能为空"}
            }
        });
    }

    // 查看接待计划
    function viewReception(rowData) {

        var $fileList = $viewReceptionDialog.find('#download-reception-view');
        var viewReceptionUrl = '${basePath}/come/come-reception/get-reception-file-list.do';
        var id = rowData.id;

        $viewReceptionDialog.find('.editable').each(function () {
            $(this).html(rowData[$(this).attr('id')]);
        });

        $.ajax({
            url: viewReceptionUrl,
            type: "POST",
            data: {id: id},
            dataType: "json",
            success: function (result) {

                appendAttach($fileList, result.receptionFileList);

                initViewDialog($viewReceptionDialog);
            },
            error: function () {
                G.alert({message: "操作失败！"});
            }
        });

    }

    // 查看接待计划弹窗
    function initViewDialog($container) {
        $container.removeClass('hide').dialog({
            resizable: false,
            height: 'auto',
            maxHeight: 600,
            width: 800,
            modal: true,
            title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看接待计划</h4></div>",
            title_html: true,
            close: function () {
                $container.addClass('hide');
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

    function reloadGrid() {
        $receptionGrid.tjGrid('reloadGrid');
    }

    // 获取文件上传区 fileId, realName 信息
    function getFileListArray(messageFileQueue) {
        var documentFileArray = [];
        messageFileQueue.find('.uploadifive-queue-item').each(function () {
            var $this = $(this);
            var fileId = $this.find(".progress").attr('hiddenFileId');
            var fileName = $this.find(".progress").attr('hiddenFileName');
            var documentFile = {};
            documentFile.fileId = fileId;
            documentFile.fileName = fileName;
            documentFileArray.push(documentFile);
        });
        return documentFileArray;
    }

    /*--------附件上传start--------*/
    function bindUpload(fileInput, queueId, $fileList) {
        fileInput.uploadifive({
            'uploadScript': '${basePath}/file/upload-file.do',
            'queueID': queueId,//列表区域id
            'queueSizeLimit': 10,
            'uploadLimit': 0,
            'auto': true,
            'multi': false,
            'fileObjName': 'uploadFile',
            'height': 30,
            'width': 100,
            'simUploadLimit': 2,
            'buttonCursor': 'hand',
            'buttonClass': 'btn btn-sm btn-primary',
            'buttonText': '&nbsp;&nbsp添加附件&nbsp;&nbsp',
            'removeCompleted': false,
            'method': 'post',
            'fileSizeLimit': 1024000,
            'overrideEvents': ['onUploadComplete'],
            'onUploadComplete': function (file, data, response) {
                var result = JSON.parse(data);
                if (result.result) {
                    var realName = result.realName;
                    var fileId = result.fileId;
                    file.queueItem.find('.progress-bar').css('width', '100%');
                    file.queueItem.find('.fileinfo').html(' - 完成');
                    file.queueItem.find('.progress').slideUp(250);
                    file.queueItem.find('.progress').attr('hiddenFileName',realName);
                    file.queueItem.find('.progress').attr('hiddenFileId',fileId);
                    file.queueItem.addClass('complete');
                    if($fileList.html().indexOf('暂无') !== -1) {
                        $fileList.empty();
                    }
                } else {
                    G.showGritterFail();
                }

            }
        });
    }
    /*--------附件上传end--------*/

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

    $(document).ready(function (e) {

        $('.ui-jqdialog').remove();
        $('.ui-dialog').remove();
    });
</script>
