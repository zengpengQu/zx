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

<style>
    .typeahead-wrapper {
        position: relative;
        display: inline-block;
        width: 100%;
    }
</style>

<div class="row">
    <div class="col-xs-10 col-sm-offset-1">
        <div class="widget-box transparent">
            <div class="widget-body">
                <div class="widget-main">
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" role="form" autocomplete="off" id="saveForm"
                                  action="${basePath}/abroad-info/abroad-info-save.do" method="post">
                                <div class="hidden">
                                    <input type="text" id="form-field-id" name="id" value="${abroadInfo.id}"/>
                                    <input type="text" id="form-field-delFlag" name="delFlag"
                                           value="${abroadInfo.delFlag}"/>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 30px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${abroadInfo.id eq null}"> 出访信息新增</c:when>
                                                    <c:otherwise> 出访信息编辑</c:otherwise>
                                                </c:choose></h1>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label no-padding-right"
                                                   for="form-field-groupLeader">团长：<span class="red">*</span></label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control" name="leaderName" id="form-field-groupLeader"
                                                       value="${leaderName}" placeholder="请输入团长 ..."/>
                                                <input class="hidden" name="leaderId" id="form-field-groupLeaderId"
                                                       value="${leaderId}"/>
                                            </div>
                                        </div>
                                    </div>

                                    <%--<div class="col-xs-8" id="row-country">--%>
                                        <%--<div class="form-group">--%>
                                            <%--<label class="col-sm-2 control-label no-padding-right"--%>
                                                   <%--for="form-field-country">出访国家：<span class="required">&nbsp;</span></label>--%>
                                            <%--<div class="col-sm-10 ">--%>
                                                <%--<div class="inline">--%>
                                                    <%--<input type="text" class="form-control" name="country"--%>
                                                           <%--id="form-field-country" placeholder="请输入出访国家..." />--%>
                                                <%--</div>--%>
                                            <%--</div>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label no-padding-right"
                                                   for="form-field-abroadType"> 团组活动类别：<span class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-abroadType"
                                                        name="abroadType">
                                                    <option value="">-----请选择-----</option>
                                                    <option value="0" <c:if test="${abroadInfo.abroadType eq 0}">selected</c:if>>全国政协组团</option>
                                                    <option value="1" <c:if test="${abroadInfo.abroadType eq 1}">selected</c:if>>外单位组团</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label no-padding-right" for="form-field-groupLevel">团组活动级别： <span class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-groupLevel" name="groupLevelId">
                                                    <option value="">---------请选择---------</option>
                                                    <c:forEach items="${groupLevelList}" var="groupLevel">
                                                        <option value="${groupLevel.id}" <c:if test="${abroadInfo.groupLevel.id eq groupLevel.id}">selected</c:if> >${groupLevel.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label no-padding-right"
                                                   for="form-field-planFlag">是否计划内：<span
                                                    class="required">*</span></label>
                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-planFlag" name="planFlag">
                                                    <option value="">-----请选择-----</option>
                                                    <option value="0"
                                                            <c:if test="${abroadInfo.planFlag eq 0}">selected</c:if> >
                                                        计划内
                                                    </option>
                                                    <option value="1"
                                                            <c:if test="${abroadInfo.planFlag eq 1}">selected</c:if> >
                                                        计划外
                                                    </option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label no-padding-right"
                                                   for="form-field-groupNumber">团组活动编号：<span
                                                    class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-groupNumber" name="groupNumber"
                                                       class="form-control " value="${abroadInfo.groupNumber}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label no-padding-right"
                                                   for="form-field-groupName">团组活动名称：<span class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-groupName" name="groupName"
                                                       class="form-control " value="${abroadInfo.groupName}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label no-padding-right"
                                                   for="form-field-orgId">主办单位：<span class="red">&nbsp;</span></label>
                                            <div class="col-sm-8 deptDiv">
                                                <input type="text" id="form-field-orgId" name="orgId"
                                                       class="hide" value=""/>
                                                <input type="text" class="form-control" id="form-field-deptName"
                                                       name="deptName" value="" style="cursor: pointer;" readonly/>
                                            </div>
                                            <div class="col-sm-8 outDeptDiv hidden">
                                                <input type="text" class="form-control" id="form-field-outDeptName"
                                                       name="outDeptName" value="${outDeptName}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label no-padding-right"
                                                   for="form-field-startDateStr">开始日期：<span
                                                    class="required">*</span></label>
                                            <div class="col-sm-8">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="startDateStr"
                                                           id="form-field-startDateStr"
                                                           value="${abroadInfo.jsonObject.startDateStr}" type="text"/>
                                                    <span class="input-group-addon">
                                                        <i class="fa fa-calendar bigger-110"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label no-padding-right"
                                                   for="form-field-endDateStr"> 结束日期：<span
                                                    class="required">*</span></label>
                                            <div class="col-sm-8">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="endDateStr"
                                                           id="form-field-endDateStr"
                                                           value="${abroadInfo.jsonObject.endDateStr}" type="text"/>
                                                    <span class="input-group-addon">
                                                        <i class="fa fa-calendar bigger-110"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label no-padding-right"
                                                   for="form-field-batchNumber">任务批件号：<span class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-batchNumber" name="batchNumber"
                                                       class="form-control " value="${abroadInfo.batchNumber}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <%--&lt;%&ndash;<div class="col-sm-8 ">&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<input type="text" id="form-field-groupLeader" name="groupLeader" class="form-control " value="${abroadInfo.groupLeader}" placeholder="姓名"/>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                                <%--</div>--%>
                                <%--</div>--%>
                                <%--<div class="col-xs-6">--%>
                                <%--<div class="form-group">--%>
                                <%--<label class="col-sm-4 control-label no-padding-right"--%>
                                <%--for="form-field-totalNum">团组总人数：<span class="red">*</span></label>--%>
                                <%--<div class="col-sm-8 ">--%>
                                <%--<input type="text" id="form-field-totalNum" name="totalNum"--%>
                                <%--class="form-control " value="${abroadInfo.totalNum}"--%>
                                <%--placeholder="团组总人数"/>--%>
                                <%--</div>--%>
                                <%--</div>--%>
                                <%--</div>--%>
                                <%--</div>--%>

                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label no-padding-right"
                                                   for="form-field-abroadTask">出访任务：<span
                                                    class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-abroadTask" name="abroadTaskId">
                                                    <option value="">---------请选择---------</option>
                                                    <c:forEach items="${abroadTaskList}" var="abroadTask">
                                                        <option value="${abroadTask.id}"
                                                                <c:if test="${abroadInfo.abroadTask.id eq abroadTask.id}">selected</c:if> >${abroadTask.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label no-padding-right"
                                                   for="form-field-costSource">费用来源：<span
                                                    class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-costSource" name="costSourceId">
                                                    <option value="">---------请选择---------</option>
                                                    <c:forEach items="${costSourceList}" var="costSource">
                                                        <option value="${costSource.id}"
                                                                <c:if test="${abroadInfo.costSource.id eq costSource.id}">selected</c:if> >
                                                                ${costSource.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label no-padding-right" for="form-field-abroadDays">在外停留天数：<span
                                                    class="red">*</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="number" id="form-field-abroadDays" min="0" name="abroadDays" class="form-control editable"
                                                       value="${abroadInfo.abroadDays}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-8">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label no-padding-right"
                                                   for="form-field-taskDesc">任务描述：<span class="required">&nbsp;</span></label>
                                            <div class="col-sm-10 ">
                                                <textarea class="form-control limited" id="form-field-taskDesc"
                                                          name="taskDesc" maxlength="300"
                                                          style="min-height: 100px;">${abroadInfo.taskDesc}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-8 ">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label no-padding-right"
                                                   for="form-field-costInstruct">费用说明：<span class="required">&nbsp;</span></label>

                                            <div class="col-sm-10 ">
                                                <textarea class="form-control limited" id="form-field-costInstruct"
                                                          name="costInstruct" maxlength="300"
                                                          style="min-height: 100px;">${abroadInfo.costInstruct}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-8 ">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label no-padding-right"
                                                   for="form-field-remark">备注信息：<span class="required">&nbsp;</span></label>
                                            <div class="col-sm-10 ">
                                                <textarea class="form-control limited" id="form-field-remark"
                                                          name="remark" maxlength="300"
                                                          style="min-height: 100px;">${abroadInfo.remark}</textarea>
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
<link type="text/css" rel="stylesheet" href="${basePath}/plugin/bootstrap-tagsinput/dist/bootstrap-tagsinput.css">
<script src="${basePath}/plugin/bootstrap-tagsinput/dist/bootstrap-tagsinput.min.js"></script>
<script src="${basePath}/plugin/ace/assets/js/typeahead.jquery.js"></script>
<script src="${basePath}/plugin/ace/assets/js/bloodhound.js"></script>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.datepicker({
            todayHighlight: true
        });

        G.initDept('deptDiv',true,['${dicDept}'],TREE_NODE);

        var $abroadType = $("#form-field-abroadType");
        var $groupLeader = $("#form-field-groupLeader");
        var $countryInputTag = $('#form-field-country');

        var $saveForm = $("#saveForm");
        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");

        var $startDate = $("#form-field-startDateStr");
        var $endDate = $("#form-field-endDateStr");

        var type = $abroadType.val();
        // 外单位组团
        if (type === '1') {
            $(".deptDiv").addClass('hidden');
            $(".outDeptDiv").removeClass('hidden');
        }
        // 选择组团类型，更改单位输入框形式
        $abroadType.on('change', function () {
            var type = $abroadType.val();
            if (type === '0') {
                console.log('全国政协')
                $(".deptDiv").removeClass('hidden');
                $(".outDeptDiv").addClass('hidden');
            } else if (type === '1') {
                console.log('外单位')
                $(".deptDiv").addClass('hidden');
                $(".outDeptDiv").removeClass('hidden');
            } else {
                $(".deptDiv").removeClass('hidden');
                $(".outDeptDiv").addClass('hidden');
            }
        });

        $endDate.on('change', function () {
            var startDate = $startDate.val();
            var endDate = $endDate.val();

            if (startDate !== '' && endDate !== '') {
                var d1 = new Date(startDate.replace(/-/g, "//"));
                var d2 = new Date(endDate.replace(/-/g, "//"));

                var diff = (d2 - d1) / (24 * 60 * 60 * 1000);

                var $abroadDays = $("#form-field-abroadDays");
                // 自动填充默认在外天数为结束日期与开始日期之差
                $abroadDays.val(diff);
                // 设置在外天数最大值为 diff
                $abroadDays.attr('max', diff);

            }
        });

        $startDate.on('change', function () {
            var startDate = $startDate.val();
            var endDate = $endDate.val();

            if (startDate !== '' && endDate !== '') {
                var d1 = new Date(startDate.replace(/-/g, "//"));
                var d2 = new Date(endDate.replace(/-/g, "//"));

                var diff = (d2 - d1) / (24 * 60 * 60 * 1000);

                var $abroadDays = $("#form-field-abroadDays");
                // 自动填充默认在外天数为结束日期与开始日期之差
                $abroadDays.val(diff);
                // 设置在外天数最大值为 diff
                $abroadDays.attr('max', diff);

            }
        });


        <%--var people = new Bloodhound({--%>
            <%--datumTokenizer: Bloodhound.tokenizers.obj.whitespace('empName'),--%>
            <%--queryTokenizer: Bloodhound.tokenizers.whitespace,--%>
            <%--prefetch: '${basePath}/user/get-first-count.do',--%>
            <%--remote: {--%>
                <%--url: '${basePath}/user/query-user.do',--%>
                <%--// wildcard: '%QUERY',--%>
                <%--prepare: function (query, settings) {--%>
                    <%--console.log($('.tt-input').typeahead('val'));--%>
                    <%--console.log(settings.url)--%>
                    <%--return settings.url +="?query="+ encodeURIComponent($('.tt-input').typeahead('val'));--%>

                <%--},--%>
                <%--// ajax: {--%>
                <%--//         type:"POST",--%>
                <%--//         cache:false,--%>
                <%--//         data: {--%>
                <%--//             limit:5--%>
                <%--//         },--%>
                <%--//     beforeSend:function(jqXHR,settings){--%>
                <%--//         settings.data+="&query="+ $('.tt-input').typeahead('val');--%>
                <%--//         console.log(settings.data);--%>
                <%--//     },--%>
                <%--//     complete:function(jqXHR,textStatus){--%>
                <%--//         people.clearRemoteCache();--%>
                <%--//     }--%>
                <%--// },--%>
                <%--rateLimitWait: 900--%>
            <%--}--%>
        <%--});--%>
        // people.initialize();

        // 团长
        $groupLeader.typeahead({
                hint: true,
                highlight: true,
                minLength: 1,
                classNames: {
                    wrapper: "typeahead-wrapper"
                }
            },
            {
                name: 'people',
                display: 'empName',
                templates: {
                    empty: [
                        '<div class="empty-message">',
                        '找不到该人员',
                        '</div>'
                    ].join('\n'),
                    suggestion: Handlebars.compile('<div><strong>{{empName}}</strong> – {{deptName}}</div>')
                },
                // source: people,
                source: function(query, processSync, processAsync) {
                    $.ajax({
                        url: '${basePath}/user/query-user.do',
                        data: {
                            query: encodeURI(query)
                        },
                        type: 'get',
                        dataType: "json",
                        success: function (data) {
                            return processAsync(data);
                        }
                    });
                }
        }).on("typeahead:select", function (evt, selection) {
            $("#form-field-groupLeaderId").val(selection.id);
        });


        // 国家数据集
        <%--var countries = new Bloodhound({--%>
            <%--datumTokenizer: Bloodhound.tokenizers.obj.whitespace('nationName'),--%>
            <%--queryTokenizer: Bloodhound.tokenizers.whitespace,--%>
            <%--prefetch: '${basePath}/nation-condition/get-all.do'--%>
        <%--});--%>
        <%--countries.initialize();--%>

        // // 出访国家
        // $countryInputTag.tagsinput({
        //     itemValue: 'id',
        //     itemText: 'nationName',
        //     typeaheadjs: {
        //         name: 'countries',
        //         displayKey: 'nationName',
        //         source: countries.ttAdapter()
        //     }
        // });

        // var savedCountry = ${savedCountry};
        // // 显示已保存的国家
        // if (!_.isEmpty(savedCountry)) {
        //     $.each(savedCountry, function (index, item) {
        //         $countryInputTag.tagsinput('add', { "id": item.id , "nationName": item.nationName});
        //     });
        // }

        // try {
        //
        // } catch(e) {
        //     //display a textarea for old IE, because it doesn't support this plugin or another one I tried!
        //     $countryInputTag.after('<textarea id="'+$countryInputTag.attr('id')+'" name="'+$countryInputTag.attr('name')+'" rows="3">'+$countryInputTag.val()+'</textarea>').remove();
        // }
        

        $saveBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var saveUrl = '${basePath}/abroad-info/abroad-info-save.do';

            if ($saveForm.validate().form()) {
                var loadId = G.showAjaxLoading("正在保存中，请稍候...");

                var data = $saveForm.serializeObject();
                data['countryIds'] = $countryInputTag.tagsinput('val');

                $saveBtn.prop("disabled", true);
                $backBtn.prop("disabled", true);
                $.ajax({
                    url: saveUrl,
                    type: 'POST',
                    dataType: 'json',
                    data: data,
                    async: true
                }).done(function (map) {
                    if (map.result) {
                        G.doneAjaxLoading(loadId);
                        G.showGritterSuccess("保存成功!");
                        G.pjaxLoadPageContentDiv("page/abroad-info/abroad-info-list");
                    } else {
                        G.doneAjaxLoading(loadId);
                        G.showGritterFail("保存失败,请稍后重试!");
                    }
                }).error(function () {
                    G.doneAjaxLoading(loadId);
                    G.showGritterFail("保存失败,请稍后重试!");
                    $saveBtn.prop("disabled", false);
                    $backBtn.prop("disabled", false);
                });
            }
        });

        $saveForm.tjValidate({
            focusInvalid: false,
            rules: {
                leaderName: {
                    required: true,
                    maxlength: 64
                },
                abroadType: {
                    required: true
                },
                groupLevelId: {
                    required: true
                },
                planFlag: {
                    required: true
                },
                groupNumber: {
                    required: true,
                    maxlength: 64
                },
                groupName: {
                    required: true,
                    maxlength:128
                },
                startDateStr: {
                    required: true
                },
                endDateStr: {
                    required: true,
                    compareDate : '#form-field-startDateStr'
                },
                // deptName: {
                //     required: true
                // },
                batchNumber: {
                    required: true,
                    maxlength: 64
                },
                abroadTaskId: {
                    required: true
                },
                costSourceId: {
                    required: true
                },
                abroadDays: {
                    required: true,
                    max: 999
                },
                taskDesc: {
                    maxlength: 1000
                },
                costInstruct : {
                    maxlength: 1000
                },
                remark: {
                    maxlength: 2000
                }
            },
            messages: {
                leaderName: {
                    required: "团长不能为空"
                },
                abroadType: {
                    required: "团组活动类别不能为空"
                },
                groupLevelId: {
                    required: "团组活动级别不能为空"
                },
                planFlag: {
                    required: "是否计划内不能为空"
                },
                groupNumber: {
                    required: "团组活动编号不能为空"
                },
                groupName: {
                    required: "团组活动名称不能为空"
                },
                startDateStr: {
                    required: "开始日期不能为空"
                },
                endDateStr: {
                    required: "结束日期不能为空"
                },
                // deptName: {
                //     required: "主办单位不能为空"
                // },
                batchNumber: {
                    required: "任务批件号不能为空"
                },
                abroadTaskId: {
                    required: "出访任务不能为空"
                },
                costSourceId: {
                    required: "费用来源不能为空"
                },
                abroadDays: {
                    required: "在外停留天数不能为空"
                }
            }
        });

        //返回
        $backBtn.unbind('click').bind('click', function () {
            window.history.back(-1);
        });

    });
</script>