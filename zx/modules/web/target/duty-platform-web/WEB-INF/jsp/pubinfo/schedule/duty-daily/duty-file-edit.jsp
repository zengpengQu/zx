<%--
  Created by IntelliJ IDEA.
  User: yingji
  Date: 2018/7/4
  Time: 10:36
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    pageContext.setAttribute("basePath", basePath);
%>
<title>履职支撑平台</title>
<div class="row">
    <div class="col-xs-12">
        <div style="margin-top: 20px">
            <div class="widget-body">
                <div class="widget-main padding-8" style="height: 300px">
                    <form class="form-horizontal" id="saveForm" role="form" method="post">
                        <input id="form-field-id" name="id" type="hidden" value="${model.id}">

                        <%--期数--%>
                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-dutyNum">期数：<span class="red">*</span></label>
                            <div class="col-xs-10">
                                <input type="text" id="form-field-dutyNum" name="dutyNum" class="form-control  remote"
                                       placeholder="期数" value="${model.dutyNum}"/>
                            </div>
                        </div>

                        <%--日期--%>
                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-dutyTimeStr">日期：<span
                                    class="red">*</span></label>
                            <div class="col-xs-10">
                                <input class="form-control date-picker"
                                       name="dutyTimeStr"
                                       id="form-field-dutyTimeStr"
                                       data-date-format="yyyy-mm-dd"
                                       value="${model.jsonObject.dutyTimeStr}"
                                       placeholder="日期" type="text"/>
                            </div>
                        </div>

                        <%--上传者--%>
                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-uploader">上传者：<span
                                    class="red">*</span></label>
                            <div class="col-xs-10">
                                <input type="text" id="form-field-uploader" name="uploader" class="form-control  remote"
                                       placeholder="上传者" value="${model.uploader}">
                            </div>
                        </div>

                        <!-- 上传附件 -->
                        <div class="form-group">
                            <label class="col-xs-2 control-label"
                                   for="form-field-uploadDuty">上传附件：<span
                                    class="red">*</span></label>
                            <div class="col-xs-10">
                                <form id="upload-reception-form" name="uploadReceptionForm"
                                      method="POST">
                                    <input type="file" name="uploadDuty"
                                           id="form-field-uploadDuty"
                                           class="form-field-upload-file" />
                                </form>
                            </div>
                        </div>

                        <!-- 已上传的附件 -->
                        <div class="form-group" id="uploadedDiv">
                            <c:if test="${model.id ne null}">
                                <label class="col-xs-2 control-label" style="font-weight: bold;color: deepskyblue;">
                                    已上传的附件：
                                </label>
                                <div class="col-xs-10">
                                    <span id="download-file" style="color:#478FCA;font-family:仿宋, Arial, Helvetica, sans-serif;font-size: 18px;">${model.realName }</span>
                                </div>
                            </c:if>
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

    //元素类全局变量
    var $uploadDuty = $('#form-field-uploadDuty');

    // 表单类全局变量
    var $saveForm = $("#saveForm");

    $uploadDuty.ace_file_input({
        no_file: ' ...',
        btn_choose: '选择文件',
        btn_change: '重新选择',
        droppable: false,
        onchange: null,
        thumbnail: false //| true | large
    });

    $saveForm.tjValidate({
        focusInvalid: false,
        rules: {
            dutyNum: {
                required: true
            },
            dutyTimeStr: {
                required: true
            },
            uploader: {
                required: true
            },
            // uploadDuty: {
            //     required : true,
            //     accept: ".doc, .docx"
            // },
        },
        messages: {
            dutyNum: {
                required: "期数必须填写"
            },
            dutyTimeStr: {
                required: "日期必须填写"
            },
            uploader: {
                required: "上传者必须填写"
            },
            uploadDuty: {
                required: "必须选择一个文件"
            }
        }
    });

    $(document).one('ajaxloadstart.page', function (e) {
        $('.ui-jqdialog').remove();
        $('.ui-dialog').remove();
    });
</script>
