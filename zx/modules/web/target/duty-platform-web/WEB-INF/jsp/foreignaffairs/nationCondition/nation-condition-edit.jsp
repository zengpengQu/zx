<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>

<title>履职支撑平台</title>

<script src="${basePath}/plugin/ace/assets/js/chosen.jquery.js"></script>

<div class="row">
    <div class="col-sm-10 col-sm-offset-1">
        <div class="widget-box transparent">
            <div class="widget-body">
                <div class="widget-main">
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" id="nationForm" role="form" autocomplete="off" method="post">
                                <input id="id" name="id" type="hidden" value="${nation.id}">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 30px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${nation.id eq null}"> 国家情况管理新增</c:when>
                                                    <c:otherwise> 国家情况管理编辑</c:otherwise>
                                                </c:choose></h1>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" >国家名称：<span
                                                    class="required">*</span></label>
                                            <div class="col-sm-8 ">
                                                <select class="chosen-select form-control" id="nationId"
                                                        name="dicNation.id" data-placeholder="请选择...">
                                                    <option value=""> </option>
                                                    <c:forEach items="${dicNationList}" var="dicNation">
                                                        <option value="${dicNation.id}" <c:if test="${nation.dicNation.id eq dicNation.id}">selected</c:if> >${dicNation.nationName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" >所属地区：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="belongArea" name="belongArea"
                                                       class="form-control " value="${nation.belongArea}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" >一带一路国家：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8" style="margin-top: 5px">
                                                <label>
                                                    <input name="isOborNation" type="radio" class="ace input-lg"
                                                           value="0" <c:if test="${nation.isOborNation eq '0'}">checked</c:if>>
                                                    <span class="lbl bigger-120"> 是</span>
                                                </label>
                                                <label>
                                                    <input name="isOborNation" type="radio" class="ace input-lg"
                                                           value="1" <c:if test="${nation.isOborNation eq '1'}">checked</c:if>>
                                                    <span class="lbl bigger-120"> 否</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" style="padding-left: 0px">阿拉伯国家：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8" style="margin-top: 5px">
                                                <label>
                                                    <input name="isArabNation" type="radio" class="ace input-lg"
                                                           value="0" <c:if test="${nation.isArabNation eq '0'}">checked</c:if>>
                                                    <span class="lbl bigger-120"> 是</span>
                                                </label>
                                                <label>
                                                    <input name="isArabNation" type="radio" class="ace input-lg"
                                                           value="1" <c:if test="${nation.isArabNation eq '1'}">checked</c:if>>
                                                    <span class="lbl bigger-120"> 否</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" >周边国家：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8" style="margin-top: 5px">
                                                <label>
                                                    <input name="isAroundNation" type="radio" class="ace input-lg"
                                                           value="0" <c:if test="${nation.isAroundNation eq '0'}">checked</c:if>>
                                                    <span class="lbl bigger-120"> 是</span>
                                                </label>
                                                <label>
                                                    <input name="isAroundNation" type="radio" class="ace input-lg"
                                                           value="1" <c:if test="${nation.isAroundNation eq '1'}">checked</c:if>>
                                                    <span class="lbl bigger-120"> 否</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" >西方发达国家：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8" style="margin-top: 5px">
                                                <label>
                                                    <input name="isWestNation" type="radio" class="ace input-lg"
                                                           value="0" <c:if test="${nation.isWestNation eq '0'}">checked</c:if>>
                                                    <span class="lbl bigger-120"> 是</span>
                                                </label>
                                                <label>
                                                    <input name="isWestNation" type="radio" class="ace input-lg"
                                                           value="1" <c:if test="${nation.isWestNation eq '1'}">checked</c:if>>
                                                    <span class="lbl bigger-120"> 否</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" >其他国家：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8" style="margin-top: 5px">
                                                <label>
                                                    <input name="isOtherNation" type="radio" class="ace input-lg"
                                                           value="0" <c:if test="${nation.isOtherNation eq '0'}">checked</c:if>>
                                                    <span class="lbl bigger-120"> 是</span>
                                                </label>
                                                <label>
                                                    <input name="isOtherNation" type="radio" class="ace input-lg"
                                                           value="1" <c:if test="${nation.isOtherNation eq '1'}">checked</c:if>>
                                                    <span class="lbl bigger-120"> 否</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-12 ">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">风俗礼仪禁忌：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-10 ">
                                            <textarea class="form-control limited" id="moresProtocolTaboo"
                                                      name="moresProtocolTaboo" maxlength="2000">${nation.moresProtocolTaboo}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12 ">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">入境注意事项：<span
                                                    class="required">*</span>
                                            </label>

                                            <div class="col-sm-10 ">
                                            <textarea class="form-control limited" id="ehtryNotices"
                                                      name="ehtryNotices" maxlength="2000">${nation.ehtryNotices}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12 ">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">国家简介：<span
                                                    class="required">*</span>
                                            </label>

                                            <div class="col-sm-10 ">
                                                <div id="nationIntro" name="nationIntro" type="text/plain"
                                                     style="min-height: 200px"></div>
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

        $('.chosen-select').chosen({allow_single_deselect:true});
        //resize the chosen on window resize

        $(window)
            .off('resize.chosen')
            .on('resize.chosen', function() {
                $('.chosen-select').each(function() {
                    var $this = $(this);
                    $this.next().css({'width': $this.parent().width()});
                })
            }).trigger('resize.chosen');
        //resize chosen on sidebar collapse/expand

        $(document).on('settings.ace.chosen', function(e, event_name, event_val) {
            if(event_name != 'sidebar_collapsed') return;
            $('.chosen-select').each(function() {
                var $this = $(this);
                $this.next().css({'width': $this.parent().width()});
            })
        });

        UE.delEditor('nationIntro');
        var ue = UE.getEditor('nationIntro');

        ue.addListener("ready", function () {
            ue.setContent('${nation.nationIntro}');
        });

        var $nationForm = $('#nationForm');

        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");

        var $nationId = $('#nationId');
        var $belongArea = $('#belongArea');

        $nationId.change(function () {
           var nationId =  $nationId.val();
           if ('' != nationId) {
               getBelongArea(nationId);
           } else {
               $belongArea.val('');
           }
        });

        function getBelongArea(nationId) {
            var loadId = G.showAjaxLoading();
            $.ajax({
                type: 'POST',
                url: '${basePath}/nation-condition/find-belong-area.do',
                dataType: 'json',
                data: {id: nationId},
                success: function(response) {
                    if (response.result) {
                        G.doneAjaxLoading(loadId);
                        $belongArea.val(response.area);
                    }
                }
            });
        }

        var saveUrl = '${basePath}/nation-condition/nation-condition-save.do';

        $saveBtn.unbind('click').bind('click', function (e) {
            if ($nationForm.validate().form()) {
                if ($('input[name="isOborNation"]:checked').val() == undefined) {
                    G.showGritterFail('请选择是否是一带一路国家!');
                    e.preventDefault();
                } else if ($('input[name="isArabNation"]:checked').val() == undefined) {
                    G.showGritterFail('请选择是否是阿拉伯国家!');
                    e.preventDefault();
                } else if ($('input[name="isAroundNation"]:checked').val() == undefined) {
                    G.showGritterFail('请选择是否是周边国家!');
                    e.preventDefault();
                } else if ($('input[name="isWestNation"]:checked') == undefined) {
                    G.showGritterFail('请选择是否是西方发达国家!');
                    e.preventDefault();
                } else if ($('input[name="isOtherNation"]:checked').val() == undefined) {
                    G.showGritterFail('请选择是否是其他国家!');
                    e.preventDefault();
                } else if ($('select[name="dicNation.id"] option:selected').val() == "") {
                    G.showGritterFail('请选择国家名称!');
                    e.preventDefault();
                } else {
                    var data = $nationForm.serializeObject();
                    G.confirm({
                        message: '确认保存此条国家情况信息吗？',
                        callback: function (result) {
                            if (result) {
                                var loadId = G.showAjaxLoading();
                                $saveBtn.prop("disabled", true);
                                $backBtn.prop("disabled", true);
                                $.ajax({
                                    url: saveUrl,
                                    type: 'POST',
                                    dataType: 'json',
                                    data: data,
                                    async: true
                                }).done(function (map) {
                                    G.doneAjaxLoading(loadId);
                                    if (map.result == true) {
                                        G.showGritterSuccess("保存成功!");
                                        G.pjaxLoadPageContentDiv('#page/nation-condition/nation-condition-list');
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

        $nationForm.tjValidate({
            focusInvalid: true,
            rules: {
                nationName: {required: true}
            },
            messages: {
                nationName: {required: "国家名称必须选择"}
            }
        });

        $backBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var listUrl = '#page/nation-condition/nation-condition-list';
            var postData = $nationForm.serializeObject();
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
                    message: "您有国家情况信息未保存，确认退出吗？",
                    callback: function (result) {
                        if (result) {
                            G.pjaxLoadPageContentDiv(listUrl);
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