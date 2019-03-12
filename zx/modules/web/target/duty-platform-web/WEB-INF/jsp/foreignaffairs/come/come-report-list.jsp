<%--
  Created by IntelliJ IDEA.
  User: yx
  Date: 2018/7/31
  Time: 17:31
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

<div class="row">
    <div class="col-xs-12">
        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right">
                    <button class="btn btn-info btn-sm" type="button" id="addReportRow">
                        <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                        新增
                    </button>
                </div>
                <div class="pull-right">
                    <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue bigger-150 mar_r_10 mar_t_5"></i>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <table id="grid-table-report"></table>
            </div>
        </div>
    </div>
</div>


<div id="edit-report-dialog" class="hide">

</div>

<div id="view-report-dialog" class="hide">
    <div class="row">
        <div class="col-xs-12">
            <div class="profile-user-info profile-user-info-striped">

                <div class="profile-info-row">
                    <div class="profile-info-name"> 报送单位</div>
                    <div class="profile-info-value">
                        <span class="editable" id="sendOrg"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 保送日期</div>
                    <div class="profile-info-value">
                        <span class="editable" id="sendDateStr"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 标题</div>
                    <div class="profile-info-value">
                        <span class="editable " id="title"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 内容</div>
                    <div class="profile-info-value">
                    <span class="editable " id="content"
                          style="word-break: normal;max-width: 500px;display: block;white-space: pre-wrap;
                        word-wrap: break-word;overflow: hidden"></span>
                        </span>
                    </div>
                </div>
            </div>


            <div class="row">
                <div class="form-group form-horizontal" id="uploadedReportDiv">
                    <label class="col-sm-2 control-label" for="download-report-view"
                           style="font-weight: bold;color: deepskyblue;">
                        已上传的附件：
                    </label>
                    <div class="col-sm-10">
                        <span id="download-report-view"></span>
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

    var comeInfoId = '${comeInfoId}';
    var loadReportUrl = '${basePath}/come/come-report/load-report-list.do';
    var editReportUrl = '${basePath}/come/come-report/load-report-edit';
    var deleteReportUrl = '${basePath}/come/come-report/report-delete.do';

    var $reportGrid = $("#grid-table-report");
    var $editReportDialog = $("#edit-report-dialog");
    var $viewReportDialog = $("#view-report-dialog");

    var $addReportRow = $("#addReportRow");

    var reportColModel = [
        {name: 'id', index: 'id', hidden: true},
        {name: 'title', header: '标题', index: 'title', sortable: true},
        {name: 'sendOrg', header: '报送单位', index: 'sendOrg', sortable: true},
        {name: 'sendDateStr', header: '报送日期', index: 'sendDateStr', sortable: true},
        {name: 'content', header: '内容', index: 'content', sortable: true, cellattr: styleFormatter},
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
        operations.push('<i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
        operations.push('</button>');

        operations.push("</div>");
        cellvalue = operations.join('');
        return cellvalue;
    }

    $reportGrid.tjGrid({
        loadUrl: loadReportUrl,
        height: '100%',
        autowidth: true,
        colModel: reportColModel,
        postData: {
            comeInfoId: comeInfoId
        },
        sortname: '',
        sortorder: 'asc',
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
            var rowData = $reportGrid.jqGrid('getRowData', id);

            if (className.indexOf('row-record-view') !== -1) {
                viewReport(rowData);
            } else if (className.indexOf('row-record-delete') !== -1) {
                G.confirm({
                    message: '确认删除此条简报信息吗？',
                    callback: function (result) {
                        if (result) {
                            $.post(deleteReportUrl, {id: id}, function (data) {
                                if (data.result) {
                                    G.showGritterSuccess("删除成功");
                                    $reportGrid.tjGrid('reloadGrid');
                                }
                            });
                        }
                    }
                });
            } else if (className.indexOf('row-record-edit') !== -1) {
                editReportRow(id);
            }
        }
    });

    $reportGrid.tjGrid("triggerResizeGrid");

    // 添加一行来访简报
    $addReportRow.unbind('click').bind('click', function (e) {
        e.preventDefault();

        editReportRow();
    });

    // 编辑来访简报
    function editReportRow(id) {
        var loadId = G.showAjaxLoading();
        $.ajax({
            url: editReportUrl,
            type: "GET",
            data: {id: id},
            dataType: "html",
            success: function (String) {
                $editReportDialog.html(String);
                G.doneAjaxLoading(loadId);
                reportDialog($editReportDialog);
            },
            error: function () {
                G.doneAjaxLoading(loadId);
                G.alert({message: "操作失败！"});
            }
        });
    }

    var enableClick = true;
    // 来访简报弹窗
    function reportDialog($dialog) {

        var $form = $dialog.find("#report-form");

        var saveRowUrl = '${basePath}/come/come-report/report-edit.do';

        var $uploadReportFile = $dialog.find("#form-field-report-file");
        var $reportFileQueue = $dialog.find('#report-file-queue');
        var $downloadReport = $dialog.find("#download-report");

        $dialog.removeClass('hide').dialog({
            resizable: false,
            height: 'auto',
            maxHeight: 600,
            width: 800,
            modal: true,
            title: "<div class='widget-header header-bg'><h4 class='smaller' style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>新增/编辑来访简报</h4></div>",
            title_html: true,
            close: function () {
                $form.tjValidate('resetForm');
            },
            buttons: [
                {
                    html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                    "class": "btn btn-warning",
                    click: function () {
                        $dialog.dialog("close");
                    }
                },
                {
                    html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 确定",
                    "class": "btn btn-success",
                    click: function () {
                        if ($form.validate().form()) {
                            if (enableClick) {
                                enableClick = false;
                                var data = $form.serializeObject();
                                data['comeInfoId'] = comeInfoId;
                                data['fileIds'] = JSON.stringify(getFileListArray($reportFileQueue));

                                var startDate = moment('${startDate}','YYYY-MM-DD').toDate();
                                var endDate = moment('${endDate}','YYYY-MM-DD').toDate();
                                var sendDate = moment($dialog.find('#form-field-sendDateStr').val(),'YYYY-MM-DD').toDate();

                                if (sendDate >= startDate && sendDate <= endDate) {
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
                                            $reportGrid.tjGrid('reloadGrid');
                                            $dialog.dialog('close');
                                        } else {
                                            G.showGritterFail("操作失败,请稍后重试！");
                                        }
                                    });
                                } else {
                                    G.alert({message: '报送日期应在来访开始日期和结束日期之间!'});
                                }
                            }
                        }
                    }
                }
            ]
        });

        bindUpload($uploadReportFile, "report-file-queue", $downloadReport);

        $form.tjValidate({
            focusInvalid: true,
            rules: {
                title: {required: true, maxlength: 100},
                sendOrg: {required: true, maxlength: 50},
                sendDateStr: {required: true},
                content: {required: true, maxlength: 5000}
            },
            messages: {
                title: {required: "标题不能为空"},
                sendOrg: {required: "报送单位不能为空"},
                sendDateStr: {required: "报送日期不能为空"},
                content: {required: "简报内容不能为空"}
            }
        });
    }

    // 查看来访简报
    function viewReport(rowData) {

        var viewReportUrl = '${basePath}/come/come-report/get-report-file-list.do';
        var $fileList = $viewReportDialog.find('#download-report-view');
        var id = rowData.id;

        $viewReportDialog.find('.editable').each(function () {
            $(this).html(rowData[$(this).attr('id')]);
        });

        $.ajax({
            url: viewReportUrl,
            type: "POST",
            data: {id: id},
            dataType: "json",
            success: function (result) {
                appendAttach($fileList, result.reportFileList);
                initViewDialog($viewReportDialog, result.reportFileList);
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
            title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看来访简报</h4></div>",
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
                    if ($fileList.html().indexOf('暂无') !== -1) {
                        $fileList.empty();
                    }
                } else {
                    G.showGritterFail();
                }

            }
        });
    }
    /*--------附件上传end--------*/

    //获取已上传的附件
    function appendReportAttach($div, jsonFileObject) {

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
</script>