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
    <c:if test="${recordMap eq null}">
        <span style="text-align: center;display: block;">该电报无操作记录</span>
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
                                <span class="timeline-date">${record.jsonObject.createTimeStr}</span>
                                <i class="timeline-indicator btn btn-info no-hover"></i>
                            </div>
                            <div class="widget-box transparent">
                                <div class="widget-body">
                                    <div class="widget-main no-padding">
                                        <i class="ace-icon fa fa-share blue bigger-125"></i>
                                        &nbsp;&nbsp;来文标题为:
                                        <span style="color: #00b3ee;font-weight: bold;font-size: 18px">
                                            ${record.telegraphManage.telegramTitle}
                                        </span>
                                        <br />
                                        <span class="bigger-110">
                                        &nbsp;&nbsp;借出时间:<span style="color: #00af0e;font-weight: bold;font-size: 16px;font-family:仿宋, Arial, Helvetica, sans-serif;">${record.jsonObject.lendTimeStr}</span>
                                        ，归还时间:<a class="purple bolder">${record.jsonObject.returnTimeStr}</a>
                                        </span>
                                        <br />
                                        <span class="bigger-110">
                                        &nbsp;&nbsp;去向:<span style="color: #00af0e;font-weight: bold;font-size: 16px;font-family:仿宋, Arial, Helvetica, sans-serif;">${record.destination}</span>
                                        ，流转:<a class="orange bolder">${record.circulation}</a>
                                        </span>
                                        <br />
                                        <span class="bigger-110">
                                            <c:if test="${record.jsonObject.archiveFlag ne '0'}">
                                                &nbsp;&nbsp;存档状态:<span style="color: #00af0e;font-weight: bold;font-size: 16px;font-family:仿宋, Arial, Helvetica, sans-serif;">
                                                        <c:if test="${record.jsonObject.archiveFlag eq '1'}">
                                                            未存档
                                                        </c:if>
                                                        <c:if test="${record.jsonObject.archiveFlag eq '2'}">
                                                            已存档
                                                        </c:if>
                                                    </span>
                                            </c:if>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:forEach>
    </c:if>
    <%--<div class="col-xs-12 widget-container-col">
        <div class="accordion-style2 accordions">
                <div class="group">
                    <div class="widget-body">
                        <div class="row">
                            <div class="col-xs-12 col-sm-10 col-sm-offset-2">


                            </div>
                        </div>
                    </div>
                </div>
        </div>
    </div>--%>
</div>
<div class="row">
    <div class="space-10"></div>
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
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {
        var $backBtn = $("#backBtn");
        var localUrl = '#page/telegraph-manage/jump-to-telegraph-manage-list';
        //返回操作
        $backBtn.unbind('click').bind('click',function (e) {
            G.pjaxLoadPageContentDiv(localUrl);
        });
    });
</script>