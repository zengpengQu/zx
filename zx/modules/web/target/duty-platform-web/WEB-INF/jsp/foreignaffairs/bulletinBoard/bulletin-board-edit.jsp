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
    <div class="col-xs-10 col-sm-offset-1">
        <div class="widget-box transparent">
            <div class="widget-body">
                <div class="widget-main">
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" id="new-edit-form" role="form" method="post">
                                <input id="id-bulletin-board" name="id" type="hidden" value="${bulletinBoard.id}">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 5px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${bulletinBoard.id eq null}">公告栏新增</c:when>
                                                    <c:otherwise>公告栏编辑</c:otherwise>
                                                </c:choose></h1>
                                        </div>
                                    </div>
                                </div>

                                <div style="margin-top: 5%"></div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-title" >标题：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-title" name="title"
                                                       class="form-control " value="${bulletinBoard.title}"/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-publishTime" >发布时间：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="publishTimeStr" id="form-field-publishTime"
                                                           value="${publishTime}" type="text"/>
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
                                    <div class="col-xs-12 ">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="form-field-content">内容：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-10">
                                            <textarea class="form-control limited" id="form-field-content"
                                                      name="content" maxlength="200"
                                                      style="min-height: 100px;">${bulletinBoard.content}</textarea>
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
                                            <label class="col-sm-2 control-label" for="form-field-notes">备注：<span
                                                    class="required">&nbsp;</span></label>
                                            <div class="col-sm-10">
                                            <textarea class="form-control limited" id="form-field-notes"
                                                      name="notes" maxlength="200"
                                                      style="min-height: 100px;">${bulletinBoard.notes}</textarea>
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
                                                上传附件：<span class="required">&nbsp;</span>
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
                                            <div class="col-sm-10 pull-right" style="padding-left: 0px">
                                                <span id="download-file"></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                                <div class="clearfix form-actions center">
                                    <div class="col-xs-12">
                                        <button class="btn btn-info btn-sm" type="button" id="saveBtn">
                                            <i class="ace-icon fa fa-check bigger-110"></i>
                                            保存
                                        </button>
                                        &nbsp;&nbsp;&nbsp;
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
    </div>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        //时间控件
        G.datepicker({autoclose: true, todayHighlight: true});

        // 控件类全局变量
        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");

        // 表单类全局变量
        var $saveForm = $("#new-edit-form");

        //其他全局变量
        var bulletinBoardId = $saveForm.find("#id-bulletin-board").val();

        //文件上传全局变量
        var $messageFile = $('#message-file');
        var $messageFileQueue = $('#message-file-queue');
        var $downLoadFile = $("#download-file");

        //本地url
        var editUrl = '${basePath}/bulletin-board/load-bulletin-board-save.do';


        // 获取上传文件信息
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

            var $oldFiles = $(".filePreview");

            if ($oldFiles !== undefined) {
                $oldFiles.each(function () {
                    var $this = $(this);
                    var fileId = $this.attr('fileId');
                    var documentFile = {};
                    documentFile.fileId = fileId;
                    documentFileArray.push(documentFile);
                })
            }

            return documentFileArray;
        }


        bindUpload($messageFile, "message-file-queue");

        /*--------附件上传start--------*/
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
                        if($downLoadFile.html().indexOf('暂无') !== -1) {
                            $downLoadFile.empty();
                        }
                    } else {
                        G.showGritterFail();
                    }

                }
            });
        }
        /*--------附件上传end--------*/


        //获取已上传的附件
        appendAttach($downLoadFile,${jsonFileObject});

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
                    html.push('<span class="red fileDelete" fileId="' + jsonFileObject[i].id + '">');
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
                            var url = '${basePath}/file/delete-file.do';
                            $.post(url, {id: fileId}, function (map) {
                                if (map.result) {
                                    G.showGritterSuccess();
                                }
                                $this.parent().remove();
                            });
                        }
                    }
                });
            })
        }


        //新增或编辑提交数据
        $saveBtn.unbind('click').bind('click',function (e) {
            e.preventDefault();
            var data = $saveForm.serializeObject();
            data['fileIds'] = JSON.stringify(getFileListArray($messageFileQueue));
            data["bulletinBoardId"] = bulletinBoardId;

            if($saveForm.validate().form()) {
                G.confirm({
                    message: '确认保存此条公告栏信息吗？',
                    callback: function (result) {
                        if (result) {
                            var loadId = G.showAjaxLoading();
                            $.ajax({
                                url: editUrl,
                                type: 'POST',
                                dataType: 'json',
                                data: data,
                                async: true
                            }).done(function (map) {
                                G.doneAjaxLoading(loadId);
                                if (map.result) {
                                    G.showGritterSuccess("保存成功!");
                                    G.pjaxLoadPageContentDiv("#page/bulletin-board/jump-to-bulletin-board-list");
                                } else {
                                    G.showGritterFail("保存信息失败,请稍后重试!");
                                }
                            });
                        }
                    }
                });
            }
        });

        //新增或编辑返回操作
        $backBtn.unbind('click').bind('click',function (e) {
            e.preventDefault();
            var url = '#page/bulletin-board/jump-to-bulletin-board-list';
            var postData = $saveForm.serializeObject();
            var flag = 0;
            $.each(postData,function (index,item) {
                if (item !== ""){
                    flag = 1;
                }
            });
            if (flag === 0){
                G.pjaxLoadPageContentDiv(url);
            } else {
                G.confirm({
                    message: "您的公告栏信息未保存,确认退出吗？",
                    callback: function (result) {
                        if (result){
                            G.pjaxLoadPageContentDiv(url);
                        }
                    }
                });
            }
        });

        $saveForm.tjValidate({
            focusInvalid: true,
            rules: {
                title: {required: true, maxlength: 50},
                publishTimeStr: {required: true},
                content: {required: true, maxlength: 2000},
                notes: {required: false, maxlength: 1000}
            },
            messages: {
                title: {required: "标题必须填写"},
                publishTimeStr: {required: "发布时间必须填写"},
                content: {required: "内容必须填写"},
                notes: {required: "备注必须填写"}
            }
        });

        $(document).one('ajaxloadstart.page', function (e) {
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>
