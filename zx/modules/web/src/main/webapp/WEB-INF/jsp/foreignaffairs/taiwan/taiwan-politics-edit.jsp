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
    <div class="col-xs-10 col-sm-offset-1">
        <div class="widget-box transparent">
            <div class="widget-body">
                <div class="widget-main">
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" id="new-edit-form" role="form" method="post">
                                <input id="id-taiwan-politics" name="id" type="hidden" value="${taiWanPolitics.id}">
                                <input id="id-taiwan-currDate" name="currDate" type="hidden" value="${currDate}">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 5px">
                                            <h1 align="center" style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${taiWanPolitics.id eq null}">台湾主要人士新增</c:when>
                                                    <c:otherwise>台湾主要人士编辑</c:otherwise>
                                                </c:choose>
                                            </h1>
                                        </div>
                                    </div>
                                </div>
                                <div style="margin-top: 5%"></div>
                                <!-- 填写信息 -->
                                <div class="row">
                                    <!-- 姓名 -->
                                    <div class="col-xs-6">
                                        <label class="col-sm-4 control-label" for="form-field-mainName" >
                                            姓名：<span class="required">*</span>
                                        </label>
                                        <div class="col-sm-8 ">
                                            <input type="text" id="form-field-mainName" readonly="readonly"
                                                   name="mainName" class="form-control "
                                                   value="${taiWanPolitics.mainName}"/>
                                        </div>
                                    </div>
                                    <!-- 出生日期 -->
                                    <div class="col-xs-6">
                                        <label class="col-sm-4 control-label" for="form-field-birthday" >
                                            出生日期：<span class="required">*</span>
                                        </label>
                                        <div class="col-sm-8 ">
                                            <div class="input-group">
                                                <input class="form-control date-picker"
                                                       name="birthdayStr"
                                                       id="form-field-birthday"
                                                       data-date-format="yyyy-mm-dd"
                                                        value="${taiWanPolitics.jsonObject.birthday}" type="text"/>
                                                <span class="input-group-addon">
                                                    <i class="fa fa-calendar bigger-110"></i>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- 空格 -->
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                                <div class="row">
                                    <!-- 社团名称 -->
                                    <div class="col-xs-6">
                                        <label class="col-sm-4 control-label" for="form-field-partyName" >
                                            社团名称：<span class="required">*</span>
                                        </label>
                                        <div class="col-sm-8 ">
                                            <select class="form-control" id="form-field-partyName"
                                                    name="taiWanParty.id">
                                                <option value="">-----请选择-----</option>
                                                <c:forEach items="${list}" var="taiWanParty">
                                                    <option value="${taiWanParty.id}"
                                                            <c:if test="${taiWanPolitics.taiWanParty.id eq taiWanParty.id}">
                                                                selected
                                                            </c:if>>
                                                            ${taiWanParty.partyName}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <!-- 性别 -->
                                    <div class="col-xs-6">
                                        <label class="col-sm-4 control-label" >
                                            性别：<span class="required">*</span>
                                        </label>
                                        <div class="col-xs-8 ">
                                            <label>
                                                <input name="gender" class="ace input-lg"
                                                       value="0" type="radio"
                                                       <c:if test="${null eq taiWanPolitics}">checked</c:if>
                                                       <c:if test="${'男' eq taiWanPolitics.jsonObject.gender}">checked</c:if>/>
                                                <span class="lbl bigger-120"> 男</span>
                                            </label>
                                            &nbsp;&nbsp;
                                            <label>
                                                <input name="gender" class="ace input-lg"
                                                       value="1" type="radio"
                                                       <c:if test="${'女' eq taiWanPolitics.jsonObject.gender}">checked</c:if> required/>
                                                <span class="lbl bigger-120"> 女</span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <!-- 空格 -->
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                                <div class="row">
                                    <!-- 单位 -->
                                    <div class="col-xs-6">
                                        <label class="col-sm-4 control-label" for="form-field-belongOrg" >
                                            单位：<span class="required">*</span>
                                        </label>
                                        <div class="col-sm-8 ">
                                            <input type="text" id="form-field-belongOrg"
                                                   name="belongOrg" class="form-control "
                                                   value="${taiWanPolitics.belongOrg}"/>
                                        </div>
                                    </div>
                                    <!-- 职务 -->
                                    <div class="col-xs-6">
                                        <label class="col-sm-4 control-label" for="form-field-duty" >
                                            职务：<span class="required">*</span>
                                        </label>
                                        <div class="col-sm-8 ">
                                            <input type="text" id="form-field-duty"
                                                   name="duty" class="form-control "
                                                   value="${taiWanPolitics.duty}"/>
                                        </div>
                                    </div>
                                </div>
                                <!-- 空格 -->
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                                <!-- 按钮 -->
                                <div class="clearfix form-actions center">
                                    <div class="col-xs-12">
                                        <button class="btn btn-info btn-sm" type="button" id="saveBtn">
                                            <i class="ace-icon fa fa-check bigger-110"></i>
                                            保存
                                        </button>
                                        &nbsp;&nbsp;&nbsp;
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
<script src="${basePath}/plugin/ace/assets/js/ace/elements.fileinput.js"></script>
<script type="text/javascript">
    //时间控件
    G.datepicker({autoclose: true, endDate: new Date()});

    // 控件类全局变量
    var $saveBtn = $("#saveBtn");
    var $backBtn = $("#backBtn");

    // 表单类全局变量
    var $saveForm = $("#new-edit-form");

    //其他全局变量
    var politicsId = $saveForm.find("#id-taiwan-politics").val();
    var $currDate = $("#id-taiwan-currDate");
    var $birthday = $("#form-field-birthday");

    //本地URL
    var url = '#page/taiwan-politics/taiwan-politics-list';
    var editUrl = '${basePath}/taiwan-politics/load-taiwan-politics-save.do';


    //台湾主要人士新增或编辑提交数据
    $saveBtn.unbind('click').bind('click',function (e) {
        if ($saveForm.validate().form()) {
            var currDate = moment($currDate.val(),'YYYY-MM-DD').toDate();
            var birthday = moment($birthday.val(),'YYYY-MM-DD').toDate();
            if (birthday >= currDate) {
                G.alert({message : '出生日期应小于当前日期！'});
                e.preventDefault();
            }else {
                e.preventDefault();
                var data = $saveForm.serializeObject();
                data["politicsId"] = politicsId;
                G.confirm({
                message: '确认保存此条信息吗？',
                callback: function (result) {
                    if (result) {
                        var loadId = G.showAjaxLoading();
                        $.ajax({
                            url: editUrl,
                            type: 'POST',
                            dataType: 'json',
                            data: data,
                            async: true
                        }).done(function (map) {
                            if (map.result) {
                                G.doneAjaxLoading(loadId);
                                G.showGritterSuccess("保存成功");
                                G.pjaxLoadPageContentDiv(url);
                            } else {
                                G.doneAjaxLoading(loadId);
                                G.showGritterFail("保存信息失败,请稍后重试!");
                            }
                        });
                    }
                }
            });
            }
        }
    });

    //台湾主要人士新增或编辑返回操作
    $backBtn.unbind('click').bind('click',function (e) {
        e.preventDefault();
        var postData = $saveForm.serializeObject();
        var flag = 0;
        $.each(postData,function (index,item) {
            if (item !== ""){
                flag = 1;
            }
        });
        if (flag === 0){
            G.pjaxLoadPageContentDiv(url);
        } else {
            G.confirm({
                message: "台湾重要人士信息尚未保存，确认退出吗？",
                callback: function (result) {
                    if(result){
                        G.pjaxLoadPageContentDiv(url);
                    }
                }
            });
        }
    });

    //数据校验
    $saveForm.tjValidate({
        focusInvalid: true,
        rules: {
            mainName: {required: true},
            birthdayStr: {required: true},
            partyId: {required: true},
            belongOrg: {required: true},
            duty: {required: true}
        },
        messages: {
            mainName: {required: "姓名必须填写"},
            birthdayStr: {required: "出生日期必须填写"},
            partyId: {required: "社团名称必须填写"},
            belongOrg: {required: "单位必须填写"},
            duty: {required: "职务必须填写"}
        }
    });

    $(document).one('ajaxloadstart.page', function (e) {
        $('.ui-jqdialog').remove();
        $('.ui-dialog').remove();
    });
</script>
