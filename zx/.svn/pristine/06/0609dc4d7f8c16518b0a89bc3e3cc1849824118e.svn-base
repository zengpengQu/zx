<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>
<title>履职支撑平台</title>

<style>
    .buttonCursor >input {
        cursor: pointer;
    }
</style>

<div class="row">
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->
        <div class="space-6"></div>
        <div class="row">
            <div class="col-sm-10 col-sm-offset-1">
                <!-- #section:pages/invoice -->
                <div class="widget-box transparent">
                    <div class="widget-header widget-header-large center">
                        <h3 class="widget-title grey lighter">
                            <span style="font-size: 20px; font-weight: bold; color: #0B1022">当前档案：</span>
                            <span style="font-size: 18px; font-weight: bold; color: #00a0e9">${documentArchive.jsonObject.teamName}-${documentArchive.jsonObject.archiveNumber}</span>
                        </h3>
                    </div>

                    <div class="widget-body">
                        <div class="widget-main padding-24">
                            <div class="row">
                                <div class="col-xs-12">
                                    <form class="form-horizontal" id="documentForm" role="form" autocomplete="off" method="post">
                                        <input id="documentId" name="documentId" type="hidden" value="${document.id}">
                                        <input id="documentArchiveId" name="documentArchiveId" type="hidden" value="${documentArchive.id}">
                                        <div class="row">
                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label" for="form-field-documentNumber" >文件编号：<span
                                                            class="required">*</span></label>

                                                    <div class="col-sm-8 ">
                                                        <input type="text" id="form-field-documentNumber" name="documentNumber"
                                                               class="form-control " value="${document.documentNumber}"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label" for="form-field-documentName" >文件题名：<span
                                                            class="required">*</span></label>

                                                    <div class="col-sm-8 ">
                                                        <input type="text" id="form-field-documentName" name="documentName"
                                                               class="form-control " value="${document.documentName}"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="space-10"></div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label" for="form-field-dutyPerson" >责任人：<span
                                                            class="required">*</span></label>

                                                    <div class="col-sm-8 ">
                                                        <input type="text" id="form-field-dutyPerson" name="dutyPerson"
                                                               class="form-control " value="${document.dutyPerson}"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label" for="form-field-formationDate" >文件形成日期：<span
                                                            class="required">*</span></label>

                                                    <div class="col-sm-8 ">
                                                        <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                            <input class="form-control" name="formationDate" id="form-field-formationDate"
                                                                   value="${document.jsonObject.formationDate}" type="text"/>
                                                            <span class="input-group-addon">
                                                    <i class="fa fa-calendar bigger-110"></i>
                                                </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="space-10"></div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label" for="form-field-pageNumber" >页号：<span
                                                            class="required">*</span></label>

                                                    <div class="col-sm-8 ">
                                                        <input type="text" id="form-field-pageNumber" name="pageNumber"
                                                               class="form-control " value="${document.pageNumber}"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label" for="form-field-department" >编制单位：<span
                                                            class="required">*</span></label>

                                                    <div class="col-sm-8 deptDiv">
                                                        <input type="text" id="form-field-department" name="department"
                                                               class="hide" value=""/>
                                                        <input type="text" class="form-control" id="form-field-deptName"
                                                               name="deptName" value="" style="cursor: pointer;" readonly/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="space-10"></div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12 ">
                                                <div class="form-group">
                                                    <label class="col-sm-2 control-label" for="form-field-notes" >备注：<span
                                                            class="required">*</span></label>

                                                    <div class="col-sm-10 ">
                                            <textarea class="form-control limited" id="form-field-notes"
                                                      name="notes" maxlength="200" style="min-height: 100px;">${document.notes}</textarea>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="space-10"></div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="form-group">
                                                    <label class="col-sm-2 control-label" >
                                                        多附件上传：<span class="required">&nbsp;</span>
                                                    </label>
                                                    <div class="col-sm-10">
                                                        <input id="message-file" type="file"/>
                                                        <div id="message-file-queue"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="space-10"></div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="form-group" id="uploadedDiv">
                                                    <div class="col-xs-12">
                                                        <label style="width: 13%" class="col-xs-2 control-label no-padding-left">
                                                            已上传附件：
                                                        </label>
                                                        <div class="col-xs-8 no-padding-left">
                                                            <span id="download-file"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="clearfix form-actions center">
                                            <div class="col-xs-12">
                                                <button class="btn btn-info btn-sm" type="button" id="saveBtn">
                                                    <i class="ace-icon fa fa-check bigger-110"></i>
                                                    保存
                                                </button>
                                                &nbsp; &nbsp; &nbsp;&nbsp;
                                                <button class="btn btn-primary btn-sm" type="button" id="backBtn">
                                                    <i class="ace-icon fa fa-undo bigger-110"></i>
                                                    返回
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- /section:pages/invoice -->
            </div>
        </div>
        <!-- PAGE CONTENT ENDS -->
    </div><!-- /.col -->
</div><!-- /.row -->

<script src="${basePath}/plugin/ace/assets/js/ace/elements.fileinput.js"></script>
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.datepicker({
            todayHighlight : true
        });

        G.initDept('deptDiv',true,['${dicDept}'],TREE_NODE);

        var $documentForm = $('#documentForm');
        var $documentId = $('#documentId');
        var $documentArchiveId = $('#documentArchiveId');
        var $documentNumber = $('#form-field-documentNumber');
        var $documentName = $('#form-field-documentName');
        var $dutyPerson = $('#form-field-dutyPerson');
        var $formationDate = $('#form-field-formationDate');
        var $pageNumber = $('#form-field-pageNumber');
        var $department = $('#form-field-department');
        var $notes = $('#form-field-notes');

        var $messageFile = $('#message-file');
        var $messageFileQueue = $('#message-file-queue');
        var $uploadedDiv = $('#uploadedDiv');
        var $downLoadFile = $("#download-file");

        //新增时隐藏
        if ('' == $documentId.val()) {
            $uploadedDiv.addClass('hide');
        }

        function getDocumentData() {
            var documentData = {};
            var dicDept = {};
            var documentArchive = {};
            documentData.id = $documentId.val();
            documentData.documentNumber = $documentNumber.val();
            documentData.documentName = $documentName.val();
            documentData.dutyPerson = $dutyPerson.val();
            documentData.formationDate = $formationDate.val();
            documentData.pageNumber = $pageNumber.val();
            documentData.notes = $notes.val();

            documentArchive.id = $documentArchiveId.val();
            documentData.documentArchive = documentArchive;

            dicDept.id = $department.val();
            documentData.dicDept = dicDept;

            var documentFileArray = getFileListArray($messageFileQueue);

            documentData.documentFileList = documentFileArray;

            return documentData;
        }

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

        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");

        var saveUrl = '${basePath}/document/document-save.do';

        $saveBtn.unbind('click').bind('click', function (e) {
            if ($documentForm.validate().form()) {
                var data = getDocumentData();
                G.confirm({
                    message: '确认保存此条文件信息吗？',
                    callback: function (result) {
                        if (result) {
                            var loadId = G.showAjaxLoading();
                            $saveBtn.prop("disabled", true);
                            $backBtn.prop("disabled", true);
                            $.ajax({
                                url: saveUrl,
                                type: 'POST',
                                dataType: 'json',
                                data: JSON.stringify(data),
                                contentType: "application/json;charset=utf-8",
                                async: true
                            }).done(function (map) {
                                G.doneAjaxLoading(loadId);
                                if (map.result == true) {
                                    G.showGritterSuccess("保存成功!");
                                    G.pjaxLoadPageContentDiv('#page/document-archive/document-archive-list');
                                } else {
                                    G.showGritterFail("保存失败!");
                                    $saveBtn.prop("disabled", false);
                                    $backBtn.prop("disabled", false);
                                }
                            });
                        } else {
                            $saveBtn.prop("disabled", false);
                            $backBtn.prop("disabled", false);
                        }
                    }
                });
            }
        });

        $documentForm.tjValidate({
            focusInvalid: true,
            rules: {
                documentNumber: {required: true},
                documentName: {required: true},
                dutyPerson: {required: true},
                formationDate: {required: true},
                pageNumber: {required: true, digits:true},
                deptName: {required: true}
            },
            messages: {
                documentNumber: {required: "文件编号填写"},
                documentName: {required: "文件题名必须填写"},
                dutyPerson: {required: "责任人必须填写"},
                formationDate: {required: "文件形成日期必须填写"},
                pageNumber: {required: "页号必须填写"},
                deptName: {required: "编制单位必须选择"}
            }
        });

        $backBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var listUrl = '#page/document-archive/document-archive-list';
            var postData = $documentForm.serializeObject();
            var flag = 0;
            $.each(postData, function (index, item) {

                if (item !== "") {
                    flag = 1;
                }
            });
            if (flag === 0) {
                G.pjaxLoadPageContentDiv(listUrl)
            } else {
                G.confirm({
                    message: "您有文件信息未保存，确认退出吗？",
                    callback: function (result) {
                        if (result) {
                            G.pjaxLoadPageContentDiv(listUrl);
                        }
                    }
                });
            }

        });

        /*--------附件上传start--------*/
        bindUpload($messageFile, "message-file-queue");

        function bindUpload(fileInput, queueId) {
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
                'buttonClass': 'btn btn-sm btn-primary buttonCursor',
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
                    } else {
                        G.showGritterFail();
                    }

                }
            });
        }
        /*--------附件上传end--------*/

        /*--------附件预览删除start--------*/
        //获取已上传的附件
        appendAttach($downLoadFile, ${jsonFileList});

        //获取已上传的附件
        function appendAttach($div, attachList) {
            $div.empty();
            var html = [];
            if (_.isEmpty(attachList)) {
                html.push('<ul class="list-unstyled list-striped pricing-table-header"><li style="margin-top:5px">');
                html.push('暂无上传附件！');
                html.push('</li></ul>');
            } else {
                html.push('<ul class="list-unstyled list-striped pricing-table-header">');
                for (var i in attachList) {
                    var attach = attachList[i];
                    html.push('<li class="blue"  style="cursor:pointer;margin-top:5px;background-color: white;">');
                    html.push('<a class="filePreview" fileId="' + attach.id + '" style="color:#478FCA;font-family:仿宋, Arial, Helvetica, sans-serif;font-size: 18px;">');
                    html.push(attach.fileName);
                    html.push('</a>&nbsp&nbsp&nbsp');
                    html.push('<a style="color:grey" href="${basePath}/file/download.action?id=' + attach.id + '&type=0">');
                    html.push('<i class="ace-icon fa fa-download grey bigger-130"></i>下载</a>&nbsp;');
                    html.push('<span class="red fileDelete" fileId="' + attach.id + '">');
                    html.push('<i class="ace-icon fa fa-trash-o red bigger-130 fileDelete"></i>删除&nbsp;');
                    html.push('</span>');
                    html.push('</li>');
                }
                html.push('</ul>');
            }
            $div.append(html.join(""));
            deleteFile();
        }

        //删除已上传附件
        function deleteFile() {
            $('.fileDelete').click(function () {
                var $this = $(this);
                var fileId = $this.attr("fileId");
                G.confirm({
                    message: '确定删除该附件信息？',
                    callback: function (result) {
                        if (result) {
                            var url = '${basePath}/document/document-file-delete.do';
                            $.post(url, {id: fileId}, function (response) {
                                if (response.result) {
                                    G.showGritterSuccess();
                                }
                                $this.parent().remove();
                            });
                        }
                    }
                })
            })
        }

        $(document).one('ajaxloadstart.page', function (e) {
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

        /*--------附件预览删除end--------*/

    });
</script>