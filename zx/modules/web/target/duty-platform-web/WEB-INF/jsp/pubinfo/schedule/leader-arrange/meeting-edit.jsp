<%--
  Created by IntelliJ IDEA.
  User: BT4900
  Date: 2018/8/21
  Time: 14:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                                  action="${basePath}/plan-receipt/meeting-edit-save.do" method="post">
                                <!--页面隐藏元素-->
                                <div class="hidden">
                                    <input type="text" id="form-field-id" name="id" value="${planReceipt.id}"/>
                                    <input type="text" id="form-field-status" name="status" value="${planReceipt.status}"/>
                                    <input type="text" id="form-field-delFlag" name="delFlag" value="0"/>
                                    <input type="text" id="form-field-feedbackTimeStr" name="feedbackTimeStr"
                                           value="${planReceipt.jsonObject.feedbackTimeStr}"/>
                                </div>

                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 5px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                会议回执</h1>
                                        </div>
                                    </div>
                                </div>

                                <div style="margin-top: 5%"></div>

                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                            <label class="control-label col-xs-12 col-sm-2 no-padding-right"
                                                   style="margin-top: 25px">参会情况：<span
                                                    class="required">*</span></label>

                                            <div class="col-xs-12 col-sm-10">
                                                <div class="row">
                                                    <div class="col-xs-2"
                                                         style="margin-top: 10px;margin-bottom: 10px">
                                                        <label class="line-height-1 blue">
                                                            <input name="isAttend" value="0" type="radio"
                                                                   class="ace"
                                                                   id="attend"
                                                                   <c:if test="${planReceipt.isAttend eq '0' or planReceipt.isAttend eq null}">checked</c:if>>
                                                            <span class="lbl"> 参会</span>
                                                        </label>
                                                    </div>
                                                    <div class="col-xs-10">
                                                        <div class="form-group"
                                                             style="margin-top: 5px;margin-bottom: 5px">
                                                            <label class="col-sm-2 control-label"
                                                                   for="leaderName">与会领导:</label>

                                                            <div class="col-sm-10 ">
                                                                <input type="text" id="leaderName" name="leaderName"
                                                                       holderName="与会领导"
                                                                       class="form-control add-status"
                                                                       value="${planReceipt.leaderName}"/>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="row">
                                                    <div class="col-xs-2"
                                                         style="margin-top: 10px;margin-bottom: 10px">
                                                        <label class="line-height-1 blue">
                                                            <input name="isAttend" value="1" id="offWork"
                                                                   type="radio" class="ace"
                                                                   <c:if test="${planReceipt.isAttend eq '1'}">checked</c:if>>
                                                            <span class="lbl"> 不参会</span>
                                                        </label>
                                                    </div>
                                                    <div class="col-xs-10">
                                                        <div class="form-group"
                                                             style="margin-top: 5px;margin-bottom: 5px">
                                                            <label class="col-sm-2 control-label"
                                                                   for="reason">请假原因:</label>

                                                            <div class="col-sm-10 ">
                                                                <input type="text" id="reason" disabled
                                                                       name="reason"
                                                                       holderName="请假原因"
                                                                       class="form-control add-status"
                                                                       value="${planReceipt.reason}"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="hr hr-18 hr-double dotted"></div>

                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <h3 align="center">下周工作安排<span
                                                    class="required">*</span></h3>
                                        </div>
                                    </div>
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <div class="col-sm-offset-3 col-sm-6">
                                                <div class="input-daterange input-group">

                                                    <span class="input-group-addon"><i
                                                            class="fa fa-calendar bigger-110"></i></span>

                                                    <input type="text" class="form-control date-picker"
                                                           id="form-field-startDateStr" data-date-format="yyyy-mm-dd" name="startDateStr"
                                                           value="${planReceipt.jsonObject.startDateStr}" type="text"/>
                                                    <span class="input-group-addon">
                                                            <i class="fa fa-exchange"></i>
                                                            </span>

                                                    <input type="text" class="form-control date-picker"
                                                           id="form-field-endDateStr" data-date-format="yyyy-mm-dd" name="endDateStr"
                                                           value="${planReceipt.jsonObject.endDateStr}" type="text"/>
                                                    <span class="input-group-addon"><i
                                                            class="fa fa-calendar bigger-110"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12">
                                        <textarea id="workPlan" style="min-height: 200px" name="workPlan"
                                                  class="autosize-transition form-control">${planReceipt.workPlan}</textarea>
                                    </div>
                                </div>

                                <div class="clearfix form-actions center">
                                    <div class="col-xs-12">
                                        <button class="btn btn-info btn-sm" type="button" id="saveBtn">
                                            <i class="ace-icon fa fa-check bigger-110"></i>
                                            保存
                                        </button>

                                        <c:if test="${planReceipt.status eq '0' or planReceipt.status eq null}">
                                            &nbsp; &nbsp; &nbsp;
                                            <button class="btn btn-success btn-sm" type="button" id="receiptBtn">
                                                <i class="ace-icon glyphicon glyphicon-arrow-up bigger-110"></i>
                                                反馈
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

        $('.input-daterange').datepicker({autoclose: true, todayHighlight: true, format: 'yyyy-mm-dd'});
        G.datepicker({autoclose: true, todayHighlight: true});

        var $saveForm = $("#saveForm");
        var $saveBtn = $("#saveBtn");
        var $receiptBtn = $("#receiptBtn");
        var $backBtn = $("#backBtn");

        var $startDate = $("#form-field-startDateStr");
        var $endDate = $("#form-field-endDateStr");

        var feedbackViewUrl = '#page/plan-receipt/load-receipt-list';

        initPage();

        function initPage() {

            if ($startDate.val() === '') {
                $startDate.val('${nextWeekMondayStr}');
            }
            if ($endDate.val() === '') {
                $endDate.val('${nextWeekSundayStr}');
            }

            $saveForm.find('input[name=isAttend]').on('click',function (e) {

                var target = e.target;
                var id = $(target).attr("id");

                if (id === 'attend') {
                    $saveForm.find('input[name=reason]').prop('disabled',true).val('');
                    $("#leaderName").removeAttr('disabled');

                } else if (id === 'offWork') {
                    $saveForm.find('input[name=reason]').prop('disabled',false);
                    $("#leaderName").attr('disabled',true).val('');

                } else {
                    //do nothing
                }
            })
        }

        $saveBtn.unbind('click').bind('click', function () {

            //状态
            $("#form-field-status").val("0");
            save('保存', $saveBtn);
        });

        $receiptBtn.unbind('click').bind('click', function () {

            //状态
            $("#form-field-status").val("1");
            //反馈日期
            $("#form-field-feedbackTimeStr").val("${sysDateStr}");
            save('反馈', $receiptBtn);
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
                            window.history.back(-1);

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
                startDateStr: {
                    required: true
                },
                endDateStr: {
                    required: true
                },
                workPlan: {
                    required: true
                }
            },
            messages: {
                startDateStr: {
                    required: "开始日期不能为空"
                },
                endDateStr: {
                    required: "结束日期不能为空"
                },
                workPlan: {
                    required: "下周工作安排不能为空"
                }
            }
        });


        $(document).one('ajaxloadstart.page', function (e) {

            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>
