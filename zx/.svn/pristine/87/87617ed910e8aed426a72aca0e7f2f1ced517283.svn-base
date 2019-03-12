<%--
  Created by IntelliJ IDEA.
  User: yingji
  Date: 2018/8/23
  Time: 10:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>

<title>履职支撑平台</title>

<div class="row">
    <div class="col-xs-12">
        <form class="form-horizontal" role="form" id="searchForm">
            <div class="col-xs-3">

            </div>
            <div class="col-xs-5">
                <div class="form-group" style="margin-top: 5px; margin-bottom: 5px;padding-right: 0px;">
                            <label class="col-sm-4 control-label no-padding-right">年度:</label>
                            <div class="col-sm-8">
                                <div class=" input-group">
                                    <input class="form-control year-picker"
                                           name="startDate"
                                           id="form-field-startDate"
                                           value="${startDate}"
                                           data-date-format="yyyy"
                                           placeholder="选择年度" type="text"/>
                                    <span class="input-group-addon"><i
                                            class="fa fa-calendar bigger-110"></i></span>
                                </div>
                            </div>
                        </div>
            </div>
            <div class="col-xs-4 pull-right" style="margin-top: 5px;margin-bottom: 5px">
                <div class="btn-group pull-right">
                            <button class="btn btn-success btn-sm" type="button"
                                    id="searchBtn">
                                <span class="ace-icon fa fa-search icon-on-right bigger-110"></span>
                                查询
                            </button>
                            <button class="btn btn-warning btn-sm" type="button" id="resetBtn">
                                <span class="ace-icon fa fa-retweet icon-on-right bigger-110"></span>
                                重置
                            </button>
                        </div>
            </div>
        </form>
    </div>

    <div class="row">
        <div class="col-xs-12" style="margin-right: 20px; margin-top: 10px">
            <div class="btn-group pull-right">
                <div class="btn-group pull-right">
                    <button style="margin-right: 33px;width: 140px;"
                            class="btn btn-primary btn-sm" type="button"
                            id="exportBtn">
                        <span class="ace-icon glyphicon glyphicon-export icon-on-right bigger-110"></span>
                        导出Excel表格
                    </button>
                </div>
                <div class="pull-right">
                    <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue bigger-150 mar_r_10 mar_t_5"></i>
                </div>
            </div>
        </div>
    </div>

    <div class="row" style="margin-top: 10px">
        <div class="col-xs-12">
            <div class="tabbable tabs-left">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active">
                        <a data-toggle="tab" href="#tabs-above-vice-minister">
                            <i class="ace-icon fa fa-rocket"></i>
                            副部级以上领导干部
                        </a>
                    </li>

                    <li>
                        <a data-toggle="tab" href="#tabs-business-abroad">
                            <i class="ace-icon fa fa-rocket"></i>
                            因公出国（境）情况
                        </a>
                    </li>

                    <li>
                        <a data-toggle="tab" href="#tabs-abroad-details">
                            <i class="ace-icon fa fa-rocket"></i>
                            出访情况详表
                        </a>
                    </li>

                    <li>
                        <a data-toggle="tab" href="#tabs-zx-vice-chairman">
                            <i class="ace-icon fa fa-rocket"></i>
                            副主席率团出访情况表（内）
                        </a>
                    </li>

                    <li>
                        <a data-toggle="tab" href="#tabs-zx-leaders">
                            <i class="ace-icon fa fa-rocket"></i>
                            全国政协办公厅领导出访
                        </a>
                    </li>

                    <li>
                        <a data-toggle="tab" href="#tabs-committee-leaders">
                            <i class="ace-icon fa fa-rocket"></i>
                            全国政协专委会负责人出访
                        </a>
                    </li>

                    <li>
                        <a data-toggle="tab" href="#tabs-party-leaders">
                            <i class="ace-icon fa fa-rocket"></i>
                            党派领导出访统计表
                        </a>
                    </li>

                    <li>
                        <a data-toggle="tab" href="#tabs-local-leaders">
                            <i class="ace-icon fa fa-rocket"></i>
                            地方政协负责人参团情况
                        </a>
                    </li>

                    <li>
                        <a data-toggle="tab" href="#tabs-economy-society-council">
                            <i class="ace-icon fa fa-rocket"></i>
                            经社理事会出访团组统计
                        </a>
                    </li>

                    <li>
                        <a data-toggle="tab" href="#tabs-nine-committee">
                            <i class="ace-icon fa fa-rocket"></i>
                            全国政协专委会出访
                        </a>
                    </li>

                    <li>
                        <a data-toggle="tab" href="#tabs-outer-vice-chairman">
                            <i class="ace-icon fa fa-rocket"></i>
                            副主席率团出访情况表（外）
                        </a>
                    </li>

                    <li>
                        <a data-toggle="tab" href="#tabs-religion-peace">
                            <i class="ace-icon fa fa-rocket"></i>
                            “中宗和”出访情况一览表
                        </a>
                    </li>

                    <li>
                        <a data-toggle="tab" href="#tabs-outer-zx">
                            <i class="ace-icon fa fa-rocket"></i>
                            政协人员参加外单位组团
                        </a>
                    </li>

                    <li>
                        <a data-toggle="tab" href="#tabs-plan-summary">
                            <i class="ace-icon fa fa-rocket"></i>
                            对外交往计划和执行情况对比
                        </a>
                    </li>

                    <li>
                        <a data-toggle="tab" href="#tabs-minister">
                            <i class="ace-icon fa fa-rocket"></i>
                            部级团组出访统计表
                        </a>
                    </li>

                    <li>
                        <a data-toggle="tab" href="#tabs-below-minister">
                            <i class="ace-icon fa fa-rocket"></i>
                            部级以下团组出访统计表
                        </a>
                    </li>

                    <li>
                        <a data-toggle="tab" href="#tabs-chairman-vice-chairman">
                            <i class="ace-icon fa fa-rocket"></i>
                            主席、副主席出访情况
                        </a>
                    </li>
                </ul>

                <div class="tab-content">
                    <div id="tabs-above-vice-minister" class="tab-pane in active" style="min-height:525px;">
                        <div class="row" style="margin-top: 20px">
                            <div id="table-above-vice-minister"></div>
                        </div>
                    </div>

                    <div id="tabs-business-abroad" class="tab-pane" style="min-height:500px;">
                        <div class="row" style="margin-top: 20px">
                            <div id="table-business-abroad"></div>
                        </div>
                    </div>

                    <div id="tabs-abroad-details" class="tab-pane" style="min-height:500px;">
                        <div class="row" style="margin-top: 20px">
                            <div id="table-abroad-details"></div>
                        </div>
                    </div>

                    <div id="tabs-zx-vice-chairman" class="tab-pane" style="min-height:500px;">
                        <div class="row" style="margin-top: 20px">
                            <div id="table-zx-vice-chairman"></div>
                        </div>
                    </div>

                    <div id="tabs-zx-leaders" class="tab-pane" style="min-height:500px;">
                        <div class="row" style="margin-top: 20px">
                            <div id="table-zx-leaders"></div>
                        </div>
                    </div>

                    <div id="tabs-committee-leaders" class="tab-pane" style="min-height:500px;">
                        <div class="row" style="margin-top: 20px">
                            <div id="table-committee-leaders"></div>
                        </div>
                    </div>

                    <div id="tabs-party-leaders" class="tab-pane" style="min-height:500px;">
                        <div class="row" style="margin-top: 20px">
                            <div id="table-party-leaders"></div>
                        </div>
                    </div>

                    <div id="tabs-local-leaders" class="tab-pane" style="min-height:500px;">
                        <div class="row" style="margin-top: 20px">
                            <div id="table-local-leaders"></div>
                        </div>
                    </div>

                    <div id="tabs-economy-society-council" class="tab-pane" style="min-height:500px;">
                        <div class="row" style="margin-top: 20px">
                            <div id="table-economy-society-council"></div>
                        </div>
                    </div>

                    <div id="tabs-nine-committee" class="tab-pane" style="min-height:500px;">
                        <div class="row" style="margin-top: 20px">
                            <div id="table-nine-committee"></div>
                        </div>
                    </div>

                    <div id="tabs-outer-vice-chairman" class="tab-pane" style="min-height:500px;">
                        <div class="row" style="margin-top: 20px">
                            <div id="table-outer-vice-chairman"></div>
                        </div>
                    </div>

                    <div id="tabs-religion-peace" class="tab-pane" style="min-height:500px;">
                        <div class="row" style="margin-top: 20px">
                            <div id="table-religion-peace"></div>
                        </div>
                    </div>

                    <div id="tabs-outer-zx" class="tab-pane" style="min-height:500px;">
                        <div class="row" style="margin-top: 20px">
                            <div id="table-outer-zx"></div>
                        </div>
                    </div>

                    <div id="tabs-plan-summary" class="tab-pane" style="min-height:500px;">
                        <div class="row" style="margin-top: 20px">
                            <div id="table-plan-summary"></div>
                        </div>
                    </div>

                    <div id="tabs-minister" class="tab-pane" style="min-height:500px;">
                        <div class="row" style="margin-top: 20px">
                            <div id="table-minister"></div>
                        </div>
                    </div>

                    <div id="tabs-below-minister" class="tab-pane" style="min-height:500px;">
                        <div class="row" style="margin-top: 20px">
                            <div id="table-below-minister"></div>
                        </div>
                    </div>

                    <div id="tabs-chairman-vice-chairman" class="tab-pane" style="min-height:500px;">
                        <div class="row" style="margin-top: 20px">
                            <div id="table-chairman-vice-chairman"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%--1. 副部级以上领导干部统计--%>

<script id="template-above-vice-minister" type="text/x-handlebars-template">
    <table class="table table-striped table-bordered table-hover center">
        <caption class="align-center"><h4>{{thisYear}} 年中央和国家机关副部级以上领导干部因公出国（境）情况明细表</h4></caption>
        <thead>
        <tr>
            <th class="center">序号</th>
            <th class="center">姓名</th>
            <th class="center" width="15%">职务</th>
            <th class="center">出访国家（地区）</th>
            <th class="center">经停国家（地区）</th>
            <th class="center">离境日期</th>
            <th class="center">抵境日期</th>
            <th class="center">在外停留天数</th>
            <th class="center">代表团人数</th>
            <th class="center">委员人数</th>
            <th class="center">备注</th>
        </tr>
        </thead>
        <tbody>
        {{#each dataList}}
        <tr class="aboveMinisterItem">
            <td>{{indexAddOne @index}}</td>
            <td>{{name}}</td>
            <td>{{duty}}</td>
            <td>{{dstCountry}}</td>
            <td>{{trsCountry}}</td>
            <td>{{leaveDate}}</td>
            <td>{{backDate}}</td>
            <td>{{outDate}}</td>
            <td>{{peopleNum}}</td>
            <td>{{committeeNum}}</td>
            <td>{{notes}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<%--2. 因公出国（境）汇总表--%>
<script id="template-business-abroad" type="text/x-handlebars-template">
    <table class="table table-striped table-bordered table-hover center"
           id="business-abroad">
        <%--<caption class="align-center"><h4>{{thisYear}} 年中央和国家机关各部门因公出国（境）情况汇总表</h4></caption>--%>
        <thead>
        <tr>
            <th class="center" colspan="8"><h4>{{thisYear}} 年中央和国家机关各部门因公出国（境）情况汇总表</h4></th>
        </tr>
        <tr>
            <th class="center" rowspan="2" width="15%">项目</th>
            <th class="center" colspan="2">总批次</th>
            <th class="center" colspan="2">总人数</th>
            <th class="center" colspan="2">执行总批次占年度计划比率</th>
        </tr>
        <tr>
            <th class="center">{{lastYear}} 年</th>
            <th class="center">{{thisYear}} 年</th>
            <th class="center">{{lastYear}} 年</th>
            <th class="center">{{thisYear}} 年</th>
            <th class="center">{{lastYear}} 年</th>
            <th class="center">{{thisYear}} 年</th>
        </tr>

        </thead>
        <tbody>
        <tr></tr>
        {{#each dataList}}
        <tr>
            <td class="center">正部级及以上领导干部出国（境）</td>
            <td class="center">{{aboveMinisterBatchCount1}}</td>
            <td class="center">{{aboveMinisterBatchCount2}}</td>
            <td class="center">{{aboveMinisterPeopleCount1}}</td>
            <td class="center">{{aboveMinisterPeopleCount2}}</td>
            <td class="center" rowspan="2">{{aboveMinisterLastPercent}}</td>
            <td class="center" rowspan="2">{{aboveMinisterThisPercent}}</td>
        </tr>

        <tr>
            <td class="center">副部级领导干部出国（境）</td>
            <td class="center">{{viceMinisterBatchCount1}}</td>
            <td class="center">{{viceMinisterBatchCount2}}</td>
            <td class="center">{{viceMinisterPeopleCount1}}</td>
            <td class="center">{{viceMinisterPeopleCount2}}</td>
        </tr>

        <tr>
            <td class="center">机关厅局级及以下人员出国（境）</td>
            <td class="center">{{belowDepartmentsBatchCount1}}</td>
            <td class="center">{{belowDepartmentsBatchCount2}}</td>
            <td class="center">{{belowDepartmentsPeopleCount1}}</td>
            <td class="center">{{belowDepartmentsPeopleCount2}}</td>
            <td class="center">{{belowDepartmentsLastPercent}}</td>
            <td class="center">{{belowDepartmentsThisPercent}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<%--3. 出访情况详表--%>
<script id="template-abroad-details" type="text/x-handlebars-template">
    <table class="table table-striped table-bordered table-hover center"
           id="abroad-details">
        <caption class="align-center"><h4>{{thisYear}} 年出访情况详表</h4></caption>
        <thead>
        <tr>
            <th class="center" align="center" valign="center">团组顺序</th>
            <th class="center" colspan="2">出入境时间</th>
            <th class="center">组团单位</th>
            <th class="center">批件号</th>
            <th class="center">途径国家/地区</th>
            <th class="center">出访国家</th>
            <th class="center">出访任务</th>
            <th class="center">任务类型</th>
            <th class="center">团组级别</th>
            <th class="center">参团人数</th>
            <th class="center">委员人数</th>
            <th class="center">姓名</th>
            <th class="center" width="10%">职务</th>
            <th class="center">具体单位/部门</th>
            <th class="center">备注</th>
        </tr>
        </thead>
        <tbody>
        {{#each dataList}}
        <tr class="abroadDetailsItem">
            {{#if index}}
            <td rowspan="{{rowspan}}" align="center" valign="center">{{index}}</td>
            {{/if}}
            <td>{{leaveDate}}</td>
            <td>{{backDate}}</td>
            <td>{{org}}</td>
            <td>{{batchNumber}}</td>
            <td>{{trsCountry}}</td>
            <td>{{dstCountry}}</td>
            <td>{{task}}</td>
            <td>{{taskType}}</td>
            <td>{{groupLevel}}</td>
            <td>{{peopleNum}}</td>
            <td>{{committeeNum}}</td>
            <td>{{name}}</td>
            <td>{{duty}}</td>
            <td>{{personOrg}}</td>
            <td>{{notes}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<%--4. 副主席出访统计表（政协团组）--%>
<script id="template-zx-vice-chairman" type="text/x-handlebars-template">
    <table class="table table-striped table-bordered table-hover center">
        <caption class="align-center"><h4>{{thisYear}} 年全国政协副主席率团出访情况表（政协组团）</h4></caption>
        <thead>
        <tr>
            <th class="center">序号</th>
            <th class="center" width="15%">日期</th>
            <th class="center">组团单位</th>
            <th class="center">团长</th>
            <th class="center">邀请单位</th>
            <th class="center">出访国家</th>
            <th class="center">出访任务</th>
            <th class="center">团组人数</th>
            <th class="center">委员人数</th>
            <th class="center">会见情况</th>
            <th class="center">备注</th>
        </tr>
        </thead>
        <tbody>
        {{#each dataList}}
        <tr class="viceChairmanItem">
            <td>{{indexAddOne @index}}</td>
            <td>{{date}}</td>
            <td>{{org}}</td>
            <td>{{groupLeader}}</td>
            <td>{{inviteOrg}}</td>
            <td>{{dstCountry}}</td>
            <td>{{task}}</td>
            <td>{{peopleNum}}</td>
            <td>{{committeeNum}}</td>
            <td>{{meeting}}</td>
            <td>{{notes}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<%--5. 办公厅领导出访统计表--%>
<script id="template-zx-leaders" type="text/x-handlebars-template">
    <table class="table table-striped table-bordered table-hover center">
        <caption class="align-center"><h4>{{thisYear}} 年全国政协办公厅领导出访情况一览表</h4></caption>
        <thead>
        <tr>
            <th class="center">序号</th>
            <th class="center">姓名</th>
            <th class="center">职务</th>
            <th class="center" width="15%">日期</th>
            <th class="center">团组名</th>
            <th class="center">出访国家</th>
        </tr>
        </thead>
        <tbody>
        {{#each dataList}}
        <tr class="zxLeadersItem">
            <td>{{indexAddOne @index}}</td>
            <td>{{name}}</td>
            <td>{{duty}}</td>
            <td>{{date}}</td>
            <td>{{groupName}}</td>
            <td>{{dstCountry}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<%--6. 专委会负责人出访统计表--%>
<script id="template-committee-leaders" type="text/x-handlebars-template">
    <table class="table table-striped table-bordered table-hover center">
        <caption class="align-center"><h4>{{thisYear}} 年专委会负责人出访情况一览表（以委员会排序）</h4></caption>
        <thead>
        <tr>
            <th class="center">序号</th>
            <th class="center">委员会名称</th>
            <th class="center">姓名</th>
            <th class="center">职务</th>
            <th class="center" width="15%">日期</th>
            <th class="center">团组名</th>
            <th class="center">访问国家</th>
        </tr>
        </thead>
        <tbody>
        {{#each dataList}}
        <tr class="committeeLeadersItem">
            <td>{{indexAddOne @index}}</td>
            <td>{{committee}}</td>
            <td>{{name}}</td>
            <td>{{duty}}</td>
            <td>{{date}}</td>
            <td>{{groupName}}</td>
            <td>{{dstCountry}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<%--7. 党派领导出访统计表--%>   <%--未完成--%>
<script id="template-party-leaders" type="text/x-handlebars-template">
    <table class="table table-striped table-bordered table-hover center">
        <caption class="align-center"><h4>__ 届党派领导出访统计表</h4></caption>
        <thead>
        <tr>
            <th class="center">序号</th>
            <th class="center" width="15%">日期</th>
            <th class="center">组团单位</th>
            <th class="center">团长</th>

        </tr>
        </thead>
        <tbody>
        {{#each dataList}}
        <tr class="partyLeadersItem">
            <td>{{indexAddOne @index}}</td>
            <td>{{date}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<%--8. 地方政协负责人出访统计表--%>   <%--未完成--%>
<script id="template-local-leaders" type="text/x-handlebars-template">
    <table class="table table-striped table-bordered table-hover center">
        <caption class="align-center"><h4>{{thisYear}} 年政协主席、副主席组团出访地方政协负责人参团情况（以省市排序）</h4></caption>
        <thead>
        <tr>
            <th class="center">序号</th>
            <th class="center" width="15%">日期</th>
            <th class="center">组团单位</th>
            <th class="center">团长</th>

        </tr>
        </thead>
        <tbody>
        {{#each dataList}}
        <tr class="localLeadersItem">
            <td>{{indexAddOne @index}}</td>
            <td>{{date}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<%--9. 经社理事会出访团组统计--%>
<script id="template-economy-society-council" type="text/x-handlebars-template">
    <table class="table table-striped table-bordered table-hover center">
        <caption class="align-center"><h4>{{thisYear}} 年经社理事会出访团组统计</h4></caption>
        <thead>
        <tr>
            <th class="center">序号</th>
            <th class="center">团长姓名</th>
            <th class="center">对外身份</th>
            <th class="center">级别</th>
            <th class="center">代表团总人数</th>
            <th class="center">代表团主要成员及工作人员</th>
            <th class="center">启程时间</th>
            <th class="center">回国时间</th>
            <th class="center">访问国家（地区）</th>
            <th class="center">访问目的</th>
            <th class="center">邀请方</th>
            <th class="center">备注</th>
        </tr>
        </thead>
        <tbody>
        {{#each dataList}}
        <tr class="ecoSoCoItem">
            <td>{{indexAddOne @index}}</td>
            <td>{{leaderName}}</td>
            <td>{{foreignIdentity}}</td>
            <td>{{level}}</td>
            <td>{{peopleNum}}</td>
            <td>{{members}}</td>
            <td>{{leaveDate}}</td>
            <td>{{backDate}}</td>
            <td>{{dstCountry}}</td>
            <td>{{task}}</td>
            <td>{{inviteOrg}}</td>
            <td>{{notes}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<%--10. 专委会出访统计表--%>
<script id="template-nine-committee" type="text/x-handlebars-template">
    <table class="table table-striped table-bordered table-hover center">
        <caption class="align-center"><h4>{{thisYear}} 年全国政协专门委员会出访情况一览表</h4></caption>
        <thead>
        <tr>
            <th class="center">序号</th>
            <th class="center" width="15%">日期</th>
            <th class="center">组团单位</th>
            <th class="center">团长</th>
            <th class="center">团长职务</th>
            <th class="center">邀请单位</th>
            <th class="center">人数</th>
            <th class="center">出访国家</th>
            <th class="center">出访任务（调研题目）</th>
            <th class="center">代表团成员</th>
            <th class="center">委员人数</th>
            <th class="center">备注</th>

        </tr>
        </thead>
        <tbody>
        {{#each dataList}}
        <tr class="committeeItem">
            <td>{{indexAddOne @index}}</td>
            <td>{{date}}</td>
            <td>{{org}}</td>
            <td>{{groupLeader}}</td>
            <td>{{leaderDuty}}</td>
            <td>{{inviteOrg}}</td>
            <td>{{peopleNum}}</td>
            <td>{{dstCountry}}</td>
            <td>{{task}}</td>
            <td>{{members}}</td>
            <td>{{committeeNum}}</td>
            <td>{{notes}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<%--11. 副主席出访统计表（外单位组团）--%>
<script id="template-outer-vice-chairman" type="text/x-handlebars-template">
    <table class="table table-striped table-bordered table-hover center">
        <caption class="align-center"><h4>{{thisYear}} 年全国政协副主席率团出访情况一览表(外单位组团)</h4></caption>
        <thead>
        <tr>
            <th class="center">序号</th>
            <th class="center" width="15%">日期</th>
            <th class="center">组团单位</th>
            <th class="center">团长</th>
            <th class="center">邀请单位</th>
            <th class="center">对外名义</th>
            <th class="center">人数</th>
            <th class="center">出访国家</th>
            <th class="center">出访任务</th>
            <th class="center">会见情况</th>
            <th class="center">备注</th>
        </tr>
        </thead>
        <tbody>
        {{#each dataList}}
        <tr class="outerViceChairmanItem">
            <td>{{indexAddOne @index}}</td>
            <td>{{date}}</td>
            <td>{{org}}</td>
            <td>{{groupLeader}}</td>
            <td>{{inviteOrg}}</td>
            <td>{{foreignIdentity}}</td>
            <td>{{peopleNum}}</td>
            <td>{{dstCountry}}</td>
            <td>{{task}}</td>
            <td>{{meeting}}</td>
            <td>{{notes}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<%--12. “中宗和”出访情况一览表--%>
<script id="template-religion-peace" type="text/x-handlebars-template">
    <table class="table table-striped table-bordered table-hover center">
        <caption class="align-center"><h4>{{thisYear}} 年“中宗和”出访情况一览表</h4></caption>
        <thead>
        <tr>
            <th class="center">序号</th>
            <th class="center" width="15%">日期</th>
            <th class="center">组团单位</th>
            <th class="center">团长</th>
            <th class="center">团长职务</th>
            <th class="center">邀请单位</th>
            <th class="center">人数</th>
            <th class="center">出访国家</th>
            <th class="center">出访任务</th>
            <th class="center">会见情况</th>
            <th class="center">备注</th>
        </tr>
        </thead>
        <tbody>
        {{#each dataList}}
        <tr class="outerRelegionPeaceItem">
            <td>{{indexAddOne @index}}</td>
            <td>{{date}}</td>
            <td>{{org}}</td>
            <td>{{groupLeader}}</td>
            <td>{{leaderDuty}}</td>
            <td>{{inviteOrg}}</td>
            <td>{{peopleNum}}</td>
            <td>{{dstCountry}}</td>
            <td>{{task}}</td>
            <td>{{meeting}}</td>
            <td>{{notes}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<%--13. 政协人员参加外单位组团--%>
<script id="template-outer-zx" type="text/x-handlebars-template">
    <table class="table table-striped table-bordered table-hover center">
        <caption class="align-center"><h4>{{thisYear}} 年政协人员参加外单位组团</h4></caption>
        <thead>
        <tr>
            <th class="center">序号</th>
            <th class="center" width="15%">日期</th>
            <th class="center">组团单位</th>
            <th class="center">参加人员</th>
            <th class="center">职务</th>
            <th class="center">邀请单位</th>
            <th class="center">对外名义</th>
            <th class="center">人数</th>
            <th class="center">出访国家</th>
            <th class="center">出访任务</th>
            <th class="center">会见情况</th>
            <th class="center">备注</th>
        </tr>
        </thead>
        <tbody>
        {{#each dataList}}
        <tr class="outerZxItem">
            <td>{{indexAddOne @index}}</td>
            <td>{{date}}</td>
            <td>{{org}}</td>
            <td>{{name}}</td>
            <td>{{duty}}</td>
            <td>{{inviteOrg}}</td>
            <td>{{foreignIdentity}}</td>
            <td>{{peopleNum}}</td>
            <td>{{dstCountry}}</td>
            <td>{{task}}</td>
            <td>{{meeting}}</td>
            <td>{{notes}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<%--14. 对外交往计划和执行情况对比--%>  <%--未完成--%>
<script id="template-plan-summary" type="text/x-handlebars-template">
    <table class="table table-striped table-bordered table-hover center"
           id="plan-summary">
        <%--<caption class="align-center"><h4>{{thisYear}} 年全国政协对外交往计划和执行情况对比表（出访部分）</h4></caption>--%>
        <thead>
        <tr>
            <th class="center " colspan="14"><h4>{{thisYear}} 年全国政协对外交往计划和执行情况对比表（出访部分）</h4></th>
        </tr>
        <tr>
            <th class="center" colspan="6">{{thisYear}} 年计划</th>
            <th class="center"></th>
            <th class="center" colspan="6">{{thisYear}} 年执行情况</th>
            <th class="center">备注</th>
        </tr>
        <tr>
            <th class="center">级别</th>
            <th class="center">序号</th>
            <th class="center">时间</th>
            <th class="center">往访国</th>
            <th class="center">团长</th>
            <th class="center">组团单位</th>
            <th class="center">是否完成</th>
            <th class="center">级别</th>
            <th class="center">序号</th>
            <th class="center">时间</th>
            <th class="center">往访国</th>
            <th class="center">团长</th>
            <th class="center">组团单位</th>
            <th class="center"></th>
        </tr>
        </thead>
        <tbody>
        <tr></tr>
        <tr></tr>
        {{#each dataList}}
        <tr class="planSummaryItem">
            <td class="center" rowspan="{{rowspan}}">{{level}}</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td class="center">{{isFinished}}</td>
            <td class="center">{{adminLevel}}</td>
            <td class="center">{{indexAddOne @index}}</td>
            <td class="center">{{date}}</td>
            <td class="center">{{dstCountry}}</td>
            <td class="center">{{groupLeader}}</td>
            <td class="center">{{org}}</td>
            <td class="center">{{notes}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<%--15. 部级团组出访统计表--%>
<script id="template-minister" type="text/x-handlebars-template">
    <table class="table table-striped table-bordered table-hover center">
        <caption class="align-center"><h4>{{thisYear}} 年部级团组出访统计表</h4></caption>
        <thead>
        <tr>
            <th class="center">序号</th>
            <th class="center" width="15%">时间</th>
            <th class="center">组团单位</th>
            <th class="center">出访国家</th>
            <th class="center">出访任务</th>
            <th class="center">团长</th>
            <th class="center">级别</th>
            <th class="center">委员人数</th>
            <th class="center">代表团人数</th>
        </tr>
        </thead>
        <tbody>
        {{#each dataList}}
        <tr class="ministerItem">
            <td>{{indexAddOne @index}}</td>
            <td>{{date}}</td>
            <td>{{org}}</td>
            <td>{{dstCountry}}</td>
            <td>{{task}}</td>
            <td>{{groupLeader}}</td>
            <td>{{level}}</td>
            <td>{{committeeNum}}</td>
            <td>{{peopleNum}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<%--16. 部级以下团组出访统计表--%>
<script id="template-below-minister" type="text/x-handlebars-template">
    <table class="table table-striped table-bordered table-hover center">
        <caption class="align-center"><h4>{{thisYear}} 年部级以下团组出访统计表</h4></caption>
        <thead>
        <tr>
            <th class="center">序号</th>
            <th class="center" width="15%">时间</th>
            <th class="center">组团单位</th>
            <th class="center">出访国家</th>
            <th class="center">出访任务</th>
            <th class="center">团长</th>
            <th class="center">级别</th>
            <th class="center">委员人数</th>
            <th class="center">代表团人数</th>
        </tr>
        </thead>
        <tbody>
        {{#each dataList}}
        <tr class="belowMinisterItem">
            <td>{{indexAddOne @index}}</td>
            <td>{{date}}</td>
            <td>{{org}}</td>
            <td>{{dstCountry}}</td>
            <td>{{task}}</td>
            <td>{{groupLeader}}</td>
            <td>{{level}}</td>
            <td>{{committeeNum}}</td>
            <td>{{peopleNum}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<%--17. 主席、副主席出访情况--%>
<script id="template-chairman-vice-chairman" type="text/x-handlebars-template">
    <table class="table table-striped table-bordered table-hover center">
        <caption class="align-center"><h4>{{thisYear}} 年主席、副主席出访情况</h4></caption>
        <thead>
        <tr>
            <th class="center">序号</th>
            <th class="center" width="15%">日期</th>
            <th class="center">姓名</th>
            <th class="center">党派/工商联</th>
            <th class="center">出访国家</th>
            <th class="center">主办单位</th>
        </tr>
        </thead>
        <tbody>
        {{#each dataList}}
        <tr class="chairmanViceChairmanItem">
            <td>{{indexAddOne @index}}</td>
            <td>{{date}}</td>
            <td>{{groupLeader}}</td>
            <td>{{party}}</td>
            <td>{{dstCountry}}</td>
            <td>{{org}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        $('.year-picker').datepicker({
            starView: 'decade',
            minView: 'decade',
            format: 'yyyy',
            maxViewMode: 2,
            minViewMode: 2,
            autoclose: true
        });

        var $searchForm = $("#searchForm");
        var $searchBtn = $("#searchBtn");

        var $resetBtn = $("#resetBtn");
        var $exportBtn = $("#exportBtn");

        // 副部级以上
        var $avmTab = $("#tabs-above-vice-minister");
        var $avmTemplate = $("#template-above-vice-minister");
        var $avmTable = $("#table-above-vice-minister");

        // 因公出国情况
        var $baTab = $("#tabs-business-abroad");
        var $baTemplate = $("#template-business-abroad");
        var $baTable = $("#table-business-abroad");

        // 出访情况详表
        var $adTab = $("#tabs-abroad-details");
        var $adTemplate = $("#template-abroad-details");
        var $adTable = $("#table-abroad-details");

        // 副主席参加政协组团
        var $zxVcTab = $("#tabs-zx-vice-chairman");
        var $zxVcTemplate = $("#template-zx-vice-chairman");
        var $zxVcTable = $("#table-zx-vice-chairman");

        // 政协办公厅领导
        var $leadersTab = $("#tabs-zx-leaders");
        var $leadersTemplate = $("#template-zx-leaders");
        var $leadersTable = $("#table-zx-leaders");

        // 专委会领导
        var $commLeadersTab = $("#tabs-committee-leaders");
        var $commLeadersTemplate = $("#template-committee-leaders");
        var $commLeadersTable = $("#table-committee-leaders");

        // 经社理事会
        var $escTab = $("#tabs-economy-society-council");
        var $escTemplate = $("#template-economy-society-council");
        var $escTable = $("#table-economy-society-council");

        // 9个专委会
        var $nineCommTab = $("#tabs-nine-committee");
        var $nineCommTemplate = $("#template-nine-committee");
        var $nineCommTable = $("#table-nine-committee");

        // 副主席参加外单位组团
        var $outerVcTab = $("#tabs-outer-vice-chairman");
        var $outerVcTemplate = $("#template-outer-vice-chairman");
        var $outerVcTable = $("#table-outer-vice-chairman");

        // 中宗和
        var $rpTab = $("#tabs-religion-peace");
        var $rpTemplate = $("#template-religion-peace");
        var $rpTable = $("#table-religion-peace");

        // 政协人员参加外单位组团
        var $outerZxTab = $("#tabs-outer-zx");
        var $outerZxTemplate = $("#template-outer-zx");
        var $outerZxTable = $("#table-outer-zx");

        // 对外交往计划和执行情况对比表
        var $psTab = $("#tabs-plan-summary");
        var $psTemplate = $("#template-plan-summary");
        var $psTable = $("#table-plan-summary");

        // 部级团组出访统计
        var $ministerTab = $("#tabs-minister");
        var $ministerTemplate = $("#template-minister");
        var $ministerTable = $("#table-minister");

        // 部级以下团组出访统计
        var $bmTab = $("#tabs-below-minister");
        var $bmTemplate = $("#template-below-minister");
        var $bmTable = $("#table-below-minister");

        // 主席、副主席出访统计
        var $cvcTab = $("#tabs-chairman-vice-chairman");
        var $cvcTemplate = $("#template-chairman-vice-chairman");
        var $cvcTable = $("#table-chairman-vice-chairman");

        loadData('avm', $avmTab, $avmTemplate, $avmTable);

        $('#myTab a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            var $target = $(e.target).attr('href');

            dispatch($target);
        });


        function dispatch($target) {
            if ($target === "#tabs-above-vice-minister") {
                loadData('avm', $avmTab, $avmTemplate, $avmTable);
            } else if ($target === "#tabs-business-abroad") {
                loadData('ba', $baTab, $baTemplate, $baTable);
            } else if ($target === "#tabs-abroad-details") {
                loadData('ad', $adTab, $adTemplate, $adTable);
            } else if ($target === "#tabs-zx-vice-chairman") {
                loadData('zxVc', $zxVcTab, $zxVcTemplate, $zxVcTable);
            } else if ($target === "#tabs-zx-leaders") {
                loadData('leaders', $leadersTab, $leadersTemplate, $leadersTable);
            } else if ($target === "#tabs-committee-leaders") {
                loadData('commLeaders', $commLeadersTab, $commLeadersTemplate, $commLeadersTable);
            }
            else if ($target === "#tabs-economy-society-council") {
                loadData("esc", $escTab, $escTemplate, $escTable);
            } else if ($target === "#tabs-nine-committee") {
                loadData("nineComm", $nineCommTab, $nineCommTemplate, $nineCommTable);
            } else if ($target === "#tabs-outer-vice-chairman") {
                loadData('outerVc', $outerVcTab, $outerVcTemplate, $outerVcTable);
            } else if ($target === "#tabs-religion-peace") {
                loadData('rp', $rpTab, $rpTemplate, $rpTable);
            } else if ($target === "#tabs-outer-zx") {
                loadData('outerZx', $outerZxTab, $outerZxTemplate, $outerZxTable);
            } else if ($target === "#tabs-plan-summary") {
                loadData('ps', $psTab, $psTemplate, $psTable);
            } else if ($target === "#tabs-minister") {
                loadData('mini', $ministerTab, $ministerTemplate, $ministerTable);
            } else if ($target === "#tabs-below-minister") {
                loadData('bm', $bmTab, $bmTemplate, $bmTable);
            } else if ($target === "#tabs-chairman-vice-chairman") {
                loadData('cvc', $cvcTab, $cvcTemplate, $cvcTable);
            }
        }


        function loadData(type, $tab, $template, $table) {

            var searchDataUrl = "/statistics/load-data.do";
            var searchFormData = $searchForm.serializeObject();

            var loadId = G.showAjaxLoading();

            $.post(searchDataUrl, {searchParams: JSON.stringify(searchFormData), type: type}, function (map) {
                G.doneAjaxLoading(loadId);
                if (null != map) {
                    /*查询数据展示*/
                    $table.empty();
                    var sourceHtml = $template.html();
                    var template = Handlebars.compile(sourceHtml);
                    Handlebars.registerHelper('indexAddOne', function (index, options) {
                        return parseInt(index) + 1;
                    });

                    /*展示数据*/
                    var thisYear = searchFormData.startDate.slice(0, 4);
                    var lastYear = parseInt(thisYear) - 1;
                    var dataList = map.searchResult;

                    if (null != dataList && dataList.length > 0) {
                        var data = {dataList: dataList, thisYear: thisYear, lastYear: lastYear};
                        var html = template(data);
                        $table.append(html);
                    } else {
                        var dataYear = {thisYear: thisYear, lastYear: lastYear};
                        var empty = template(dataYear);
                        $table.append(empty);
                    }
                }
            }, 'json').error(function () {
                G.alert({message: "查询数据错误！"});
                G.doneAjaxLoading(loadId);
            });
        }


        // 查询
        $searchBtn.click(function () {
            // 获取当前选中的 tab 页
            var $target = $('#myTab li[class="active"] a').attr('href');
            dispatch($target);
        });


        //导出表格
        $exportBtn.unbind().bind('click', function () {
            var $target = $('#myTab li[class="active"] a').attr('href');

            var type;
            var startDate = $searchForm.find('#form-field-startDate').val();

            if ($target === "#tabs-above-vice-minister") {
                type = 'avm';
            } else if ($target === "#tabs-business-abroad") {
                type = 'ba';
            } else if ($target === "#tabs-abroad-details") {
                type = 'ad';
            } else if ($target === "#tabs-zx-vice-chairman") {
                type = 'zxVc';
            } else if ($target === "#tabs-zx-leaders") {
                type = 'leaders';
            } else if ($target === "#tabs-committee-leaders") {
                type = 'commLeaders';
            } else if ($target === "#tabs-economy-society-council") {
                type = 'esc';
            } else if ($target === "#tabs-nine-committee") {
                type = 'nineComm';
            } else if ($target === "#tabs-outer-vice-chairman") {
                type = 'outerVc';
            } else if ($target === "#tabs-religion-peace") {
                type = 'rp';
            } else if ($target === "#tabs-outer-zx") {
                type = 'outerZx';
            } else if ($target === "#tabs-plan-summary") {
                type = 'ps';
            } else if ($target === "#tabs-minister") {
                type = 'mini';
            } else if ($target === "#tabs-below-minister") {
                type = 'bm';
            } else if ($target === "#tabs-chairman-vice-chairman") {
                type = 'cvc';
            }


            G.confirm({
                message: '确认导出统计表吗?',
                callback: function (result) {
                    if (result) {
                        if (type === 'deprecated' || type === 'ad' || type === 'ps') {
                            exportExcel(type)
                        } else {
                            location.href = '${basePath}/statistics/export-excel.do?type=' + type + '&year=' + startDate;
                        }
                    }
                }
            });
        });

        function exportExcel(type) {

            var tableId;
            var fileName;
            var year = new Date().getFullYear();
            if (type === 'ba') {
                tableId = 'business-abroad';
                fileName = year + '年中央和国家机关各部门因公出国（境）情况汇总表';

                $baTable = $('#business-abroad');
            } else if (type === 'ad') {
                tableId = 'abroad-details';
                fileName = year + '年出访情况详表';
            } else if (type === 'ps') {
                tableId = 'plan-summary';
                fileName = year + '年出访计划执行情况统计表';
            }

            var $table = $('#' + tableId);
            $table.tableExport({
                type: 'excel',
                mso: {fileFormat: 'xls'},
                fileName: fileName
            });
            // var $table = document.getElementById(tableId);
            //
            //
            // var workbook = XLSX.utils.table_to_book($table);
            //
            // XLSX.writeFile(workbook, fileName + '.xls');
        }


        // 重置查询条件
        $resetBtn.click(function () {
            $searchForm.resetForm();

            // 设置查询年度为当前年份
            var $startDate = $searchForm.find('#form-field-startDate');
            $startDate.val(new Date().getFullYear());

            $('#myTab a:first').tab('show');
        });


        $(document).one('ajaxloadstart.page', function (e) {

            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

    });
</script>
<script src="${basePath}/plugin/xlsx.full.min.js" type="text/javascript"></script>

<script src="${basePath}/plugin/tableExport/libs/FileSaver/FileSaver.min.js"></script>
<script src="${basePath}/plugin/tableExport/libs/js-xlsx/xlsx.core.min.js"></script>
<script src="${basePath}/plugin/tableExport/tableExport.min.js"></script>