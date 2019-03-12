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
                                <input id="id-batch-leader" name="id" type="hidden" value="${model.id}">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 30px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${model.id eq null}"> 领导的信息新增</c:when>
                                                    <c:otherwise> 领导的信息编辑</c:otherwise>
                                                </c:choose></h1>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label"
                                                   for="form-field-leaName"> 姓名：<span class="required">*</span> </label>
                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-leaName" name="leaName"
                                                       class="form-control" value="${model.leaName}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                                   for="form-field-dutyName"> 职务：<span class="required">*</span> </label>
                                            <div class="col-sm-9 ">
                                                <select class="form-control" id="form-field-dutyName"
                                                        name="dicDutyVoList[0].dutyId">
                                                    <option value="" >-----请选择-----</option>
                                                    <c:forEach items="${dutyList}" var="duty">
                                                        <option value="${duty.id}" <c:if test="${model.dicDuty.id eq duty.id}">selected</c:if> >${duty.dutyName}</option>
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
                                                   for="form-field-secretart"> 秘书：<span class="required">&nbsp;</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" id="form-field-secretart" name="secretart"
                                                       class="form-control" value="${model.secretart}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                                   for="form-field-phone"> 手机号码：<span class="required">&nbsp;</span></label>
                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-phone" name="phone"
                                                       class="form-control" value="${model.phone}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                                   for="form-field-tel"> 办公电话：<span class="required">*</span> </label>
                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-tel" name="tel"
                                                       class="form-control" value="${model.tel}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-xs-3 control-label "
                                            > 性别：<span class="required">*</span> </label>
                                            <div class="col-xs-2">
                                                <input type="radio" name="sex"
                                                       class="control-label " style="font-weight: bold;" value="1"
                                                       <c:if test="${'1' eq model.sex}">checked</c:if> checked="checked"
                                                />男&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <input type="radio" name="sex" class="control-label "
                                                       style="font-weight: bold;" value="0"
                                                       <c:if test="${'0' eq model.sex}">checked</c:if>
                                                />女
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                                   for="form-field-birthday" > 出生年月：<span class="required">*</span> </label>
                                            <div class="col-sm-9">
                                                <div class="input-group">
                                                    <input class="form-control date-picker" name="birth" id="form-field-birthday"
                                                           data-date-format="yyyy-mm-dd" value="${model.jsonObject.birthday}" type="text"/>
                                                    <span class="input-group-addon"><i class="fa fa-calendar bigger-110"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="clearfix form-actions center">
                                    <div class="col-xs-10">
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
        </div>
    </div>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {
        $('.date-picker').datepicker({
            autoclose: true,
            todayHighlight: true,
            minView:'month'//设值时间选择器为年月日
        });

        var $saveForm = $('#saveForm');
        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");
        var saveUrl = '${basePath}/manage-batch/batch-leader-save.do';
        var batchDraftId = $saveForm.find("#id-batch-leader").val();

        //新增或编辑提交数据
        $saveBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            if($saveForm.validate().form()){
                var data = $saveForm.serializeObject();
                data["batchDraftId"] = batchDraftId;

                G.confirm({
                    message: '确认保存此条信息吗？',
                    callback: function (result) {
                        if (result) {
                            var loadId = G.showAjaxLoading();
                            $.ajax({
                                url: saveUrl,
                                type: 'POST',
                                dataType: 'json',
                                data: data,
                                async: true
                            }).done(function (map) {
                                G.doneAjaxLoading(loadId);
                                if (map.result) {
                                    G.showGritterSuccess("保存成功");
                                    G.pjaxLoadPageContentDiv("#page/manage-batch/batch-leader-manage-list");
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
                leaName:{
                    required:true
                },
                tel:{
                    required:true
                },
                "dicDutyVoList[0].dutyId":{
                    required:true
                },
                birth:{
                    required:true
                },
                phone:{
                    isMobile:true
                }
            },
            messages:{
                leaName:{
                    required:"姓名不能为空"
                },
                "dicDutyVoList[0].dutyId":{
                    required:"职务不能为空"
                },
                tel:{
                    required:"办公电话不能为空"
                },
                birth:{
                    required:"出生日期不可为空"
                },
                phone:{
                    isMobile:"请正确填写手机号"
                }


            }
        });

        //返回
        $backBtn.unbind('click').bind('click', function () {
            // G.pjaxLoadPageContentDiv("#page/manage-batch/batch-leader-manage-list");
            G.back();
        });

    });
</script>