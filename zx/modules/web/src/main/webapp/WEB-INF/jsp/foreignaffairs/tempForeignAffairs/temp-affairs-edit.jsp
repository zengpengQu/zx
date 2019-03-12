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
                            <form class="form-horizontal" id="tempAffairsForm" role="form" autocomplete="off"
                                  method="post">
                                <input id="tempAffairsId" name="id" type="hidden" value="${tempAffairs.id}">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 30px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${tempAffairs.id eq null}"> 临时外事活动新增</c:when>
                                                    <c:otherwise> 临时外事活动编辑</c:otherwise>
                                                </c:choose></h1>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-groupNumber">团组编号：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-groupNumber" name="groupNumber"
                                                       class="form-control " value="${tempAffairs.groupNumber}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-groupName">团组名称：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-groupName" name="groupName"
                                                       class="form-control " value="${tempAffairs.groupName}"/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-attendLeader">出席领导：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-attendLeader" name="attendLeader"
                                                       class="form-control " value="${tempAffairs.attendLeader}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-groupLevelId">团组级别：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-groupLevelId"
                                                        name="groupLevelId">
                                                    <option value="">---------请选择---------</option>
                                                    <c:forEach items="${dicParamList}" var="dicParam">
                                                        <option value="${dicParam.id}"
                                                                <c:if test="${tempAffairs.dicParam.id eq dicParam.id}">selected</c:if> >${dicParam.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-activityType">活动类型：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-activityType" name="activityType"
                                                       class="form-control " value="${tempAffairs.activityType}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-sponsorId">主办单位：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 deptDiv">
                                                <input type="text" id="form-field-sponsorId" name="sponsorId"
                                                       class="hide" value=""/>
                                                <input type="text" class="form-control" id="form-field-deptName"
                                                       name="deptName" value="" style="cursor: pointer;" readonly/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-accompany">陪同人员：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-accompany" name="accompany"
                                                       class="form-control " value="${tempAffairs.accompany}"
                                                       placeholder="多人请用逗号隔开"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-activityTime">活动时间：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="activityTime"
                                                           id="form-field-activityTime"
                                                           value="${tempAffairs.jsonObject.activityTime}" type="text"/>
                                                    <span class="input-group-addon">
                                                    <i class="fa fa-calendar bigger-110"></i>
                                                </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-activitySite">活动地点：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-activitySite" name="activitySite"
                                                       class="form-control " value="${tempAffairs.activitySite}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-feteSite">宴请地点：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-feteSite" name="feteSite"
                                                       class="form-control " value="${tempAffairs.feteSite}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-newsOrg">新闻单位：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-newsOrg" name="newsOrg"
                                                       class="form-control " value="${tempAffairs.newsOrg}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-chinese"
                                                   style="padding-left: 0px;padding-right: 0px;text-align: left">我方出席人员：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-chinese" name="chinese"
                                                       class="form-control " value="${tempAffairs.chinese}"
                                                       placeholder="多人请用逗号隔开"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-foreigner"
                                                   style="padding-left: 0px;padding-right: 0px;text-align: left">外方出席人员：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-foreigner" name="foreigner"
                                                       class="form-control " value="${tempAffairs.foreigner}"
                                                       placeholder="多人请用逗号隔开"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-contacts">联系人：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-contacts" name="contacts"
                                                       class="form-control " value="${tempAffairs.contacts}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-contactsTel"
                                                   style="padding-left: 0px;">联系人电话：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-contactsTel" name="contactsTel"
                                                       class="form-control " value="${tempAffairs.contactsTel}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12 ">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="form-field-activityContent"
                                                   style="padding-left: 0px;width: 11%">活动内容：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-10" style="width: 89%">
                                            <textarea class="form-control limited" id="form-field-activityContent"
                                                      name="activityContent" maxlength="200"
                                                      style="min-height: 100px;">${tempAffairs.activityContent}</textarea>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12 ">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="form-field-notes"
                                                   style="padding-left: 0px;padding-right: 0px;width: 11%">备注：<span
                                                    class="required">&nbsp;</span></label>
                                            <div class="col-sm-10" style="width: 89%">
                                            <textarea class="form-control limited" id="form-field-notes"
                                                      name="notes" maxlength="200"
                                                      style="min-height: 100px;">${tempAffairs.notes}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="btn-group pull-right" style="margin-bottom: 5px">
                                            <button class="btn btn-sm btn-primary" type="button" id="addChronicleBtn">
                                                增行
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12 ">
                                        <label class="col-sm-2 control-label" style="width: 11%;text-align: center">大事记：<span
                                                class="required">*</span></label>

                                        <div class="col-sm-10" style="width: 89%;padding-left: 0px;padding-right: 0px;">
                                            <table id="simple-table" class="table table-striped table-bordered">
                                                <thead>
                                                <tr>
                                                    <th class="hide">id</th>
                                                    <th class="center" style="width:30%;">内容</th>
                                                    <th class="center" style="width:15%;">开始时间</th>
                                                    <th class="center" style="width:15%;">结束时间</th>
                                                    <th class="center" style="width:30%;">备注</th>
                                                    <th class="center" style="width:10%;">操作</th>
                                                </tr>
                                                </thead>

                                                <tbody id="chronicleTBody">
                                                <c:if test="${tempAffairs.id ne null}">
                                                    <c:forEach items="${tempAffairs.chronicleList}"
                                                               var="chronicle">
                                                        <tr class="chronicleTr" data-item={"id":"${chronicle.id}"}>
                                                            <td class="hide chronicleId">${chronicle.id}</td>
                                                            <td class="left-align tempAffairsContent"
                                                                data-id="content">${chronicle.content}</td>
                                                            <td class="center tempAffairsContentBeginTimeStr" style="vertical-align: middle"
                                                                data-id="beginTime">${chronicle.jsonObject.beginTimeStr}</td>
                                                            <td class="center tempAffairsContentEndTimeStr" style="vertical-align: middle;"
                                                                data-id="endTime">${chronicle.jsonObject.endTimeStr}</td>
                                                            <td class="left-align tempAffairsContentNotes"
                                                                data-id="notes">${chronicle.notes}</td>
                                                            <td class="center" style="vertical-align: middle">
                                                                <i class="ace-icon blue fa fa-pencil-square-o row-record-edit bigger-150"
                                                                   style="cursor: pointer;" title="编辑"></i>&nbsp;
                                                                <i class="ace-icon red fa fa-trash-o row-record-delete bigger-150"
                                                                    style="cursor: pointer;" title="删除"></i>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" style="padding-left: 0px;width: 11%">
                                                上传附件：<span class="required">&nbsp;</span>
                                            </label>
                                            <div class="col-sm-10">
                                                <input id="message-file" type="file"/>
                                                <div id="message-file-queue"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="form-group" id="uploadedDiv">
                                                <div class="col-sm-11 pull-right">
                                                    <span id="download-file"></span>
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

<div id="chronicle-dialog" class="hidden">
    <form id="chronicleForm" autocomplete="off" role="form">
        <div class="hidden">
            <input type="text" id="id" name="id"/>
        </div>
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right">开始时间：<span
                            class="required">*</span></label>

                    <div class="col-sm-8 ">
                        <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                            <input class="form-control" name="beginTime" id="beginTime"
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
                    <label class="col-sm-4 control-label text-right">结束时间：<span
                            class="required">*</span></label>

                    <div class="col-sm-8">
                        <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                            <input class="form-control" name="endTime" id="endTime"
                                   type="text"/>
                            <span class="input-group-addon">
                            <i class="fa fa-calendar bigger-110"></i>
                        </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>

        <div class="row">
            <div class="col-xs-12 ">
                <label class="col-sm-2 control-label" for="form-field-activityContent"
                       style="text-align: right">内容：<span
                        class="required">*</span></label>

                <div class="col-sm-10">
                    <textarea class="form-control limited" id="content"
                              name="content" maxlength="2000"
                              style="min-height: 100px;"></textarea>
                </div>

            </div>
        </div>
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12 ">
                <label class="col-sm-2 control-label" for="form-field-notes"
                       style="text-align: right">备注：<span
                        class="required">&nbsp;</span></label>
                <div class="col-sm-10">
                    <textarea class="form-control limited" id="notes"
                              name="notes" maxlength="500"
                              style="min-height: 100px;"></textarea>
                </div>
            </div>
        </div>
    </form>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.datepicker({
            todayHighlight: true,
            autoclose: true
        });

        G.initDept('deptDiv', true, ['${dicDept}'], TREE_NODE);

        var uploadUrl = '${basePath}/file/upload-file.do';

        //文件上传全局变量
        var $messageFile = $('#message-file');
        var $messageFileQueue = $('#message-file-queue');
        var $downLoadFile = $("#download-file");

        var $chronicleTBody = $('#chronicleTBody');
        var $addChronicleBtn = $('#addChronicleBtn');
        var $chronicleDialog = $('#chronicle-dialog');
        var $chronicleForm = $('#chronicleForm');
        var $beginTime = $('#beginTime');
        var $endTime = $('#endTime');
        var $chronicleNotes = $("#notes");
        var $chronicleContent = $("#content");
        var $Id = $("#id");

        $addChronicleBtn.click(function (e) {
            e.preventDefault();
            initEditDialog("add");
        });
        function initEditDialog(type,tr) {
            $chronicleDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>大事记</h4></div>",
                title_html: true,
                close: function () {
                    $chronicleForm.resetForm();
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn",
                        click: function () {
                            $(this).dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 添加",
                        "class": "btn btn-success",
                        click: function () {
                            var $this = $(this);
                            if ($chronicleForm.validate().form()) {
                                var beginTime = moment($beginTime.val(), 'YYYY-MM-DD').toDate();
                                var endTime = moment($endTime.val(), 'YYYY-MM-DD').toDate();
                                if (beginTime > endTime) {
                                    G.alert({message: '结束时间应大于等于开始时间！'});
                                } else {
                                    var data = $chronicleForm.serializeObject();
                                        data.json = JSON.stringify(data);
                                        appendLine(data,type,tr);
                                        $this.dialog('close');

                                }
                            }
                        }
                    }
                ]
            });
        }

        function appendLine(data,type,tr) {
            if(type != "add"){
                tr.remove();
                var html = '<tr class="chronicleTr" data-item ="{{json}}">' +
                    ' <td class="hide chronicleId" data-id="id">'+data.id+'</td>' +
                    '<td class="tempAffairsContent" style="text-align:left" data-id="content">'+data.content+'</td>' +
                    '<td class="tempAffairsContentBeginTimeStr" style="text-align:center" data-id="beginTime">'+data.beginTime+'</td>' +
                    '<td class="tempAffairsContentEndTimeStr" style="text-align:center" data-id="endTime">'+data.endTime+'</td>' +
                    '<td class="tempAffairsContentNotes" style="text-align:left" data-id="notes">'+data.notes+'</td>' +
                    '<td style="text-align:center">' +
                    '<i class="ace-icon blue fa fa-pencil-square-o row-record-edit bigger-150" style="cursor: pointer;" title="编辑"></i>&nbsp;' +
                    '<i class="ace-icon red fa fa-trash-o row-record-delete bigger-150" style="cursor: pointer;" title="删除"></i></td>' +
                    '</tr>';
                var temp = Handlebars.compile(html);
                var view = temp(data);
                $chronicleTBody.append(view)
            }else {
                var html = '<tr class="chronicleTr" data-item ="{{json}}">' +
                    '<td class="hide chronicleId">{{chronicle.id}}</td>' +
                    '<td class="tempAffairsContent" style="text-align:left" data-id="content">{{content}}</td>' +
                    '<td class="tempAffairsContentBeginTimeStr" style="text-align:center" data-id="beginTime">{{beginTime}}</td>' +
                    '<td class="tempAffairsContentEndTimeStr" style="text-align:center" data-id="endTime">{{endTime}}</td>' +
                    '<td class="tempAffairsContentNotes" style="text-align:left" data-id="notes">{{notes}}</td>' +
                    '<td style="text-align:center">' +
                    '<i class="ace-icon blue fa fa-pencil-square-o row-record-edit bigger-150" style="cursor: pointer;" title="编辑"></i>&nbsp;' +
                    '<i class="ace-icon red fa fa-trash-o row-record-delete bigger-150" style="cursor: pointer;" title="删除"></i></td>' +
                    '</tr>';
                var temp = Handlebars.compile(html);
                var view = temp(data);
                $chronicleTBody.append(view);
            }
        }
        $chronicleForm.tjValidate({
            focusInvalid: true,
            rules: {
                content: {required: true},
                beginTime: {required: true},
                endTime: {required: true}
            },
            messages: {
                content: {required: "内容必须填写"},
                beginTime: {required: "开始时间必须填写"},
                endTime: {required: "结束时间必须填写"}
            }
        });



        var $tempAffairsForm = $('#tempAffairsForm');
        var $tempAffairsId = $('#tempAffairsId');
        var $groupNumber = $('#form-field-groupNumber');
        var $groupName = $('#form-field-groupName');
        var $attendLeader = $('#form-field-attendLeader');
        var $groupLevelId = $('#form-field-groupLevelId');
        var $activityType = $('#form-field-activityType');
        var $sponsorId = $('#form-field-sponsorId');
        var $accompany = $('#form-field-accompany');
        var $activityTime = $('#form-field-activityTime');
        var $activitySite = $('#form-field-activitySite');
        var $feteSite = $('#form-field-feteSite');
        var $newsOrg = $('#form-field-newsOrg');
        var $chinese = $('#form-field-chinese');
        var $foreigner = $('#form-field-foreigner');
        var $contacts = $('#form-field-contacts');
        var $contactsTel = $('#form-field-contactsTel');
        var $activityContent = $('#form-field-activityContent');
        var $notes = $('#form-field-notes');

        function
        getAllTempAffairsData() {
            var tempAffairsData = {};
            var dicParam = {};
            var dicDept = {};
            var chronicleArray = [];
            var tempAffairsFile = {};
            var fileIds = JSON.stringify(getFileListArray($messageFileQueue));
            tempAffairsData.id = $tempAffairsId.val();
            tempAffairsData.groupNumber = $groupNumber.val();
            tempAffairsData.groupName = $groupName.val();
            tempAffairsData.attendLeader = $attendLeader.val();
            tempAffairsData.activityType = $activityType.val();
            tempAffairsData.accompany = $accompany.val();
            tempAffairsData.activityTime = $activityTime.val();
            tempAffairsData.activitySite = $activitySite.val();
            tempAffairsData.feteSite = $feteSite.val();
            tempAffairsData.newsOrg = $newsOrg.val();
            tempAffairsData.chinese = $chinese.val();
            tempAffairsData.foreigner = $foreigner.val();
            tempAffairsData.contacts = $contacts.val();
            tempAffairsData.contactsTel = $contactsTel.val();
            tempAffairsData.activityContent = $activityContent.val();
            tempAffairsData.notes = $notes.val();
            tempAffairsData.fileIds = fileIds;

            dicParam.id = $groupLevelId.val();
            tempAffairsData.dicParam = dicParam;
            dicDept.id = $sponsorId.val();
            tempAffairsData.dicDept = dicDept;

            $chronicleTBody.find('tr[class="chronicleTr"]').each(function () {
                var $tr = $(this);
                var chronicleData = $tr.data('item');
                chronicleData['tempAffairs'] = {};
                chronicleData['tempAffairs']['id'] = $tempAffairsId.val();
                if (chronicleData) {
                    chronicleArray.push(chronicleData);
                }
            });

            tempAffairsData.chronicleList = chronicleArray;

            return tempAffairsData;
        }

        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");

        var saveUrl = '${basePath}/temp-affairs/temp-affairs-save.do';

        $saveBtn.unbind('click').bind('click', function (e) {
            if ($tempAffairsForm.validate().form()) {
                var data = getAllTempAffairsData();

                $saveBtn.prop("disabled", true);
                $backBtn.prop("disabled", true);
                G.confirm({
                    message: '确认保存此条临时外事活动信息吗？',
                    callback: function (result) {
                        if (result) {
                            var loadId = G.showAjaxLoading();
                            $.ajax({
                                url: saveUrl,
                                type: 'POST',
                                dataType: 'json',
                                data: JSON.stringify(data),
                                contentType: "application/json;charset=utf-8",
                                async: true
                            }).done(function (map) {
                                G.doneAjaxLoading(loadId);
                                if (map.result == true) {
                                    G.showGritterSuccess("保存成功!");
                                    G.pjaxLoadPageContentDiv('#page/temp-affairs/temp-affairs-list');
                                } else if (map.result == 'empty') {
                                    G.showGritterFail("请添加大事记!");
                                    $saveBtn.prop("disabled", false);
                                    $backBtn.prop("disabled", false);
                                } else {
                                    G.showGritterFail("保存失败!");
                                    $saveBtn.prop("disabled", false);
                                    $backBtn.prop("disabled", false);
                                }
                            });
                        } else {
                            $saveBtn.prop("disabled", false);
                            $backBtn.prop("disabled", false);
                        }
                    }
                });
            }
        });

        $tempAffairsForm.tjValidate({
            focusInvalid: true,
            rules: {
                groupNumber: {required: true},
                groupName: {required: true},
                attendLeader: {required: true},
                groupLevelId: {required: true},
                activityType: {required: true},
                deptName: {required: true},
                accompany: {required: true},
                activityTime: {required: true},
                activitySite: {required: true},
                feteSite: {required: true},
                newsOrg: {required: true},
                chinese: {required: true},
                foreigner: {required: true},
                contacts: {required: true},
                contactsTel: {required: true, maxlength: 20},
                activityContent: {required: true}
            },
            messages: {
                groupNumber: {required: "团组编号必须填写"},
                groupName: {required: "团组名称必须填写"},
                attendLeader: {required: "出席领导必须填写"},
                groupLevelId: {required: "团组级别必须选择"},
                activityType: {required: "活动类型必须填写"},
                deptName: {required: "主办单位必须选择"},
                accompany: {required: "陪同人员必须填写"},
                activityTime: {required: "活动时间必须填写"},
                activitySite: {required: "活动地点必须填写"},
                feteSite: {required: "宴请地点必须填写"},
                newsOrg: {required: "新闻单位必须填写"},
                chinese: {required: "我方出席人员必须填写"},
                foreigner: {required: "外方出席人员必须填写"},
                contacts: {required: "联系人必须填写"},
                contactsTel: {required: "联系人电话必须填写"},
                activityContent: {required: "活动内容必须填写"}
            }
        });

        $backBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var listUrl = '#page/temp-affairs/temp-affairs-list';

            var postData = $tempAffairsForm.serializeObject();

            var flag = 0;
            $.each(postData, function (index, item) {

                if (item !== "") {
                    flag = 1;
                }
            });

            if (flag === 0) {
                G.pjaxLoadPageContentDiv(listUrl)
            } else {
                G.confirm({
                    message: "您有临时外事活动信息未保存，确认退出吗？",
                    callback: function (result) {
                        if (result) {
                            G.pjaxLoadPageContentDiv(listUrl);
                        }
                    }
                });
            }

        });



        // 获取上传文件信息
        function getFileListArray(messageFileQueue) {
            var documentFileArray = [];
            messageFileQueue.find('.uploadifive-queue-item').each(function () {
                var $this = $(this);
                var fileId = $this.find(".progress").attr('hiddenFileId');
                var fileName = $this.find(".progress").attr('hiddenFileName');
                var documentFile = {};
                documentFile.fileId = fileId;
                documentFile.fileName = fileName;
                documentFileArray.push(documentFile);
            });

            var $oldFiles = $(".filePreview");

            if ($oldFiles !== undefined) {
                $oldFiles.each(function () {
                    var $this = $(this);
                    var fileId = $this.attr('fileId');
                    var documentFile = {};
                    documentFile.fileId = fileId;
                    documentFileArray.push(documentFile);
                })
            }

            return documentFileArray;
        }


        bindUpload($messageFile, "message-file-queue");

        /*--------附件上传start--------*/
        function bindUpload(fileInput, queueId) {
            fileInput.uploadifive({
                'uploadScript': '${basePath}/file/upload-file.do',
                'queueID': queueId,//列表区域id
                'queueSizeLimit': 10,
                'uploadLimit': 0,
                'auto': true,
                'multi': false,
                'fileObjName': 'uploadFile',
                'height': 30,
                'width': 100,
                'simUploadLimit': 2,
                'buttonCursor': 'hand',
                'buttonClass': 'btn btn-sm btn-primary',
                'buttonText': '&nbsp;&nbsp添加附件&nbsp;&nbsp',
                'removeCompleted': false,
                'method': 'post',
                'fileSizeLimit': 1024000,
                'overrideEvents': ['onUploadComplete'],
                'onUploadComplete': function (file, data, response) {
                    var result = JSON.parse(data);
                    if (result.result) {
                        var realName = result.realName;
                        var fileId = result.fileId;
                        file.queueItem.find('.progress-bar').css('width', '100%');
                        file.queueItem.find('.fileinfo').html(' - 完成');
                        file.queueItem.find('.progress').slideUp(250);
                        file.queueItem.find('.progress').attr('hiddenFileName',realName);
                        file.queueItem.find('.progress').attr('hiddenFileId',fileId);
                        file.queueItem.addClass('complete');
                        if($downLoadFile.html().indexOf('暂无') !== -1) {
                            $downLoadFile.empty();
                        }

                    } else {
                        G.showGritterFail();
                    }

                }
            });
        }
        /*--------附件上传end--------*/

        //获取已上传的附件
        appendAttach($downLoadFile, ${jsonFileObject});

        //获取已上传的附件
        function appendAttach($div, jsonFileObject) {
            $div.empty();
            var html = [];
            if (_.isEmpty(jsonFileObject)) {
                html.push('<ul class="list-unstyled list-striped pricing-table-header"><li style="margin-top:5px">');
                html.push('暂无上传附件！');
                html.push('</li></ul>');
            } else {
                html.push('<ul class="list-unstyled list-striped pricing-table-header">');
                for (var i = 0; i < jsonFileObject.length; i++) {
                    html.push('<li class="blue"  style="cursor:pointer;background-color: white;">');
                    html.push('<a class="filePreview" fileId="' + jsonFileObject[i].id + '" style="color:#478FCA;font-family:仿宋, Arial, Helvetica, sans-serif;font-size: 18px;">');
                    html.push(jsonFileObject[i].fileName);
                    html.push('</a>&nbsp&nbsp&nbsp');
                    html.push('<a style="color:grey" href="${basePath}/file/download.action?id=' + jsonFileObject[i].id + '&type=0">');
                    html.push('<i class="ace-icon fa fa-download grey bigger-130"></i>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;');
                    html.push('<span class="red fileDelete" fileId="' + jsonFileObject[i].id + '">');
                    html.push('<i class="ace-icon fa fa-trash-o red bigger-130 fileDelete"></i>删除&nbsp;');
                    html.push('</span>');
                    html.push('</li>');
                }
                html.push('</ul>');
            }

            $div.append(html.join(""));
            deleteFile();
        }

        //删除已上传附件
        function deleteFile() {
            $('.fileDelete').click(function () {
                var $this = $(this);
                var fileId = $this.attr("fileId");
                G.confirm({
                    message: '确定删除该附件信息？',
                    callback: function (result) {
                        if (result) {
                            var url = '${basePath}/file/delete-file.do';
                            $.post(url, {id: fileId}, function (map) {
                                if (map.result) {
                                    G.showGritterSuccess();
                                }
                                $this.parent().remove();
                            });
                        }
                    }
                });
            })
        }

        // 编辑一行大事记
        $chronicleTBody.on('click', '.row-record-edit', function (e) {
            var tr = $(this).parent().parent();
            var Id= tr.children(".chronicleId").text();
            var content= tr.children(".tempAffairsContent").text();
            var beginTimeStr= tr.children(".tempAffairsContentBeginTimeStr").text();
            var endTimeStr= tr.children(".tempAffairsContentEndTimeStr").text();
            var notes= tr.children(".tempAffairsContentNotes").text();
            $chronicleNotes.val(notes);
            $chronicleContent.val(content);
            $Id.val(Id);
            $endTime.val(endTimeStr);
            $beginTime.val(beginTimeStr);
            initEditDialog("update",tr);
        });



        // 删除一行礼品
        $chronicleTBody.on('click', '.row-record-delete', function (e) {
            e.preventDefault();
            deleteChronicle(e);
        });

        function deleteChronicle(e) {
            var id = $(e.target).closest('tr').data('item').id;
            var deleteUrl = '';

            if (!_.isEmpty(id)) {

                deleteUrl = '${basePath}/temp-affairs/chronicle-delete.do';
                deleteByUrl(e, deleteUrl, id);
            } else {
                $(e.target).closest('tr').remove();
            }
        }

        //删除方法
        function deleteByUrl(e, url, id) {

            G.confirm({
                message: '确认删除此条大事记吗？',
                callback: function (result) {
                    if (result) {
                        $.post(url, {id: id}, function (data) {
                            if (data.result) {
                                G.showGritterSuccess("删除成功！");
                                $(e.target).closest('tr').remove();
                            } else {
                                G.showGritterFail("删除失败！")
                            }
                        });
                    }
                }
            });
        }


        $(document).one('ajaxloadstart.page', function (e) {
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

    });
</script>