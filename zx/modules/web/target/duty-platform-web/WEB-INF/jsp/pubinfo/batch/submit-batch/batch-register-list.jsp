<%--
  Created by IntelliJ IDEA.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
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
                            <form class="form-horizontal" role="form" id="saveForm">
                                <input id="id-batch-draft" name="id" type="hidden" value="${model.id}"/>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 30px">
                                            <h1 align="center" style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                内行文历史流转记录
                                            </h1>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-6" align="left" style="padding-left: 0px;">
                                        <h4 class="widget-title" style="font-weight: bold; color: #00b3ee;text-align: left">
                                            <i class="ace-icon fa fa-leaf green"></i>
                                            基本信息详情
                                        </h4>
                                    </div>
                                    <div class="col-xs-6" align="right">
                                        <button class="btn btn-primary btn-sm" type="button" id="backBtn">
                                            <i class="ace-icon fa fa-undo bigger-110"></i>
                                            返回
                                        </button>
                                    </div>
                                </div>

                                <div style="margin-top: 2%"></div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right"
                                                   for="form-field-title"> 标题： </label>
                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-title" name="title" readonly="readonly"
                                                       class="form-control" value="${model.title}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right"
                                                   for="form-field-orgName"> 部门： </label>
                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-orgName" name="orgName" readonly="readonly"
                                                       class="form-control" value="${model.dicDept.deptName}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right"
                                                   for="form-field-reporter"> 拟稿人： </label>

                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-reporter" name="reporter" readonly="readonly"
                                                       class="form-control" value="${model.reporter}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right"
                                                   for="form-field-check"> 核稿人： </label>

                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-check" name="checker" readonly="readonly"
                                                       class="form-control" value="${model.checker}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-xs-3 control-label no-padding-right"
                                            > 是否会签： </label>
                                            <div class="col-xs-3">
                                                <input type="radio"  name="counterSignFlag"
                                                       class="control-label no-padding-right" value="1" disabled="disabled"
                                                       <c:if test="${'1' eq model.counterSignFlag}">checked</c:if>
                                                />是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <input type="radio"  name="counterSignFlag" class="control-label no-padding-right" value="0" disabled="disabled"
                                                       <c:if test="${'0' eq model.counterSignFlag}">checked</c:if>
                                                />否
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right"> 会签单位： </label>

                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-conuterSingUnit"
                                                       class="form-control" value="${model.counterSignUnit}" readonly="readonly"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right"
                                                   for="form-field-tel"> 联系电话： </label>

                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-tel" name="tel" readonly="readonly"
                                                       class="form-control" value="${model.tel}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right"
                                                   for="form-field-reason"> 补录理由： </label>

                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-reason" name="tel" readonly="readonly"
                                                       class="form-control" value="${dicReason.reason}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right"
                                                   for="form-field-serNumber"> 流水号： </label>

                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-serNumber" name="serNumber"
                                                       class="form-control" value="${model.serNumber}" readonly="readonly"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-12">

                                        <div class="row">
                                            <h4 class="widget-title" style="font-weight: bold; color: #00b3ee;text-align: left">
                                                <i class="ace-icon fa fa-leaf green"></i>
                                                历史流转记录
                                            </h4>
                                        </div>

                                        <div style="margin-top: 2%"></div>

                                        <div class="row">
                                            <c:if test="${null eq model.sendTime}">
                                                <span style="text-align: left;display: block;">还未上报</span><br />
                                            </c:if>
                                            <c:if test="${null ne model.sendTime}">
                                                <c:if test="${null ne mapSeq}">
                                                    <c:forEach var="reg" items="${mapSeq}">
                                                        <div class="timeline-container timeline-style2">
                                                <span class="timeline-label" style="width: 90px">
                                                    <b>${reg.key}</b>
                                                </span>
                                                            <div class="timeline-items">
                                                                <c:forEach var="listreg" items="${reg.value}">
                                                                    <div class="timeline-item">
                                                                        <div class="timeline-info" >
                                                                            <span class="timeline-date">${listreg.hourTime}</span>
                                                                            <i class="timeline-indicator btn btn-info no-hover"></i>
                                                                        </div>
                                                                        <c:if test="${null eq listreg.dutyName}">
                                                                            <div class="widget-box transparent">
                                                                                <div class="widget-body">
                                                                                    <div class="widget-main no-padding">
                                                                                        <i class="ace-icon fa fa-share blue bigger-125"></i>
                                                                                        &nbsp;&nbsp;该呈批件已呈转至:
                                                                                        <span style="color: #00b3ee;font-weight: bold;font-size: 16px">
                                                                                                ${listreg.countersignUnitName}
                                                                                        </span>
                                                                                        <span class="bigger-110">
                                                                        &nbsp;&nbsp;会签人:<span style="color: #00af0e;font-weight: bold;font-size: 16px;font-family:仿宋, Arial, Helvetica, sans-serif;">${listreg.reportLeader}</span>
                                                                        &nbsp;&nbsp;会签意见：<span style="color: red;font-weight: bold;font-size: 16px;font-family:仿宋, Arial, Helvetica, sans-serif;">${listreg.conmentsLeaer}</span>
                                                                    </span>
                                                                                        <br />
                                                                                        <span class="bigger-110"></span>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </c:if>
                                                                        <c:if test="${null eq listreg.countersignUnitName}">
                                                                            <div class="widget-box transparent">
                                                                                <div class="widget-body">
                                                                                    <div class="widget-main no-padding">
                                                                                        <i class="ace-icon fa fa-share blue bigger-125"></i>
                                                                                        &nbsp;&nbsp;该呈批件已呈转至:
                                                                                        <span style="color: #00b3ee;font-weight: bold;font-size: 16px">
                                                                                                ${listreg.dutyName}
                                                                                        </span>
                                                                                        <span class="bigger-110">
                                                                        &nbsp;&nbsp;领导同志:
                                                                        <span style="color: #00af0e;font-weight: bold;font-size: 16px;font-family:仿宋, Arial, Helvetica, sans-serif;">${listreg.reportLeader}</span>
                                                                        &nbsp;&nbsp;批示：
                                                                        <span style="color: red;font-weight: bold;font-size: 16px;font-family:仿宋, Arial, Helvetica, sans-serif;">${listreg.conmentsLeaer}</span>
                                                                    </span>
                                                                                        <br />
                                                                                        <span class="bigger-110"></span>
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

                                                <div class="timeline-container timeline-style2">
                                        <span class="timeline-label" style="width: 90px">
                                            <b>${day}</b>
                                        </span>
                                                    <div class="timeline-items">
                                                        <div class="timeline-item">
                                                            <div class="timeline-info" >
                                                                <span class="timeline-date">${hour}</span>
                                                                <i class="timeline-indicator btn btn-info no-hover"></i>
                                                            </div>
                                                            <div class="widget-box transparent">
                                                                <div class="widget-body">
                                                                    <div class="widget-main no-padding">
                                                                        <i class="ace-icon fa fa-share blue bigger-125"></i>
                                                                        该呈批件已呈转至
                                                                        <span style="color: #00b3ee;font-weight: bold;font-size: 16px">
                                                            值班室 &nbsp; &nbsp;
                                                            </span>
                                                                        <span class="bigger-110">
                                                            &nbsp;&nbsp;拟稿人：
                                                        <span style="color: #00af0e;font-weight: bold;font-size: 16px;font-family:仿宋, Arial, Helvetica, sans-serif;">
                                                                ${model.reporter}
                                                        </span>
                                                        &nbsp;&nbsp;核稿人：
                                                        <span style="color: #00af0e;font-weight: bold;font-size: 16px;font-family:仿宋, Arial, Helvetica, sans-serif;">
                                                                ${model.checker}
                                                        </span>
                                                    </span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </div>
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

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        var $backBtn = $("#backBtn");

        //返回
        $backBtn.unbind('click').bind('click', function () {
            //window.history.back(-1);
            G.pjaxLoadPageContentDiv("#page/submit-batch/batch-submit-list");
        });

    });
</script>

