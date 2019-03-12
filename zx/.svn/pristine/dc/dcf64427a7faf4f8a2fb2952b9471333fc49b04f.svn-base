<%--
  Created by IntelliJ IDEA.
  User: yingji
  Date: 2018/6/29
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
<div class="row">
    <div class="col-xs-10 col-sm-offset-1">
        <div class="widget-box transparent">
            <div class="widget-body">
                <div class="widget-main">
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" id="new-edit-form" role="form" method="post">
                                <input id="id-come-info" name="id" type="hidden" value="${comeInfo.id}">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 30px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${comeInfo.id eq null}"> 来访信息新增</c:when>
                                                    <c:otherwise> 来访信息编辑</c:otherwise>
                                                </c:choose></h1>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin-top: 15px">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-sponsorId">主办单位：<span
                                                    class="red">*</span></label>

                                            <div class="col-sm-8 deptDiv">
                                                <input type="text" id="form-field-sponsorId" name="sponsorId"
                                                       class="hide" value=""/>
                                                <input type="text" class="form-control" id="form-field-deptName"
                                                       name="deptName" value="" style="cursor: pointer;" readonly/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-invitationId">邀请名义：<span
                                                    class="red">*</span></label>

                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-invitationId" name="invitationId">
                                                    <option value="">---------请选择---------</option>
                                                    <c:forEach items="${inviteList}" var="invite">
                                                        <option value="${invite.id}" <c:if test="${comeInfo.invitation.id eq invite.id}">selected</c:if>>${invite.name}</option>
                                                        <%--<c:if test="${invite.id eq currentUser.dicDept.id and dept.id ne '434'}">selected</c:if>--%>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-groupNumber">团组编号：<span
                                                    class="red">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-groupNumber" name="groupNumber"
                                                       class="form-control " value="${comeInfo.groupNumber}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-groupName">团组名称：<span
                                                    class="red">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-groupName" name="groupName"
                                                       class="form-control " value="${comeInfo.groupName}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-groupLevelId">团组级别：<span
                                                    class="red">*</span></label>

                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-groupLevelId" name="groupLevelId">
                                                    <option value="">---------请选择---------</option>
                                                    <c:forEach items="${levelList}" var="level">
                                                        <option value="${level.id}"  <c:if test="${comeInfo.groupLevel.id eq level.id}">selected</c:if> >${level.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-countryId">来访团国家：<span
                                                    class="red">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-countryId" name="countryId"
                                                       class="form-control " value="${comeInfo.countryId}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-peopleNum">来访团人数：<span
                                                    class="red">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-peopleNum" name="peopleNum"
                                                       class="form-control " value="${comeInfo.peopleNum}"/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label">日期：<span
                                                    class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <div class="input-daterange input-group">
                                                    <input class="form-control date-picker"
                                                           name="startDateStr"
                                                           id="form-field-startDate"
                                                           data-date-format="yyyy-mm-dd"
                                                           value="${comeInfo.jsonObject.startDateStr}"
                                                           placeholder="开始日期" type="text"/>
                                                    <span class="input-group-addon"><i
                                                            class="fa fa-calendar bigger-110"></i></span>
                                                    <input class="form-control date-picker"
                                                           name="endDateStr"
                                                           id="form-field-endDate"
                                                           data-date-format="yyyy-mm-dd"
                                                           value="${comeInfo.jsonObject.endDateStr}"
                                                           placeholder="结束日期" type="text"/>
                                                    <span class="input-group-addon"><i
                                                            class="fa fa-calendar bigger-110"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-cnName">团长中文名：<span
                                                    class="red">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-cnName" name="cnName"
                                                       class="form-control " value="${comeInfo.cnName}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-foreignName">团长外文名：<span
                                                    class="red">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-foreignName" name="foreignName"
                                                       class="form-control " value="${comeInfo.foreignName}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="form-field-taskDscr">任务描述：<span
                                                    class="red">*</span></label>

                                            <div class="col-sm-10 " style="padding-left: 12px;padding-right: 13px;">
                                        <textarea class="form-control limited"
                                                  id="form-field-taskDscr"
                                                  name="taskDscr"
                                                  style="min-height: 100px;">${comeInfo.taskDscr}</textarea>
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

        $('.input-daterange').datepicker({
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayHighlight: true
            }
        );

        G.initDept('deptDiv',true,['${dicDept}'],TREE_NODE);

        // 控件类全局变量
        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");

        // 表单类全局变量
        var $saveForm = $("#new-edit-form");

        var editUrl = '${basePath}/come/come-info-save.do';

        $saveBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var data = $saveForm.serializeObject();
            if ($saveForm.validate().form()) {
                G.confirm({
                    message: '确认保存此条来访管理信息吗？',
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
                                    G.showGritterSuccess("保存成功!");
                                    G.pjaxLoadPageContentDiv('#page/come/come-info-list');
                                } else {
                                    G.doneAjaxLoading(loadId);
                                    G.showGritterFail("保存失败,请稍后重试!");
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
                deptName: {
                    required: true
                },
                invitationId: {
                    required: true
                },
                groupNumber: {
                    required: true
                },
                groupName: {
                    required: true
                },
                groupLevelId: {
                    required: true
                },
                countryId: {
                    required: true
                },
                peopleNum: {
                    required: true
                },
                startDateStr: {
                    required: true
                },
                endDateStr: {
                    required: true
                },
                cnName: {
                    required: true
                },
                foreignName: {
                    required: true
                },
                taskDscr: {
                    required: true
                }

            },
            messages: {
                deptName: {
                    required: "主办单位不能为空"
                },
                invitationId: {
                    required: "邀请名义不能为空"
                },
                groupNumber: {
                    required: "团组编号不能为空"
                },
                groupName: {
                    required: "团组名称不能为空"
                },
                groupLevelId: {
                    required: "团组级别不能为空"
                },
                countryId: {
                    required: "来访团国家不能为空"
                },
                peopleNum: {
                    required: "来访团人数不能为空"
                },
                startDateStr: {
                    required: "开始日期不能为空"
                },
                endDateStr: {
                    required: "结束日期不能为空"
                },
                cnName: {
                    required: "团长中文名不能为空"
                },
                foreignName: {
                    required: "团长外文名不能为空"
                },
                taskDscr: {
                    required: "任务描述不能为空"
                }
            }
        });

        $backBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var url = '#page/come/come-info-list';

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
                    message: "您有来访管理信息未保存，确认退出吗？",
                    callback: function (result) {
                        if (result) {
                            G.pjaxLoadPageContentDiv(url);
                        }
                    }
                });
            }

        });
    });
</script>