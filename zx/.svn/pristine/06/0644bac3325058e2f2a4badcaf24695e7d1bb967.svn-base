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
                            <form class="form-horizontal" id="new-edit-form" role="form" method="post"
                                  autocomplete="off">
                                <input id="id-file-manage" name="id" type="hidden" value="${fileManage.id}">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 5px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${fileManage.id eq null}">文件新增</c:when>
                                                    <c:otherwise>文件编辑</c:otherwise>
                                                </c:choose></h1>
                                        </div>
                                    </div>
                                </div>
                                <div style="margin-top: 5%"></div>

                                <div class="row">
                                    <!-- 内部序号 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-inSerialNum">内部序号：<span
                                                    class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-inSerialNum" name="inSerialNum"
                                                       class="form-control " value="${fileManage.inSerialNum}"
                                                />
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 收件时间 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-receiveTime">收件时间：<span
                                                    class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <div class="input-group">
                                                    <input class="form-control date-picker"
                                                           name="receiveTimeSt"
                                                           id="form-field-receiveTime"
                                                           data-date-format="yyyy-mm-dd"
                                                           value="${receiveTimeSt}" type="text"/>
                                                    <span class="input-group-addon"><i
                                                            class="fa fa-calendar bigger-110"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>

                                <div class="row">
                                    <!-- 来文单位 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-senderOrg">来文单位：<span
                                                    class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-senderOrg" name="senderOrg"
                                                       class="form-control " value="${fileManage.senderOrg}"
                                                />
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 密级 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-secClassStr">密级：<span
                                                    class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-secClassStr" name="secClassStr">
                                                    <option value="">--------请选择--------</option>
                                                    <c:forEach items="${secClassList}" var="secClass">
                                                        <option value="${secClass.name}"
                                                        <c:if test="${secClass.name eq fileManage.secClass}">selected</c:if>>${secClass.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>

                                <div class="row">
                                    <!-- 文号 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-fileNum">文号：<span
                                                    class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-fileNum" name="fileNum"
                                                       class="form-control " value="${fileManage.fileNum}"
                                                />
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 数量 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-quantity">数量：<span
                                                    class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-quantity" name="quantity"
                                                       class="form-control " value="${fileManage.quantity}"
                                                />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>

                                <div class="row">
                                    <!-- 保密期限 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-secDeadline">保密期限(年)：<span
                                                    class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-secDeadline" name="secDeadline"
                                                       class="form-control " value="${fileManage.secDeadline}"
                                                />
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 回收状态 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-recycleStatus">回收状态：<span
                                                    class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-recycleStatus" name="recycleStatus"
                                                       class="form-control " value="${fileManage.recycleStatus}"
                                                />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>

                                <div class="row">
                                    <!-- 来文类型 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-fileType">来文类型：<span
                                                    class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-fileType" name="fileType"
                                                       class="form-control " value="${fileManage.fileType}"
                                                />
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 来文标题 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-fileTitle">来文标题：<span
                                                    class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-fileTitle" name="fileTitle"
                                                       class="form-control " value="${fileManage.fileTitle}"
                                                />
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
                                <!-- 按钮 -->
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
        G.datepicker();

        // 控件类全局变量
        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");

        // 表单类全局变量
        var $saveForm = $("#new-edit-form");

        //其他全局变量
        var fileManageId = $saveForm.find("#id-file-manage").val();

        //文件上传全局变量
        var $messageFile = $('#message-file');
        var $messageFileQueue = $('#message-file-queue');
        var $downLoadFile = $("#download-file");


        //本地URL
        var url = '#page/telegraph-manage/jump-to-telegraph-manage-list?flag=1';
        var editUrl = '${basePath}/file-manage/load-file-manage-save.do';

        //文件新增或编辑提交数据
        $saveBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var data = $saveForm.serializeObject();
            data['fileIds'] = JSON.stringify(getFileListArray($messageFileQueue));
            data["fileManageId"] = fileManageId;

            if ($saveForm.validate().form()) {
                G.confirm({
                    message: '确认保存此条信息吗？',
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
                                    G.showGritterSuccess("保存成功");
                                    G.pjaxLoadPageContentDiv(url);
                                } else {
                                    G.showGritterFail("保存信息失败,请稍后重试!");
                                }
                            });
                        }
                    }
                });
            }
        });

        //文件新增或编辑返回操作
        $backBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var postData = $saveForm.serializeObject();
            var flag = 0;
            $.each(postData, function (index, item) {
                if (item !== "") {
                    flag = 1;
                }
            });
            if (flag === 0) {
                G.pjaxLoadPageContentDiv(url);
            } else {
                G.confirm({
                    message: "您的文件信息尚未保存，确认退出吗？",
                    callback: function (result) {
                        if (result) {
                            G.pjaxLoadPageContentDiv(url);
                        }
                    }
                });
            }
        });

        //数据校验
        $saveForm.tjValidate({
            focusInvalid: false,
            rules: {
                inSerialNum: {
                    required: true
                },
                receiveTimeSt: {
                    required: true
                },
                senderOrg: {
                    required: true
                },
                secClassStr: {
                    required: true
                },
                fileNum: {
                    required: true
                },
                quantity: {
                    required: true
                },
                secDeadline: {
                    required: true
                },
                recycleStatus: {
                    required: true
                },
                fileType: {
                    required: true
                },
                fileTitle: {
                    required: true
                },
            },
            messages: {
                inSerialNum: {
                    required: "内部序号不能为空"
                },
                receiveTimeSt: {
                    required: "收件时间不能为空"
                },
                senderOrg: {
                    required: "来文单位不能为空"
                },
                secClassStr: {
                    required: "密级不能为空"
                },
                fileNum: {
                    required: "文号不能为空"
                },
                quantity: {
                    required: "数量不能为空"
                },
                secDeadline: {
                    required: "保密期限不能为空"
                },
                recycleStatus: {
                    required: "回收状态不能为空"
                },
                fileType: {
                    required: "来文类型不能为空"
                },
                fileTitle: {
                    required: "来文标题不能为空"
                },
            }
        });

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

        $(document).one('ajaxloadstart.page', function (e) {
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>