<%--
  Created by IntelliJ IDEA.
  User: yx
  Date: 2018/7/31
  Time: 13:41
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
<%--<script src="${basePath}/js/foreignaffairs/come/come-reception.js"></script>--%>

<div class="row" style="margin-top: 30px;">
    <div class="col-xs-12">
        <form class="form-horizontal" id="reception-form" role="form"
              method="post">
            <input id="id-reception" name="id" type="hidden" class="editable"
                   value="${comeReception.id}"/>
            <input id="id-comeInfo" name="comeInfoId" type="hidden" class="editable"
                   value="${comeReception.comeInfo.id}"/>

            <div class="row">
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"
                               for="form-field-receptionTitle">标题：<span
                                class="red">*</span></label>

                        <div class="col-sm-8 ">
                            <input type="text" id="form-field-receptionTitle"
                                   name="receptionTitle"
                                   class="form-control editable" value="${comeReception.receptionTitle}"
                                   placeholder="标题"/>
                        </div>
                    </div>
                </div>
                <%--<div class="col-xs-6">--%>
                    <%--<div class="form-group">--%>
                        <%--<label class="col-sm-4 control-label"--%>
                               <%--for="form-field-accompanyNum">陪同人员数：<span--%>
                                <%--class="red">*</span></label>--%>

                        <%--<div class="col-sm-8 ">--%>
                            <%--<input type="text" id="form-field-accompanyNum"--%>
                                   <%--name="accompanyNum"--%>
                                   <%--class="form-control editable" value="${comeReception.accompanyNum}"--%>
                                   <%--placeholder="陪同人员数"/>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
            </div>

            <div class="row">
                <div class="input-daterange">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-4 control-label"
                                   for="form-field-recpTimeStart">开始日期：<span
                                    class="red">*</span></label>
                            <div class="col-sm-8">
                                <div class="input-group">
                                    <input class="form-control date-picker"
                                           name="startDateStr"
                                           value="${comeReception.jsonObject.startDateStr}"
                                           id="form-field-recpTimeStart"
                                           data-date-format="yyyy-mm-dd"
                                           placeholder="开始日期" type="text"/>
                                    <span class="input-group-addon"><i
                                            class="fa fa-calendar bigger-110"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-4 control-label"
                                   for="form-field-recpTimeEnd">结束日期：<span
                                    class="red">*</span></label>
                            <div class="col-sm-8">
                                <div class="input-group">
                                    <input class="form-control date-picker"
                                           name="endDateStr"
                                           value="${comeReception.jsonObject.endDateStr}"
                                           id="form-field-recpTimeEnd"
                                           data-date-format="yyyy-mm-dd"
                                           placeholder="结束日期" type="text">
                                    <span class="input-group-addon"><i
                                            class="fa fa-calendar bigger-110"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <label class="col-sm-2 control-label"
                       for="form-field-activityPlan">具体安排：<span
                        class="red">*</span></label>

                <div class="col-sm-10 ">
            <textarea class="form-control limited editable"
                      id="form-field-activityPlan"
                      name="activityPlan" rows="10"
                      style="min-height: 100px;">${comeReception.activityPlan}</textarea>

                </div>
            </div>
            <%--<div class="row">--%>
                <%--<div class="space-10"></div>--%>
            <%--</div>--%>
            <%--<div class="row">--%>
                <%--<label class="col-sm-2 control-label"--%>
                       <%--for="form-field-talkReference">谈话参考要点：<span--%>
                        <%--class="red">*</span></label>--%>

                <%--<div class="col-sm-10">--%>

            <%--<textarea class="form-control limited editable"--%>
                      <%--id="form-field-talkReference"--%>
                      <%--name="talkReference"--%>
                      <%--style="min-height: 100px;">${comeReception.talkReference}</textarea>--%>
                <%--</div>--%>
            <%--</div>--%>

            <div class="row">
                <div class="space-10"></div>
            </div>


            <div class="hr hr-18 hr-double dotted"></div>

            <div class="row">
                <label class="col-sm-2 control-label"
                       for="form-field-reception-file">上传附件：</label>
                <div class="col-sm-3 ">
                    <form id="upload-reception-form" name="uploadReceptionForm"
                          method="POST">
                        <input type="file" name="uploadFile"
                               class="form-field-upload-file"
                               id="form-field-reception-file"/>
                        <div id="message-file-queue"></div>
                    </form>

                </div>
            </div>

            <div class="row">
                <div class="space-10"></div>
            </div>

            <div class="row">
                <div class="form-group form-horizontal" id="uploadedDiv">
                    <label class="col-sm-2 control-label" for="download-reception"
                           style="font-weight: bold;color: deepskyblue;">
                        已上传的附件：
                    </label>
                    <div class="col-sm-10">
                        <span id="download-reception"></span>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<script type="text/javascript">

    G.datepicker();

    var $downLoadReceptionFile = $("#download-reception");

    //获取已上传的附件
    appendAttach($downLoadReceptionFile, ${receptionFileList});

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