<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2018/6/25
  Time: 14:15
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
        <div class="widget-box transparent">
            <div class="widget-body">
                <div class="widget-main">
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" role="form" id="saveForm" autocomplete="off"
                                  action="${basePath}/week-work/work-feedback-save.do" method="post">
                                <!--页面隐藏元素-->
                                <div class="hidden">
                                    <input type="text" id="workId" name="weekWork.id" value="${weekWork.id}"/>
                                    <input type="text" id="id" name="id" value="${workFeedbackVo.id}"/>
                                    <input type="text" id="deptId" name="deptId" value="${user.dicDept.id}"/>
                                    <input type="text" id="status" name="status" value="${workFeedbackVo.status}"/>
                                </div>

                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                            <h2 align="center" style="font-weight:bolder;letter-spacing: 2pt">
                                                一周工作情况</h2>
                                        </div>
                                    </div>
                                </div>

                                <div class="hr hr-18 hr-double dotted"></div>

                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-deptName">单位:<span class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-deptName" name="deptName"
                                                       holderName="单位" readonly="readonly"
                                                       class="form-control add-status"
                                                       value="${user.dicDept.deptName}"/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xs-4">
                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-createName">填报人:<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-createName" name="createName"
                                                       holderName="填报人"
                                                       class="form-control add-status" value="${user.empName}"/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xs-4">
                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-phone">联系电话:<span class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-phone" name="phone"
                                                       holderName="联系电话"
                                                       class="form-control add-status" value="${workFeedbackVo.phone}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-signLeader">签发领导:<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-signLeader" name="signLeader"
                                                       holderName="签发领导"
                                                       class="form-control add-status"
                                                       value="${workFeedbackVo.signLeader}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-feedbackDate">报送日期:<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <div class="input-group">
                                                    <input type="text" class="form-control date-picker"
                                                           name="feedbackDateStr"
                                                           id="form-field-feedbackDate" data-date-format="yyyy-mm-dd"
                                                           value="${workFeedbackVo.feedbackDateStr}"
                                                           type="text"/>
                                                    <span class="input-group-addon"><i
                                                            class="fa fa-calendar bigger-110"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="hr hr-18 hr-double dotted"></div>

                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                            <label class="col-sm-2 control-label"
                                                   for="form-field-meeting">综合处长会议:</label>

                                            <div class="col-sm-10 ">
                                                <input type="text" id="form-field-meeting" name="weekWork.meeting"
                                                       holderName="综合处长会议"
                                                       class="form-control add-status"
                                                       value="${weekWork.meeting}" readonly="readonly"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                            <label class="control-label col-xs-12 col-sm-2 no-padding-right"
                                                   style="margin-top: 25px">出勤情况反馈：<span
                                                    class="required">*</span></label>

                                            <div class="col-xs-12 col-sm-10">
                                                <div class="row">

                                                    <div class="col-xs-2"
                                                         style="margin-top: 10px;margin-bottom: 10px">
                                                        <label class="line-height-1 blue">
                                                            <input name="isAttend" value="0" type="radio"
                                                                   class="ace"
                                                                   id="attend"
                                                                   <c:if test="${workFeedbackVo.isAttend eq '0' or workFeedbackVo.isAttend eq null}">checked</c:if>>
                                                            <span class="lbl"> 参加</span>
                                                        </label>
                                                    </div>
                                                    <div class="col-xs-10" style="padding-right: 11px">
                                                        <div class="form-group"
                                                             style="margin-top: 5px;margin-bottom: 5px">
                                                            <label class="col-sm-2 control-label"
                                                                   for="participantsId">参加人员:</label>

                                                            <div class="col-sm-10">
                                                                <select class="form-control" id="participantsId"
                                                                        name="participants.id">
                                                                    <option value="">-----请选择-----</option>
                                                                    <c:forEach items="${userList}" var="user">
                                                                        <option value="${user.id}"
                                                                                <c:if test="${workFeedbackVo.participants.id eq user.id}">selected</c:if>>${user.empName}</option>
                                                                    </c:forEach>
                                                                </select>
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
                                                                   <c:if test="${workFeedbackVo.isAttend eq '1'}">checked</c:if>>
                                                            <span class="lbl"> 请假</span>
                                                        </label>
                                                    </div>
                                                    <div class="col-xs-10" style="padding-right: 11px">
                                                        <div class="form-group"
                                                             style="margin-top: 5px;margin-bottom: 5px">
                                                            <label class="col-sm-2 control-label"
                                                                   for="reason">请假理由:</label>

                                                            <div class="col-sm-10 ">
                                                                <input type="text" id="reason" readonly="readonly"
                                                                       name="reason"
                                                                       holderName="请假理由"
                                                                       class="form-control add-status"
                                                                       value="${workFeedbackVo.reason}"/>
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
                                            <h3 align="center" style="font-weight: bold;">本周工作开展情况</h3>
                                        </div>
                                    </div>

                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <div class="col-sm-offset-3 col-sm-6">
                                                <div class="input-daterange input-group">
                                                    <span class="input-group-addon"><i
                                                            class="fa fa-calendar bigger-110"></i></span>

                                                    <input type="text" class="form-control" readonly="readonly"
                                                           id="form-field-curStartTime" data-date-format="yyyy-mm-dd"
                                                           value="${weekWork.jsonObject.startDateStr}" type="text"/>
                                                    <span class="input-group-addon">
                                                            <i class="fa fa-exchange"></i>
                                                            </span>
                                                    <input type="text" class="form-control" readonly="readonly"
                                                           id="form-field-curEndTime" data-date-format="yyyy-mm-dd"
                                                           value="${weekWork.jsonObject.endDateStr}" type="text"/>
                                                    <span class="input-group-addon"><i
                                                            class="fa fa-calendar bigger-110"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-1 control-label"
                                                   for="workContent" style="height: 150px;line-height: 150px">内容:<span
                                                    class="required">*</span></label>
                                            <div class="col-sm-11 ">
                                                <textarea id="workContent" style="min-height: 150px" name="workContent"
                                                          class="autosize-transition form-control">${workFeedbackVo.workContent}</textarea>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="hr hr-18 hr-double dotted"></div>

                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <h3 align="center" style="font-weight: bold;">下周工作安排</h3>
                                        </div>
                                    </div>
                                    <div class="col-xs-12">
                                        <div class="form-group">

                                            <div class="col-sm-offset-3 col-sm-6">
                                                <div class="input-daterange input-group">

                                                    <span class="input-group-addon"><i
                                                            class="fa fa-calendar bigger-110"></i></span>

                                                    <input type="text" class="form-control" readonly="readonly"
                                                           id="form-field-nextStartTime" data-date-format="yyyy-mm-dd"
                                                           value="${weekWork.jsonObject.startDateStr}" type="text"/>
                                                    <span class="input-group-addon">
                                                            <i class="fa fa-exchange"></i>
                                                            </span>

                                                    <input type="text" class="form-control" readonly="readonly"
                                                           id="form-field-nextEndTime" data-date-format="yyyy-mm-dd"
                                                           value="${weekWork.jsonObject.endDateStr}" type="text"/>

                                                    <span class="input-group-addon"><i
                                                            class="fa fa-calendar bigger-110"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-1 control-label"
                                                   for="workSchedule" style="height: 150px;line-height: 150px">内容:<span
                                                    class="required">*</span></label>
                                            <div class="col-sm-11 ">
                                                <textarea id="workSchedule" style="min-height: 150px"
                                                          name="workSchedule"
                                                          class="autosize-transition form-control">${workFeedbackVo.workSchedule}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="hr hr-18 hr-double dotted"></div>

                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <h3 align="center" style="font-weight: bold;">近期重点工作</h3>
                                        </div>
                                    </div>
                                    <div class="col-xs-12">
                                        <div class="form-group">

                                            <div class="col-sm-offset-3 col-sm-6">
                                                <div class="input-daterange input-group">

                                                    <span class="input-group-addon"><i
                                                            class="fa fa-calendar bigger-110"></i></span>

                                                    <input type="text" class="form-control" readonly="readonly"
                                                           id="form-field-majorStartTime" data-date-format="yyyy-mm-dd"
                                                           value="${weekWork.jsonObject.startDateStr}" type="text"/>
                                                    <span class="input-group-addon">
                                                            <i class="fa fa-exchange"></i>
                                                            </span>

                                                    <input type="text" class="form-control" readonly="readonly"
                                                           id="form-field-majorEndTime" data-date-format="yyyy-mm-dd"
                                                           value="${weekWork.jsonObject.endDateStr}" type="text"/>

                                                    <span class="input-group-addon"><i
                                                            class="fa fa-calendar bigger-110"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-1 control-label"
                                                   for="majorWork" style="height: 150px;line-height: 150px">内容:<span
                                                    class="required">*</span></label>
                                            <div class="col-sm-11 ">
                                                <textarea id="majorWork" style="min-height: 150px" name="majorWork"
                                                          class="autosize-transition form-control">${workFeedbackVo.majorWork}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="hr hr-18 hr-double dotted"></div>

                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <h3 align="center" style="font-weight: bold;">局级领导离京和脱产学习情况</h3>
                                        </div>
                                    </div>

                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <div class="col-sm-offset-3 col-sm-6">
                                                <div class="input-daterange input-group">

                                                    <span class="input-group-addon"><i
                                                            class="fa fa-calendar bigger-110"></i></span>

                                                    <input type="text" class="form-control" readonly="readonly"
                                                           id="form-field-leaveStartDate" data-date-format="yyyy-mm-dd"
                                                           value="${weekWork.jsonObject.startDateStr}" type="text"/>
                                                    <span class="input-group-addon">
                                                            <i class="fa fa-exchange"></i>
                                                            </span>

                                                    <input type="text" class="form-control" readonly="readonly"
                                                           id="form-field-leaveEndDate" data-date-format="yyyy-mm-dd"
                                                           value="${weekWork.jsonObject.endDateStr}" type="text"/>

                                                    <span class="input-group-addon"><i
                                                            class="fa fa-calendar bigger-110"></i></span>
                                                </div>
                                            </div>
                                            <div class="col-sm-3 pull-right">
                                                <div class="btn-group pull-right">
                                                    <button class="btn btn-info btn-sm" type="button" id="addStudyRow">
                                                        <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                                        <%--<i class="ace-icon fa fa-check bigger-110"></i>--%>
                                                        新增一行
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-12">
                                        <table class="table table-striped table-bordered" id="workStudy"
                                               data-feedback="${workFeedbackVo.id}"
                                               name="workStudyList">
                                            <thead>
                                            <tr>
                                                <th class="center hide">id</th>
                                                <th class="center hide">是否删除</th>
                                                <th class="center" style="width: 10%">姓名</th>
                                                <th class="center" style="width: 18%">开始日期</th>
                                                <th class="center" style="width: 18%">截止日期</th>
                                                <th class="center" style="width: 17%">手机号</th>
                                                <th class="center" style="width: 25%">离京事由或脱产学习情况</th>
                                                <th class="center" style="width: 23%">操作</th>
                                            </tr>
                                            </thead>

                                            <tbody>
                                            <c:if test="${!empty workFeedbackVo.workStudyList}">
                                                <c:forEach items="${workFeedbackVo.workStudyList}" var="workStudy"
                                                           varStatus="status">
                                                    <tr class="workStudy" data-id="${workStudy.id}">
                                                        <td class="center hide">${workStudy.id}</td>
                                                        <td class="center hide">${workStudy.delFlag}</td>
                                                        <td class="center">${workStudy.name}</td>
                                                        <td class="center">${workStudy.jsonObject.startDateStr}</td>
                                                        <td class="center">${workStudy.jsonObject.endDateStr}</td>
                                                        <td class="center">${workStudy.phone}</td>
                                                        <td class="center">${workStudy.reason}</td>
                                                        <td class="center">
                                                            <div>
                                                                <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">
                                                                    <i class="ace-icon fa fa-pencil blue row-record-edit"></i> 编辑
                                                                </button>
                                                                <button class="btn btn-minier btn-white btn-danger row-record-delete">
                                                                    <i class="ace-icon orange fa fa-trash-o blue row-record-delete"></i> 删除
                                                                </button>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${fn:length(workFeedbackVo.workStudyList) == 0}">
                                                <tr class="empty-row">
                                                    <th style="width: 100%" colspan="6" class="center">无内容！</th>
                                                </tr>
                                            </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <div class="hr hr-18 hr-double dotted"></div>

                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <h3 align="center" style="font-weight: bold;">法定节假日局级领导带班情况</h3>
                                        </div>
                                    </div>

                                    <div class="col-xs-12">
                                        <div class="form-group">

                                            <div class="col-sm-offset-3 col-sm-6">
                                                <div class="input-daterange input-group">

                                                    <span class="input-group-addon"><i
                                                            class="fa fa-calendar bigger-110"></i></span>

                                                    <input type="text" class="form-control" readonly="readonly"
                                                           data-date-format="yyyy-mm-dd"
                                                           value="${weekWork.jsonObject.startDateStr}" type="text"/>
                                                    <span class="input-group-addon">
                                                            <i class="fa fa-exchange"></i>
                                                            </span>

                                                    <input type="text" class="form-control" readonly="readonly"
                                                           data-date-format="yyyy-mm-dd"
                                                           value="${weekWork.jsonObject.endDateStr}" type="text"/>

                                                    <span class="input-group-addon"><i
                                                            class="fa fa-calendar bigger-110"></i></span>
                                                </div>
                                            </div>
                                            <div class="col-sm-3 pull-right">
                                                <div class="btn-group pull-right">
                                                    <button class="btn btn-info btn-sm" type="button" id="addGuideRow">
                                                        <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                                        <%--<i class="ace-icon fa fa-check bigger-110"></i>--%>
                                                        新增一行
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-12">
                                        <table class="table table-striped table-bordered" id="workGuide"
                                               data-feedback="${workFeedbackVo.id}">
                                            <thead>
                                            <tr>
                                                <th class="center hide">id</th>
                                                <th class="center hide">是否删除</th>
                                                <th class="center">姓名</th>
                                                <th class="center">开始日期</th>
                                                <th class="center">截止日期</th>
                                                <th class="center">手机号</th>
                                                <th class="center" style="width: 15%">操作</th>
                                            </tr>
                                            </thead>

                                            <tbody>
                                            <c:if test="${!empty workFeedbackVo.workGuideList}">
                                                <c:forEach items="${workFeedbackVo.workGuideList}" var="workGuide"
                                                           varStatus="status">
                                                    <tr class="workGuide" data-id="${workGuide.id}">
                                                        <td class="center hide">${workGuide.id}</td>
                                                        <td class="center hide">${workGuide.delFlag}</td>
                                                        <td class="center">${workGuide.name}</td>
                                                        <td class="center">${workGuide.jsonObject.startDateStr}</td>
                                                        <td class="center">${workGuide.jsonObject.endDateStr}</td>
                                                        <td class="center">${workGuide.phone}</td>
                                                        <td class="center">
                                                            <div>
                                                                <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">
                                                                    <i class="ace-icon fa fa-pencil blue row-record-edit"></i> 编辑
                                                                </button>
                                                                <button class="btn btn-minier btn-white btn-danger row-record-delete">
                                                                    <i class="ace-icon orange fa fa-trash-o blue row-record-delete"></i> 删除
                                                                </button>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${fn:length(workFeedbackVo.workGuideList) == 0}">
                                                <tr class="empty-row">
                                                    <th style="width: 100%" colspan="5" class="center">无内容！</th>
                                                </tr>
                                            </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <div class="clearfix form-actions center">
                                    <div class="col-sm-12">
                                        <button class="btn btn-info btn-sm" type="button" id="saveBtn">
                                            <i class="ace-icon fa fa-check bigger-110"></i>
                                            保存
                                        </button>
                                        &nbsp; &nbsp; &nbsp;
                                        <button class="btn btn-success btn-sm" type="button" id="feedBackBtn">
                                            <i class="ace-icon glyphicon glyphicon-arrow-up bigger-130"></i>
                                            上报
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

<div id="addStudyRow-dialog" class="hide">
    <div class="widget-body">
        <div class="widget-main">
            <form class="form-horizontal" role="form" id="saveStudyForm" autocomplete="off">
                <div class="hidden">
                    <input type="text" id="form-field-id" name="id" value=""/>
                    <input type="text" id="form-field-feedbackId" name="workFeedback.id" value=""/>
                </div>

                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="form-study-name"> 姓名： <span
                                    class="required">*</span></label>
                            <div class="col-sm-9 ">
                                <input type="text" id="form-study-name" name="name"
                                       class="form-control" value=""/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="form-study-phone"> 手机号： <span
                                    class="required">*</span></label>

                            <div class="col-sm-9 ">
                                <input type="text" id="form-study-phone" name="phone"
                                       class="form-control" value=""/>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="form-study-startDateStr"> 开始日期：<span
                                    class="required">*</span></label>

                            <div class="col-sm-9">
                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                    <input class="form-control" name="startDateStr"
                                           id="form-study-startDateStr"
                                           value="" type="text"/>
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
                                   for="form-study-endDateStr"> 结束日期：<span
                                    class="required">*</span></label>

                            <div class="col-sm-9">
                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                    <input class="form-control" name="endDateStr"
                                           id="form-study-endDateStr"
                                           value="" type="text"/>
                                    <span class="input-group-addon">
                                                        <i class="fa fa-calendar bigger-110"></i>
                                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="hr hr-18 hr-double dotted"></div>

                <div class="row">
                    <div class="col-xs-12">
                        <div class="form-group">
                            <h3 align="center">离京事由或脱产学习情况<span class="required">*</span></h3>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="form-group">
                            <textarea id="form-study-reason" style="min-height: 150px" name="reason"
                                      class="autosize-transition form-control"></textarea>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<div id="addGuideRow-dialog" class="hide">
    <div class="widget-body">
        <div class="widget-main">
            <form class="form-horizontal" role="form" id="saveGuideForm" autocomplete="off">
                <div class="hidden">
                    <input type="text" id="form-guide-id" name="id" value=""/>
                    <input type="text" id="form-guide-feedbackId" name="workFeedback.id" value=""/>
                </div>

                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="form-guide-name"> 姓名： <span
                                    class="required">*</span></label>
                            <div class="col-sm-9 ">
                                <input type="text" id="form-guide-name" name="name"
                                       class="form-control" value=""/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="form-guide-phone"> 手机号： <span
                                    class="required">*</span></label>

                            <div class="col-sm-9 ">
                                <input type="text" id="form-guide-phone" name="phone"
                                       class="form-control" value=""/>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="form-guide-startDateStr"> 开始日期：<span
                                    class="required">*</span></label>

                            <div class="col-sm-9">
                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                    <input class="form-control" name="startDateStr"
                                           id="form-guide-startDateStr"
                                           value="" type="text"/>
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
                                   for="form-guide-endDateStr"> 结束日期：<span
                                    class="required">*</span></label>

                            <div class="col-sm-9">
                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                    <input class="form-control" name="endDateStr"
                                           id="form-guide-endDateStr"
                                           value="" type="text"/>
                                    <span class="input-group-addon">
                                                        <i class="fa fa-calendar bigger-110"></i>
                                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        // $('.input-daterange').datepicker({autoclose: true, todayHighlight: true,format: 'yyyy-mm-dd'});
        G.datepicker({autoclose: true, todayHighlight: true,format: 'yyyy-mm-dd'});

        var $saveForm = $("#saveForm");
        var $saveBtn = $("#saveBtn");
        var $feedBackBtn = $("#feedBackBtn");
        var $backBtn = $("#backBtn");

        var $addStudyRow = $("#addStudyRow");
        var $addGuideRow = $("#addGuideRow");

        //弹出框
        var $studyDialog = $("#addStudyRow-dialog");
        var $guideDialog = $("#addGuideRow-dialog");

        //表单
        var $saveStudyForm = $("#saveStudyForm");
        var $saveGuideForm = $("#saveGuideForm");
        //table
        var $workStudy = $("#workStudy");
        var $workGuide = $("#workGuide");

        //编辑变量
        var $guideId = $("#form-guide-id");
        var $feedbackId = $("#form-guide-feedbackId");
        var $guideName = $("#form-guide-name");
        var $guidePhone = $("#form-guide-phone");
        var $guideStartDateStr = $("#form-guide-startDateStr");
        var $guideEndDateStr = $("#form-guide-endDateStr");

        var $studyId = $("#form-field-id");
        var $studyFeedbackId = $("#form-field-feedbackId");
        var $studyName = $("#form-study-name");
        var $studyPhone = $("#form-study-phone");
        var $studyStartDateStr = $("#form-study-startDateStr");
        var $studyEndDateStr = $("#form-study-endDateStr");
        var $studyReason = $("#form-study-reason");

        initPage();

        function initPage() {

            //填报日期
            var $feedbackDate = $("#form-field-feedbackDate");
            if (_.isEmpty($feedbackDate.val())) {
                $feedbackDate.val('${sysDate}');
            }

            //出席情况反馈
            $saveForm.find('input[name=isAttend]').on('click',function (e) {

                var target = e.target;
                var id = $(target).attr("id");

                if (id === 'attend') {
                    $saveForm.find('input[name=reason]').prop('readonly',true).val('');
                    $("#participantsId").removeAttr('disabled');
                    $("#participantsId").rules("add", {required:true, messages:{ required:"参加人员不能为空!"}});

                } else if (id === 'offWork') {
                    $saveForm.find('input[name=reason]').prop('readonly',false);
                    $("#participantsId").attr('disabled',true).val('');
                    if ($(".error") !== undefined) {
                        $(".error").remove();
                    }

                } else {
                    //do nothing
                }
            });

            //一周工作情况反馈表单验证
            $saveForm.tjValidate({
                focusInvalid: false,
                rules: {
                    deptName: {
                        required: true
                    },
                    createName: {
                        required: true
                    },
                    phone: {
                        required: true
                    },
                    signLeader: {
                        required : true,
                        maxlength: 32
                    },
                    feedbackDateStr: {
                        required: true
                    },
                    "weekWork.meeting": {
                        required: true
                    },
                    isAttend: {
                        required: true
                    },
                    workContent: {
                        required: true
                    },
                    workSchedule: {
                        required: true
                    },
                    majorWork: {
                        required: true
                    }
                },
                messages: {
                    deptName: {
                        required: "单位名称不能为空"
                    },
                    createName: {
                        required: "填报人不能为空"
                    },
                    phone: {
                        required: "联系电话不能为空"
                    },
                    signLeader: {
                        required: "签发领导不能为空"
                    },
                    feedbackDateStr: {
                        required: "报送日期不能为空"
                    },
                    "weekWork.meeting": {
                        required: "综合处长会议不能为空"
                    },
                    isAttend: {
                        required: "出席情况反馈不能为空"
                    },
                    workContent: {
                        required: "本周工作开展情况不能为空"
                    },
                    workSchedule: {
                        required: "下周工作安排不能为空"
                    },
                    majorWork: {
                        required: "近期重点工作不能为空"
                    }
                }
            });
            $("#participantsId").rules("add", {required:true, messages:{ required:"参加人员不能为空!"}});
        }

        //保存点击事件绑定
        $saveBtn.unbind('click').bind('click', function () {
            $("#status").val("0");
            save('保存', $saveBtn);
        });

        //反馈点击事件绑定
        $feedBackBtn.unbind('click').bind('click', function () {

            $("#status").val("1");
            save('反馈', $feedBackBtn);
        });

        //返回点击事件绑定
        $backBtn.unbind('click').bind('click', function () {
            G.back();
        });

        //保存方法
        function save(type, $btn) {
            if ($saveForm.validate().form()) {
                var loadId = G.showAjaxLoading("保存中，请稍候...");
                $btn.prop("disabled", true);
                $saveForm.ajaxSubmit({
                    success: function (map) {
                        if (map.result) {
                            G.doneAjaxLoading(loadId);
                            G.showGritterSuccess(type + "成功!");
                            //保存成功或者上报成功跳转到反馈页面
                            var feedbackViewUrl = '#page/work-feedback/load-feedback-list';
                            var id = map.id;
                            var feedbackDeptId = map.feedbackDeptId;
                            G.pjaxLoadPageContentDiv(feedbackViewUrl + "?id=" + id + '&feedbackDeptId=' + feedbackDeptId + '&date=' + new Date().getTime());
                        } else {
                            G.showGritterFail(type + "失败,请稍后重试!");
                            $btn.prop("disabled", false);
                        }
                    }
                });
            }
        }

        //新增一行局级领导离京和脱产学习情况
        $addStudyRow.unbind('click').bind('click', function () {

            var feedbackId = $workStudy.data('feedback');
            //赋值
            $saveStudyForm.find("input[name='workFeedback.id']").val(feedbackId);
            var addFlag = "add";
            initStudyDialog($studyDialog,addFlag,null);
        });

        //编辑一行局级领导离京和脱产学习情况
        $("#workStudy").on('click', '.row-record-edit', function (e) {
            e.preventDefault();
            var editFlag = "edit";
            var id_ = $(e.target).closest('tr').data('id');
            var editUrl = "${basePath}/work-feedback/edit-workStudy.do";
            if ($saveGuideForm.validate().form()) {
                var loadId = G.showAjaxLoading();
                $.ajax({
                    type: 'post',
                    dataType: 'json',
                    url: editUrl,
                    data: {id: id_},
                    async: true
                }).done(function (map) {
                    G.doneAjaxLoading(loadId);
                    if (map.result) {
                        //填充值
                        var workStudy = map.workStudy;
                        $studyId.val(workStudy.id);
                        $studyFeedbackId.val(map.sWorkFeedbackId);
                        $studyName.val(workStudy.name);
                        $studyPhone.val(workStudy.phone);
                        $studyStartDateStr.val(workStudy.startDateStr);
                        $studyEndDateStr.val(workStudy.endDateStr);
                        $studyReason.val(workStudy.reason);
                        initStudyDialog($studyDialog,editFlag,e);
                    }
                });
            }
        });

        //初始化局级领导离京和脱产学习情况弹出框
        function initStudyDialog($container,flag,e) {

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 500,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>新增/编辑局级领导离京和脱产学习情况</h4></div>",
                title_html: true,
                close: function () {
                    //重置表单
                    $saveStudyForm.resetForm();
                    //关闭弹出框
                    $container.addClass("hide");
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-warning",
                        click: function () {
                            $container.dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 保存",
                        "class": "btn btn-success",
                        click: function () {
                            var postData = $saveStudyForm.serializeObject();
                            //保存数据
                            saveStudy(postData, $container,flag,e);
                        }
                    }
                ]
            });

        }

        //保存局级领导离京和脱产学习情况
        function saveStudy(postData, $container,flag,e) {

            var saveUrl = '${basePath}/work-feedback/save-workStudy.do';

            if ($saveStudyForm.validate().form()) {
                var loadId = G.showAjaxLoading();
                $.ajax({
                    type: 'post',
                    dataType: 'json',
                    url: saveUrl,
                    data: postData,
                    async: true
                }).done(function (map) {
                    G.doneAjaxLoading(loadId);
                    if (map.result) {
                        if (flag == 'add'){
                            G.showGritterSuccess("已添加");
                            //表格新增一行
                            addStudyRow(map.workStudy);
                        } else {
                            G.showGritterSuccess("已编辑");
                            $(e.target).closest('tr').remove();
                            //表格新增一行
                            addStudyRow(map.workStudy);
                        }
                        $container.dialog("close");
                    } else {
                        G.showGritterFail("保存失败，请稍后重试!");
                    }
                });
            }
        }

        //表格新增一行
        function addStudyRow(workStudy) {

            var $container = $workStudy.find('tbody');

            $container.find('.empty-row').remove();

            var array = [];

            array.push('<tr class="workStudy" data-id="'+ workStudy.id +'">                    ');
            array.push('    <td class="center hide">'+ workStudy.id +'</td>                    ');
            array.push('    <td class="center hide">'+ workStudy.delFlag +'</td>               ');
            array.push('    <td class="center">'+ workStudy.name +'</td>                       ');
            array.push('    <td class="center">'+ workStudy.startDateStr +'</td>    ');
            array.push('    <td class="center">'+ workStudy.endDateStr +'</td>      ');
            array.push('    <td class="center">'+ workStudy.phone +'</td>                      ');
            array.push('    <td class="center">'+ workStudy.reason +'</td>                     ');
            array.push('    <td class="center">                                             ');
            array.push('      <div>                                                       ');
            array.push('        <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
            array.push('            <i class="ace-icon fa fa-pencil blue row-record-edit"></i>                    ');
            array.push('            编辑                                                      ');
            array.push('        </button>                                                   ');
            array.push('        <button class="btn btn-minier btn-white btn-danger row-record-delete">');
            array.push('            <i class="ace-icon orange fa fa-trash-o blue row-record-delete"></i>                    ');
            array.push('            删除                                                      ');
            array.push('        </button>                                                   ');
            array.push('      </div>                                                           ');
            array.push('    </td>                                                           ');
            array.push('</tr>                                                               ');

            $container.append(array.join(''));
        }

        //新增一行法定节假日局级领导带班情况
        $addGuideRow.unbind('click').bind('click', function () {
            var feedbackId = $workGuide.data("feedback");
            $saveGuideForm.find("input[name='workFeedback.id']").val(feedbackId);
            var addFlag = "add";
            initGuideDialog($guideDialog,addFlag,null);
        });

        //编辑一行法定节假日局级领导带班情况
        $("#workGuide").on('click', '.row-record-edit', function (e) {
            e.preventDefault();
            var editFlag = "edit";
            var id = $(e.target).closest('tr').data('id');
            var editUrl = "${basePath}/work-feedback/edit-workGuide.do";
            if ($saveGuideForm.validate().form()) {
                var loadId = G.showAjaxLoading();
                $.ajax({
                    type: 'post',
                    dataType: 'json',
                    url: editUrl,
                    data: {id: id},
                    async: true
                }).done(function (map) {
                    G.doneAjaxLoading(loadId);
                    if (map.result) {
                        //填充值
                        var workGuide = map.workGuide;
                        $guideId.val(workGuide.id);
                        $feedbackId.val(map.workFeedbackId);
                        $guideName.val(workGuide.name);
                        $guidePhone.val(workGuide.phone);
                        $guideStartDateStr.val(workGuide.startDateStr);
                        $guideEndDateStr.val(workGuide.endDateStr);
                        initGuideDialog($guideDialog,editFlag,e);
                    }
                });
            }
        });

        //初始化法定节假日局级领导带班情况弹出框
        function initGuideDialog($container,flag,e) {
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 500,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>新增/编辑局级领导离京和脱产学习情况</h4></div>",
                title_html: true,
                close: function () {
                    //重置表单
                    $saveGuideForm.resetForm();
                    //关闭弹出框
                    $container.addClass("hide");
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-warning",
                        click: function () {
                            $container.dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 保存",
                        "class": "btn btn-success",
                        click: function () {
                            var postData = $saveGuideForm.serializeObject();
                            //保存数据
                            saveGuide(postData, $container,flag,e);
                        }
                    }
                ]
            });
        }

        //保存法定节假日局级领导带班情况
        function saveGuide(postData,$container,flag,e) {

            var saveUrl = '${basePath}/work-feedback/save-workGuide.do';

            if ($saveGuideForm.validate().form()) {
                var loadId = G.showAjaxLoading();
                $.ajax({
                    type: 'post',
                    dataType: 'json',
                    url: saveUrl,
                    data: postData,
                    async: true
                }).done(function (map) {
                    G.doneAjaxLoading(loadId);
                    if (map.result) {
                        if (flag == "add"){
                            G.showGritterSuccess("已添加");
                            //表格新增一行
                            addGuideRow(map.workGuide);
                        }else {
                            G.showGritterSuccess("已修改");
                            $(e.target).closest('tr').remove();
                            //表格新增一行
                            addGuideRow(map.workGuide);
                        }
                        $container.dialog("close");
                    } else {
                        G.showGritterFail("保存失败，请稍后重试!");
                    }
                });
            }
        }

        ////表格新增一行
        function addGuideRow(workGuide) {

            var $container = $workGuide.find('tbody');
            $container.find('.empty-row').remove();

            var array = [];

            array.push('<tr class="workStudy" data-id="'+ workGuide.id +'">                    ');
            array.push('    <td class="center hide">'+ workGuide.id +'</td>                    ');
            array.push('    <td class="center hide">'+ workGuide.delFlag +'</td>               ');
            array.push('    <td class="center">'+ workGuide.name +'</td>                       ');
            array.push('    <td class="center">'+ workGuide.startDateStr +'</td>    ');
            array.push('    <td class="center">'+ workGuide.endDateStr +'</td>      ');
            array.push('    <td class="center">'+ workGuide.phone +'</td>                      ');
            array.push('    <td class="center">                                             ');
            array.push('      <div>                                                       ');
            array.push('        <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
            array.push('            <i class="ace-icon fa fa-pencil blue row-record-edit"></i>                    ');
            array.push('            编辑                                                      ');
            array.push('        </button>                                                   ');
            array.push('        <button class="btn btn-minier btn-white btn-danger row-record-delete">');
            array.push('            <i class="ace-icon orange fa fa-trash-o blue row-record-delete"></i>                    ');
            array.push('            删除                                                      ');
            array.push('        </button>                                                   ');
            array.push('      </div>                                                           ');
            array.push('    </td>                                                           ');
            array.push('</tr>                                                               ');

            $container.append(array.join(''));
        }

        //删除一行局级领导离京和脱产学习情况
        $("#workStudy").on('click', '.row-record-delete', function (e) {

            e.preventDefault();
            var id = $(e.target).closest('tr').data('id');
            var deleteUrl = '';

            if (!_.isEmpty(id)) {

                deleteUrl = '${basePath}/week-work/work-study-delete.do';
                deleteByUrl(e, deleteUrl, id);
            } else {
                $(e.target).closest('tr').remove();
            }
        });

        //删除一行法定节假日局级领导带班情况
        $("#workGuide").on('click', '.row-record-delete', function (e) {

            e.preventDefault();
            var id = $(e.target).closest('tr').data('id');
            var deleteUrl = '';

            if (!_.isEmpty(id)) {

                deleteUrl = '${basePath}/week-work/work-guide-delete.do';
                deleteByUrl(e, deleteUrl, id);
            } else {
                $(e.target).closest('tr').remove();
            }
        });

        //删除方法
        function deleteByUrl(e, url, id) {

            G.confirm({
                message: '确认删除此条信息吗？',
                callback: function (result) {
                    if (result) {
                        $.post(url, {id: id}, function (data) {
                            if (data.result) {
                                G.showGritterSuccess("删除成功!");
                                $(e.target).closest('tr').remove();
                            } else {
                                G.showGritterFail("删除失败!")
                            }
                        });
                    }
                }
            });
        }

        //局级领导离京和脱产学习情况form表单校验
        $saveStudyForm.tjValidate({
            focusInvalid: false,
            rules: {
                name: {
                    required: true
                },
                phone: {
                    required: true
                },
                startDateStr: {
                    required: true
                },
                endDateStr: {
                    required: true,
                    compareDate : '#form-study-startDateStr'
                },
                reason: {
                    required: true
                }
            },
            messages: {
                name: {
                    required: "姓名不能为空"
                },
                phone: {
                    required: "手机号不能为空"
                },
                startDateStr: {
                    required: "开始日期不能为空"
                },
                endDateStr: {
                    required: "截止日期不能为空"
                },
                reason: {
                    required: "离京事由或脱产学习情况不能为空"
                }
            }
        });

        //法定节假日局级领导带班情况
        $saveGuideForm.tjValidate({
            focusInvalid: false,
            rules: {
                name: {
                    required: true
                },
                phone: {
                    required: true
                },
                startDateStr: {
                    required: true
                },
                endDateStr: {
                    required: true,
                    compareDate : '#form-guide-startDateStr'
                }
            },
            messages: {
                name: {
                    required: "姓名不能为空"
                },
                phone: {
                    required: "手机号不能为空"
                },
                startDateStr: {
                    required: "开始日期不能为空"
                },
                endDateStr: {
                    required: "截止日期不能为空"
                }
            }
        });



        $(document).one('ajaxloadstart.page', function (e) {
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });


    });
</script>

