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
<%--word导出--%>
<script src="${basePath}/plugin/wordExport/js/FileSaver.js"></script>
<script src="${basePath}/plugin/wordExport/js/jquery.wordexport.js"></script>

<div class="row">
    <div class="col-xs-10 col-sm-offset-1">
        <div class="widget-box transparent">
            <div class="widget-body">
                <div class="widget-main">
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" role="form" id="saveForm" autocomplete="off"
                                  action="${basePath}/supervision-matter/supervision-matter-save.do" method="post">
                                <%--隐藏域--%>
                                <div class="hidden">
                                    <input type="text" id="form-field-id" name="id" value="${model.id}"/>
                                    <input type="text" id="form-field-status" name="status" value="${model.status}"/>
                                    <input type="text" id="form-field-delFlag" name="delFlag" value="${model.delFlag}"/>
                                </div>
                                <%--新增/编辑--%>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 5px">
                                            <h1 align="center" style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${model.id eq null}">督查事项管理新增</c:when>
                                                    <c:otherwise>督查事项管理编辑</c:otherwise>
                                                </c:choose></h1>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin-top: 10px;margin-bottom: 10px">
                                    <div class="col-xs-12" align="right" style="padding-right: 80px">
                                        <button class="btn btn-sm btn-pink" type="button" id="wordBtn">
                                            <i class="ace-icon fa fa-plus icon-on-right bigger-110"></i>
                                            生成督查事项交办单
                                        </button>
                                    </div>
                                </div>
                                <div style="margin-top: 5%"></div>
                                <div class="row">
                                    <%--主办单位--%>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label no-padding-left"
                                                   for="form-field-hostUnit">主办单位：
                                                <span class="required">*</span>
                                            </label>

                                            <div class="col-sm-8 deptDiv">
                                                <input type="text" id="orm-field-hostUnitId" name="hostUnitId"
                                                       class="hide" value="${model.hostUnit.id}"/>
                                                <input type="text" class="form-control"
                                                       id="form-field-hostUnit"
                                                       name="hostDeptName" value="${model.hostUnit.absName}"
                                                       style="cursor: pointer;" readonly="readonly"/>
                                            </div>
                                        </div>
                                    </div>
                                    <%--协作单位--%>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label no-padding-left"
                                                   for="form-field-deptId">协作单位：
                                                <span class="required">*</span>
                                            </label>

                                            <div class="col-sm-8 deptDiv">
                                                <input type="text" id="form-field-deptId" name="deptId"
                                                       class="hide" value="${model.cooperative.id}"/>
                                                <input type="text" class="form-control"
                                                       id="form-field-deptName"
                                                       name="deptName" value="${model.cooperative.absName}"
                                                       style="cursor: pointer;" readonly="readonly"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <%--督查事项编号--%>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label no-padding-left"
                                                   for="form-field-serialNumber"> 督查事项编号：
                                                <span class="required">*</span>
                                            </label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-serialNumber" class="form-control"
                                                       name="serialNumber" value="${model.jsonObject.serialNumber}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <%--下发日期--%>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label no-padding-left"
                                                   for="form-field-issuedDate"> 下发日期：
                                                <span class="required">*</span>
                                            </label>
                                            <div class="col-sm-8">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="issuedDateStr"
                                                           id="form-field-issuedDate"
                                                           value="${model.jsonObject.issuedDate}" type="text"/>
                                                    <span class="input-group-addon">
                                                    <i class="fa fa-calendar bigger-110"></i>
                                                </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- 空格 -->
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                                <div class="row">
                                    <%--督查事项--%>
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="form-field-supMatter">
                                                督查事项：<span class="required">*</span>
                                            </label>
                                            <div class="col-sm-10 ">
                                        <textarea id="form-field-supMatter" name="supMatter"
                                                  class="form-control "
                                                  maxlength="2000" style="min-height: 100px">${model.jsonObject.supMatter}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- 空格 -->
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                                <div class="row">
                                    <%--办理要求--%>
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="form-field-requirements">
                                                办理要求：<span class="required">*</span>
                                            </label>
                                            <div class="col-sm-10 ">
                                        <textarea id="form-field-requirements" name="requirements"
                                                  class="form-control "
                                                  maxlength="2000" style="min-height: 100px">${model.jsonObject.requirements}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%--按钮--%>
                                <div class="clearfix form-actions center">
                                    <div class="col-xs-12">
                                        <button class="btn btn-info btn-sm" type="button" id="saveBtn">
                                            <i class="ace-icon fa fa-check bigger-110"></i>
                                            保存
                                        </button>
                                        <c:forEach items="${curOperateAuth}" var="curOpertate">
                                            <c:if test="${'74_6' eq curOpertate}">
                                                <c:if test="${model.status eq '0' or model.status eq null}">
                                                    &nbsp; &nbsp; &nbsp;
                                                    <button class="btn btn-success btn-sm" type="button" id="sendBtn">
                                                        <i class="ace-icon glyphicon glyphicon-arrow-down bigger-110"></i>
                                                        下发
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

<div id="preview-dialog"  class="hide" style="background-color: darkseagreen"></div>
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.initDept('deptDiv', true, ['${hostUnit}', '${cooperative}'], TREE_NODE);

        //时间控件
        G.datepicker({todayHighlight: true});

        //按钮
        var $saveForm = $('#saveForm');
        var $saveBtn = $("#saveBtn");
        var $sendBtn = $("#sendBtn");
        var $backBtn = $("#backBtn");

        var $id = $("#form-field-id");
        var $previewDialog = $("#preview-dialog");

        //数据校验
        $saveForm.tjValidate({
            focusInvalid: false,
            rules: {
                hostDeptName: {
                    required: true
                },
                deptName: {
                    required: true
                },
                serialNumber: {
                    required: true,
                    maxlength: 32
                },
                issuedDateStr: {
                    required: true
                },
                supMatter: {
                    required: true,
                    maxlength: 200
                },
                requirements: {
                    required: true,
                    maxlength: 500
                }
            },
            messages: {
                hostDeptName: {
                    required: "主办单位不能为空"
                },
                deptName: {
                    required: "协作单位不能为空"
                },
                serialNumber: {
                    required: "督查事项编号不能为空"
                },
                issuedDateStr: {
                    required: "下发日期不能为空"
                },
                supMatter: {
                    required: "督查事项不能为空"
                },
                requirements: {
                    required: "办理要求不能为空"
                }
            }
        });

        //保存操作
        $saveBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            if ($saveForm.validate().form()) {
                saveSupervisionMatter('保存', $saveBtn);
            }
        });

        $sendBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            $("#form-field-status").val("1");
            if ($saveForm.validate().form()) {
                saveSupervisionMatter('下发', $sendBtn);
            }
        });

        var id = $id.val();
        if (id == "") {

        } else {
            var cooperativeId = '${supervisionMatter.cooperativeId}';
            var cooperativeName = '${supervisionMatter.cooperativeName}';
            $("#form-field-deptId").val(cooperativeId);
            $("#form-field-deptName").val(cooperativeName);
        }

        function saveSupervisionMatter(type, $btn) {
            if ($saveForm.validate().form()) {
                var load = G.showAjaxLoading("正在保存中，请稍候...");
                $btn.prop("disabled", true);
                $saveForm.ajaxSubmit({
                    success: function (map) {
                        G.doneAjaxLoading(load);
                        if (map.result) {
                            G.showGritterSuccess(type + "成功!");
                            G.pjaxLoadPageContentDiv("#page/supervision-matter/supervision-matter-list");
                        } else {
                            G.showGritterFail(type + "失败,请稍后重试!");
                            $btn.prop("disabled", false);
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
            window.history.back(-1);
        });

        $(document).one('ajaxloadstart.page', function (e) {
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

        var $wordBtn = $("#wordBtn");
        $wordBtn.click(function () {
            G.confirm({
                message: '确认生成督查事项交办单吗?',
                callback: function (result) {
                    if (result) {
                        var deptName = $("#form-field-deptName").val();
                        var hostDeptName = $("#form-field-hostUnit").val();
                        var supMatter = $("#form-field-supMatter").val();
                        var serialNumber = $("#form-field-serialNumber").val();
                        var requirements = $("#form-field-requirements").val();

                        var excelUrl = '${basePath}/supervision-feedback/export-excel-com.do';
                        var loadId = G.showAjaxLoading();
                        $.ajax({
                            url: excelUrl,
                            type: "GET",
                            data: {deptName:encodeURI(deptName),hostDeptName:encodeURI(hostDeptName),
                                supMatter:encodeURI(supMatter),serialNumber:encodeURI(serialNumber),
                                requirements:encodeURI(requirements)},
                            dataType: "html",
                            success: function (String) {
                                $previewDialog.html(String);
                                G.doneAjaxLoading(loadId);
                                //初始化弹出框
                                initPreviewDialogWord($previewDialog);
                            },
                            error: function (e) {
                                G.doneAjaxLoading(loadId);
                                G.alert({message: "操作失败！"});
                            }
                        });

                    }
                }
            });
        });


        //初始化弹框
        function initPreviewDialogWord($container) {
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 700,
                width: 1200,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>督查事项交办单预览</h4></div>",
                title_html: true,
                close: function () {
                    $container.addClass("hide");
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-warning",
                        click: function () {
                            $(this).dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 导出",
                        "class": "btn btn-success",
                        click: function () {
                            $container.wordExport('督查事项交办单${sysDate}');
                            $(this).dialog("close");
                        }
                    }
                ]
            });
        }


    });
</script>