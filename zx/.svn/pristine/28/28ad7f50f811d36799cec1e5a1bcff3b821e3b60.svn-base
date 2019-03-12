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
                            <form class="form-horizontal" id="privateAbroadForm" role="form" autocomplete="off" method="post">
                                <input id="privateAbroadId" name="id" type="hidden" value="${privateAbroad.id}">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 30px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${privateAbroad.id eq null}"> 因私出国（境）信息新增</c:when>
                                                    <c:otherwise> 因私出国（境）信息编辑</c:otherwise>
                                                </c:choose></h1>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-department" >工作部门：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 deptDiv">
                                                <input type="text" id="form-field-department" name="department"
                                                       class="hide" value=""/>
                                                <input type="text" class="form-control" id="form-field-departmentName"
                                                       name="departmentName" value="" style="cursor: pointer;" readonly/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" >姓名：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-peopleId"
                                                        name="peopleId">
                                                    <option value="">---------请选择---------</option>
                                                    <c:forEach items="${dicUserList}" var="dicUser">
                                                        <option value="${dicUser.id}"  <c:if test="${privateAbroad.dicUser.id eq dicUser.id}">selected</c:if> >${dicUser.empName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-groupName" >团组名称：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-groupName" name="groupName"
                                                       class="form-control " value="${privateAbroad.groupName}"
                                                       placeholder="团组名称"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-groupDepartment" >组团部门：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 deptDiv">
                                                <input type="text" id="form-field-groupDepartment" name="groupDepartment"
                                                       class="hide" value=""/>
                                                <input type="text" class="form-control" id="form-field-groupDepartmentName"
                                                       name="groupDepartmentName" value="" style="cursor: pointer;" readonly/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-startTime" >出国开始时间：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="startTime" id="form-field-startTime"
                                                           value="${privateAbroad.jsonObject.startTime}" type="text" placeholder="出国开始时间"/>
                                                    <span class="input-group-addon">
                                                    <i class="fa fa-calendar bigger-110"></i>
                                                </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-endTime" >出国结束时间：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="endTime" id="form-field-endTime"
                                                           value="${privateAbroad.jsonObject.endTime}" type="text" placeholder="出国结束时间"/>
                                                    <span class="input-group-addon">
                                                    <i class="fa fa-calendar bigger-110"></i>
                                                </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12 ">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="form-field-notes" >备注：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-10 ">
                                            <textarea class="form-control limited" id="form-field-notes"
                                                      name="notes" maxlength="200" style="min-height: 100px;" placeholder="备注">${privateAbroad.notes}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
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

        G.datepicker({
            todayHighlight : true
        });

        G.initDept('deptDiv',true,['${dicDept}','${dicDeptForGroup}'],TREE_NODE);

        var $privateAbroadForm = $('#privateAbroadForm');
        var $privateAbroadId = $('#privateAbroadId');
        var $peopleId = $('#form-field-peopleId');
        var $department = $('#form-field-department');
        var $groupName = $('#form-field-groupName');
        var $groupDepartment = $('#form-field-groupDepartment');
        var $startTime = $('#form-field-startTime');
        var $endTime = $('#form-field-endTime');
        var $notes = $('#form-field-notes');

        function getPrivateAbroadData() {
            var privateAbroadData = {};
            var dicUser = {};
            var dicDept = {};
            var dicDeptForGroup = {};
            privateAbroadData.id = $privateAbroadId.val();
            privateAbroadData.groupName = $groupName.val();
            privateAbroadData.startTime = $startTime.val();
            privateAbroadData.endTime = $endTime.val();

            privateAbroadData.notes = $notes.val();

            dicUser.id = $peopleId.val();
            privateAbroadData.dicUser = dicUser;

            dicDept.id = $department.val();
            privateAbroadData.dicDept = dicDept;

            dicDeptForGroup.id = $groupDepartment.val();
            privateAbroadData.dicDeptForGroup = dicDeptForGroup;

            return privateAbroadData;
        }

        $department.change(function () {
            var deptId = $department.val();

            $.post('${basePath}/user/find-users-by-dept.do', {deptId: deptId}, function (response) {
                if (response.result) {
                    var dicUserList = response.dicUserList;
                    initSelect(dicUserList);
                }
            });
        });

        function initSelect(array) {
            var $sel = $('select[name="peopleId"]');
            $sel.empty();

            var optionsAsString = '<option value="">---------请选择---------</option>';
            for(var i = 0; i < array.length; i++) {
                var userId = array[i].id;
                var name = array[i].empName;
                optionsAsString += "<option value='" + userId + "'>" + name + "</option>";
            }
            $sel.append( optionsAsString );
        }

        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");

        var saveUrl = '${basePath}/private-abroad/private-abroad-save.do';

        $saveBtn.unbind('click').bind('click', function (e) {
            if ($privateAbroadForm.validate().form()) {
                var startTime = moment($startTime.val(),'YYYY-MM-DD').toDate();
                var endTime = moment($endTime.val(),'YYYY-MM-DD').toDate();
                if (startTime > endTime) {
                    G.alert({message : '结束时间应大于等于开始时间！'});
                    e.preventDefault();
                } else {
                    var data = getPrivateAbroadData();
                    $saveBtn.prop("disabled", true);
                    $backBtn.prop("disabled", true);
                    G.confirm({
                        message: '确认保存此条因私出国(境)信息吗？',
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
                                        G.pjaxLoadPageContentDiv('#page/private-abroad/private-abroad-list');
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
            }
        });

        $privateAbroadForm.tjValidate({
            focusInvalid: true,
            rules: {
                peopleId: {required: true},
                departmentName: {required: true},
                groupName: {required: true, maxlength: 100},
                groupDepartmentName: {required: true},
                startTime: {required: true},
                endTime: {required: true},
                notes: {required: true, maxlength: 1000}
            },
            messages: {
                peopleId: {required: "姓名必须填写"},
                departmentName: {required: "工作部门必须填写"},
                groupName: {required: "团组名称必须填写"},
                groupDepartmentName: {required: "组团部门必须选择"},
                startTime: {required: "出国开始时间必须填写"},
                endTime: {required: "出国结束时间必须填写"},
                notes: {required: "备注必须填写"}
            }
        });

        $backBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var postData = $privateAbroadForm.serializeObject();

            var flag = 0;
            $.each(postData, function (index, item) {

                if (item !== "") {
                    flag = 1;
                }
            });

            if (flag === 0) {
                G.back();
            } else {
                G.confirm({
                    message: "您有因私出国(境)信息未保存，确认退出吗？",
                    callback: function (result) {
                        if (result) {
                            G.back();
                        }
                    }
                });
            }

        });

        $(document).one('ajaxloadstart.page', function (e) {
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

    });
</script>