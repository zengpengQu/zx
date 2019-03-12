<%--
  Created by IntelliJ IDEA.
  User: pengyx
  Date: 2018/7/11
  Time: 15:15
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
                                  action="${basePath}/week-work/start-edit-save.do" method="post">
                                <!--页面隐藏元素-->
                                <div class="hidden">
                                    <input type="text" id="form-field-id" name="id" value="${model.id}"/>
                                    <input type="text" id="form-field-status" name="status" value="${model.status}"/>
                                    <input type="text" id="form-field-sendDateStr" name="sendDateStr" value="${model.jsonObject.sendDateStr}"/>
                                    <input type="text" id="deptId" name="dicDept.id"
                                           value="<c:choose><c:when test="${model.dicDept.id eq null}">${currentUser.dicDept.id}</c:when><c:when test="${model.dicDept.id ne null}">${model.dicDept.id}</c:when></c:choose>"/>
                                </div>

                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 5px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                一周工作情况发起</h1>
                                        </div>
                                    </div>
                                </div>

                                <div style="margin-top: 5%"></div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right"
                                                   for="form-field-createName"> 填报人： <span
                                                    class="required">*</span></label>

                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-createName" name="createName"
                                                       class="form-control" value="${model.createName}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right"
                                                   for="form-field-tel"> 联系方式： <span class="required">*</span></label>

                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-tel" name="tel"
                                                       class="form-control" value="${model.tel}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right"
                                                   for="form-field-startDateStr"> 开始日期：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-9">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="startDateStr"
                                                           id="form-field-startDateStr"
                                                           value="${model.jsonObject.startDateStr}"
                                                           type="text"/>
                                                    <span class="input-group-addon">
                                                            <i class="fa fa-calendar bigger-110"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right"
                                                   for="form-field-endDateStr"> 结束日期：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-9">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="endDateStr"
                                                           id="form-field-endDateStr"
                                                           value="${model.jsonObject.endDateStr}"
                                                           type="text"/>
                                                    <span class="input-group-addon">
                                                            <i class="fa fa-calendar bigger-110"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-12" style="margin-bottom: 12px">
                                        <h3 align="center" style="font-weight: bold;">综合处长会议<span
                                                class="required">*</span></h3>
                                    </div>
                                    <div class="col-xs-12" style="padding-left: 60px;">
                                        <textarea id="meeting" style="min-height: 200px" name="meeting"
                                                  class="autosize-transition form-control">${model.meeting}</textarea>
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

        $(".accordion").accordion({
            collapsible: true,
            active: true,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        var $saveForm = $("#saveForm");

        var $saveBtn = $("#saveBtn");
        var $sendBtn = $("#sendBtn");
        var $backBtn = $("#backBtn");

        var $createName = $("#form-field-createName");

        initPage();

        function initPage() {
            if (_.isEmpty($createName.val())) {
                $createName.val('${currentUser.empName}');
            }
        }

        $saveBtn.unbind('click').bind('click',function () {

            save('保存', $saveBtn);
        });

        $sendBtn.unbind('click').bind('click',function () {

            //状态
            $("#form-field-status").val("1");
            //下发日期
            $("#form-field-sendDateStr").val("${sysDate}");
            save('下发', $sendBtn);
        });

        $backBtn.unbind('click').bind('click',function () {
            G.pjaxLoadPageContentDiv("page/week-work/week-work-list");
        });

        function save(type, $btn) {
            if ($saveForm.validate().form()) {
                $btn.prop("disabled", true);
                $saveForm.ajaxSubmit({
                    success: function (map) {
                        if (map.result) {
                            G.showGritterSuccess(type + "成功!");
                            G.pjaxLoadPageContentDiv("page/week-work/week-work-list");

                        } else {
                            G.showGritterFail(type +"失败,请稍后重试!");
                            $btn.prop("disabled", false);
                        }
                    }
                });
            }
        }

        $saveForm.tjValidate({
            focusInvalid: false,
            rules: {
                createName: {
                    required: true
                },
                tel: {
                    required: true
                },
                startDateStr: {
                    required: true
                },
                endDateStr: {
                    required: true,
                    compareDate : '#form-field-startDateStr'
                },
                meeting: {
                    required: true
                }
            },
            messages: {
                createName: {
                    required: "填报人不能为空"
                },
                tel: {
                    required: "联系方式不能为空"
                },
                startDateStr: {
                    required: "开始日期不能为空"
                },
                endDateStr: {
                    required: "结束日期不能为空"
                },
                meeting: {
                    required: "综合处长会议不能为空"
                }
            }
        });

        $(document).one('ajaxloadstart.page', function (e) {
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>