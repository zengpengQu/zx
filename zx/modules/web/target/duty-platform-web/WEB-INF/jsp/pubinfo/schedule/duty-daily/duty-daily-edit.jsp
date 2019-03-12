<%--
  Created by IntelliJ IDEA.
  User: pengyx
  Date: 2018/7/4
  Time: 17:43
  新增/编辑值班日报
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
    <div class="col-sm-10 col-sm-offset-1">
        <div class="widget-box transparent">
            <div class="widget-body">
                <div class="widget-main">
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" role="form" id="saveForm" autocomplete="off"
                                  action="${basePath}/duty-daily/duty-edit-save.do" method="post">
                                <div class="hidden">
                                    <input type="text" id="form-field-id" name="id" value="${model.id}"/>
                                    <input type="text" id="form-field-status" name="status" value="${model.status}"/>
                                    <input type="text" id="form-field-user" name="dicUser.id"
                                           value="${currentUser.id}"/>
                                    <input type="text" id="form-field-delFlag" name="delFlag" value="${model.delFlag}"/>
                                    <input type="text" id="form-field-dataSource" name="dataSource"
                                           value="${model.dataSource}"/>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 5px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${model.id eq null}">值班日报新增</c:when>
                                                    <c:otherwise>值班日报编辑</c:otherwise>
                                                </c:choose></h1>
                                        </div>
                                    </div>
                                </div>

                                <div style="margin-top: 5%"></div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right"
                                                   for="form-field-deptId"> 部门名称： <span
                                                    class="required">*</span></label>
                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-deptId" name="dicDept.id"
                                                       class="hide" value="${curDept.id}"/>
                                                <input type="text" id="form-field-deptName" name="dicDept.deptName"
                                                       readonly="readonly"
                                                       class="form-control" value="${curDept.absName}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right"
                                                   for="form-field-createTimeStr"> 日期：<span
                                                    class="required" style="padding-right: 3px">*</span></label>

                                            <div class="col-sm-9">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="createTimeStr"
                                                           id="form-field-createTimeStr"
                                                           value="${model.jsonObject.createTimeStr}" type="text"/>
                                                    <span class="input-group-addon">
                                                        <i class="fa fa-calendar bigger-110"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right"
                                                   for="form-field-creatorName"> 信息员： <span
                                                    class="required">*</span></label>

                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-creatorName" name="creatorName"
                                                       class="form-control" value="${model.creatorName}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right"
                                                   for="form-field-tel"> 联系电话： <span class="required">*</span></label>

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
                                                   for="form-field-signLeader"> 签发领导： <span
                                                    class="required">*</span></label>

                                            <div class="col-sm-9 ">
                                                <input type="text" id="form-field-signLeader" name="signLeader"
                                                       class="form-control" value="${model.signLeader}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right"> 板块信息： <span
                                                    class="required">*</span></label>

                                            <div class="col-sm-9 ">
                                                <select class="form-control" name="sectionVoList[0].sectionId" required>
                                                    <option value="">--------请选择--------</option>
                                                    <c:forEach items="${sectionList}" var="section">
                                                        <option value="${section.id}"
                                                                <c:if test="${model.section.id eq section.id}">selected</c:if>>${section.sectionName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="hr hr-18 hr-double dotted"></div>

                                <div class="row">
                                    <div class="col-xs-12" style="margin-bottom: 12px">
                                        <h3 align="center">板块内容<span
                                                class="required">*</span></h3>
                                    </div>
                                    <div class="col-xs-12">
                                        <div id="editor" name="sectionVoList[0].sectionContent" type="text/plain"
                                             style="min-height: 200px"></div>
                                    </div>
                                </div>

                                <c:if test="${model.id eq null}">
                                    <div class="row ">
                                        <div class="col-xs-12 center">
                                            <div class="form-group btn-group" style="margin: 7.5px 0 7.5px">
                                                <button class="btn btn-sm btn-pink" type="button" id="addSection">
                                                    <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                                    新增板块内容
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>

                                <div class="clearfix form-actions center">
                                    <div class="col-xs-12">
                                        <button class="btn btn-info btn-sm" type="button" id="saveBtn">
                                            <i class="ace-icon fa fa-check bigger-110"></i>
                                            保存
                                        </button>
                                        <c:forEach items="${curOperateAuth}" var="curOpertate">
                                            <c:if test="${'50_7' eq curOpertate}">
                                                <c:if test="${model.status eq '0' or model.status eq null}">
                                                    &nbsp; &nbsp; &nbsp;
                                                    <button class="btn btn-success btn-sm" type="button" id="sendBtn">
                                                        <i class="ace-icon glyphicon glyphicon-arrow-up bigger-110"></i>
                                                        上报
                                                    </button>
                                                </c:if>
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

        UE.delEditor('editor');
        var ue = UE.getEditor('editor');

        ue.addListener("ready", function () {
            if ('${model.content}' !== '') {
                ue.setContent('${model.content}');
            }
        });

        G.datepicker({
            todayHighlight: true
        });

        var $saveForm = $('#saveForm');
        var $saveBtn = $("#saveBtn");
        var $sendBtn = $("#sendBtn");
        var $backBtn = $("#backBtn");
        var $addSection = $("#addSection");

        initPage();

        //初始化表单
        function initPage() {
            //为表单你赋值
            if (_.isEmpty($('#form-field-createTimeStr').val())) {
                $('#form-field-createTimeStr').val('${sysDate}');
            }
            if (_.isEmpty($('#form-field-creatorName').val())) {
                $('#form-field-creatorName').val('${currentUser.empName}');
            }
        }

        //值班日报保存
        $saveBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            saveDutyDaily('保存', $saveBtn);
        });
        //值班日报上报
        $sendBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            $("#form-field-status").val("1");
            saveDutyDaily('上报', $sendBtn);
        });

        var count = 1;
        //新增板块信息
        $addSection.unbind('click').bind('click', function (e) {

            var sectionArray = [];

            sectionArray.push('<div class="section">');
            sectionArray.push('<div class="hr hr-18 hr-double dotted"></div>');
            sectionArray.push('<div class="row" style="margin-bottom: 15px">');
            sectionArray.push('<div class="col-sm-offset-3 col-xs-6">');
            sectionArray.push('<div class="form-group">');
            sectionArray.push('<label class="col-sm-3 control-label no-padding-right"> 板块信息：');
            sectionArray.push('<span class="required">*</span></label>');
            sectionArray.push('<div class="col-sm-9 ">');
            sectionArray.push('<select class="form-control"  name="sectionVoList[' + count + '].sectionId" required>');
            sectionArray.push('<option value="">--------请选择--------</option>');
            sectionArray.push('<c:forEach items="${sectionList}" var="section">');
            sectionArray.push('<option value="${section.id}">${section.sectionName}</option>');
            sectionArray.push('</c:forEach>');
            sectionArray.push('</select>');
            sectionArray.push('</div>');
            sectionArray.push('</div>');
            sectionArray.push('</div>');
            sectionArray.push('<div class="col-xs-3">');

            sectionArray.push('<div class="btn-group pull-right">');
            sectionArray.push(' <button class="btn btn-sm btn-danger section-delete">');
            sectionArray.push(' <i class="ace-icon fa fa-trash-o section-delete"></i> 删除');
            sectionArray.push('</button>');
            sectionArray.push('</div>');
            sectionArray.push('</div>');
            sectionArray.push('</div>');

            sectionArray.push('<div class="row">');
            sectionArray.push('<div class="col-xs-12" style="margin-bottom: 12px">');
            sectionArray.push('<h3 align="center" style="font-weight: bold;">板块内容 ');
            sectionArray.push('<span class="required">*</span></h3>');
            sectionArray.push('</div>');
            sectionArray.push('<div class="col-xs-12">');
            sectionArray.push('<div id="editor' + count + '" name="sectionVoList[' + count + '].sectionContent" type="text/plain"');
            sectionArray.push('style="min-height: 200px"></div>');
            sectionArray.push('</div>');
            sectionArray.push('</div>');

            sectionArray.push('</div>');

            $(this).closest('.row').before(sectionArray.join(''));

            UE.delEditor('editor' + count);
            UE.getEditor('editor' + count);

            //绑定删除事件
            $('.section-delete').unbind('click').bind('click', function (e) {
                e.preventDefault();
                $(this).closest('.section').remove();
            });

            count++;
        });

        function saveDutyDaily(type, $btn) {
            if ($saveForm.validate().form()) {
                var load = G.showAjaxLoading("正在保存中，请稍候...");
                $btn.prop('disabled', true);
                $saveForm.ajaxSubmit({
                    success: function (map) {
                        G.doneAjaxLoading(load);
                        if (map.result) {
                            G.showGritterSuccess(type + "成功!");
                            G.pjaxLoadPageContentDiv("#page/duty-daily/duty-daily-list");
                        } else {
                            G.showGritterFail(type + "失败,请稍后重试!");
                        }
                    },
                    error: function () {
                        G.doneAjaxLoading(load);
                        G.showGritterFail(type + "失败,请稍后重试!");
                        $btn.prop('disabled', false);
                    }
                });
            }
        }

        //返回
        $backBtn.unbind('click').bind('click', function () {
            window.history.back(-1);
        });

        $saveForm.tjValidate({
            focusInvalid: false,
            rules: {
                deptName: {
                    required: true
                },
                createTimeStr: {
                    required: true
                },
                creatorName: {
                    required: true
                },
                tel: {
                    required: true
                },
                signLeader: {
                    required: true
                },
                "section.id": {
                    required: true
                },
                content: {
                    required: true
                }
            },
            messages: {
                deptName: {
                    required: "部门名称不能为空"
                },
                createTimeStr: {
                    required: "日期不能为空"
                },
                creatorName: {
                    required: "信息员名称不能为空"
                },
                tel: {
                    required: "电话信息不能为空"
                },
                signLeader: {
                    required: "签发领导不能为空"
                },
                "section.id": {
                    required: "板块信息不能为空"
                },
                content: {
                    required: "内容不能为空"
                }
            }
        });

        $(document).one('ajaxloadstart.page', function (e) {
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>

