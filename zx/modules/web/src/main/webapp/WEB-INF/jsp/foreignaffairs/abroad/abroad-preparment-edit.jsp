<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    pageContext.setAttribute("basePath", basePath);
%>
<div class="row">
    <div class="col-xs-12">
        <div style="margin-top: 20px">
            <div class="widget-body">
                <div class="widget-main padding-8" style="height: 300px">
                    <form class="form-horizontal" id="saveFormPreparment" role="form" method="post">
                        <input id="form-field-id" name="id" type="hidden" value="${abroadPreparment.id}">

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-meetingName">会议名称：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <input type="text" id="form-field-meetingName" name="meetingName" class="form-control remote"
                                       placeholder="会议名称" value="${abroadPreparment.meetingName}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-meetingDateStr">会议日期：<span
                                    class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <input class="form-control date-picker"
                                       name="dutyTimeStr"
                                       id="form-field-meetingDateStr"
                                       data-date-format="yyyy-mm-dd"
                                       value="${abroadPreparment.jsonObject.meetingDateStr}"
                                       placeholder="会议日期" type="text"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-meetingTime">会议时间：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <input type="text" id="form-field-meetingTime" name="meetingTime" class="form-control remote"
                                       placeholder="会议时间" value="${abroadPreparment.meetingTime}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-meetingPlace">会议地点：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <input type="text" id="form-field-meetingPlace" name="meetingPlace" class="form-control remote"
                                       placeholder="会议地点" value="${abroadPreparment.meetingPlace}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-attendees">参会人员：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <input type="text" id="form-field-attendees" name="attendees" class="form-control remote"
                                       placeholder="参会人员" value="${abroadPreparment.attendees}"/>
                            </div>
                        </div>

                        <%--<div class="form-group">--%>
                            <%--<label class="col-xs-2 control-label" for="form-field-uploadAbroadPreparment">添加资料：</label>--%>
                            <%--<div class="col-xs-10 ">--%>
                                <%--<input type="file" name="uploadAbroadPreparment" id="form-field-uploadAbroadPreparment"/>--%>
                            <%--</div>--%>
                        <%--</div>--%>

                        <div class="row">
                            <label class="col-sm-2 control-label"
                                   for="form-field-uploadAbroadPreparment">上传附件：</label>
                            <div class="col-sm-3 ">
                                <form id="upload-preparment-form" name="uploadPreparmentForm"
                                      method="POST">
                                    <input type="file" name="uploadFile"
                                           class="form-field-upload-file"
                                           id="form-field-uploadAbroadPreparment"/>
                                    <div id="message-file-queue"></div>
                                </form>

                            </div>
                        </div>

                        <div class="row">
                            <div class="space-10"></div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group form-horizontal" id="uploadedDiv">
                                    <label class="col-sm-2 control-label" for="download-materials"
                                           style="font-weight: bold;color: deepskyblue;">
                                        已上传的资料：
                                    </label>
                                    <div class="col-sm-10">
                                        <span id="download-materials"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ace scripts -->
<script src="${basePath}/plugin/ace/assets/js/ace/elements.fileinput.js"></script>

<script type="text/javascript">
    G.datepicker({
        todayHighlight: true
    });

    var $downLoadMaterialFile = $("#download-materials");

    //获取已上传的附件
    appendAttach($downLoadMaterialFile, ${preparmentFileList});

    //获取已上传的附件
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
    /*--------附件预览删除end--------*/

</script>
