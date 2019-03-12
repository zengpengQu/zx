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
    <ul class="tabbale-uls" id="table" style="margin-bottom: 15px;">
        <li class="active" style="    flex: unset;" id="stopApply">
            <a data-toggle="tab" href="#info">往来港澳证件详情</a>
        </li>
        <li style="flex: unset;" id="flow">
            <a data-toggle="tab" href="#record">往来港澳证件操作记录</a>
        </li>
    </ul>
    <div class="tab-content" style="border: 0px">
        <div class="tab-pane fade in active" id="info">
            <div class="row">
                <div class="form-group">
                    <div class="profile-user-info profile-user-info-striped">
                        <div class="profile-info-row">
                            <div class="profile-info-name" style="text-align: center">姓名</div>
                            <div class="profile-info-value" style="text-align: center">
                                <span class="editable">${hkMaCao.jsonObject.dicUser}</span>
                            </div>
                            <div class="profile-info-name" style="text-align: center">证件号码</div>
                            <div class="profile-info-value" style="text-align: center">
                                <span class="editable">${hkMaCao.permitCode}</span>
                            </div>
                            <div class="profile-info-name" style="text-align: center">签发机关</div>
                            <div class="profile-info-value" style="text-align: center">
                                <span class="editable">${hkMaCao.signOrg}</span>
                            </div>
                        </div>
                        <div class="profile-info-row">
                            <div class="profile-info-name" style="text-align: center">签发日期</div>
                            <div class="profile-info-value" style="text-align: center">
                                <span class="editable">${hkMaCao.jsonObject.signDateStr}</span>
                            </div>
                            <div class="profile-info-name" style="text-align: center">港澳通行证有效期</div>
                            <div class="profile-info-value" style="text-align: center">
                                <span class="editable">${hkMaCao.jsonObject.validDateStr}</span>
                            </div>
                            <div class="profile-info-name" style="text-align: center">工作部门</div>
                            <div class="profile-info-value" style="text-align: center">
                                <span class="editable">${hkMaCao.jsonObject.department}</span>
                            </div>
                        </div>
                        <div class="profile-info-row">
                            <div class="profile-info-name" style="text-align: center">创建时间</div>
                            <div class="profile-info-value" style="text-align: center">
                                <span class="editable">${hkMaCao.jsonObject.createTime}</span>
                            </div>
                            <div class="profile-info-name" style="text-align: center">更新时间</div>
                            <div class="profile-info-value" style="text-align: center">
                                <span class="editable">${hkMaCao.jsonObject.updateTime}</span>
                            </div>
                            <div class="profile-info-name" style="text-align: center">是否注销</div>
                            <div class="profile-info-value" style="text-align: center">
                                        <span class="editable">
                                            <c:if test="${hkMaCao.jsonObject.destroy eq '0'}">
                                                未注销
                                            </c:if>
                                            <c:if test="${hkMaCao.jsonObject.destroy eq '1'}">
                                                已注销
                                            </c:if>
                                        </span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="space-10"></div>
                    </div>
                    <!-- 证件扫描件 -->
                    <div class="form-group" id="uploadedDiv">
                        <div class="col-xs-12">
                            <label style="width: 13%; font-size: 20px;font-weight: bold;color: deepskyblue;" class="col-xs-3 control-label no-padding-left">
                                证件扫描件：
                            </label>
                            <div class="col-xs-8 no-padding-left">
                                <span id="download-file"></span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="space-10"></div>
                    </div>
                    <div class="form-group" >
                        <div class="col-xs-12">
                            <div id="imgDiv" class="center"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="tab-pane fade" id="record">
            <div class="row">
                    <div class="col-xs-12 col-sm-10 col-sm-offset-2">
                        <c:if test="${recordMap eq null}">
                            <div>
                                <span class="center bolder">该护照无操作记录</span>
                            </div>
                        </c:if>
                        <c:if test="${recordMap ne null}">
                            <c:forEach var="recordMap" items="${recordMap}">
                                <div class="timeline-container timeline-style2">
                                            <span class="timeline-label" style="width: 90px">
                                                <b>${recordMap.key}</b>
                                            </span>
                                    <div class="timeline-items">
                                        <c:forEach var="record" items="${recordMap.value}">
                                            <div class="timeline-item" style="width: 80%;">
                                                <div class="timeline-info" >
                                                    <span class="timeline-date">${record.jsonObject.createTime}</span>
                                                    <i class="timeline-indicator btn btn-info no-hover"></i>
                                                </div>
                                                <!-- 借取 -->
                                                <c:if test="${record.status eq '1'}">
                                                    <div class="widget-box transparent" style="margin-left: 0px;">
                                                        <div class="widget-body">
                                                            <div class="widget-main no-padding">
                                                                <div style="margin-left: 100px">
                                                                        <i class="ace-icon fa fa-share blue bigger-125"></i>
                                                                        执行了<span style="color: #00b3ee;
                                                                                font-weight: bold;font-size: 18px">
                                                                            ${record.jsonObject.statusValue}</span>操作，
                                                                        借取人:<span style="color: #00af0e;
                                                                                font-weight: bold;font-size: 16px;
                                                                                font-family:仿宋, Arial, Helvetica, sans-serif;">
                                                                            ${record.jsonObject.borrower}</span>
                                                                        ，经办人:<span style="color: #00af0e;
                                                                                font-weight: bold;font-size: 16px;
                                                                                font-family:仿宋, Arial, Helvetica, sans-serif;">
                                                                            ${record.jsonObject.empName}</span>，
                                                                        借出时间:<a class="orange bolder">
                                                                            ${record.jsonObject.borrowTime}</a></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                                <!-- 归还 -->
                                                <c:if test="${record.status eq '2'}">
                                                    <div class="widget-box transparent" style="margin-left: 0px;">
                                                        <div class="widget-body">
                                                            <div class="widget-main no-padding">
                                                                <div style="margin-left: 100px">
                                                                        <i class="ace-icon fa fa-check green bigger-125"></i>
                                                                        执行了<span style="color: #00b3ee;
                                                                                    font-weight: bold;font-size: 18px">
                                                                            ${record.jsonObject.statusValue}</span>操作，
                                                                        归还人:<span style="color: #00af0e;
                                                                                    font-weight: bold;font-size: 16px;
                                                                                    font-family:仿宋, Arial, Helvetica, sans-serif;">
                                                                            ${record.jsonObject.returnPeople}</span>
                                                                        ，经办人:<span style="color: #00af0e;
                                                                                    font-weight: bold;font-size: 16px;
                                                                                    font-family:仿宋, Arial, Helvetica, sans-serif;">
                                                                            ${record.jsonObject.empName}</span>，
                                                                        归还时间:<a class="orange bolder">
                                                                            ${record.jsonObject.returnTime}</a></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                                <!-- 销毁 -->
                                                <c:if test="${record.status eq '4'}">
                                                    <div class="widget-box transparent" style="margin-left: 0px;">
                                                        <div class="widget-body">
                                                            <div class="widget-main no-padding">
                                                                <div style="margin-left: 100px">
                                                                    <i class="ace-icon fa fa-check green bigger-125"></i>
                                                                    执行了<span style="color: #00b3ee;font-weight: bold;font-size: 18px">
                                                                        ${record.jsonObject.statusValue}</span>操作，
                                                                    销毁原因:<span style="color: #00af0e;
                                                                                    font-weight: bold;font-size: 16px;
                                                                                    font-family:仿宋,Arial, Helvetica, sans-serif;">
                                                                        ${record.jsonObject.destroyReason}
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>
                </div>
        </div>
    </div>
    <div class="row">
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
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        var $downLoadFile = $("#download-file");
        var $imgDiv = $("#imgDiv");

        //获取已上传的附件
        appendAttach($downLoadFile, $imgDiv, ${jsonFileObject});

        //获取已上传的附件
        function appendAttach($downLoadFile, $imgDiv, jsonFileObject) {
            $downLoadFile.empty();
            $imgDiv.empty();
            var html = [];
            var imgHtml = [];
            if (_.isEmpty(jsonFileObject)) {
                html.push('<ul class="list-unstyled list-striped pricing-table-header"><li style="margin-top:5px">');
                html.push('暂无上传附件！');
                html.push('</li></ul>');
            } else {
                html.push('<ul class="list-unstyled list-striped pricing-table-header">');
                html.push('<li class="blue"  style="cursor:pointer;margin-top:5px;background-color: white;">');
                html.push('<a class="filePreview" fileId="' +
                    jsonFileObject.id + '" style="color:#478FCA;font-family:仿宋, Arial, Helvetica, sans-serif;font-size: 18px;">');
                html.push(jsonFileObject.fileName);
                html.push('</a>&nbsp&nbsp&nbsp');
                html.push('<a style="color:grey" href="${basePath}/file/download.action?id=' + jsonFileObject.id + '&type=0">');
                html.push('<i class="ace-icon fa fa-download grey bigger-130"></i>下载</a>&nbsp;');
                html.push('</li>');
                html.push('</ul>');

                imgHtml.push('<img style="color:grey" height="400px" width="350px" src="${basePath}/file/download.action?id=' +
                    jsonFileObject.id + '&type=0">');
            }
            $downLoadFile.append(html.join(""));
            $imgDiv.append(imgHtml.join(""));
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