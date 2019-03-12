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
                            <form class="form-horizontal" id="taiwanInfoForm" role="form" autocomplete="off" method="post">
                                <input id="taiWanInfoId" name="id" type="hidden" value="${taiWanInfo.id}">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 30px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${documentArchive.id eq null}"> 因公赴台信息新增</c:when>
                                                    <c:otherwise> 因公赴台信息编辑</c:otherwise>
                                                </c:choose></h1>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <!-- 团组名称 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-groupName" >团组名称：<span
                                                    class="required">*</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-groupName" name="groupName"
                                                       class="form-control " value="${taiWanInfo.groupName}"
                                                       placeholder="团组名称"/>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 组团部门 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-groupDepartment" >
                                                组团部门：<span class="required">*</span></label>
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
                                    <!-- 赴台时间 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-startTime" >开始时间：<span class="required">*</span></label>
                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="goTimeStr" id="form-field-startTime"
                                                           value="${taiWanInfo.jsonObject.goTime}" type="text" placeholder="赴台时间"/>
                                                    <span class="input-group-addon">
                                                    <i class="fa fa-calendar bigger-110"></i>
                                                </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-EndTime" >结束时间：<span class="required">*</span></label>
                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="endTimeStr" id="form-field-endTime"
                                                           value="${taiWanInfo.jsonObject.endTime}" type="text" placeholder="离台时间"/>
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
                                    <!-- 台方接待单位 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-taiDept" >台方接待单位：<span
                                                    class="required">&nbsp;</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-taiDept" name="taiDept"
                                                       class="form-control " value="${taiWanInfo.jsonObject.taiDept}"
                                                       placeholder="台方接待单位"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-taiCharge" >费用来源：<span
                                                    class="required">&nbsp;</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-taiCharge" name="taiCharge"
                                                       class="form-control " value="${taiWanInfo.jsonObject.taiCharge}"
                                                       placeholder="费用来源"/>
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
                                            <label class="col-sm-4 control-label">
                                                人员信息：<span class="required">*</span></label>
                                            <div class="col-sm-8">
                                                <button class="btn btn-info btn-sm" type="button"
                                                        id="openName2">点击添加赴台人员信息
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">赴台人员：<span
                                                    class="required">*</span></label>
                                            <div class="col-sm-10">
                                                <table id="simple-table" class="table table-striped table-bordered">
                                                    <thead>
                                                    <tr>
                                                        <th class="hide">id</th>
                                                        <th class="center" style="width:30%;">工作部门</th>
                                                        <th class="center" style="width:15%;">姓名</th>
                                                        <th class="center" style="width:15%;">赴台身份</th>
                                                        <th class="center" style="width:15%;">团组职务</th>

                                                        <th class="center" style="width:10%;">操作</th>
                                                    </tr>
                                                    </thead>

                                                    <tbody id="chronicleTBody">
                                                    <c:if test="${taiWanInfo.id ne null}">
                                                        <c:forEach items="${taiWanInfo.taiWanInfoUserList}"
                                                                   var="chronicle">
                                                            <tr class="chronicleTr" data-item={"userInfoId":"${chronicle.id}"}>
                                                                <td class="hide userInfoId">${chronicle.id}</td>
                                                                <td class="hide userDeptId" data-id="userDeptId">${chronicle.dicDept.id}</td>
                                                                <td class="left-align userDeptName"
                                                                    data-id="userDeptName">${chronicle.dicDept.deptName}</td>
                                                                <td class="hide userPeopleId" data-id="userPeopleId">${chronicle.dicUser.id}</td>
                                                                <td class="center userName" style="vertical-align: middle"
                                                                    data-id="userName">${chronicle.dicUser.empName}</td>
                                                                <td class="center userDegree" style="vertical-align: middle"
                                                                    data-id="userDegree">${chronicle.degree}</td>
                                                                <td class="hide userNotes" style="vertical-align: middle"
                                                                    data-id="userNotes">${chronicle.notes}</td>
                                                                <td class="center userNotes" style="vertical-align: middle"
                                                                    data-id="userDutyTai">${chronicle.dutyTai}</td>
                                                                <td class="hide userDuty" style="vertical-align: middle"
                                                                    data-id="userDuty">${chronicle.duty}</td>
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
                                </div>

                                <div class="row">
                                    <div class="space-10"></div>
                                </div>

                                <div class="row">
                                    <!-- 备注 -->
                                    <div class="col-xs-12 ">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="form-field-notes" >
                                                备注：<span class="required">&nbsp;</span></label>
                                            <div class="col-sm-10 " >
                                            <textarea class="form-control limited" id="form-field-notes"
                                                      name="notes" maxlength="200" style="min-height: 100px;" placeholder="备注">${taiWanInfo.jsonObject.notes}</textarea>
                                            </div>
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
<div id="view-dialog01" class="hide">
        <form id="chronicleForm" autocomplete="off" role="form">
            <div class="hidden">
                <input type="text" id="id" name="userTaiWanId"/>
                <input type="text" id="userInfoId" name="userInfoId"/>
            </div>
            <div class="row">
                <!-- 工作部门 -->
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label" for="form-field-userDeptId" >
                            工作部门：<span class="required">*</span></label>

                        <div class="col-sm-8 deptDiv">
                            <input type="text" id="form-field-userDeptId" name="userDeptId"
                                   class="hide" value=""/>
                            <input type="text" class="form-control" id="form-field-userDeptName"
                                   name="userDeptName" value="" style="cursor: pointer;" readonly/>
                        </div>
                    </div>
                </div>

                <!-- 姓名 -->
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label" >姓名：<span
                                class="required">*</span></label>
                        <div class="col-sm-8 ">
                            <select class="form-control" id="form-field-userPeopleId"
                                    name="userPeopleId">
                                <option value="">---------请选择---------</option>
                                <c:forEach items="${dicUserList}" var="dicUser">
                                    <option value="${dicUser.id}"  <c:if test="${taiWanInfo.dicUser.id eq dicUser.id}">selected</c:if> >${dicUser.empName}</option>
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
                <!-- 本职职务 -->
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label" for="form-field-userDuty" >本职职务：<span
                                class="required"></span></label>
                        <div class="col-sm-8 ">
                            <input type="text" id="form-field-userDuty" name="userDuty"
                                   class="form-control " value=""
                                   placeholder="本职职务"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label" for="form-field-userDutyTai" >团组职务：<span
                                class="required"></span></label>
                        <div class="col-sm-8 ">
                            <input type="text" id="form-field-userDutyTai" name="userDutyTai"
                                   class="form-control " value=""
                                   placeholder="团组职务"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="space-10"></div>
            </div>
            <div class="row">
                <!-- 赴台身份 -->
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label" for="form-field-userDegree" >赴台身份：<span
                            class="required"></span></label>
                        <div class="col-sm-8 ">
                            <input type="text" id="form-field-userDegree" name="userDegree"
                                   class="form-control " value=""
                                   placeholder="赴台身份"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label" for="form-field-userNotes" >备注：<span
                                class="required"></span></label>
                        <div class="col-sm-8 ">
                            <input type="text" id="form-field-userNotes" name="userNotes"
                                   class="form-control " value=""
                                   placeholder="备注"/>
                        </div>
                    </div>
                </div>
            </div>
        </form>
</div>
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {
        //时间控件
        G.datepicker({todayHighlight: true,autoclose: true});

        G.initDept('deptDiv',true,['${dept}','${dicDept}'],TREE_NODE);

        // 控件类全局变量
        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");

        // 表单类全局变量
        var $saveForm = $('#taiwanInfoForm');

        //本地url
        var url = '${basePath}/taiwan-info/load-taiwan-info-save.do';
        var localUrl = '#page/taiwan-info/taiwan-info-list';

        //其他全局变量
        var infoId = $saveForm.find("#taiWanInfoId").val();


        //保存
        $saveBtn.unbind('click').bind('click',function (e) {
            e.preventDefault();
            var beginTime = moment($("#form-field-startTime").val(), 'YYYY-MM-DD').toDate();
            var endTime = moment($("#form-field-endTime").val(), 'YYYY-MM-DD').toDate();
            if (beginTime > endTime) {
                G.alert({message: '结束时间应大于等于开始时间！'});
            } else {
                if ($saveForm.validate().form()) {
                    var data = $saveForm.serializeObject();
                    data["infoId"] = infoId;
                    var chronicleArray = [];
                    $chronicleTBody.find('tr[class="chronicleTr"]').each(function () {
                        var $tr = $(this);
                        var chronicleData = $tr.data('item');
                        if (chronicleData) {
                            chronicleArray.push(chronicleData);
                        }
                    });
                    if(chronicleArray.length>0) {
                        data.taiWanInfoUserListVo = chronicleArray;
                        data = JSON.stringify(data);
                        if ($saveForm.validate().form()) {
                            G.confirm({
                                message: '确认保存此条信息吗？',
                                callback: function (result) {
                                    if (result) {
                                        var loadId = G.showAjaxLoading();
                                        $.ajax({
                                            url: url,
                                            type: 'POST',
                                            dataType: 'json',
                                            data: data,
                                            async: true,
                                            contentType: "application/json;charset=utf-8"
                                        }).done(function (map) {
                                            G.doneAjaxLoading(loadId);
                                            if (map.result) {
                                                G.showGritterSuccess("保存成功");
                                                G.pjaxLoadPageContentDiv(localUrl);
                                            } else {
                                                if (map.messageStr == undefined) {
                                                    G.showGritterFail("保存信息失败,请稍后重试！");
                                                } else {
                                                    G.showGritterFail(map.messageStr);
                                                }
                                            }
                                        });
                                    }
                                }
                            });
                        }
                    }else {
                        G.alert({message: '请选择人员信息！'});
                    }
                }
            }
        });

        //返回
        $backBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var listUrl = '#page/taiwan-info/taiwan-info-list';
            var postData = $saveForm.serializeObject();
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
                    message: "您有因公赴台信息未保存，确认退出吗？",
                    callback: function (result) {
                        if (result) {
                            G.pjaxLoadPageContentDiv(listUrl);
                        }
                    }
                });
            }
        });

        //数据校验
        $saveForm.tjValidate({
            focusInvalid: false,
            rules: {
                groupName: {
                    required: true
                },
                groupDepartmentName: {
                    required: true
                },
                goTimeStr: {
                    required: true
                },
                endTimeStr: {
                    required: true
                }
            },
            messages: {

                groupName: {
                    required: "团组名称不能为空"
                },
                groupDepartmentName: {
                    required: "组团部门不能为空"
                },
                goTimeStr: {
                    required: "开始时间不能为空"
                },
                endTimeStr: {
                    required: "结束时间不能为空"
                }
            }
        });


        var $openName2 = $("#openName2");
        var $viewDialog = $("#view-dialog01");
        var $chronicleForm = $('#chronicleForm');
        var $chronicleTBody = $('#chronicleTBody');
        var $formFieldUserDeptId = $('#form-field-userDeptId');
        var $formFieldUserDeptName = $('#form-field-userDeptName');
        var $formFieldUserPeopleId = $('#form-field-userPeopleId');
        var $formFieldUserNotes = $('#form-field-userNotes');
        var $formFieldUserDegree = $('#form-field-userDegree');
        var $formFieldUserDuty = $('#form-field-userDuty');
        var $formFieldUserDutyTai = $('#form-field-userDutyTai');




        var $userInfoId = $("#userInfoId");

        //数据校验
        $chronicleForm.tjValidate({
            focusInvalid: false,
            rules: {
                userPeopleId: {
                    required: true
                },
                userDeptName: {
                    required: true
                }
            },
            messages: {
                userPeopleId: {
                    required: "姓名不能为空"
                },
                userDeptName: {
                    required: "工作部门不能为空"
                }
            }
        });


        var $department = $("#form-field-userDeptId");

        function bindDeptChange() {
            $department.change(function () {
                var deptId = $department.val();

                $.post('${basePath}/user/find-users-by-dept.do', {deptId: deptId}, function (response) {
                    if (response.result) {
                        var dicUserList = response.dicUserList;
                        initSelect(dicUserList);
                    }
                });
            });

            var initSelect = function (array) {
                var $sel = $('select[name="userPeopleId"]');
                $sel.empty();

                var optionsAsString = '<option value="">---------请选择---------</option>';
                for(var i = 0; i < array.length; i++) {
                    var userId = array[i].id;
                    var name = array[i].empName;
                    optionsAsString += "<option value='" + userId + "'>" + name + "</option>";
                }
                $sel.append( optionsAsString );
            }
        }


        $openName2.click(function (e) {
            $formFieldUserDeptId.val("");
            $formFieldUserDeptName.val("");
            $formFieldUserPeopleId.val("");
            $userInfoId.val("");
            $formFieldUserNotes.val("");
            $formFieldUserDegree.val("");
            $formFieldUserDuty.val("");
            $formFieldUserDutyTai.val("");
            initViewDialog($viewDialog,"add");
        })
        function initViewDialog($container,type,tr) {
            bindDeptChange();
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
                            if ($chronicleForm.validate().form()){
                                var data = $chronicleForm.serializeObject();
                                var name = $('#form-field-userPeopleId option:selected').text();
                                data.userName=name;
                                data.json = JSON.stringify(data);
                                appendLine(data,type,tr);
                                $(this).dialog('close');
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
                    ' <td class="hide userInfoId" data-id="userInfoId">'+data.userInfoId+'</td>' +
                    '<td class="hide userDeptId" style="text-align:left" data-id="userDeptId">{{userDeptId}}</td>' +
                    '<td class="userDeptName" style="text-align:left" data-id="userDeptName">{{userDeptName}}</td>' +
                    '<td class="hide userPeopleId" style="text-align:left" data-id="userPeopleId">{{userPeopleId}}</td>' +
                    '<td class="userName" style="text-align:center" data-id="userName">{{userName}}</td>' +
                    '<td class="userDegree" style="text-align:center" data-id="userDegree">{{userDegree}}</td>' +
                    '<td class="hide userNotes" style="text-align:center" data-id="userNotes">{{userNotes}}</td>' +
                    '<td class="hide userDuty" style="text-align:center" data-id="userDuty">{{userDuty}}</td>' +
                    '<td class="userDutyTai" style="text-align:center" data-id="userDutyTai">{{userDutyTai}}</td>' +
                    '<td style="text-align:center">' +
                    '<i class="ace-icon blue fa fa-pencil-square-o row-record-edit bigger-150" style="cursor: pointer;" title="编辑"></i>&nbsp;' +
                    '<i class="ace-icon red fa fa-trash-o row-record-delete bigger-150" style="cursor: pointer;" title="删除"></i></td>' +
                    '</tr>';
                var temp = Handlebars.compile(html);
                var view = temp(data);
                $chronicleTBody.append(view)
            }else {
                var html = '<tr class="chronicleTr" data-item ="{{json}}">' +
                    '<td class="hide userInfoId" data-id="userInfoId">{{userInfoId}}</td>' +
                    '<td class="hide userDeptId" style="text-align:left" data-id="userDeptId">{{userDeptId}}</td>' +
                    '<td class="userDeptName" style="text-align:left" data-id="userDeptName">{{userDeptName}}</td>' +
                    '<td class="hide userPeopleId" style="text-align:left" data-id="userPeopleId">{{userPeopleId}}</td>' +
                    '<td class="userName" style="text-align:center" data-id="userName">{{userName}}</td>' +
                    '<td class="userDegree" style="text-align:center" data-id="userDegree">{{userDegree}}</td>' +
                    '<td class="hide userNotes" style="text-align:center" data-id="userNotes">{{userNotes}}</td>' +
                    '<td class="hide userDuty" style="text-align:center" data-id="userDuty">{{userDuty}}</td>' +
                    '<td class="userDutyTai" style="text-align:center" data-id="userDutyTai">{{userDutyTai}}</td>' +
                    '<td style="text-align:center">' +
                    '<i class="ace-icon blue fa fa-pencil-square-o row-record-edit bigger-150" style="cursor: pointer;" title="编辑"></i>&nbsp;' +
                    '<i class="ace-icon red fa fa-trash-o row-record-delete bigger-150" style="cursor: pointer;" title="删除"></i></td>' +
                    '</tr>';
                var temp = Handlebars.compile(html);
                var view = temp(data);
                $chronicleTBody.append(view);
            }
        }


        // 编辑一行
        $chronicleTBody.on('click', '.row-record-edit', function (e) {
            var tr = $(this).parent().parent();
            var Id= tr.children(".userInfoId").text();
            var userDeptId= tr.children(".userDeptId").text();
            var userDeptName= tr.children(".userDeptName").text();
            var userPeopleId= tr.children(".userPeopleId").text();
            var userNotes= tr.children(".userNotes").text();
            var userDegree= tr.children(".userDegree").text();
            var userDuty= tr.children(".userDuty").text();
            var userDutyTai= tr.children(".userDutyTai").text();
            $formFieldUserNotes.val(userNotes);
            $formFieldUserDegree.val(userDegree);
            $formFieldUserDeptId.val(userDeptId);
            $formFieldUserDeptName.val(userDeptName);
            $formFieldUserPeopleId.val(userPeopleId);
            $userInfoId.val(Id);
            $formFieldUserDuty.val(userDuty);
            $formFieldUserDutyTai.val(userDutyTai);
            initViewDialog($viewDialog,"update",tr);
        });

        // 删除一行
        $chronicleTBody.on('click', '.row-record-delete', function (e) {
            e.preventDefault();
            deleteChronicle(e);
        });
        function deleteChronicle(e) {
            var id = $(e.target).closest('tr').data('item').userInfoId;
            var deleteUrl = '';

            if (!_.isEmpty(id)) {
                deleteUrl = '${basePath}/taiwan-info/taiWanInFoUser-delete.do';
                deleteByUrl(e, deleteUrl, id);
            } else {
                $(e.target).closest('tr').remove();
            }
        }

        //删除方法
        function deleteByUrl(e, url, id) {

            G.confirm({
                message: '确认删除此条人员信息？',
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
    });
</script>