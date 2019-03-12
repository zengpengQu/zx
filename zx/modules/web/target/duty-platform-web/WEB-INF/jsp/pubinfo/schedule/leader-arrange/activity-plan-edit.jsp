<%--
  Created by IntelliJ IDEA.
  User: BT4900
  Date: 2018/8/15
  Time: 19:38
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

<div class="row">
    <div class="col-sm-10 col-sm-offset-1">
        <!-- #section:pages/invoice -->
        <div class="widget-box transparent">
            <div class="widget-body">
                <div class="widget-main">
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" role="form" id="saveForm" autocomplete="off"
                                  action="${basePath}/activity-plan/plan-edit-save.do" method="post">
                                <!--页面隐藏元素-->
                                <div class="hidden">
                                    <input type="text" id="form-field-id" name="id" value="${model.id}"/>
                                    <input type="text" id="form-field-status" name="status" value="${model.status}"/>
                                    <input type="text" id="form-field-delFlag" name="delFlag" value="0"/>
                                    <input type="text" id="form-field-sendTimeStr" name="sendTimeStr"
                                           value="${model.jsonObject.sendDateStr}"/>
                                    <input type="text" id="deptId" name="dicDept.id"
                                           value="<c:choose><c:when test="${model.dicDept.id eq null}">${currentUser.dicDept.id}</c:when><c:when test="${model.dicDept.id ne null}">${model.dicDept.id}</c:when></c:choose>"/>
                                </div>

                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 5px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                秘书长碰头会通知</h1>
                                        </div>
                                    </div>
                                </div>

                                <div style="margin-top: 5%"></div>

                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 5px">
                                            <label class="col-sm-1 control-label no-padding-right"
                                                   style="padding-top: 2px">是否开会:</label>

                                            <div class="col-sm-10">
                                                <label class="inline">
                                                    <input name="meetingFlag" value="0" type="radio"
                                                           class="ace input-lg"
                                                           <c:if test="${model.meetingFlag eq '0' or model.meetingFlag eq null}">checked</c:if>>
                                                    <span class="lbl middle"> 是 </span>
                                                </label>

                                                &nbsp; &nbsp; &nbsp;
                                                <label class="inline">
                                                    <input name="meetingFlag" value="1" type="radio"
                                                           class="ace input-lg"
                                                           <c:if test="${model.meetingFlag eq '1'}">checked</c:if>>
                                                    <span class="lbl middle"> 否 </span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="hr hr-18 hr-double dotted"></div>

                                <div class="row">
                                    <div class="col-xs-12" style="margin-bottom: 12px">
                                        <h3 align="center" style="font-weight: bold;">通知内容<span
                                                class="required">*</span></h3>
                                    </div>
                                    <div class="col-xs-12">
                                        <textarea id="meeting" style="min-height: 200px" name="content"
                                                  class="autosize-transition form-control">${model.content}</textarea>
                                    </div>
                                </div>

                                <div class="clearfix form-actions center">
                                    <div class="col-xs-12">
                                        <button class="btn btn-info btn-sm" type="button" id="saveBtn">
                                            <i class="ace-icon fa fa-check bigger-110"></i>
                                            保存
                                        </button>

                                        <c:if test="${model.status eq '0' or model.status eq null}">
                                            &nbsp; &nbsp; &nbsp;
                                            <button class="btn btn-success btn-sm" type="button" id="sendBtn">
                                                <i class="ace-icon glyphicon glyphicon-arrow-down bigger-110"></i>
                                                下发
                                            </button>
                                        </c:if>

                                        &nbsp; &nbsp; &nbsp;
                                        <button class="btn btn-primary btn-sm" type="button" id="backBtn">
                                            <i class="ace-icon fa fa-undo bigger-110"></i>
                                            返回
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div><!-- /.col -->
                    </div><!-- /.row -->
                </div><!-- /.widget-main -->
            </div><!-- /.widget-body -->
        </div>
    </div>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.datepicker({autoclose: true, todayHighlight: true});

        var $saveForm = $('#saveForm');
        var $saveBtn = $("#saveBtn");
        var $sendBtn = $("#sendBtn");
        var $backBtn = $("#backBtn");

        $saveBtn.unbind('click').bind('click', function () {

            //状态
            $("#form-field-status").val("0");
            save('保存', $saveBtn);
        });

        $sendBtn.unbind('click').bind('click', function () {

            //状态
            $("#form-field-status").val("1");
            //下发日期
            $("#form-field-sendTimeStr").val("${sysDate}");
            save('下发', $sendBtn);
        });

        //返回
        $backBtn.unbind('click').bind('click', function () {
            window.history.back(-1);
        });

        function save(type, $btn) {
            if ($saveForm.validate().form()) {
                $btn.prop('disabled', true);
                $saveForm.ajaxSubmit({
                    success: function (map) {
                        if (map.result) {
                            G.showGritterSuccess(type + "成功!");
                            G.pjaxLoadPageContentDiv("page/activity-plan/activity-plan-list");
                        } else {
                            G.showGritterFail(type + "失败,请稍后重试!");
                            $btn.prop('disabled', false);
                        }
                    }
                });
            }
        }

        $saveForm.tjValidate({
            focusInvalid: false,
            rules: {
                content: {
                    required: true
                }
            },
            messages: {
                content: {
                    required: "通知内容不能为空"
                }
            }
        });

        $(document).one('ajaxloadstart.page', function (e) {
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>
