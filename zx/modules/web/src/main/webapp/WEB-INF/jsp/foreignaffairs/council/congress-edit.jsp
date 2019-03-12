<%--
  Created by IntelliJ IDEA.
  User: sy
  Date: 2018/7/5
  Time: 9:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>

<title>履职支撑平台</title>

<script src="${basePath}/plugin/ace/assets/js/chosen.jquery.js"></script>

<div class="row">
    <div class="col-xs-10 col-sm-offset-1">
        <div class="widget-box transparent">
            <div class="widget-body">
                <div class="widget-main">
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" id="saveForm" role="form"
                                  action="${basePath}/council/congress-info-save.do" method="post">
                                <input name="id" type="hidden" value=${loadCongress.id}>
                                <input name="isNo" type="hidden" value="0">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 30px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${loadCongress.id eq null}"> 外事局局务会议信息新增</c:when>
                                                    <c:otherwise> 外事局局务会议信息编辑</c:otherwise>
                                                </c:choose></h1>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin-top: 15px">
                                    <div class="row">
                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <label class="col-sm-4 control-label" for="form-field-title">会议标题：<span
                                                        class="required">*</span></label>

                                                <div class="col-sm-8 ">
                                                    <input type="text" id="form-field-title" name="title"
                                                           class="form-control " value="${loadCongress.title}"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <label class="col-sm-4 control-label"
                                                       for="form-field-meetingSite">会议地点：<span
                                                        class="required">*</span></label>
                                                <div class="col-sm-8 ">
                                                    <input type="text" id="form-field-meetingSite" name="meetingSite"
                                                           class="form-control " value="${loadCongress.meetingSite}"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <label class="col-sm-4 control-label"
                                                       for="form-field-timeStr">会议日期：<span
                                                        class="required">*</span></label>

                                                <div class="col-sm-8">
                                                    <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                        <input class="form-control" name="timeStr"
                                                               id="form-field-timeStr"
                                                               value="${loadCongress.jsonObject.time}" type="text"/>
                                                        <span class="input-group-addon">
                                                        <i class="fa fa-calendar bigger-110"></i>
                                                    </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <label class="col-sm-4 control-label" for="form-field-other">其他备注：<span
                                                        class="required">&nbsp;&nbsp;</span></label>
                                                <div class="col-sm-8 ">
                                                    <input type="text" id="form-field-other" name="other"
                                                           class="form-control " value="${loadCongress.other}"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;<span class="required">&nbsp;</span></label>

                                                <div class="col-sm-10">
                                                    <button class="btn btn-info btn-sm" type="button"
                                                            id="openName2">点击选择参会人员信息
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="row
                                        <c:choose>
                                            <c:when test="${loadCongress.id eq null}"> hide</c:when>
                                            <c:otherwise></c:otherwise>
                                        </c:choose>
                                    " id="congressUserNameDiv">
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label">
                                                    参会人员：<span class="required">*&nbsp;</span></label>

                                                <div class="col-sm-10">
                                                  <textarea class="form-control limited" id="congressUserNameId"
                                                            name="userNames"
                                                            style="min-height: 50px;" readonly="readonly">${loadCongress.attendence}</textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-xs-12 ">
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label"
                                                       for="form-field-content">会议内容：<span
                                                        class="required">*&nbsp;</span></label>

                                                <div class="col-sm-10 ">
                                                   <textarea class="form-control limited" id="form-field-content"
                                                             name="content" maxlength="2000"
                                                             style="min-height: 100px;">${loadCongress.content}</textarea>
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
                                            &nbsp;&nbsp;&nbsp;
                                            <button class="btn btn-primary btn-sm" type="button" id="backBtn">
                                                <i class="ace-icon fa fa-undo bigger-110"></i>
                                                返回
                                            </button>
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
<div id="view-dialog01" class="hide">
    <div class="col-sm-offset-1 col-sm-10">
        <c:forEach items="${dicUserListCongress}" var="UserList" varStatus="status">
            <input type="text" value="   ${UserList.key}"
                   style="width: 98%;border:black; font-size: 19px;
                       font-weight: bold;color: black" readonly="readonly"/>
            <br>
            <c:forEach items="${UserList.value}" var="UserListName">
                &nbsp;&nbsp;
                <input type="checkbox" name="congressUserName" id="${UserListName.id}" value="${UserListName.empName}">
                <span style="font-size:15px">${UserListName.empName}&nbsp;&nbsp;</span>
                </input>
            </c:forEach>
        </c:forEach>
    </div>
</div>
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.datepicker({
            todayHighlight: true,
            autoclose:true
        });


        // 控件类全局变量
        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");
        var $viewDialog = $("#view-dialog01");
        var $openName2 = $("#openName2");
        var $congressUserNameId = $("#congressUserNameId");
        // 表单类全局变量
        var $saveForm = $("#saveForm");
        var url = '#page/council/congress-info-list';
        $saveBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            if ($saveForm.validate().form()) {
                var  userNames = $congressUserNameId.val();
                if(!_.isEmpty(userNames)){
                    var load = G.showAjaxLoading("正在保存中，请稍候...");
                    $saveBtn.prop("disabled", true);
                    $backBtn.prop("disabled", true);
                    $saveForm.ajaxSubmit({
                        success: function (result) {
                            G.doneAjaxLoading(load);
                            if (result.result) {
                                G.showGritterSuccess("保存成功!");
                                G.pjaxLoadPageContentDiv(url);
                            } else {
                                G.showGritterFail("失败,请稍后重试!");
                            }
                        },
                        error: function () {
                            G.doneAjaxLoading(load);
                            G.showGritterFail("保存失败,请稍后重试!");
                            $saveBtn.prop("disabled", false);
                            $backBtn.prop("disabled", false);
                        }
                    });
                }else {
                    G.showGritterFail("人员信息不能为空!");
                }

            }
        });


        $openName2.click(function () {
            $("#isNo").val("1");
            var  userNames = $congressUserNameId.val();
            initViewDialog($viewDialog ,userNames)
        })
        function initViewDialog($container,userNames) {
            var name = userNames.split(",");
            //回显选已有值
            $('input[name="congressUserName"]:not(:checked)').each(function () {
                for(var i=0;i<name.length;i++){
                    var name1 = name[i]
                    if(name1 === $(this).val()){
                        $(this).prop("checked",true);
                    }
                }
            });
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>选择参会人员</h4></div>",
                title_html: true,
                close: function () {
                    $container.addClass("hide");
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 确定",
                        "class": "btn btn-success",
                        click: function () {
                            var congressUserNameValus = [];
                            $('input[name="congressUserName"]:checked').each(function () {
                                congressUserNameValus.push($(this).val());
                            })
                            $congressUserNameId.val(congressUserNameValus);
                            $("#congressUserNameDiv").removeClass("hide");
                            $(this).dialog("close");
                        }
                    }
                ]
            });
        }

        $backBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var postData = $saveForm.serializeObject();
            var flag = 0;
            $.each(postData, function (index, item) {
                if (item !== "") {
                    flag = 1;
                }
            });
            if (flag === 0) {
                G.pjaxLoadPageContentDiv(url)
            } else {
                G.confirm({
                    message: "局务会议信息未保存，确认退出吗？",
                    callback: function (result) {
                        if (result) {
                            G.pjaxLoadPageContentDiv(url);
                        }
                    }
                });
            }

        });
        $saveForm.tjValidate({
            focusInvalid: false,
            rules: {
                title: {
                    required: true,
                    maxlength:50
                },
                meetingSite: {
                    required: true,
                    maxlength:50
                },
                timeStr: {
                    required: true
                },
                content: {
                    required: true,
                    maxlength:2000
                },
                userNames:{
                    required: true
                }
            },
            messages: {
                title: {
                    required: "标题不能为空"
                },
                meetingSite: {
                    required: "地点不能为空"
                },
                timeStr: {
                    required: "时间不能为空"
                },
                content: {
                    required: "内容不能为空"
                },
                userNames: {
                    required: "人员信息不能为空"
                }
            }
        });
        $(document).one('ajaxloadstart.page', function (e) {

            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>
