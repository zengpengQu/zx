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
                            <form class="form-horizontal" id="new-edit-form" role="form" method="post" autocomplete="off">
                                <input id="id-telegraph-manage" name="telegraphId" type="hidden"
                                       value="${telegraphManage.id}">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 5px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                电报传阅新增
                                            </h1>
                                        </div>
                                    </div>
                                </div>
                                <div style="margin-top: 5%"></div>

                                <div class="row">
                                    <!-- 来文标题 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-telegramTitle">来文标题：<span
                                                    class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-telegramTitle" name="telegramTitle"
                                                       class="form-control " value="${telegraphManage.telegramTitle}"
                                                       readonly="readonly"/>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 存档标志 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-archiveFlag">存档标志：<span
                                                    class="red">&nbsp;</span></label>
                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-archiveFlag"
                                                        name="archiveFlag">
                                                    <option value="0">-----请选择-----</option>
                                                    <option value="1">未存档</option>
                                                    <option value="2">已存档</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>

                                <div class="row">
                                    <!-- 借出时间 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label no-padding-right"
                                                   for="form-field-lendTime"> 借出时间：<span
                                                    class="required">*</span></label>
                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="lendTimeStr"
                                                           id="form-field-lendTime"

                                                           type="text"/>
                                                    <span class="input-group-addon">
                                                            <i class="fa fa-calendar bigger-110"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 归还时间 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label no-padding-right"
                                                   for="form-field-returnTime"> 归还时间：<span
                                                    class="required">*</span></label>
                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="returnTimeStr"
                                                           id="form-field-returnTime"
                                                           type="text"/>
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
                                    <!-- 去向 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-destination">去向：<span
                                                    class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-destination" name="destination"
                                                       class="form-control " value=""
                                                />
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 流转 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-circulation">流转：<span
                                                    class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-circulation" name="circulation"
                                                       class="form-control " value=""
                                                />
                                            </div>
                                        </div>
                                    </div>
                                </div>
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
<script src="${basePath}/plugin/ace/assets/js/ace/elements.fileinput.js"></script>
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {
        //时间控件校验
        G.datepicker({autoclose: true, todayHighlight: true});

        // 控件类全局变量
        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");

        // 表单类全局变量
        var $saveForm = $("#new-edit-form");

        //其他全局变量
        var fd = new FormData();
        var telegraphId = $saveForm.find("#id-telegraph-manage").val();

        //本地url
        var url = '${basePath}/circulate-record/load-circulate-telegraph-save.do';
        var localUrl = '#page/telegraph-manage/jump-to-telegraph-manage-list';

        //电报传阅新增提交数据
        $saveBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var data = $saveForm.serializeObject();
            data["telegraphId"] = telegraphId;
            $("#form-field-archiveFlag").change(function () {
                data["archiveFlag"] = $(this).val();
            });
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
                                async: true
                            }).done(function (map) {
                                G.doneAjaxLoading(loadId);
                                if (map.result) {
                                    G.showGritterSuccess("保存成功");
                                    G.pjaxLoadPageContentDiv(localUrl);
                                } else {
                                    G.showGritterFail("保存信息失败,请稍后重试！");
                                }
                            });
                        }
                    }
                });
            }

        });

        //电报传阅返回操作
        $backBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var postData = $saveForm.serializeObject();
            var flag = 0;
            $.each(postData, function (index, item) {
                if (item !== "") {
                    flag = 1;
                }
            });
            if (flag === 0) {
                G.pjaxLoadPageContentDiv(localUrl);
            } else {
                G.confirm({
                    message: "您的文件信息尚未保存，确认退出吗？",
                    callback: function (result) {
                        if (result){
                            G.pjaxLoadPageContentDiv(localUrl);
                        }

                    }
                });
            }
        });

        //数据校验
        $saveForm.tjValidate({
            focusInvalid: false,
            rules: {
                lendTimeStr: {
                    required: true
                },
                returnTimeStr: {
                    required: true,
                    compareDate: '#form-field-lendTime'
                },
                destination: {
                    required: true
                },
                circulation: {
                    required: true
                }
            },
            messages: {
                lendTimeStr: {
                    required: "借出时间不能为空"
                },
                returnTimeStr: {
                    required: "归还时间不能为空"
                },
                destination: {
                    required: "去向不能为空"
                },
                circulation: {
                    required: "流转不能为空"
                }
            }
        });
        $(document).one('ajaxloadstart.page', function (e) {
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>