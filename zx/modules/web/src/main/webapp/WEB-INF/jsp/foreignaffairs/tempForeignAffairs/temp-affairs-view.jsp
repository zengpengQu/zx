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
                            临时外事活动
                        </h4>
                    </div>
                    <div class="widget-body">
                        <div class="widget-main" style="padding: 0px">
                            <div class="profile-user-info profile-user-info-striped">
                                <div class="profile-info-row">
                                    <div class="profile-info-name" style="text-align: center">团组编号</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${tempAffairs.groupNumber}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">团组名称</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${tempAffairs.groupName}</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name" style="text-align: center">团组级别</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${tempAffairs.jsonObject.groupLevelName}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">出席领导</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${tempAffairs.attendLeader}</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name" style="text-align: center">主办单位</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${tempAffairs.jsonObject.deptName}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">新闻单位</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${tempAffairs.newsOrg}</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name" style="text-align: center">活动类型</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${tempAffairs.activityType}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">活动时间</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${tempAffairs.jsonObject.activityTime}</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name" style="text-align: center">活动地点</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${tempAffairs.activitySite}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">宴请地点</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${tempAffairs.feteSite}</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name" style="text-align: center">联系人</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${tempAffairs.contacts}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">联系人电话</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${tempAffairs.contactsTel}</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name" style="text-align: center">陪同人员</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${tempAffairs.accompany}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">我方出席人员</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${tempAffairs.chinese}</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name" style="text-align: center">外方出席人员</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${tempAffairs.foreigner}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">创建时间</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${tempAffairs.jsonObject.createTime}</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name" style="text-align: center">活动内容</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${tempAffairs.activityContent}</span>
                                    </div>
                                    <div class="profile-info-name" style="text-align: center">备注</div>
                                    <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">${tempAffairs.notes}</span>
                                    </div>

                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name" style="text-align: center">更新时间</div>
                                    <div class="profile-info-value" style="text-align: center;vertical-align: center">
                                        <span class="editable">${tempAffairs.jsonObject.updateTime}</span>
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
                            大事记列表
                        </h4>
                    </div>
                    <div class="widget-body">
                        <div class="widget-main" style="padding-top: 0px;">
                            <table class="table table-striped table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th class="center" style="width:25%;">内容</th>
                                    <th class="center" style="width:20%;">开始时间</th>
                                    <th class="center" style="width:20%;">结束时间</th>
                                    <th class="center" style="width:25%;">备注</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:if test="${tempAffairs.id ne null}">
                                    <c:forEach items="${chronicleList}"
                                               var="chronicle">
                                        <tr class="chronicleTr" data-item={"id":"${chronicle.id}"}>
                                            <td class="center">${chronicle.content}</td>
                                            <td class="center">${chronicle.jsonObject.beginTimeStr}</td>
                                            <td class="center">${chronicle.jsonObject.endTimeStr}</td>
                                            <td class="center">${chronicle.notes}</td>
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
                            附件
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

                <div class="clearfix center">
                    <div class="col-xs-12">
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
        appendAttach($downLoadFile, ${jsonFileObject});

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

    });
</script>


