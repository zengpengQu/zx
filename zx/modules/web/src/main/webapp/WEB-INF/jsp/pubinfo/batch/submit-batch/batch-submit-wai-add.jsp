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
                            <form class="form-horizontal" role="form" id="saveFormWai">
                                <input id="id-batch-draft-wai" name="id" type="hidden" value="${draftBatchOut.id}">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 30px">
                                            <h1 align="center" style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                外行文呈批件
                                            </h1>
                                        </div>
                                    </div>
                                </div>
                                <%--暂时不用--%>
                                <%--<div class="row" style="margin-bottom: 10px">
                                    <div class="col-xs-12" align="right" style="padding-right: 210px">
                                        <button class="btn btn-sm btn-pink" type="button" id="wordBtnWai">
                                            <i class="ace-icon fa fa-plus icon-on-right bigger-110"></i>
                                            word模板
                                        </button>
                                    </div>
                                </div>--%>
                                <div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                                   for="form-field-title"> 标题： <span class="required">*</span></label>
                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-title" name="title"
                                                       class="form-control" value="${draftBatchOut.title}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                                   for="form-field-orgName"> 来文单位： <span class="required">*</span></label>
                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-orgName" name="orgName"
                                                       class="form-control" value="${draftBatchOut.orgName}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <%--<div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                                   for="form-field-deptName"> 承办部门： <span class="required">*</span></label>

                                            <div class="col-sm-9 deptDiv">
                                                <input type="text" id="form-field-deptId" name="underUnitOutVoList[0].deptId"
                                                       class="hide" value=""/>
                                                <input type="text" class="form-control" id="form-field-deptName"
                                                       name="deptName" value="${draftBatchOut.deptName}" style="cursor: pointer;" readonly/>
                                            </div>
                                        </div>
                                    </div>
                                </div>--%>
                                <div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                                   for="form-field-orgName"> 承办部门：<span class="required">*</span>
                                            </label>
                                            <div class="col-sm-9 deptDiv">
                                                <input type="text" id="form-field-depNameWai" name="orgId"
                                                       class="hide" value="${draftBatchOut.orgDept.id}"/>
                                                <input type="text" class="form-control" id="form-field-deptName"
                                                       readonly="readonly"
                                                       name="deptName" value="${draftBatchOut.orgDept.deptName}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                                   for="form-field-depLeaderwai"> 承办方部门领导： <span class="required">*</span></label>
                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-depLeaderwai" name="depLeader"
                                                       class="form-control" value="${draftBatchOut.depLeader}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                            > 承办人： <span class="required">*</span></label>
                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-contractor" name="contractor"
                                                       class="form-control" value="${draftBatchOut.contractor}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                            > 联系电话： <span class="required">*</span></label>
                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-telWai" name="tel"
                                                       class="form-control" value="${draftBatchOut.tel}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-xs-3 control-label "
                                            > 是否会签： <span class="required">&nbsp;</span></label>
                                            <div class="col-xs-2">
                                                <input type="radio"  name="counterSignFlag"
                                                       class="control-label "  style="font-weight: bold;" value="1"
                                                       <c:if test="${'1' eq draftBatchOut.counterSignFlag}">checked="checked"</c:if> checked="checked"
                                                />是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <input type="radio"  name="counterSignFlag" class="control-label"  style="font-weight: bold;" value="0"
                                                       <c:if test="${'0' eq draftBatchOut.counterSignFlag}">checked="checked"</c:if>
                                                />否
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <%--<div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                            > 会签单位： <span class="required">&nbsp;</span></label>
                                            <div class="col-sm-9 deptDiv" id="hideDiv">
                                                <input type="text" id="form-field-counterSignUnitWai" name="dicDeptOutVoList[0].deptId"
                                                       class="hide" value=""/>
                                                <input type="text" class="form-control" id="form-field-counterSignUnitWaiName"
                                                       name="counterSignUnit" value="${draftBatchOut.counterSignUnit}" style="cursor: pointer;" readonly/>
                                            </div>
                                        </div>
                                    </div>
                                </div>--%>
                                <div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group" id="hideDivOut" <c:if test="${'0' eq draftBatchOut.counterSignFlag}">hidden</c:if>>
                                            <label class="col-sm-3 control-label "
                                                   for="form-field-counterSignUnitWai"> 会签单位： <span class="required">*</span></label>

                                            <div class="col-sm-9">
                                                <input type="text" class="form-control"
                                                       id="form-field-counterSignUnitWai"
                                                       name="counterSignUnit" value="${draftBatchOut.counterSignUnit}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div id="view-reason-wai" <c:if test="${'1' ne showStatus and '1' ne showReason}">hidden</c:if>>
                                        <div class="col-xs-10">
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label"
                                                > 补录理由： <span class="required">*</span></label>
                                                <div class="col-sm-9">
                                                    <select class="form-control" id="form-field-reasonwai"
                                                            name="dicReasonVoOutList[0].reasonId">
                                                        <option value="">-----请选择-----</option>
                                                        <c:forEach items="${dicReasonList}" var="reason">
                                                            <option value="${reason.id}" <c:if test="${draftBatchOut.dicReason.id eq reason.id}">selected</c:if>>${reason.reason}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div id="view-dialog-wai" <c:if test="${'1' ne showStatus and '1' ne checkStatus}">hidden</c:if>>
                                        <div class="col-xs-10">
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label "
                                                > 审核人： <span class="required">*</span></label>
                                                <div class="col-sm-9 ">
                                                    <input type="text" id="form-field-approver-wai" name="approver"
                                                           class="form-control" value=""/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="clearfix form-actions center">
                                    <div class="col-xs-10">
                                        <button class="btn btn-info btn-sm" type="button" id="saveBtnWai">
                                            <i class="ace-icon fa fa-check bigger-110"></i>
                                            保存
                                        </button>
                                        &nbsp; &nbsp; &nbsp;
                                        <button class="btn btn-primary btn-sm" type="button" id="backBtnWai">
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

        G.initDept('deptDiv',true,null,TREE_NODE);

        var $saveForm = $('#saveForm');
        var $saveFormWai = $('#saveFormWai');
        var $saveBtn = $("#saveBtn");
        var $saveBtnWai = $("#saveBtnWai");
        var $sendBtn = $("#sendBtn");
        var $backBtnWai = $("#backBtnWai");
        var $wordBtn = $("#wordBtn");
        var saveUrlWai = '${basePath}/submit-batch-out/batch-submit-wai-save.do';
        var batchDraftIdWai = $saveFormWai.find("#id-batch-draft-wai").val();

        //是否会签单选按钮和文本框的联动
        $(":radio").click(function () {
            var num = $(this).val();
            if(num==0){
                $("#hideDiv").hide();
            }
            if(num==1){
                $("#hideDiv").show();
            }
        });
        G.datepicker({
            todayHighlight: true
        });
        $wordBtn.click(function () {
            G.pjaxLoadPageContentDiv('#page/draft-batch/batch-drafting-words');
        });
        $sendBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            $("#form-field-status").val("1");
            saveDutyDaily('上报');
        });

        //新增或编辑提交数据
        $saveBtnWai.unbind('click').bind('click',function (e) {
            e.preventDefault();
            if($saveFormWai.validate().form()){
                var data = $saveFormWai.serializeObject();
                data["batchDraftIdWai"] = batchDraftIdWai;
                G.confirm({
                    message: '确认保存此条信息吗？',
                    callback: function (result) {
                        if(result){
                            var loadId = G.showAjaxLoading();
                            $.ajax({
                                url: saveUrlWai,
                                type: 'POST',
                                dataType: 'json',
                                data: data,
                                async: true
                            }).done(function (map) {
                                G.doneAjaxLoading(loadId);
                                if (map.result){
                                    G.showGritterSuccess("保存成功");
                                    G.pjaxLoadPageContentDiv("#page/submit-batch-out/batch-submit-list");
                                } else {
                                    G.showGritterFail("保存信息失败,请稍后重试!");
                                }
                            });
                        }
                    }
                });
            }

        });

        $saveFormWai.tjValidate({
            focusInvalid: false,
            rules:{
                title:{
                    required:true
                },
                orgName:{
                    required:true
                },
                contractor:{
                    required:true
                },
                tel:{
                    required:true
                },
                deptName:{
                    required:true
                },
                orgId:{
                    required:true
                },
                depLeader:{
                    required:true
                },
                counterSignUnit:{
                    required:true
                },
                "dicReasonVoOutList[0].reasonId":{
                    required:true
                },
                approver:{
                    required:true
                }

            },
            messages:{
                title:{
                    required:"标题不能为空"
                },
                orgName:{
                    required:"来文单位不能为空"
                },
                contractor:{
                    required:"承办人不能为空"
                },
                tel:{
                    required:"联系电话不能为空"
                },
                deptName:{
                    required:"承办部门不能为空"
                },
                orgId:{
                    required:"承办部门不能为空"
                },
                depLeader:{
                    required:"承办部门领导不能为空"
                },
                counterSignUnit:{
                    required:"会签单位不能为空"
                },
                "dicReasonVoOutList[0].reasonId":{
                    required:"补录理由不能为空"
                },
                approver:{
                    required:"审核人不能为空"
                }

            }
        });

        //返回
        $backBtnWai.unbind('click').bind('click', function () {
            G.back();
        });

    });
</script>

