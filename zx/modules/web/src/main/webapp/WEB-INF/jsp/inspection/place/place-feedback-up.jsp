<%--
  Created by IntelliJ IDEA.
  User: sy
  Date: 2018/7/27
  Time: 14:15
  To change this template use File | Settings | File Templates.
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

<div class="row" style="background-color: lightgrey">
    <div class="col-sm-10 col-sm-offset-1">
        <!-- #section:pages/invoice -->
        <div class="widget-box">
            <div class="widget-body">
                <div class="widget-main">
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" role="form" id="saveForm"
                                  action="${basePath}/feedback/feedback-place-save.do" method="post">
                                <!--页面隐藏元素-->
                                <div class="hidden">
                                    <input type="text" id="placeId" name="placeId" value="${placeList.id}"/>
                                    <input type="text" id="deptId" name="deptId" value="${placeList.dicDept.id}"/>
                                    <input type="text" id="reportState" name="reportState" value="${placeList.reportState}"/>
                                    <input type="text" id="feedbackFlag" name="feedbackFlag" value="0"/>
                                    <input type="text" id="feedbackId" name="feedbackId" value="${placeList.feedback.id}"/>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                            <h2 align="center" style="font-weight:bolder;letter-spacing: 2pt">
                                                视察考察调研活动安排反馈</h2>
                                        </div>
                                    </div>
                                </div>
                                <div class="hr hr-18 hr-double dotted"> </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-title">活动名称：<span class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-title" name="title"
                                                       holderName="活动名称" readonly="readonly"
                                                       class="form-control"
                                                       value="${placeList.title}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-actTypeId">活动性质：<span class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-actTypeId" name="actTypeId"
                                                       holderName="性质" readonly="readonly"
                                                       class="form-control" value="${placeList.actTypeId}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-dicdeptName"> 承办单位：<span class="required">*</span></label>

                                            <div class="col-sm-8">
                                                <input type="text" id="form-field-dicdeptName" name="dicdeptName" readonly="readonly"
                                                       class="form-control" value="${placeList.dicDept.deptName}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group"style="margin-top: 5px;margin-bottom: 5px">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-orgType"> 组织形式：<span class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-orgType" name="orgType"
                                                       class="form-control" value=""/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-teamLeader"> 率队领导：<span class="required">*</span></label>

                                            <div class="col-sm-8">
                                                <input type="text" id="form-field-teamLeader" name="teamLeader"
                                                       class="form-control" value=""/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group"style="margin-top: 5px;margin-bottom: 5px">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-groupScale"> 团队规模：<span class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-groupScale" name="groupScale"
                                                       class="form-control" value=""/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group"style="margin-top: 5px;margin-bottom: 5px">
                                            <label class="col-sm-4 control-label"> 实际时间：<span class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                    <div class="input-daterange input-group">

                                                    <span class="input-group-addon"><i
                                                            class="fa fa-calendar bigger-110"></i></span>

                                                        <input type="text" class="form-control date-picker" name="beginTimeStr"
                                                               id="form-field-actualTime1" data-date-format="yyyy-mm-dd"
                                                               value="" type="text"/>
                                                        <span class="input-group-addon">
                                                            <i class="fa fa-exchange"></i>
                                                            </span>

                                                        <input type="text" class="form-control date-picker" name="endTimeStr"
                                                               id="form-field-actualTime2" data-date-format="yyyy-mm-dd"
                                                               value="" type="text"/>

                                                        <span class="input-group-addon"><i
                                                                class="fa fa-calendar bigger-110"></i></span>
                                                    </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xs-6">
                                        <div class="form-group"style="margin-top: 5px;margin-bottom: 5px">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-actualPlace"> 实际地点：<span class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-actualPlace" name="actualPlace"
                                                       class="form-control" value=""/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12">
                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                <label class="col-sm-2 control-label"
                                                       for="form-field-adjustmentReason">计划调整原因:</label>

                                                <div class="col-sm-10 ">
                                                    <input type="text" id="form-field-adjustmentReason" name="adjustmentReason"
                                                           holderName="计划调整原因"
                                                           class="form-control"
                                                           value=""/>
                                                </div>
                                            </div>
                                        </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                <label class="col-sm-4 control-label"
                                                       for="form-field-agentName"> 经办人：<span class="required">*</span></label>

                                                <div class="col-sm-8">
                                                    <input type="text" id="form-field-agentName" name="agentName"
                                                           class="form-control" value=""/>
                                                </div>
                                            </div>
                                        </div>
                                    <div class="col-xs-6">
                                            <div class="form-group"style="margin-top: 5px;margin-bottom: 5px">
                                                <label class="col-sm-4 control-label"
                                                       for="form-field-agentMobile"> 联系方式：<span class="required">*</span></label>

                                                <div class="col-sm-8 ">
                                                    <input type="text" id="form-field-agentMobile" name="agentMobile"
                                                           class="form-control" value=""/>
                                                </div>
                                            </div>
                                        </div>
                                </div>
                                <div class="hr hr-18 hr-double dotted"></div>
                                <div class="clearfix form-actions center">
                                    <div class="col-xs-12">
                                        <c:forEach items="${curOperateAuth}" var="curOpertate">
                                            <c:if test="${'76_11' eq curOpertate}">
                                                &nbsp; &nbsp; &nbsp;
                                                <button class="btn btn-success btn-sm" type="button" id="feedBackBtn">
                                                    <i class="ace-icon glyphicon glyphicon-arrow-up bigger-110"></i>
                                                    反馈
                                                </button>
                                            </c:if>
                                        </c:forEach>
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

       $('.input-daterange').datepicker({autoclose: true, todayHighlight: true,format: 'yyyy-mm-dd'});
        G.datepicker({autoclose: true, todayHighlight: true,format: 'yyyy-mm-dd'});

        var $saveForm = $("#saveForm");
        var $feedBackBtn = $("#feedBackBtn");
        var $backBtn = $("#backBtn");

        //反馈点击事件绑定
        $feedBackBtn.unbind('click').bind('click',function (e) {
            e.preventDefault();
            $("#feedbackFlag").val("1");
            saveFeedBack('反馈');
        });

        //返回点击事件绑定
        $backBtn.unbind('click').bind('click',function () {
            window.history.back(-1);
        });

        //保存方法
        function saveFeedBack(type) {
            if ($saveForm.validate().form()) {
                var load = G.showAjaxLoading("正在"+type+"中，请稍候...");
                $saveForm.ajaxSubmit({

                    success: function (map) {
                        G.doneAjaxLoading(load);
                        if (map.result) {
                            G.showGritterSuccess(type + "成功!");
                            G.pjaxLoadPageContentDiv("page/place/place-list");
                        } else {
                            G.showGritterFail(type + "失败,请稍后重试!");
                        }
                    },
                    error: function () {
                        G.doneAjaxLoading(load);
                        G.showGritterFail(type + "失败,请稍后重试!");
                    }
                });
            }
        }

        $saveForm.tjValidate({
            focusInvalid: false,
            rules: {
                orgType: {
                    required: true,
                    maxlength: 60
                },
                teamLeader: {
                    required: true,
                    maxlength: 60
                },
                groupScale: {
                    required: true,
                    maxlength: 60
                },
                beginTimeStr:{
                    required: true
                },
                actualPlace:{
                    required: true,
                    maxlength: 20
                },
                agentName:{
                    required: true,
                    maxlength: 32
                },
                agentMobile:{
                    required: true,
                    maxlength: 20
                }
            },
            messages: {
                orgType: {
                    required: "组织形式不能为空"
                },
                teamLeader: {
                    required: "率队领导不能为空"
                },
                groupScale: {
                    required: "团队规模不能为空"
                },
                beginTimeStr:{
                    required: "实际时间不能为空"

                },
                endTimeStr:{
                    required: "实际时间不能为空"
                },
                agentName:{
                    required: "经办人不能为空"
                },
                agentMobile:{
                    required: "联系方式不能为空"
                },
                actualPlace:{
                    required: "实际地点不能为空"
                }
            }
        });




    });
</script>

