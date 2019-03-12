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
            <input type="text" id="form-field-abroadInfoId" name="abroadInfoId" value="${abroadInfoId}"/>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right">
                    <button class="btn btn-info btn-sm" type="button" id="addBtn-preparment">
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
                <table id="grid-table-preparment"></table>
            </div>
        </div>

    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <div id="edit-dialog-preparment" class="hide"></div>
    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <div id="view-dialog-preparment" class="hide">
            <div class="profile-user-info profile-user-info-striped">

                <div class="profile-info-row">
                    <div class="profile-info-name" style="width: 12%;"> 会议名称</div>
                    <div class="profile-info-value" style="width: 38%">
                        <span class="editable " id="meetingName"></span>
                    </div>
                    <div class="profile-info-name" style="width: 12%"> 会议日期</div>
                    <div class="profile-info-value" style="width: 38%">
                        <span class="editable " id="meetingDateStr"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 会议时间</div>
                    <div class="profile-info-value">
                        <span class="editable " id="meetingTime"></span>
                    </div>
                    <div class="profile-info-name"> 会议地点</div>
                    <div class="profile-info-value">
                        <span class="editable " id="meetingPlace"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 参会人员</div>
                    <div class="profile-info-value">
                        <span class="editable " id="attendees"></span>
                    </div>
                    <div class="profile-info-name"></div>
                    <div class="profile-info-value">
                    </div>
                </div>

                <%--<div class="profile-info-row">--%>
                    <%--<div class="profile-info-name"> 会议资料</div>--%>
                    <%--<div class="profile-info-value">--%>
                        <%--<span class="editable preparment" id="files"></span>--%>
                    <%--</div>--%>
                <%--</div>--%>

            </div>
            <div class="row">
                <div class="col-xs-12">
                    <div class="form-group form-horizontal">
                        <label class="col-sm-2 control-label" for="files"
                               style="font-weight: bold;color: deepskyblue;">
                            会议资料：
                        </label>
                        <div class="col-sm-10">
                            <span id="files"></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="hidden">
    <input type="text" id="abroadInfoStartDate" value="${abroadInfo.startDate}"/>
    <input type="text" id="abroadInfoEndDate" value="${abroadInfo.endDate}"/>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.datepicker();

        var $abroadInfoId = $("#form-field-abroadInfoId");

        var $addBtn = $("#addBtn-preparment");

        var $gridTable = $("#grid-table-preparment");
        var $editDialog = $("#edit-dialog-preparment");
        var $viewDialog = $("#view-dialog-preparment");

        var loadUrl = '${basePath}/abroad-preparment/load-preparment-list.do';
        var editUrl = '${basePath}/abroad-preparment/load-preparment-edit.do';
        var saveUrl = '${basePath}/abroad-preparment/abroad-preparment-edit-save.do';
        var deleteUrl = '${basePath}/abroad-preparment/abroad-preparment-delete.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'meetingName', header: '会议名称', index: 'meetingName', sortable: false},
            {name: 'meetingDateStr', header: '会议日期', index: 'meetingDateStr', sortable: false},
            {name: 'meetingTime', header: '会议时间', index: 'meetingTime', sortable: false},
            {name: 'meetingPlace', header: '会议地点', index: 'meetingPlace', sortable: false},
            {name: 'attendees', header: '参会人员', index: 'attendees', sortable: false},
            {name: 'realName', header: '会议资料', index: 'realName', hidden: true},
            {name: 'basic', header: '基本操作', sortable: false, width: 200, fixed: true, formatter: basicOperationFormatter},
        ];

        function basicOperationFormatter(cellvalue, options, rowData, action) {
            var operations = [];

            operations.push("<div style='margin-left:5px;font-size: 20px;'>");
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue row-record-view"></i> 查看');
            operations.push('</button>');

            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
            operations.push('<i class="ace-icon fa fa-pencil blue row-record-edit"></i> 编辑');
            operations.push('</button>');

            operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete">');
            operations.push(' <i class="ace-icon orange fa fa-trash-o blue row-record-delete"></i> 删除');
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
                abroadInfoId: $abroadInfoId.val()
            },
            sortname: 'meetingDate',
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

                if (className.indexOf('row-record-view') !== -1) {
                    var rowData = $gridTable.jqGrid('getRowData', id);
                    viewAbroadPreparment(rowData);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条会议信息吗？',
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
                    editAbroadPreparment(id);
                } else if (className.indexOf('downloadAbroadPreparment') != -1) {
                    handleAbroadPreparment(id, '0');
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        $addBtn.click(function () {
            editAbroadPreparment();
        });

        function editAbroadPreparment(id) {
            var loadId = G.showAjaxLoading();
            $.ajax({
                url: editUrl,
                type: "GET",
                data: {id: id},
                dataType: "html",
                success: function (String) {
                    $editDialog.html(String);
                    G.doneAjaxLoading(loadId);
                    initEditDialog($editDialog);
                },
                error: function () {
                    G.doneAjaxLoading(loadId);
                    G.alert({message: "操作失败！"});
                }
            });
        }

        var enableClick = true;
        function initEditDialog($container) {
            var $form = $("#saveFormPreparment");
            var $uploadAbroadPreparment = $container.find("#form-field-uploadAbroadPreparment");
            var $downloadPreparment = $container.find("#download-materials");
            var $messageFileQueue = $container.find('#message-file-queue');

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-fire green'></i> 新增/编辑</h4></div>",
                title_html: true,
                close: function () {
                    $form.resetForm();
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
                                var postData = getRecord($form);
                                postData['fileIds'] = JSON.stringify(getFileListArray($messageFileQueue));

                                if (enableClick) {
                                    enableClick = false;
                                    var loadId = G.showAjaxLoading();
                                    $.ajax({
                                        url: saveUrl,
                                        type: 'post',
                                        dataType: 'json',
                                        data: postData,
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
                                    });
                                }
                            }
                        }
                    }
                ]
            });

            $form.tjValidate({
                focusInvalid: false,
                rules: {
                    meetingName: {
                        required: true
                    },
                    dutyTimeStr: {
                        required: true
                    },
                    meetingTime: {
                        required: true
                    },
                    meetingPlace: {
                        required: true
                    },
                    attendees: {
                        required: true
                    }
                },
                messages: {
                    meetingName: {
                        required: "会议名称不能为空"
                    },
                    dutyTimeStr: {
                        required: "会议日期不能为空"
                    },
                    meetingTime: {
                        required: "会议时间不能为空"
                    },
                    meetingPlace: {
                        required: "会议地点不能为空"
                    },
                    attendees: {
                        required: "参会人员不能为空"
                    }
                }
            });

            bindUpload($uploadAbroadPreparment, "message-file-queue", $downloadPreparment);

        }

        function getRecord($form) {
            var abroadInfoId = $abroadInfoId.val();
            var abroadPreparmentId = $form.find('#form-field-id').val();
            var meetingName = $form.find('#form-field-meetingName').val();
            var meetingDateStr = $form.find('#form-field-meetingDateStr').val();
            var meetingTime = $form.find('#form-field-meetingTime').val();
            var meetingPlace = $form.find('#form-field-meetingPlace').val();
            var attendees = $form.find('#form-field-attendees').val();

            var records = {
                'id': abroadPreparmentId,
                'abroadInfoId': abroadInfoId,
                'meetingName': meetingName,
                'meetingDateStr': meetingDateStr,
                'meetingTime': meetingTime,
                'meetingPlace': meetingPlace,
                'attendees': attendees
            };

            return records;
        }

        function viewAbroadPreparment(rowData) {
            $viewDialog.find('.editable').each(function () {
                $(this).html(rowData[$(this).attr('id')]);
            });

            showViewDialog(rowData.id);
        }

        function showViewDialog(id) {
            var fileUrl = '${basePath}/abroad-preparment/get-file-list.do';

            // 获取筹备会议附件资料
            $.post(fileUrl, {id: id}, function (data) {
                if (data.result) {
                    var $fileList = $viewDialog.find("#files");

                    appendAttach($fileList, data.preparementFileList);

                    initViewDialog($viewDialog);
                }
            });
        }

        // 显示附件资料
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

        function initViewDialog($container) {
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看会议信息</h4></div>",
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

        function handleAbroadPreparment(id, type) {
            var operName = "";
            var downloadUrl = '${basePath}/file/download.action?id=' + id + '&type=0';
            if (type == '0') {
                operName = '下载';

                var $downloadForm = $("<form method='post'></form>");
                $downloadForm.attr("action", downloadUrl);
                $(document.body).append($downloadForm);
                $downloadForm.submit();
            }
        }

        function reloadGrid() {
            $gridTable.tjGrid('reloadGrid');
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

        $(document).one('ajaxloadstart.page', function (e) {
            // $.jgrid.gridDestroy("#grid-table-preparment");
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>
