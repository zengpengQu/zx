<%--
  Created by IntelliJ IDEA.
  User: sy
  Date: 2018/7/25
  Time: 17:43
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

<div class="row">
    <div class="col-xs-10 col-sm-offset-1">
        <div class="widget-box transparent">
            <div class="widget-body">
                <div class="widget-main">
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" role="form" id="saveForm"
                                  action="${basePath}/place/place-save.do" method="post">

                                <div class="hidden">
                                    <input type="text" id="form-field-id" name="id" value="${placeList.id}"/>
                                    <input type="text" id="form-field-status" name="reportState" value="${placeList.reportState}"/>
                                    <input type="text" id="form-field-feedbackId" name="feedbackId" value="${placeList.feedback.id}"/>
                                    <c:if test="${!empty correctType}"><input type="text" id="form-field-correctId" value="4"/></c:if>

                                </div>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 5px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${placeList.id eq null}">视察考察活动安排新增</c:when>
                                                    <c:when test="${!empty correctType}">视察考察活动安排调整</c:when>
                                                    <c:otherwise>视察考察活动安排修改</c:otherwise>
                                                </c:choose></h1>
                                        </div>
                                    </div>
                                </div>
                                <div class="hr hr-18 hr-double dotted"></div>

                                <div class="row">

                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <h3 align="center" style="font-weight: bold;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;调研活动基本信息：</h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div style="margin-top: 2%"></div>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">

                                            <label class="col-sm-2 control-label no-padding-right"
                                                   for="form-field-title"> 活动标题： <span
                                                    class="required">*</span></label>
                                            <div class="col-sm-10">
                                                <input type="text" id="form-field-title" name="title"
                                                       class="form-control" value="${placeList.title}"/>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-6 control-label no-padding-right"
                                                   for="form-field-actType"> 来源类别： <span
                                                    class="required">*</span></label>
                                            <div class="col-sm-6">
                                                <select class="form-control" id="form-field-actType" name="actTypeName">
                                                    <c:choose>
                                                        <c:when test="${placeList.actTypeId eq null}"><option value="">----请选择----</option></c:when>
                                                        <c:otherwise> <option value="${placeList.actTypeId}">${placeList.actTypeId}</option></c:otherwise>
                                                    </c:choose>
                                                    <option value="视察">视察</option>
                                                    <option value="考察">考察</option>
                                                    <option value="调研">调研</option>

                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-6 control-label no-padding-right"
                                                   for="form-field-deptName"> 承办单位：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-6">
                                                <input type="text" id="form-field-deptId" name="dicDept.id"
                                                       class="hide" value="${dicUser.dicDept.id}"/>
                                                <input type="text" class="form-control" id="form-field-deptName"
                                                       name="" value="${dicUser.dicDept.deptName}" style="cursor: pointer;" readonly="readonly"/>
                                                <%--  <select class="form-control" id="form-field-deptName" name="deptName">
                                                      <c:choose>
                                                          <c:when test="${placeList.dicDept.deptName eq null}"><option value="">----请选择----</option></c:when>
                                                          <c:otherwise> <option value="${placeList.dicDept.id }">${placeList.dicDept.deptName}</option></c:otherwise>
                                                      </c:choose>
                                                      <c:forEach items="${deptList}" var="depts">
                                                          <option value="${depts.id}">${depts.deptName}</option>
                                                      </c:forEach>
                                                  </select>--%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                            <label class="col-sm-4 control-label no-padding-right"
                                                   for="form-field-nowTime"> 年度：</label>
                                            <div class="col-sm-8">
                                                <div class="input-group date" data-date-format="yyyy">
                                                    <input class="form-control yearpicker" name="nowTime" id="form-field-nowTime"
                                                           value="${systemDateAddYear}" type="text"/>
                                                    <span class="input-group-addon">
                                                            <i class="fa fa-calendar bigger-110"></i>
                                                        </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">

                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label no-padding-right"
                                                   for="form-field-notes"> 备注： <span
                                                    class="required">&nbsp;</span></label>

                                            <div class="col-sm-10 ">
                                                <input type="text" id="form-field-notes" name="notes"
                                                       value="${placeList.notes}" class="form-control"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="hr hr-18 hr-double dotted"></div>
                                <c:if test="${!empty correctType}">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <label class="col-sm-12" style="font-size: 20px;color: #2a62bc"> &nbsp; &nbsp; &nbsp;需要调整的信息如下:</label>
                                                <c:forEach items="${correctType}" var="correct" varStatus="start">
                                                    <c:if test="${correct.state == '2'}"><span style="color: #3C6E31" class="col-sm-2" >&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;(已调整)</span></c:if>
                                                    <c:if test="${correct.state != '2'}"><span style="color: red "class="col-sm-2">&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;(未调整)</span></c:if>
                                                    <label class="col-sm-10" style="font-size: 14px;"> &nbsp;&nbsp;&nbsp;&nbsp; 第 ${start.index+1} 条: &nbsp &nbsp${correct.text}
                                                    </label>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="hr hr-18 hr-double dotted"></div>
                                </c:if>
                                <input class="hide" value="${correctOuUpdate}" name="correctPlace">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <h3 align="center" style="font-weight: bold;">活动安排：</h3>
                                        </div>
                                    </div>

                                    <div class="col-xs-12">
                                        <div class="form-group">
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
                                    <div class="col-sm-1"></div>
                                    <div class="col-sm-11">
                                        <table class="table table-striped table-bordered" id="workStudy"
                                               name="dateTypeList">
                                            <thead>
                                            <tr>
                                                <th class="center hide">id</th>
                                                <th class="center hide">是否删除</th>
                                                <th class="center" style="width: 15%">日期类型</th>
                                                <th class="center" style="width: 18%">开始日期</th>
                                                <th class="center" style="width: 18%">截止日期</th>
                                                <th class="center" style="width: 17%">省份</th>
                                                <th class="center" style="width: 25%">特殊地点</th>
                                                <th class="center" style="width: 7%">操作</th>
                                            </tr>
                                            </thead>

                                            <tbody>
                                            <c:choose>
                                                <c:when test="${!empty placeList.dateTypeLists}">
                                                    <c:forEach items="${placeList.dateTypeLists}" var="dateType" varStatus="status">
                                                        <tr class="dateType" data-id="${dateType.id}">
                                                            <td class="center hide"><input type="text"
                                                                                           name="dateTypeList[${status.index}].id"
                                                                                           value="${dateType.jsonObject.id}"
                                                                                           style="width: 98%"/></td>
                                                            <td class="center hide"><input type="text"
                                                                                           class="editable isDelete"
                                                                                           name="dateTypeList[${status.index}].delFlag"
                                                                                           value="${dateType.jsonObject.delFlag}"
                                                                                           style="width: 98%;border:none;"/></td>
                                                            <td class="center">

                                                                <input type="text" role="textbox"
                                                                       class="editable" readonly="readonly"
                                                                       name="dateTypeList[${status.index}].dateType"
                                                                       value="${dateType.jsonObject.dateType}"
                                                                       style="width: 98%;border:none;"/></td>
                                                            <td class="center"><input type="text"
                                                                                      class="form-control date-picker date-beginTime-str"
                                                                                      name="dateTypeList[${status.index}].beginTimeStr"
                                                                                      id="date-beginTime-str${status.index}"
                                                                                      value="${dateType.jsonObject.beginTimeStr}"
                                                                                      data-date-format="yyyy-mm-dd"
                                                                                      style="width: 98%;border:none;"/></td>
                                                            <td class="center"><input type="text"
                                                                                      class="form-control date-picker date-endTime-str"
                                                                                      name="dateTypeList[${status.index}].endTimeStr"
                                                                                      id="date-endTime-str${status.index}"
                                                                                      value="${dateType.jsonObject.endTime}"
                                                                                      data-date-format="yyyy-mm-dd"
                                                                                      style="width: 98%;border:none;"/></td>

                                                            <td class="center">
                                                                <select  name="dateTypeList[${status.index}].placeIdStr" style="width: 98%;border:none;">
                                                                    <c:choose>
                                                                        <c:when test="${empty dateType.jsonObject.place}"><option value="">请选择省份</option></c:when>
                                                                        <c:otherwise> <option value="${dateType.jsonObject.placeDistrictId}">${dateType.jsonObject.place}</option></c:otherwise>
                                                                    </c:choose>
                                                                    <c:forEach items="${districtList}" var="depts">
                                                                        <option value="${depts.id}">${depts.districtName}</option>
                                                                    </c:forEach>
                                                                </select></td>

                                                            <td class="center"><input type="text" role="textbox"
                                                                                      class="editable"
                                                                                      name="dateTypeList[${status.index}].specialPlace"
                                                                                      value="${dateType.jsonObject.specialPlace}"
                                                                                      style="width: 98%;border:none;"/></td>
                                                            <td class="center">
                                                                <button class="btn btn-minier btn-danger row-record-delete">
                                                                    <i class="ace-icon fa fa-times"></i>
                                                                    删除
                                                                </button>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr class="empty-row">
                                                        <th style="width: 100%" colspan="6" class="center">无内容！</th>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
                                            </tbody>
                                        </table>
                                    </div>

                                </div>
                                <div style="margin-top: 2%"></div>
                                <div class="hr hr-18 hr-double dotted"></div>
                                <div class="clearfix form-actions center">
                                    <div class="col-xs-12">
                                        <button class="btn btn-info btn-sm" type="button" id="saveBtn">
                                            <i class="ace-icon fa fa-check bigger-110"></i>
                                            保存
                                        </button>
                                        <c:if test="${empty correctType}">
                                            <c:forEach items="${curOperateAuth}" var="curOpertate">
                                                <c:if test="${'76_5' eq curOpertate}">
                                                    &nbsp; &nbsp; &nbsp;
                                                    <button class="btn btn-success btn-sm" type="button" id="sendBtn">
                                                        <i class="ace-icon glyphicon glyphicon-arrow-up bigger-110"></i>
                                                        上报
                                                    </button>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
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
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {
        $('.yearpicker').datepicker({
            starView:'decade',
            minView:'decade',
            format:'yyyy',
            maxViewMode:2,
            minViewMode:2,
            autoclose:true
        });

        bindDatePicker();

        function bindDatePicker() {
            G.datepicker({autoclose: true, startDate: new Date()});
            //时间控件 开始时间和结束时间相互依赖

            $(".date-beginTime-str").on("click", function () {
                var id = $(this).parent().next().children(".date-endTime-str").attr('id');
                var endTimeStr = $("#" + id).val();
                $(".date-beginTime-str").datetimepicker("setEndDate", endTimeStr);
            });

            $(".date-endTime-str").on("click",function () {
                var id = $(this).parent().prev().children(".date-beginTime-str").attr("id");
                var beginTimeStr = $("#" + id).val();
                if(beginTimeStr === ""){
                    beginTimeStr = new Date();
                }
                $(".date-endTime-str").datetimepicker("setStartDate", beginTimeStr);
            })
        }

        var $saveForm = $('#saveForm');
        var $saveBtn = $("#saveBtn");
        var $sendBtn = $("#sendBtn");
        var $backBtn = $("#backBtn");
        var $addStudyRow = $("#addStudyRow");

        //活动安排报保存
        $saveBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            <c:if test="${empty correctType}">$("#form-field-status").val("0");</c:if>
            <c:if test="${!empty correctType}">$("#form-field-status").val("5");</c:if>
            savePlace('保存', $saveBtn);
        });
        //活动安排上报
        $sendBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            $("#form-field-status").val("1");
            savePlace('上报', $sendBtn);
        });

        // 保存活动安排
        function savePlace(type, $btn) {
            if ($saveForm.validate().form()) {
                var load = G.showAjaxLoading("正在保存中，请稍候...");
                $btn.prop("disabled", true);
                $saveForm.ajaxSubmit({
                    success: function (map) {
                        G.doneAjaxLoading(load);
                        $btn.prop("disabled", false);
                        if (map.result) {
                            if(map.resultNo == "yes"){
                                G.showGritterFail(map.resultNoStr);
                            }else {
                                if(map.isResult !== "0"){
                                    var placeId = map.placeIdStr;
                                    G.confirm({
                                        message: '此活动安排信息存在冲突，确认'+type+'？',
                                        callback: function (result) {
                                            if (result) {
                                                G.showGritterSuccess("活动安排信息" + type + "成功!");
                                                G.pjaxLoadPageContentDiv("page/place/place-list");
                                            } else {
                                                var loadId = G.showAjaxLoading();
                                                $.ajax({
                                                    type: 'post',
                                                    dataType: 'json',
                                                    url: '${basePath}/place/place-cancel.do',
                                                    data: {id: placeId,status:"yes"},
                                                    async: true
                                                }).done(function (map) {
                                                    G.doneAjaxLoading(loadId);
                                                    if (map.result) {
                                                        G.pjaxLoadPageContentDiv("page/place/place-list");
                                                    }
                                                });
                                            }
                                        }
                                    });
                                }else {
                                    G.showGritterSuccess(type + '成功');
                                    G.pjaxLoadPageContentDiv("page/place/place-list");
                                }
                            }

                        } else {
                            G.showGritterFail(type + "失败,请稍后重试!");
                        }
                    },
                    error: function () {
                        G.doneAjaxLoading(load);
                        G.showGritterFail(type + "失败,请稍后重试!");
                        $btn.prop("disabled", false);
                    }
                });
            }
        }
        //返回
        $backBtn.unbind('click').bind('click', function () {
           G.back();
        });

        //新增一行
        $addStudyRow.unbind('click').bind('click',function () {

            var array = [];

            $("#workStudy").find('tr.empty-row').remove();

            var index = $("#workStudy").find("tr").length - 1;

            array.push(' <tr class="workStudy" data-id="">                                   ');
            array.push('     <td class="center hide"><input type="text" role="textbox"                           ');
            array.push('                               class="editable"                                     ');
            array.push('                               name="dateTypeList['+ index +'].id"           ');
            array.push('                               value=""                            ');
            array.push('                               style="width: 98%;border:none;"/></td>                            ');
            array.push('     <td class="center hide"><input type="text" role="textbox"                           ');
            array.push('                               class="editable isDelete"                                     ');
            array.push('                               name="dateTypeList['+ index +'].delFlag"           ');
            array.push('                               value="0"                            ');
            array.push('                               style="width: 98%;border:none;"/></td>                            ');
            array.push('     <td class="center">');
            array.push('     <select ');
            array.push(   'name="dateTypeList['+ index +'].dateType" style="width: 98%;border:none;"> ');
            //需要修改
            array.push('     <option>时间</option>');
            //待定
            /*array.push('     <option>旬</option>');
            array.push('     <option>...</option>');*/
            array.push('     </select></td>');
            array.push('     <td class="center"><input type="text"                                          ');
            array.push('                               class="form-control date-picker date-beginTime-str"  placeholder="请选择时间"');
            array.push('                               name="dateTypeList['+ index +'].beginTimeStr"   ');
            array.push('                               value=""         id="date-beginTime-str'+index+'"');
            array.push('                               data-date-format="yyyy-mm-dd"                        ');
            array.push('                               style="width: 98%;border:none;"/></td>                            ');
            array.push('     <td class="center"><input type="text"                                          ');
            array.push('                               class="form-control date-picker date-endTime-str"                     ');
            array.push('                               name="dateTypeList['+ index +'].endTimeStr"     ');
            array.push('                               value="" id="date-endTime-str' + index +'" placeholder="请选择时间"          ');
            array.push('                               data-date-format="yyyy-mm-dd"                        ');
            array.push('                               style="width: 98%;border:none;"/></td>                            ');

            array.push('     <td class="center"><select');
            array.push('   name="dateTypeList['+ index +'].placeIdStr" style="width: 98%;border:none;">');
            array.push('<option value="">请选择省份</option>');
            <c:forEach items="${districtList}" var="district">
            array.push(' <option value="${district.id}">${district.districtName}</option>');
            </c:forEach>
            array.push('  </select></td>');

            array.push('     <td class="center"><input type="text" role="textbox"                           ');
            array.push('                               class="editable"                                     ');
            array.push('                               name="dateTypeList['+ index +'].specialPlace"         ');
            array.push('                               value=""  placeholder="请输入地点"                         ');
            array.push('                               style="width: 98%;border:none;"/></td>                            ');
            array.push('     <td class="center">                                                            ');
            array.push('         <button class="btn btn-minier btn-danger row-record-delete">                                 ');
            array.push('             <i class="ace-icon fa fa-times"></i>                                   ');
            array.push('             删除                                                                     ');
            array.push('         </button>                                                                  ');
            array.push('     </td>                                                                          ');
            array.push(' </tr>                                                                              ');

            $("#workStudy").find('tbody').append(array.join(''));

            bindDatePicker();
        });

        //删除一行
        $("#workStudy").on('click','.row-record-delete',function (e) {

            e.preventDefault();
            var id = $(e.target).closest('tr').data('id');
            var deleteUrl = '';

            if (!_.isEmpty(id)) {
                deleteUrl = '${basePath}/dateType/dateType-delete.do';
                deleteByUrl(e,deleteUrl,id);
            } else {
                $(e.target).closest('tr').remove();
            }
        });

        //删除方法
        function deleteByUrl(e,url,id) {

            G.confirm({
                message: '确认删除此条信息吗？',
                callback: function (result) {
                    if (result) {
                        $.post(url, {id: id}, function (data) {
                            if (data.result) {
                                G.showGritterSuccess("删除成功！");
                                $(e.target).closest('tr').remove();
                                //G.pjaxLoadPageContentDiv('#page/place/place-edit');
                            } else {
                                G.showGritterFail("删除失败！")
                            }
                        });
                    }
                }
            });
        }

        $saveForm.tjValidate({
            focusInvalid: false,
            rules: {
                title:{
                    required: true,
                    maxlength:500
                },
                deptName: {
                    required: true
                },
                actTypeName:{
                    required: true
                },
                place:{
                    required: true
                }
            },
            messages: {
                deptName: {
                    required: "承办单位不能为空"
                },
                title: {
                    required: "活动标题不能为空"
                },
                actTypeName: {
                    required: "请选择来源类别"
                },
                place:{
                    required: "省份不能为空"
                }
            }
        });
    });
</script>

