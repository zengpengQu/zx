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
                    <div class="row" align="center">
                        <h1 align="center" style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                            外行文流转登记
                        </h1>
                        <div class="col-xs-12">
                            <form class="form-horizontal" role="form" id="saveFormDetail">
                                <input id="id-batch-draft" name="id" type="hidden" value="${model.id}"/>
                                <div class="row">
                                    <div class="col-xs-6" align="left" style="padding-left: 0px;">
                                        <h4 class="widget-title" style="font-weight: bold; color: #00b3ee;text-align: left">
                                            <i class="ace-icon fa fa-leaf green"></i>
                                            基本信息详情
                                        </h4>
                                    </div>
                                    <div class="col-xs-6" align="right">
                                        <%--<button class="btn btn-sm btn-pink" type="button" id="searchBtn">
                                            <i class="ace-icon fa fa-plus icon-on-right bigger-110"></i>
                                            返回
                                        </button>--%>
                                        <button class="btn btn-primary btn-sm" type="button" id="searchBtn">
                                            <i class="ace-icon fa fa-undo bigger-110"></i>
                                            返回
                                        </button>
                                    </div>
                                </div>

                                <div style="margin-top: 2%"></div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                                   for="form-field-title"> 标题： </label>
                                            <div class="col-sm-7 ">
                                                <input type="text" id="form-field-title" name="title" readonly="readonly"
                                                       class="form-control" value="${model.title}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                                   for="form-field-orgName"> 来文单位： </label>
                                            <div class="col-sm-7 ">
                                                <input type="text" id="form-field-orgName" name="orgName" readonly="readonly"
                                                       class="form-control" value="${model.orgName}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                                   for="form-field-deptName"> 承办部门： </label>
                                            <div class="col-sm-7 ">
                                                <input type="text" class="form-control" id="form-field-deptName"
                                                       name="deptName" readonly="readonly" value="${model.orgDept.deptName}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                            > 承办人： </label>
                                            <div class="col-sm-7 ">
                                                <input type="text" id="form-field-contractor" name="contractor" readonly="readonly"
                                                       class="form-control" value="${model.contractor}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-xs-3 control-label "
                                            > 是否会签： </label>
                                            <div class="col-xs-3">
                                                <input type="radio"  name="counterSignFlag"
                                                       class="control-label "  style="font-weight: bold;" value="1" disabled="disabled"
                                                       <c:if test="${'1' eq model.counterSignFlag}">checked="checked"</c:if>
                                                />是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <input type="radio"  name="counterSignFlag" class="control-label"  style="font-weight: bold;" value="0" disabled="disabled"
                                                       <c:if test="${'0' eq model.counterSignFlag}">checked="checked"</c:if>
                                                />否
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                            > 会签单位： </label>
                                            <div class="col-sm-7 ">
                                                <input type="text" id="form-field-counterSignUnitWai" name="counterSignUnit" readonly="readonly"
                                                       class="form-control" value="${model.counterSignUnit}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                            > 承办人联系电话： </label>
                                            <div class="col-sm-7 ">
                                                <input type="text" id="form-field-telWai" name="tel" readonly="readonly"
                                                       class="form-control" value="${model.tel}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="view-reason-wai">
                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label"
                                                > 补录理由： </label>
                                                <div class="col-sm-7">
                                                    <select class="form-control" id="form-field-reasonwai" disabled="disabled"
                                                            name="dicReasonVoOutList[0].reasonId">
                                                        <option value="">-----请选择-----</option>
                                                        <c:forEach items="${dicReasonList}" var="reason">
                                                            <option value="${reason.id}" <c:if test="${model.dicReason.id eq reason.id}">selected</c:if>>${reason.reason}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div id="view-dialog-wai">
                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label "
                                                > 审核人： </label>
                                                <div class="col-sm-7 ">
                                                    <input type="text" id="form-field-approver-wai" name="approver" readonly="readonly"
                                                           class="form-control" value="${model.approver}"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label"
                                            > 流水号： </label>

                                            <div class="col-sm-7 ">
                                                <input type="text" id="form-field-serNumber" name="serNumber"
                                                       class="form-control" value="${model.serNumber}" readonly="readonly"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="col-xs-12" <c:if test="${null ne model}"><c:if test="${'4' eq model.status}">hidden</c:if></c:if>
                             <c:if test="${null eq model}">hidden</c:if>>
                            <div class="row">
                                <h4 class="widget-title" style="font-weight: bold; color: #00b3ee;text-align: left">
                                    <i class="ace-icon fa fa-leaf green"></i>
                                    领导同志批示
                                </h4>
                            </div>
                            <div style="margin-top: 2%"></div>
                            <div class="row" align="center">
                                <div class="col-xs-12">
                                    <form class="form-horizontal" role="form" id="saveForm">
                                        <input id="id-batch-draft-reg" name="id" type="hidden" value="${register.id}"/>

                                        <div style="margin-top: 2%"></div>

                                        <%--<div class="row">
                                            <div class="col-xs-10">
                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label"
                                                           for="form-field-reportLeader"> 领导姓名：<span class="required">*</span> </label>
                                                    <div class="col-sm-7">
                                                        <input type="text" id="form-field-reportLeader" name="reportLeader"
                                                               class="form-control" value=""/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>--%>
                                        <div class="row">
                                            <div class="col-xs-10">
                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label no-padding-right"
                                                           for="form-field-LeaName"> 领导姓名：<span class="required">*</span> </label>
                                                    <div class="col-sm-7">
                                                        <select class="form-control" id="form-field-LeaName"
                                                                name="leaderManageList[0].lea_Id">
                                                            <option value="" >-----请选择-----</option>
                                                            <c:forEach items="${leaderManageList}" var="leaName">
                                                                <option value="${leaName.id}">${leaName.leaName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-xs-10">
                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label "
                                                           for="form-field-dutyName"> 领导职务：<span class="required">*</span> </label>
                                                    <div class="col-sm-7 ">
                                                        <select class="form-control" id="form-field-dutyName"
                                                                name="dicDutyVoList[0].dutyId">
                                                            <option value="" >-----请选择-----</option>
                                                            <c:forEach items="${dutyList}" var="duty">
                                                                <option value="${duty.id}">${duty.dutyName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-xs-10">
                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label"
                                                           for="form-field-conmentsLeader"> 领导批示：<span class="required">*</span> </label>
                                                    <div class="col-sm-7">
                                                <textarea type="text" id="form-field-conmentsLeader" name="conmentsLeader"
                                                          class="form-control" value="" placeholder="2000字以内"></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="clearfix form-actions center">
                                            <div class="col-xs-12">
                                                <button class="btn btn-info btn-sm" type="button" id="saveBtn">
                                                    <i class="ace-icon fa fa-check bigger-110"></i>
                                                    保存
                                                </button>
                                                &nbsp; &nbsp; &nbsp;
                                                <button class="btn btn-primary btn-sm" type="button" id="backBtn">
                                                    <i class="ace-icon fa fa-undo bigger-110"></i>
                                                    返回
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row" <c:if test="${null eq model}">hidden</c:if>>
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
                                    <span style="text-align: left;display: block;">还未上报</span><br/>
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
                                                            <div class="timeline-info">
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
                                                                        &nbsp;&nbsp;会签人:<span
                                                                                    style="color: #00af0e;font-weight: bold;font-size: 16px;font-family:仿宋, Arial, Helvetica, sans-serif;">${listreg.reportLeader}</span>
                                                                        &nbsp;&nbsp;会签意见：<span
                                                                                    style="color: red;font-weight: bold;font-size: 16px;font-family:仿宋, Arial, Helvetica, sans-serif;">${listreg.conmentsLeaer}</span>
                                                                    </span>
                                                                            <br/>
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
                                                                            <br/>
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
                                                <div class="timeline-info">
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
                                                            &nbsp;&nbsp;承办人：
                                                        <span style="color: #00af0e;font-weight: bold;font-size: 16px;font-family:仿宋, Arial, Helvetica, sans-serif;">
                                                                ${model.contractor}
                                                        </span>
                                                        &nbsp;&nbsp;核稿人：
                                                        <span style="color: #00af0e;font-weight: bold;font-size: 16px;font-family:仿宋, Arial, Helvetica, sans-serif;">
                                                                ${model.approver}
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

                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.initDept('deptDiv',true,null,TREE_NODE);

        var $saveForm = $('#saveForm');
        var $saveFormDetail = $('#saveFormDetail');
        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");
        var $searchBtn = $("#searchBtn");
        var saveUrl = '${basePath}/register-batch-out/transfer-register-wai-save.do';
        var batchDraftRegId = $saveForm.find("#id-batch-draft-reg").val();
        var batchDraftDetId = $saveFormDetail.find("#id-batch-draft").val();

        $searchBtn.click(function () {
            G.pjaxLoadPageContentDiv("#page/register-batch/batch-transfer-wai-register");
        });

        //流转登记的保存
        $saveBtn.unbind('click').bind('click',function (e) {
            e.preventDefault();
            if($saveForm.validate().form()){
                var data = $saveForm.serializeObject();
                data["batchDraftRegId"] = batchDraftRegId;
                data["batchDraftDetId"] = batchDraftDetId;
                G.confirm({
                    message: '确认保存此条信息吗？',
                    callback: function (result) {
                        if(result){
                            var loadId = G.showAjaxLoading();
                            $.ajax({
                                url: saveUrl,
                                type: 'POST',
                                dataType: 'json',
                                data: data,
                                async: true
                            }).done(function (map) {
                                G.doneAjaxLoading(loadId);
                                if (map.result){
                                    G.showGritterSuccess("保存成功");
                                    G.pjaxLoadPageContentDiv("#page/register-batch/batch-transfer-wai-register");
                                } else {
                                    G.showGritterFail("保存信息失败,请稍后重试!");
                                }
                            });
                        }
                    }
                });
            }
        });

        $saveForm.tjValidate({
            focusInvalid: false,
            rules:{
                "leaderManageList[0].lea_Id":{
                    required:true
                },
                "dicDutyVoList[0].dutyId":{
                    required:true
                },
                conmentsLeader:{
                    required:true,
                    maxlength:2000
                }
            },
            messages:{
                "leaderManageList[0].lea_Id":{
                    required:"报送领导不能为空"
                },
                "dicDutyVoList[0].dutyId":{
                    required:"职务不能为空"
                },
                conmentsLeader:{
                    required:"领导批示不能为空",
                    maxlength:"请输入2000字以内"
                }
            }
        });

        //返回
        $backBtn.unbind('click').bind('click', function () {
            G.pjaxLoadPageContentDiv("#page/register-batch/batch-transfer-wai-register");
        });

    });
</script>

