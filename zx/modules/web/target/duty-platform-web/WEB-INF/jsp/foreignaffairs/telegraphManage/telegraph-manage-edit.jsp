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
                            <form class="form-horizontal" id="new-edit-form" role="form" method="post" autocomplete="off">
                                <input id="id-telegraph-manage" name="id" type="hidden" value="${telegraphManage.id}">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 5px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${telegraphManage.id eq null}">电报新增</c:when>
                                                    <c:otherwise>电报编辑</c:otherwise>
                                                </c:choose></h1>
                                        </div>
                                    </div>
                                </div>
                                <div style="margin-top: 5%"></div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-inSerialNum">内部序号：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-inSerialNum" name="inSerialNum"
                                                       class="form-control " value="${telegraphManage.inSerialNum}"/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-receiveTime">接收日期：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="receiveTimeStr"
                                                           id="form-field-receiveTime"
                                                           value="${receiveTime}" type="text"/>
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
                                    <!-- 报号 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-telegramNum">报号：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-telegramNum" name="telegramNum"
                                                       class="form-control " value="${telegraphManage.telegramNum}"/>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 密级 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-secClass">密级：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-secClass"
                                                        name="secClass">
                                                    <option value="">--------请选择--------</option>
                                                    <c:forEach items="${secClassList}" var="secClass">
                                                        <option value="${secClass.name}"
                                                        <c:if test="${secClass.name eq telegraphManage.secClass}">selected</c:if>>${secClass.name}</option>
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
                                    <!-- 来文类型 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-telegramType">来文类型：<span
                                                    class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-telegramType" name="telegramType"
                                                       class="form-control " value="${telegraphManage.telegramType}"
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
                                                       class="form-control " value="${telegraphManage.quantity}"
                                                />
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
                                                       class="form-control " value="${telegraphManage.senderOrg}"
                                                />
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 来文标题 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-telegramTitle">来文标题：<span
                                                    class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-telegramTitle" name="telegramTitle"
                                                       class="form-control " value="${telegraphManage.telegramTitle}"
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
<script src="${basePath}/plugin/ace/assets/js/ace/elements.fileinput.js"></script>
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
        var telegraphId = $saveForm.find("#id-telegraph-manage").val();

        //文件上传全局变量
        var $messageFile = $('#message-file');
        var $messageFileQueue = $('#message-file-queue');
        var $downLoadFile = $("#download-file");

        //本地URL
        var url = '#page/telegraph-manage/jump-to-telegraph-manage-list';
        var editUrl = '${basePath}/telegraph-manage/load-telegraph-manage-save.do';



        //电报新增或编辑提交数据
        $saveBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var data = $saveForm.serializeObject();
            data['fileIds'] = JSON.stringify(getFileListArray($messageFileQueue));
            data["telegraphId"] = telegraphId;

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

        //电报新增或编辑返回操作
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
                    message: "您的电报信息尚未保存，确认退出吗？",
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
                receiveTimeStr: {
                    required: true
                },
                telegramNum: {
                    required: true
                },
                secClass: {
                    required: true
                },
                telegramType: {
                    required: true
                },
                quantity: {
                    required: true
                },
                senderOrg: {
                    required: true
                },
                telegramTitle: {
                    required: true
                },
            },
            messages: {
                inSerialNum: {
                    required: "内部序号不能为空"
                },
                receiveTimeStr: {
                    required: "接收日期不能为空"
                },
                telegramNum: {
                    required: "报号不能为空"
                },
                secClass: {
                    required: "密级不能为空"
                },
                telegramType: {
                    required: "来文类型不能为空"
                },
                quantity: {
                    required: "数量不能为空"
                },
                senderOrg: {
                    required: "来文单位不能为空"
                },
                telegramTitle: {
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