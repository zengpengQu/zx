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
                            <form class="form-horizontal" id="saveForm" role="form" autocomplete="off"
                                  action="${basePath}/gift-type/load-gift-type-save.do" method="post">

                                <input id="gift-type-id" name="id" type="hidden" value="${dicGiftType.id}">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 30px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${dicGiftType.id eq null}"> 礼品类型信息新增</c:when>
                                                    <c:otherwise> 礼品类型信息编辑</c:otherwise>
                                                </c:choose></h1>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-typeName">类型名称：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-typeName" name="typeName"
                                                       class="form-control " value="${dicGiftType.typeName}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-typeNumber">类型编码：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-typeNumber" name="typeNumber"
                                                       class="form-control " value="${dicGiftType.typeNumber}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-status">启用状态：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-status" name="status">
                                                    <option value="">---------请选择---------</option>
                                                    <option value="0" <c:if test="${dicGiftType.status eq '0'}">selected</c:if>>已启用</option>
                                                    <option value="1" <c:if test="${dicGiftType.status eq '1'}">selected</c:if>>未启用</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-createName">录入人：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-createName" name="createName"
                                                       class="form-control " value="${dicUser.empName}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-12 ">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="form-field-remark"
                                                   style="padding-left: 0px;">说明：<span
                                                    class="required">&nbsp;</span></label>

                                            <div class="col-sm-10">
                                                <textarea class="form-control limited" id="form-field-remark"
                                                    name="remark" style="min-height: 100px;">${dicGiftType.remark}</textarea>
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

        var $saveForm = $("#saveForm");

        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");

        var $typeId = $("#gift-type-id");
        var $typeNumber = $("#form-field-typeNumber");

        $saveBtn.on('click', function (e) {
            e.preventDefault();

            if ($saveForm.validate().form()) {

                $saveBtn.prop("disabled", true);
                $backBtn.prop("disabled", true);
                $saveForm.ajaxSubmit({
                    success: function (map) {
                        if (map.result) {
                            G.showGritterSuccess("保存成功!");
                            window.history.back(-1);
                        } else {
                            G.showGritterFail("保存失败,请稍后重试!");
                            $saveBtn.prop("disabled", false);
                            $backBtn.prop("disabled", false);
                        }
                    },
                    error: function () {
                        $saveBtn.prop("disabled", false);
                        $backBtn.prop("disabled", false);
                    }
                });
            }
        });

        $saveForm.tjValidate({
            focusInvalid: false,
            rules: {
                typeName: {
                    required: true,
                    maxlength: 50
                },
                typeNumber: {
                    required: true,
                    maxlength: 50,
                    remote: {
                        url: "${basePath}/gift-type/check-typeNumber.do",
                        type: "post",
                        dataType: "json",
                        async: false,
                        data: {
                            id: function () {
                                return $typeId.val();
                            },
                            typeNumber: function() {
                                return $typeNumber.val();
                            }
                        }
                    }
                },
                status: {
                    required: true
                },
                remark: {
                    required: false
                }
            },
            messages: {
                typeName: {
                    required: "类型名称不能为空"
                },
                typeNumber: {
                    required: "类型编码不能为空",
                    remote: "类型编码重复"
                },
                status: {
                    required: "启用状态不能为空"
                },
                remark: {
                    maxlength: 500
                }
            }
        });

        $backBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var listUrl = '#page/gift-type/gift-type-manage-list';

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
                    message: "您有礼品类型信息未保存，确认退出吗？",
                    callback: function (result) {
                        if (result) {
                            G.pjaxLoadPageContentDiv(listUrl);
                        }
                    }
                });
            }

        });
    });
</script>