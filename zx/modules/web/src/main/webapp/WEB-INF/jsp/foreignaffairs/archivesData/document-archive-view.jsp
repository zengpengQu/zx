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
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->
        <div class="space-6"></div>
        <div class="row">
            <div class="col-sm-10 col-sm-offset-1">
                <!-- #section:pages/invoice -->
                <div class="widget-box transparent">
                    <div class="widget-header widget-header-large" style="border-bottom: 0px">
                        <h4 class="widget-title" style="font-weight: bold; color: #00b3ee">
                            <i class="ace-icon fa fa-leaf green"></i>
                            档案资料文件
                        </h4>
                    </div>
                    <div class="widget-body">
                        <div class="widget-main" style="padding: 0px">
                            <div class="profile-user-info profile-user-info-striped">
                                <div class="profile-info-row">
                                    <div class="profile-info-name" style="text-align: center">案卷类别</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${documentArchive.jsonObject.teamName}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">全宗号</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${documentArchive.jsonObject.fondsNumber}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">目录号</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${documentArchive.jsonObject.catalogNumber}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">案卷号</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${documentArchive.jsonObject.fileNumber}</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name" style="text-align: center">档案号</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${documentArchive.jsonObject.archiveNumber}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">年度</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${documentArchive.jsonObject.year}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">保管期限</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${documentArchive.jsonObject.retentionPeriod}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">案卷题名</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${documentArchive.jsonObject.fileName}</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name" style="text-align: center">卷内文件份数</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${documentArchive.jsonObject.fileSum}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">页数</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${documentArchive.jsonObject.pageSum}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">编制日期</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${documentArchive.jsonObject.compileDate}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">编制结束日期</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${documentArchive.jsonObject.endDate}</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name" style="text-align: center">编制单位</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${documentArchive.jsonObject.department}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">立卷人</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${documentArchive.jsonObject.writer}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">检查人</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${documentArchive.jsonObject.rummager}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">检查日期</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${documentArchive.jsonObject.rummagerDate}</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name" style="text-align: center">密级</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${documentArchive.jsonObject.secretLevelVal}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">创建时间</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${documentArchive.jsonObject.createTime}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">本卷情况说明</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${documentArchive.jsonObject.content}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">备注</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${documentArchive.jsonObject.notes}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="widget-box transparent">
                    <div class="widget-header widget-header-large" style="border-bottom: 0px">
                        <h4 class="widget-title" style="font-weight: bold; color: #00b3ee">
                            <i class="ace-icon fa fa-folder-open-o green"></i>
                            文件信息列表
                        </h4>
                    </div>
                    <div class="widget-body">
                        <div class="widget-main" style="padding-top: 0px;">
                            <table class="table table-striped table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th class="center" style="width:10%;">文件编号</th>
                                    <th class="center" style="width:15%;">文件题名</th>
                                    <th class="center" style="width:10%;">责任人</th>
                                    <th class="center" style="width:10%;">文件形成日期</th>
                                    <th class="center" style="width:10%;">页号</th>
                                    <th class="center" style="width:10%;">编制单位</th>
                                    <th class="center" style="width:15%;">备注</th>
                                    <th class="center" style="width:20%;">附件</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:if test="${documentArchive.id ne null}">
                                    <c:forEach items="${documentList}"
                                               var="document">
                                        <tr class="chronicleTr" data-item = {"id":"${document.id}"}>
                                            <td class="center">${document.jsonObject.documentNumber}</td>
                                            <td class="center">${document.jsonObject.documentName}</td>
                                            <td class="center">${document.jsonObject.dutyPerson}</td>
                                            <td class="center">${document.jsonObject.formationDate}</td>
                                            <td class="center">${document.jsonObject.pageNumber}</td>
                                            <td class="center">${document.jsonObject.department}</td>
                                            <td class="center">${document.jsonObject.notes}</td>
                                            <td class="center">${document.jsonObject.fileNames}</td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="widget-box transparent">
                    <div class="widget-header widget-header-large" style="border-bottom: 0px">
                        <h4 class="widget-title" style="font-weight: bold; color: #00b3ee">
                            <i class="ace-icon fa fa-folder-o green"></i>
                            已上传附件
                        </h4>
                    </div>
                    <div class="widget-body">
                        <div class="widget-main" style="padding-top: 0px">
                            <div class="col-xs-8 no-padding-left">
                                <span id="download-file"></span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="clearfix">
                    <div class="col-xs-12 center">
                        <button class="btn btn-primary btn-sm" type="button" id="backBtn">
                            <i class="ace-icon fa fa-undo bigger-110"></i>
                            返回
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div><!-- /.col -->
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        var $downLoadFile = $("#download-file");

        //获取已上传的附件
        appendAttach($downLoadFile, ${jsonFileList});

        //获取已上传的附件
        function appendAttach($div, attachList) {
            $div.empty();
            var html = [];
            if (attachList == null) {
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
                    html.push('</li>');
                }
                html.push('</ul>');
            }
            $div.append(html.join(""));
        }

        var $backBtn = $('#backBtn');
        $backBtn.click(function () {
            G.back();
        })

        $(document).one('ajaxloadstart.page', function (e) {
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

    });
</script>
