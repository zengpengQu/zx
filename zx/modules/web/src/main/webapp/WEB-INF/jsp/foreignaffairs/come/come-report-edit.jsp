<%--
  Created by IntelliJ IDEA.
  User: yingji
  Date: 2018/8/15
  Time: 8:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="row">
    <div class="col-xs-12">
        <form class="form-horizontal" id="report-form" role="form"
              method="post">
            <input id="id-report" name="id" type="hidden" class="editable"
                   value="${comeReport.id}"/>
            <input id="id-comeInfo" name="comeInfoId" type="hidden" class="editable"
                   value="${comeReport.comeInfo.id}"/>
            <div class="row">
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"
                               for="form-field-sendOrg">报送单位：<span
                                class="red ">*</span></label>

                        <div class="col-sm-8 ">
                            <input type="text" id="form-field-sendOrg"
                                   name="sendOrg"
                                   class="form-control editable" value="${comeReport.sendOrg}"
                                   placeholder="报送单位"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"
                               for="form-field-sendDateStr">报送日期：<span
                                class="red">*</span></label>

                        <div class="col-sm-8 ">
                            <input type="text" id="form-field-sendDateStr"
                                   name="sendDateStr"
                                   data-date-format="yyyy-mm-dd"
                                   class="form-control editable date-picker" value="${comeReport.jsonObject.sendDateStr}"
                                   placeholder="报送日期"/>
                        </div>
                    </div>

                </div>
            </div>

            <div class="row">
                <label class="col-sm-2 control-label"
                       for="form-field-title">标题：<span
                        class="red">*</span></label>

                <div class="col-sm-10">
                    <input type="text" id="form-field-title"
                           name="title"
                           class="form-control editable" value="${comeReport.title}"
                           placeholder="标题"/>
                </div>
            </div>
            <div class="row">
                <div class="space-16"></div>
            </div>

            <div class="row">
                <label class="col-sm-2 control-label"
                       for="form-field-content">内容：<span
                        class="red">*</span></label>

                <div class="col-sm-10 ">
                <textarea class="form-control limited editable"
                          id="form-field-content"
                          name="content" rows="12"
                          style="min-height: 100px;">${comeReport.content}</textarea>
                </div>
            </div>

            <div class="row">
                <div class="space-10"></div>
            </div>

            <div class="row">
                <label class="col-sm-2 control-label" for="form-field-report-file">上传附件：<span
                        class="red">&nbsp;</span></label>
                <div class="col-sm-3 ">
                    <form id="upload-report-form" name="uploadReportForm"
                          method="POST">
                        <input type="file" name="uploadFile"
                               class="form-field-upload-file"
                               id="form-field-report-file"/>
                        <div id="report-file-queue"></div>
                    </form>
                </div>
            </div>

            <div class="row">
                <div class="space-10"></div>
            </div>

            <div class="row">
                <div class="form-group form-horizontal" id="uploadedReportDiv">
                    <label class="col-sm-2 control-label" for="download-report"
                           style="font-weight: bold;color: deepskyblue;">
                        已上传的附件：
                    </label>
                    <div class="col-sm-10">
                        <span id="download-report"></span>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<script type="text/javascript">
    G.datepicker({
        autoclose: true,
        todayHighlight: true
    });

    var $downLoadReportFile = $("#download-report");

    appendReportAttach($downLoadReportFile, ${reportFileList});

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
                html.push('<span class="red fileDelete" fileId="' + jsonFileObject[i].id + '">');
                html.push('<i class="ace-icon fa fa-trash-o red bigger-130 fileDelete"></i>删除&nbsp;');
                html.push('</span>');
                html.push('</li>');
            }
            html.push('</ul>');
        }

        $div.append(html.join(""));
        deleteReportFile();
    }

    //删除已上传附件
    function deleteReportFile() {
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
