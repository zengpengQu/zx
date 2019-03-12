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
                                <input id="id-batch-draft" name="id" type="hidden" value="${model.id}">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 30px">
                                            <h1 align="center" style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                内行文呈批件
                                            </h1>
                                        </div>
                                    </div>
                                </div>
                                <%--暂时不用--%>
                                <%--<div class="row" style="margin-bottom: 10px">
                                    <div class="col-xs-12" align="right" style="padding-right: 210px">
                                        <button class="btn btn-sm btn-pink" type="button" id="wordBtn">
                                            <i class="ace-icon fa fa-plus icon-on-right bigger-110"></i>
                                            word模板
                                        </button>
                                    </div>
                                </div>--%>
                                <div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label"
                                                   for="form-field-title"> 标题： <span class="required">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" id="form-field-title" name="title"
                                                       class="form-control" value="${model.title}"/>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <%--<div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                                   for="form-field-orgName"> 部门： <span class="required">&nbsp;</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" id="form-field-orgName" name="orgName"
                                                       readonly="readonly"
                                                       class="form-control" value="${model.orgName}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>--%>
                                <div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label"
                                                   for="form-field-orgName"> 部门： <span class="required">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" id="form-field-deptId" name="deptId"
                                                       class="hide" value="${model.dicDept.id}"/>
                                                <input type="text" class="form-control" id="form-field-orgName"
                                                       readonly="readonly"
                                                       name="orgName" value="${model.dicDept.deptName}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                                   for="form-field-reporter"> 部门领导： <span class="required">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" id="form-field-depLeader" name="depLeader"
                                                       class="form-control" value="${model.depLeader}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                                   for="form-field-reporter"> 拟稿人： <span class="required">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" id="form-field-reporter" name="reporter"
                                                       readonly="readonly"
                                                       class="form-control" value="${model.reporter}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                                   for="form-field-tel"> 联系电话： <span class="required">*</span></label>
                                            <div class="col-sm-9">
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
                                            > 是否会签： <span class="required">&nbsp;</span></label>
                                            <div class="col-xs-2">
                                                <input type="radio"  name="counterSignFlag"
                                                       class="control-label "  style="font-weight: bold;" value="1"
                                                       <c:if test="${'1' eq model.counterSignFlag}">checked</c:if> checked="checked"
                                                />是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <input type="radio"  name="counterSignFlag" class="control-label "  style="font-weight: bold;" value="0"
                                                       <c:if test="${'0' eq model.counterSignFlag}">checked</c:if>
                                                />否
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <%--<div class="row">
                                    <div class="col-xs-10">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                                   for="form-field-counterSignUnit"> 会签单位： <span class="required">&nbsp;</span></label>
                                            <div class="col-sm-9 deptDiv" id="hideDiv">
                                                <input type="text" id="form-field-counterSignUnit" name="dicDeptOutVoList[0].deptId"
                                                       class="hide" value=""/>
                                                <input type="text" class="form-control" id="form-field-counterSignUnitName"
                                                       name="counterSignUnit" value="${model.counterSignUnit}" style="cursor: pointer;" readonly/>
                                            </div>
                                        </div>
                                    </div>
                                </div>--%>
                                <div class="row">
                                    <div class="col-xs-10" id="hideDiv" <c:if test="${'0' eq model.counterSignFlag}">hidden</c:if>>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label "
                                                   for="form-field-counterSignUnit"> 会签单位：<span class="required">*</span> </label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" id="form-field-counterSignUnit"
                                                       name="counterSignUnit" value="${model.counterSignUnit}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div id="view-reason" <c:if test="${'1' ne showStatus and '1' ne showReason}">hidden</c:if> >
                                        <div class="col-xs-10">
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label "
                                                       for="form-field-reason"> 补录理由： <span class="required">*</span></label>
                                                <div class="col-sm-9">
                                                    <select class="form-control" id="form-field-reason"
                                                            name="dicReasonVoList[0].reasonId">
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
                                    <div id="view-dialog" <c:if test="${'1' ne checkStatus}">hidden</c:if>>
                                        <div class="col-xs-10">
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label "
                                                       for="form-field-checker"> 核稿人： <span class="required">*</span></label>
                                                <div class="col-sm-9">
                                                    <input type="text" id="form-field-checker" name="checker"
                                                           class="form-control" value=""/>
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


        G.initDept('deptDiv',true,null,TREE_NODE);

        var $saveForm = $('#saveForm');
        var $saveBtn = $("#saveBtn");
        var $sendBtn = $("#sendBtn");
        var $backBtn = $("#backBtn");
        var $counterSignUnit = $("#form-field-counterSignUnit");
        var $wordBtn = $("#wordBtn");
        var $addSection = $("#addSection");
        var saveUrl = '${basePath}/submit-batch/batch-submit-save.do';
        var batchDraftId = $saveForm.find("#id-batch-draft").val();
        initPage();

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

        //初始化表单
        function initPage() {
            //为表单赋值
            if (_.isEmpty($('#form-field-orgName').val())) {
                $('#form-field-deptId').val('${curDept.id}');
                $('#form-field-orgName').val('${curDept.deptName}');
            }
            if (_.isEmpty($('#form-field-reporter').val())) {
                $('#form-field-reporter').val('${currentUser.empName}');
            }
        }

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
        $saveBtn.unbind('click').bind('click',function (e) {
            e.preventDefault();
            if($saveForm.validate().form()){
                var data = $saveForm.serializeObject();
                data["batchDraftId"] = batchDraftId;

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
                                    G.pjaxLoadPageContentDiv("#page/submit-batch/batch-submit-list");
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
                title:{
                    required:true,
                    maxlength: 200
                },
                tel:{
                    required:true,
                    maxlength: 20
                },
                depLeader:{
                    required:true,
                    maxlength: 20
                },
                counterSignUnit:{
                    required:true,
                    maxlength: 200
                },
                "dicReasonVoList[0].reasonId":{
                    required:true
                },
                checker:{
                    required:true,
                    maxlength: 10
                }
            },
            messages:{
                title:{
                    required:"标题不能为空"
                },
                tel:{
                    required:"联系电话不能为空"
                },
                depLeader:{
                    required:"部门领导不能为空"
                },
                counterSignUnit:{
                    required:"会签单位不能为空"
                },
                "dicReasonVoList[0].reasonId":{
                    required:"补录理由不能为空"
                },
                checker:{
                    required:"核稿人不能为空"
                }

            }
        });

        //返回
        $backBtn.unbind('click').bind('click', function () {
            // G.pjaxLoadPageContentDiv("#page/submit-batch/batch-submit-list");
            G.back();
        });
    });
</script>