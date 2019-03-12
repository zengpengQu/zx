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
    <div class="col-sm-10 col-sm-offset-1">
        <div class="widget-box transparent">
            <div class="widget-body">
                <div class="widget-main">
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" role="form" id="saveForm" autocomplete="off">
                                <div class="row">
                                    <!-- 主办单位 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-hostUnitName">主办单位：</label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-hostUnitName" name="hostUnitName"
                                                       readonly="readonly"
                                                       class="form-control " value="${supervisionMatter.jsonObject.hostUnitName}"
                                                       placeholder="主办单位"/>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 协作单位 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-cooperativeName">协作单位：</label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-cooperativeName" name="cooperativeName"
                                                       readonly="readonly"
                                                       class="form-control " value="${supervisionMatter.jsonObject.cooperativeName}"
                                                       placeholder="协作单位"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                                <div class="row">
                                    <!-- 督查事项编号 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-serialNumber">督查事项编号：</label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-serialNumber" name="serialNumber"
                                                       readonly="readonly"
                                                       class="form-control " value="${supervisionMatter.jsonObject.serialNumber}"
                                                       placeholder="督查事项编号"/>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 下发日期 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-issuedDate">下发日期：</label>
                                            <div class="col-sm-8 ">
                                                <input class="form-control"
                                                       name="issuedDate"
                                                       id="form-field-issuedDate"
                                                       readonly="readonly"
                                                       placeholder="下发日期"
                                                       value="${supervisionMatter.jsonObject.issuedDate}"
                                                       type="text"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                                <div class="row">
                                    <!-- 督查事项 -->
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="form-field-supMatter">督查事项：</label>
                                            <div class="col-sm-10 ">
                                            <textarea id="form-field-supMatter" name="supMatter"
                                                      readonly="readonly"
                                                      class="form-control " maxlength="200" style="min-height: 100px;"
                                                      placeholder="督查事项">${supervisionMatter.jsonObject.supMatter}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                                <div class="row">
                                    <!-- 办理要求 -->
                                    <div class="col-xs-12 ">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="form-field-requirements">办理要求：</label>
                                            <div class="col-sm-10 ">
                                            <textarea class="form-control limited" id="form-field-requirements"
                                                      readonly="readonly"
                                                      name="requirements" maxlength="200" style="min-height: 100px;"
                                                      placeholder="办理要求">${supervisionMatter.jsonObject.requirements}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                            </form>

                            <div class="hr hr-18 hr-double dotted"></div>

                            <form class="form-horizontal" id="new-edit-form" role="form" method="post">
                                <input id="id-supervision-matter" name="matterId" type="hidden" value="${supervisionMatter.jsonObject.id}">
                                <input id="id-feed-back" name="id" type="hidden" value="${supervisionFeedBack.jsonObject.id}">

                                <input type="hidden" id="unitId" name="unitId" value="${unitId}"/>
                                <div style="margin-top: 5%"></div>
                                <div class="row">
                                    <!-- 承办单位 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-unitId">承办单位：</label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-unitId" name="cooperativeId"
                                                       class="hide" value="${supervisionMatter.jsonObject.cooperativeId}"/>
                                                <input type="text" id="form-field-unitName"
                                                       readonly="readonly" style="width: 100%"
                                                       name="cooperativeName" value="${supervisionMatter.jsonObject.hostUnitName}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 审批人 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-name">审批人：
                                                <span class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-name" name="name"
                                                       class="form-control " value="${supervisionFeedBack.jsonObject.createName}"
                                                       placeholder="审批人"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>

                                <div class="row">
                                    <!-- 是否办结 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">

                                            <label class="col-sm-4 control-label">
                                                是否办结：<span class="red">*</span>
                                            </label>
                                            <div class="col-xs-8 ">
                                                <div class="form-control">
                                                    <label>
                                                        <input name="isTransfer" class="ace input-lg"
                                                               value="1" type="radio"
                                                               <c:if test="${'是' eq supervisionFeedBack.jsonObject.isTransfer}">checked</c:if> required/>
                                                        <span class="lbl bigger-120"> 是</span>
                                                    </label>
                                                    &nbsp;&nbsp;
                                                    <label>
                                                        <input name="isTransfer" class="ace input-lg"
                                                               value="0" type="radio"
                                                               <c:if test="${empty supervisionFeedBack.jsonObject.isTransfer}">checked</c:if>
                                                               <c:if test="${'否' eq supervisionFeedBack.jsonObject.isTransfer}">checked</c:if>/>
                                                        <span class="lbl bigger-120"> 否</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 反馈日期 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-feedBackDate">反馈日期：
                                                <span class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <div class="input-group">
                                                    <input class="form-control date-picker"
                                                           name="feedBackDateStr"
                                                           id="form-field-feedBackDate"
                                                           data-date-format="yyyy-mm-dd"
                                                           placeholder="反馈日期" value="${supervisionFeedBack.jsonObject.feedBackDate}" type="text"/>
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
                                    <!-- 办理情况概要 -->
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="form-field-summary">办理情况概要：
                                                <span class="red">*</span></label>
                                            <div class="col-sm-10 ">
                                        <textarea id="form-field-summary" name="summary"
                                                  class="form-control " maxlength="200" style="min-height: 100px;"
                                                  placeholder="办理情况概要">${supervisionFeedBack.jsonObject.summary}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>

                                <div class="row">
                                    <!-- 上传附件 -->
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label"
                                               for="form-field-file">上传附件：</label>
                                        <div class="col-sm-3 ">
                                            <form id="upload-reception-form" name="uploadReceptionForm"
                                                  method="POST">
                                                <input type="file" name="uploadFile"
                                                       class="form-field-upload-file"
                                                       id="form-field-file"/>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>

                                <!-- 已上传的附件 -->
                                <div class="row">
                                    <div class="form-group" id="uploadedDiv">
                                        <label class="col-sm-2 control-label" for="form-field-file" style="font-weight: bold;color: deepskyblue;">
                                            已上传的附件：
                                        </label>
                                        <div class="col-sm-10 no-padding-left">
                                            <span id="download-file"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                                <!-- 按钮 -->
                                <div class="clearfix">
                                    <div class="col-md-offset-4 col-md-8">
                                        <button class="btn btn-info btn-sm" type="button" id="saveBtn">
                                            <i class="ace-icon fa fa-check bigger-110"></i>
                                            保存
                                        </button>
                                        &nbsp; &nbsp; &nbsp;
                                        <button class="btn btn-success btn-sm" type="button" id="sendBtn">
                                            <i class="ace-icon glyphicon glyphicon-arrow-up bigger-110"></i>
                                            上报
                                        </button>
                                        &nbsp; &nbsp; &nbsp;
                                        <button class="btn btn-primary btn-sm" type="button" id="backBtn">
                                            <i class="ace-icon fa fa-undo bigger-110"></i>
                                            返回
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div><!-- /.col -->
                    </div><!-- /.row -->
                </div><!-- /.widget-main -->
            </div>
            <%--/.widget-body--%>
        </div>
        <%--/.widget-box--%>
    </div>
</div>
<script src="${basePath}/plugin/ace/assets/js/ace/elements.fileinput.js"></script>
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {
        //时间控件
        G.datepicker({autoclose: true, todayHighlight: true});

        // 元素类全局变量
        var $uploadFile = $(".form-field-upload-file");
        var $downLoadFile = $("#download-file");

        // 控件类全局变量
        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");
        var $sendBtn = $("#sendBtn");

        // 表单类全局变量
        var $saveForm = $("#new-edit-form");

        //其他全局变量
        var fd = new FormData();
        var feedBackId = $saveForm.find("#id-feed-back").val();
        var unitId = $("#unitId").val();
        var realName;//文件名
        var fileId;//存放文件表的ID
        var id = $saveForm.find("#id-supervision-matter").val();

        //本地url
        var editUrl = '${basePath}/supervision-feedback/supervision-feedback-save.do';
        var uploadUrl = '${basePath}/file/upload-file.do';

        $uploadFile.ace_file_input({
            no_file: ' ...',
            btn_choose: '选择文件',
            btn_change: '重新选择',
            droppable: false,
            onchange: null,
            thumbnail: false //| true | large
        });

        //数据校验
        $saveForm.tjValidate({
            focusInvalid: false,
            rules: {
                name: {
                    required: true
                },
                feedBackDateStr: {
                    required: true
                },
                summary: {
                    required: true
                }
            },
            messages: {
                name: {
                    required: "审批人不能为空"
                },
                feedBackDateStr: {
                    required: "反馈日期不能为空"
                },
                summary: {
                    required: "办理情况概要不能为空"
                }
            }
        });

        //新增或编辑保存数据
        $saveBtn.unbind('click').bind('click',function (e) {
            e.preventDefault();
            var data = $saveForm.serializeObject();
            data["fileId"] = fileId;
            data["feedBackId"] = feedBackId;
            data["status"] = 0;
            data["id"] = id;
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
                                    var feedbackViewUrl = '#page/supervision-feedback/load-feedback-list';
                                    var id = map.id;
                                    G.pjaxLoadPageContentDiv(feedbackViewUrl + "?id="+id+"&date=" + new Date().getTime());
                                    G.showGritterSuccess("保存成功");
                                } else {
                                    G.showGritterFail("保存信息失败,请稍后重试!");
                                }
                            });
                        }
                    }
                });
            }
        });

        //新增或编辑反馈数据
        $sendBtn.unbind('click').bind('click',function (e) {
            e.preventDefault();
            var data = $saveForm.serializeObject();
            data["fileId"] = fileId;
            data["feedBackId"] = feedBackId;
            data["status"] = 1;//已反馈
            data["id"] = id;
            data["unitId"] = unitId;
            if ($saveForm.validate().form()) {
                G.confirm({
                    message: '确认上报此条信息吗？',
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
                                    G.showGritterSuccess("上报成功");
                                    G.pjaxLoadPageContentDiv('#page/supervision-feedback/load-feedback-list?id='+id+'&hostUnitId='+unitId);
                                } else {
                                    G.showGritterFail("上报信息失败,请稍后重试!");
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
            var url = '#page/supervision-feedback/load-feedback-list?id='+id+'&hostUnitId='+unitId;
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
                    message: "信息未保存,确认退出吗？",
                    callback: function (result) {
                        if (result){
                            G.pjaxLoadPageContentDiv(url);
                        }
                    }
                });
            }
        });

        // 读取文件
        $uploadFile.bind('change', function () {
            $uploadFile.each(function () {
                var fieldName = $(this).attr('name');
                var files = $(this).data('ace_input_files');
                if (files && files.length > 0) {
                    for (var i = 0; i < files.length; i++) {
                        fd.append(fieldName, files[i]);
                    }
                }
            });
        });

        //文件上传至临时位置
        $uploadFile.bind('change',function () {
            var loadId = G.showAjaxLoading();
            $.ajax({
                url: uploadUrl,
                type: 'POST',
                processData: false,
                contentType: false,
                dataType: 'json',
                data: fd
            }).done(function (map) {
                G.doneAjaxLoading(loadId);
                if($downLoadFile.html().indexOf('暂无') !== -1) {
                    $downLoadFile.empty();
                }
                if (map.result){
                    fileId = map.fileId;
                    realName = map.realName;
                    fd.delete('uploadFile');
                    G.showGritterSuccess("文件上传成功！");
                } else {
                    G.showGritterFail("文件上传失败,请稍后重试!");
                }
            });
        });
        //获取已上传的附件
        function appendAttach($div,jsonFileObject) {
            $div.empty();
            var html = [];
            if (_.isEmpty(jsonFileObject)) {
                html.push('<ul class="list-unstyled list-striped pricing-table-header"><li style="margin-top:5px">');
                html.push('暂无上传附件！');
                html.push('</li></ul>');
            } else {
                html.push('<ul class="list-unstyled list-striped pricing-table-header">');
                html.push('<li class="blue"  style="cursor:pointer;margin-top:5px;background-color: white;">');
                html.push('<a class="filePreview" fileId="' + jsonFileObject.id + '" style="color:#478FCA;font-family:仿宋, Arial, Helvetica, sans-serif;font-size: 18px;">');
                html.push(jsonFileObject.fileName);
                html.push('</a>&nbsp&nbsp&nbsp');
                html.push('<a style="color:grey" href="${basePath}/bulletin-board/download.action?id=' + jsonFileObject.id + '&type=0">');
                html.push('<i class="ace-icon fa fa-download grey bigger-130"></i>下载</a>&nbsp;');
                html.push('</li>');
                html.push('</ul>');
            }
            $div.append(html.join(""));
        }
        //获取已上传的附件
        appendAttach($downLoadFile,${jsonFileObject});

    });
</script>