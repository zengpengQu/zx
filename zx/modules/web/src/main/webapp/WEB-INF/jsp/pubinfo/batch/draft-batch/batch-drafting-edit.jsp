<%--
  Created by IntelliJ IDEA.
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

<%--word导出--%>
<script src="${basePath}/plugin/wordExport/js/FileSaver.js"></script>
<script src="${basePath}/plugin/wordExport/js/jquery.wordexport.js"></script>

<div class="tab">
    <ul class="tabbale-uls" id="table" style="margin-bottom: 15px;">
        <li class="active" style="    flex: unset;">
            <a data-toggle="tab" href="#nei">内行文</a>
        </li>
        <li style="flex: unset;">
            <a data-toggle="tab" href="#wai">外行文</a>
        </li>
    </ul>
    <div class="tab-content" style="border: 0px">
        <div class="tab-pane fade in active" id="nei">
            <div class="row">
                <div class="col-xs-10 col-sm-offset-1">
                    <div class="widget-box transparent">
                        <div class="widget-body">
                            <div class="widget-main">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <form class="form-horizontal" role="form" id="saveForm">
                                            <input id="id-batch-draft" name="id" type="hidden" value="${model.id}">
                                            <div class="row">
                                                <div class="col-xs-12">
                                                    <div class="form-group">
                                                        <h1 align="center" style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                            内行文呈批件
                                                        </h1>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row" style="margin-top: 10px;margin-bottom: 10px">
                                                <div class="col-xs-12" align="right" style="padding-right: 210px">
                                                    <button class="btn btn-sm btn-pink" type="button" id="wordBtn">
                                                        <i class="ace-icon fa fa-plus icon-on-right bigger-110"></i>
                                                        word模板
                                                    </button>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-xs-10">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label"
                                                               for="form-field-title"> 标题：<span class="required">*</span> </label>
                                                        <div class="col-sm-9 ">
                                                            <input type="text" id="form-field-title" name="title"
                                                                   class="form-control" value="${model.title}"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-xs-10">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label "
                                                               for="form-field-orgName"> 部门： <span class="required">*</span></label>
                                                        <div class="col-sm-9">
                                                            <input type="text" id="form-field-deptId" name="deptId"
                                                                   class="hide" value=""/>
                                                            <input type="text" class="form-control" id="form-field-orgName"
                                                                   readonly="readonly"
                                                                   name="orgName" value="" style="cursor: pointer;"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-xs-10">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label "
                                                               for="form-field-depLeader"> 部门领导：<span class="required">*</span> </label>
                                                        <div class="col-sm-9 ">
                                                            <input type="text" id="form-field-depLeader" name="depLeader"
                                                                   class="form-control" value=""/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-xs-10">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label "
                                                               for="form-field-reporter"> 拟稿人： <span class="required">*</span></label>
                                                        <div class="col-sm-9 ">
                                                            <input type="text" id="form-field-reporter" name="reporter"
                                                                   readonly="readonly" class="form-control" value="${model.reporter}"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-xs-10">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label "
                                                               for="form-field-tel"> 联系电话：<span class="required">*</span> </label>
                                                        <div class="col-sm-9 ">
                                                            <input type="text" id="form-field-tel" name="tel"
                                                                   class="form-control" value="${model.tel}"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-xs-10">
                                                    <div class="form-group">
                                                        <label class="col-xs-3 control-label "
                                                        > 是否会签： <span class="required">&nbsp;</span></label>
                                                        <div class="col-xs-2">
                                                            <input type="radio" name="counterSignFlag"
                                                                   class="control-label " style="font-weight: bold;" value="1"
                                                                   <c:if test="${'1' eq model.counterSignFlag}">checked</c:if>
                                                                   checked="checked"
                                                            />是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            <input type="radio" name="counterSignFlag" class="control-label "
                                                                   style="font-weight: bold;" value="0"
                                                                   <c:if test="${'0' eq model.counterSignFlag}">checked</c:if>
                                                            />否
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-xs-10" id="hideDiv">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label "
                                                               for="form-field-counterSignUnit"> 会签单位：<span class="required">*</span> </label>
                                                        <div class="col-sm-9">
                                                            <input type="text" class="form-control" id="form-field-counterSignUnit"
                                                                   name="counterSignUnit" value=""/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="clearfix form-actions center">
                                                <div class="col-xs-10">
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
        </div>
        <div class="tab-pane fade" id="wai">
            <div class="row">
                <div class="col-xs-10 col-sm-offset-1">
                    <div class="widget-box transparent">
                        <div class="widget-body">
                            <div class="widget-main">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <form class="form-horizontal" role="form" id="saveFormWai">
                                            <input id="id-batch-draft-wai" name="id" type="hidden" value="${draftBatchOut.id}">
                                            <div class="row">
                                                <div class="col-xs-12">
                                                    <div class="form-group">
                                                        <h1 align="center" style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                            外行文呈批件
                                                        </h1>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row" style="margin-top: 10px;margin-bottom: 10px">
                                                <div class="col-xs-12" align="right" style="padding-right: 210px">
                                                    <button class="btn btn-sm btn-pink" type="button" id="wordBtnWai">
                                                        <i class="ace-icon fa fa-plus icon-on-right bigger-110"></i>
                                                        word模板
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-xs-10">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label "
                                                               for="form-field-titleWai"> 标题：<span class="required">*</span> </label>
                                                        <div class="col-sm-9 ">
                                                            <input type="text" id="form-field-titleWai" name="title"
                                                                   class="form-control" value="${draftBatchOut.title}"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-xs-10">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label "
                                                               for="form-field-orgNameWai"> 来文单位：<span class="required">*</span>
                                                        </label>
                                                        <div class="col-sm-9 ">
                                                            <input type="text" id="form-field-orgNameWai" name="orgName"
                                                                   class="form-control" value="${draftBatchOut.orgName}"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-xs-10">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label "
                                                               for="form-field-deptName"> 承办部门：<span class="required">*</span>
                                                        </label>
                                                        <div class="col-sm-9 deptDiv">
                                                            <input type="text" id="form-field-depNameWai"
                                                                   name="orgId"
                                                                   class="hide" value=""/>
                                                            <input type="text" class="form-control" id="form-field-deptName"
                                                                   readonly="readonly"
                                                                   name="deptName" value="" style="cursor: pointer;"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-xs-10">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label "
                                                               for="form-field-depLeaderwai"> 承办方部门领导：<span class="required">*</span>
                                                        </label>
                                                        <div class="col-sm-9 ">
                                                            <input type="text" id="form-field-depLeaderwai" name="depLeader"
                                                                   class="form-control" value=""/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-xs-10">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label "
                                                               for="form-field-contractor"> 承办人：<span class="required">*</span> </label>
                                                        <div class="col-sm-9 ">
                                                            <input type="text" id="form-field-contractor" name="contractor"
                                                                   class="form-control" value="${draftBatchOut.contractor}"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-xs-10">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label "
                                                               for="form-field-telWai"> 联系电话：<span class="required">*</span> </label>
                                                        <div class="col-sm-9 ">
                                                            <input type="text" id="form-field-telWai" name="tel"
                                                                   class="form-control" value="${model.tel}"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-xs-10">
                                                    <div class="form-group">
                                                        <label class="col-xs-3 control-label "
                                                        > 是否会签： <span class="required">&nbsp;</span></label>
                                                        <div class="col-xs-2">
                                                            <input type="radio" name="counterSignFlag"
                                                                   class="control-label " style="font-weight: bold;" value="1"
                                                                   <c:if test="${'1' eq model.counterSignFlag}">checked</c:if>
                                                                   checked="checked"
                                                            />是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            <input type="radio" name="counterSignFlag" class="control-label "
                                                                   style="font-weight: bold;" value="0"
                                                                   <c:if test="${'0' eq model.counterSignFlag}">checked</c:if>
                                                            />否
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-xs-10">
                                                    <div class="form-group" id="hideDivOut">
                                                        <label class="col-sm-3 control-label "
                                                               for="form-field-counterSignUnitWai"> 会签单位： <span class="required">*</span></label>

                                                        <div class="col-sm-9">
                                                            <input type="text" class="form-control"
                                                                   id="form-field-counterSignUnitWai"
                                                                   name="counterSignUnit" value="" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="clearfix form-actions center">
                                                <div class="col-xs-10">
                                                    <button class="btn btn-info btn-sm" type="button" id="saveBtnWai">
                                                        <i class="ace-icon fa fa-check bigger-110"></i>
                                                        保存
                                                    </button>
                                                    &nbsp;&nbsp;&nbsp;
                                                    <button class="btn btn-primary btn-sm" type="button" id="backBtnWai">
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
        </div>
    </div>
</div>

<div id="preview-dialog" class="hide" style="background-color: darkseagreen"></div>

<script type="text/javascript">
        var scripts = [null, null];
        $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

            G.initDept('deptDiv',true,[null,null,null,null],TREE_NODE);

            var $saveForm = $('#saveForm');
            var $saveFormWai = $('#saveFormWai');
            var $saveBtn = $("#saveBtn");
            var $saveBtnWai = $("#saveBtnWai");
            var $backBtn = $("#backBtn");
            var $backBtnWai = $("#backBtnWai");
            var $wordBtn = $("#wordBtn");
            var $wordBtnWai = $("#wordBtnWai");

            var saveUrl = '${basePath}/draft-batch/batch-drafting-save.do';
            var saveUrlWai = '${basePath}/draft-batch/batch-drafting-wai-save.do';
            var batchDraftId = $saveForm.find("#id-batch-draft").val();
            var batchDraftIdWai = $saveFormWai.find("#id-batch-draft-wai").val();

            var $previewDialog = $("#preview-dialog");

            var $wai = $('#wai');
            initPage();

            //是否会签单选按钮和文本框的联动
            $(":radio").click(function () {
                var num = $(this).val();
                if(num==0){
                    $("#hideDiv").hide();
                    $("#hideDivOut").hide();
                }
                if(num==1){
                    $("#hideDiv").show();
                    $("#hideDivOut").show();
                }
            });

            //初始化表单
            function initPage() {
                //为表单赋值
                if (_.isEmpty($('#form-field-orgName').val())) {
                    $('#form-field-deptId').val('${curDept.id}');
                    $('#form-field-orgName').val('${curDept.deptName}');
                }
                if (_.isEmpty($('#form-field-reporter').val())) {
                    $('#form-field-reporter').val('${currentUser.empName}');
                }
            }
            G.datepicker({
                todayHighlight: true
            });
            $wordBtn.click(function () {
                exportWord('内行文');
            });
            $wordBtnWai.click(function () {
                exportWord('外行文');
            });

            function exportWord(type) {
                var url = '${basePath}/draft-batch/batch-drafting-words.do';
                //不跳转页面，直接将页面嵌入弹出框
                var loadId = G.showAjaxLoading();
                $.ajax({
                    url: url,
                    type: "GET",
                    dataType: "html",
                    success: function (String) {
                        $previewDialog.html(String);
                        G.doneAjaxLoading(loadId);
                        //初始化弹出框
                        initPreviewDialog($previewDialog, type);
                    },
                    error: function (e) {
                        G.doneAjaxLoading(loadId);
                        G.alert({message: "操作失败！"});
                    }
                });
            }

            function initPreviewDialog($container, type) {

                $container.removeClass('hide').dialog({
                    resizable: false,
                    height: 700,
                    width: 1200,
                    modal: true,
                    title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>Word模板预览</h4></div>",
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
                                $container.wordExport(type + "呈批件模板-${sysDate}");
                                $(this).dialog("close");
                            }
                        }
                    ]
                });
            }

            //点击保存提交数据
            $saveBtn.unbind('click').bind('click', function (e) {
                e.preventDefault();
                if($saveForm.validate().form()){
                    var data = $saveForm.serializeObject();
                    data["batchDraftId"] = batchDraftId;

                    G.confirm({
                        message: '确认保存此条信息吗？',
                        callback: function (result) {
                            if (result) {
                                var loadId = G.showAjaxLoading();
                                $.ajax({
                                    url: saveUrl,
                                    type: 'POST',
                                    dataType: 'json',
                                    data: data,
                                    async: true
                                }).done(function (map) {
                                    G.doneAjaxLoading(loadId);
                                    if (map.result) {
                                        G.showGritterSuccess("保存成功");
                                        G.pjaxLoadPageContentDiv("#page/submit-batch/batch-submit-list?SubSecPopeDomViewId=79");
                                    } else {
                                        G.showGritterFail("保存信息失败,请稍后重试!");
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
                    title:{
                        required:true,
                        maxlength: 500
                    },
                    tel:{
                        required:true,
                        maxlength: 20
                    },
                    depLeader:{
                        required:true,
                        maxlength: 20
                    },
                    counterSignUnit:{
                        required:true,
                        maxlength: 200
                    }
                },
                messages:{
                    title:{
                        required:"标题不能为空"
                    },
                    tel:{
                        required:"联系电话不能为空"
                    },
                    depLeader:{
                        required:"部门领导不能为空"
                    },
                    counterSignUnit:{
                        required:"会签单位不能为空"
                    }

                }
            });

            //新增或编辑提交数据
            $saveBtnWai.unbind('click').bind('click', function (e) {
                e.preventDefault();
                if($saveFormWai.validate().form()){
                    var data = $saveFormWai.serializeObject();
                    data["batchDraftIdWai"] = batchDraftIdWai;
                    G.confirm({
                        message: '确认保存此条信息吗？',
                        callback: function (result) {
                            if (result) {
                                var loadId = G.showAjaxLoading();
                                $.ajax({
                                    url: saveUrlWai,
                                    type: 'POST',
                                    dataType: 'json',
                                    data: data,
                                    async: true
                                }).done(function (map) {
                                    G.doneAjaxLoading(loadId);
                                    if (map.result) {
                                        G.showGritterSuccess("保存成功");
                                        G.pjaxLoadPageContentDiv("#page/submit-batch-out/batch-submit-list?SubSecPopeDomViewId=79");
                                    } else {
                                        G.showGritterFail("保存信息失败,请稍后重试!");
                                    }
                                });
                            }
                        }
                    });
                }
            });
            $saveFormWai.tjValidate({
                focusInvalid: false,
                rules:{
                    title:{
                        required:true
                    },
                    orgName:{
                        required:true
                    },
                    contractor:{
                        required:true
                    },
                    deptName:{
                        required:true
                    },
                    orgId:{
                      required:true
                    },
                    tel:{
                        required:true
                    },
                    depLeader:{
                        required:true
                    },
                    counterSignUnit:{
                        required:true
                    }
                },
                messages:{
                    title:{
                        required:"标题不能为空"
                    },
                    orgName:{
                        required:"来文单位不能为空"
                    },
                    deptName:{
                        required:"承办部门不能为空"
                    },
                    orgId:{
                      required:"承办部门不能为空"
                    },
                    contractor:{
                      required:"承办人不能为空"
                    },
                    tel:{
                        required:"联系电话不能为空"
                    },
                    depLeader:{
                        required:"承办方领导不能为空"
                    },
                    counterSignUnit:{
                        required:"会签单位不能为空"
                    }

                }
            });

            //返回
            $backBtn.unbind('click').bind('click', function () {
                // G.pjaxLoadPageContentDiv("#page/submit-batch/batch-submit-list?SubSecPopeDomViewId=79");
                G.back();
            });
            $backBtnWai.unbind('click').bind('click', function () {
                // G.pjaxLoadPageContentDiv("#page/submit-batch/batch-submit-list?SubSecPopeDomViewId=79");
                G.back();
            });
        });
    </script>





