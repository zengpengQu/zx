<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath =  path;
    pageContext.setAttribute("basePath", basePath);
%>
<title>履职支撑平台</title>
<div class="row">

    <%--孙毅添加--%>
    <div class="col-xs-12">
        <div class="row">
            <div class="fl_l block width-100 height-100 mar_b_20 ">
                <div class="col-xs-6">
                    <input class="hide" id="indexMainSysTime" name="indexMainSysTime" value="${indexMainSysTime}">
                    <ul class="nav nav-tabs header-table-th header-table-th-a" >
                        <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView">
                            <c:if test="${'47' eq userSecPopeDomView.id}">
                                <li class="dropdown" style="float: right" id="draftingActive" onclick="agencyIndex(3);">
                                    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                        呈批件
                                        <i class="ace-icon fa fa-caret-down bigger-110 width-auto"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-info">
                                    <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView1">
                                        <c:if test="${'79' eq userSecPopeDomView1.id}">
                                            <li><a data-toggle="tab" href="#draftingNei">内行文</a></li>
                                            <li><a data-toggle="tab" href="#draftingWai">外行文</a></li>
                                        </c:if>
                                    </c:forEach>
                                    </ul>
                                </li>
                            </c:if>
                            <c:if test="${'49' eq userSecPopeDomView.id}">
                                <li class="dropdown"  style="float: right" id="dutyActive" onclick="agencyIndex(2);">
                                    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                        日程安排
                                        <i class="ace-icon fa fa-caret-down bigger-110 width-auto"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-info">
                                        <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView1">
                                        <c:if test="${'50' eq userSecPopeDomView1.id}">
                                            <li><a data-toggle="tab" href="#dutyDaily">值班日报</a></li>
                                        </c:if>
                                        <c:if test="${'51' eq userSecPopeDomView1.id}">
                                            <li><a data-toggle="tab" href="#wekWork">一周工作情况</a></li>
                                        </c:if>
                                        <c:if test="${'53' eq userSecPopeDomView1.id}">
                                            <li><a data-toggle="tab" href="#activity">领导活动安排</a></li>
                                        </c:if>
                                        </c:forEach>
                                    </ul>
                                </li>
                            </c:if>
                            <c:if test="${'75' eq userSecPopeDomView.id}">
                                <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView1">
                                    <c:if test="${'76' eq userSecPopeDomView1.id}">
                                        <li class="active" style="float: right" id="placeActive" onclick="agencyIndex(1);">
                                                <a data-toggle="tab" href="#place">视察考察调研活动</a>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </c:forEach>

                        <span class="span-index-title">待办事项</span>
                    </ul>
                    <div class="tab-content tab-content1" style="height: 262px; overflow: hidden">

                        <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView">
                            <%-- 呈批件 --%>
                            <c:if test="${'47' eq userSecPopeDomView.id}">
                                <%--呈批件内行文--%>
                                <div id="draftingNei" class="tab-pane">
                                    <ol style="height:202px;overflow: auto;">
                                        <c:forEach varStatus="submitBatchList" var="submitBatch" items="${submitBatchListIndexMain}">
                                            <li class="list-group-item submitBatchLi" data-item="${submitBatch.id}"
                                                    <c:if test="${'1' eq (submitBatchList.index+1)%2}"> style="background-color: #f6fbff" </c:if>
                                                    <c:if test="${'0' eq (submitBatchList.index+1)%2}"></c:if>
                                            >
                                                <span style="color: #00b7ee;float:left">${submitBatchList.index+1}.&nbsp;&nbsp;</span>
                                                <a <%--href="#page/submit-batch/batch-submit-list?id=${submitBatch.id}&SubSecPopeDomViewId=79"--%> class="span-index-length">
                                                        ${submitBatch.title}
                                                </a>
                                                <span class="label label-sm  arrowed arrowed-right label-primary"
                                                      style="float:right;margin-top: -20px;margin-right: 90px;">
                                                        ${submitBatch.jsonObject.indexStatusName} </span>
                                                <span style="float:right;margin-top: -20px">${submitBatch.jsonObject.updateTimeIndex}</span>
                                            </li>
                                        </c:forEach>
                                    </ol>
                                </div>
                                <%--呈批件内行文结束--%>
                                <%--呈批件外行文--%>
                                <div id="draftingWai" class="tab-pane">
                                    <ol style="height:202px;overflow: auto;">
                                        <c:forEach varStatus="submitBatchOutList" var="submitBatchOut" items="${submitBatchOutListIndexMain}">
                                            <li class="list-group-item submitBatchOutLi" data-item="${submitBatchOut.id}"
                                                    <c:if test="${'1' eq (submitBatchOutList.index+1)%2}"> style="background-color: #f6fbff" </c:if>
                                                    <c:if test="${'0' eq (submitBatchOutList.index+1)%2}">  </c:if>
                                            >
                                                <span style="color: #00b7ee;float:left">${submitBatchOutList.index+1}.&nbsp;&nbsp;</span>
                                                <a <%--href="#page/submit-batch-out/batch-submit-list?indexId=${submitBatchOut.id}&SubSecPopeDomViewId=79"--%>
                                                        class="span-index-length">
                                                        ${submitBatchOut.title}
                                                </a>
                                                <span class="label label-sm  arrowed arrowed-right label-primary"  style="float:right;margin-top: -20px;margin-right: 90px;">
                                                        ${submitBatchOut.jsonObject.indexStatusName}</span>
                                                <span style="float:right;margin-top: -20px">${submitBatchOut.jsonObject.updateTimeIndex}</span>
                                            </li>
                                        </c:forEach>
                                    </ol>
                                </div>
                                <%--呈批件外行文结束--%>
                            </c:if>
                            <%-- 呈批件结束 --%>

                            <%--视察考察调研活动--%>
                                <c:if test="${'75' eq userSecPopeDomView.id}">
                                    <div id="place" class="tab-pane in active">
                                        <ol style="height:202px;overflow: auto;">
                                            <c:forEach varStatus="placeAgencyList" var="placeAgency" items="${placeListIndexMainAgency}">
                                                <li class="list-group-item placeAgencyLi" data-item="${placeAgency.id}"
                                                        <c:if test="${'1' eq (placeAgencyList.index+1)%2}"> style="background-color: #f6fbff" </c:if>
                                                        <c:if test="${'0' eq (placeAgencyList.index+1)%2}"> </c:if>
                                                >
                                                    <span style="color: #00b7ee;float:left">${placeAgencyList.index+1}.&nbsp;&nbsp;</span>
                                                    <a <%--href="#page/place/place-list?SubSecPopeDomViewId=76&id=${placeAgency.id}"--%>
                                                            class="span-index-length">
                                                            ${placeAgency.title}
                                                    </a>
                                                    <span class="label label-sm  arrowed arrowed-right label-primary"  style="float:right;margin-top: -20px;margin-right: 90px;">
                                                            ${placeAgency.jsonObject.statusStr}</span>
                                                    <span style="float:right;margin-top: -20px">${placeAgency.jsonObject.createTime}</span>
                                                </li>
                                            </c:forEach>
                                        </ol>
                                    </div>
                                </c:if>
                            <%--视察考察调研活动结束--%>
                            <%-- 日程安排 --%>
                                <c:if test="${'49' eq userSecPopeDomView.id}">
                                <%--值班日报--%>
                                <div id="dutyDaily" class="tab-pane">
                                    <ol style="height:202px;overflow: auto;">
                                        <c:forEach varStatus="dutyDailyListIndex" var="dutyDailyIndex" items="${dutyDailyListIndexMainAgency}">
                                            <li class="list-group-item dutyDailyIndexLi" data-item="${dutyDailyIndex.id}"
                                                    <c:if test="${'1' eq (dutyDailyListIndex.index+1)%2}"> style="background-color: #f6fbff" </c:if>
                                                    <c:if test="${'0' eq (dutyDailyListIndex.index+1)%2}"> </c:if>
                                            >
                                                <span style="color: #00b7ee;float:left">${dutyDailyListIndex.index+1}.&nbsp;&nbsp;</span>
                                                <a <%--href="#page/duty-daily/duty-daily-list?id=${dutyDailyIndex.id}&SubSecPopeDomViewId=50"--%>
                                                        class="span-index-length">
                                                        ${dutyDailyIndex.jsonObject.indexContentStr}
                                                </a>
                                                <span class="label label-sm  arrowed arrowed-right label-primary"  style="float:right;margin-top: -20px;margin-right: 90px;">
                                                        ${dutyDailyIndex.jsonObject.statusNameStr}</span>
                                                <span style="float:right;margin-top: -20px">${dutyDailyIndex.jsonObject.updateTimeStr}</span>
                                            </li>
                                        </c:forEach>
                                    </ol>
                                </div>
                                <%--值班日报结束--%>

                                <%--一周工作情况--%>
                                <div id="wekWork" class="tab-pane">
                                    <ol style="height:202px;overflow: auto;">
                                        <c:forEach varStatus="wekWorkChargeList" var="wekWorkCharge" items="${wekWorkListIndexMainChargeList}">
                                            <li class="list-group-item wekWorkChargeLi" data-item="${wekWorkCharge.id}"
                                                    <c:if test="${'1' eq (wekWorkChargeList.index+1)%2}"> style="background-color: #f6fbff" </c:if>
                                                    <c:if test="${'0' eq (wekWorkChargeList.index+1)%2}">  </c:if>
                                            >
                                                <span style="color: #00b7ee;float:left">${wekWorkChargeList.index+1}.&nbsp;&nbsp;</span>
                                                <a <%--href="#page/week-work/week-work-list?id=${wekWorkCharge.id}&SubSecPopeDomViewId=51"--%>
                                                        class="span-index-length">
                                                        ${wekWorkCharge.meeting}
                                                </a>
                                                <span class="label label-sm  arrowed arrowed-right label-primary"  style="float:right;margin-top: -20px;margin-right: 90px;">
                                                        ${wekWorkCharge.jsonObject.statusStr}</span>
                                                <span style="float:right;margin-top: -20px">${wekWorkCharge.jsonObject.createTimeStr}</span>
                                            </li>
                                        </c:forEach>
                                    </ol>
                                </div>
                                <%--一周工作情况结束--%>

                                <%--领导活动安排--%>
                                <div id="activity" class="tab-pane">
                                    <ol style="height:202px;overflow: auto;">
                                        <c:forEach varStatus="dutyDailyChargeIndex" var="dutyDailyCharge" items="${activityPlanIndexMainChargeList}">
                                            <li class="list-group-item dutyDailyChargeLi" data-item="${dutyDailyCharge.id}"
                                                    <c:if test="${'1' eq (dutyDailyChargeIndex.index+1)%2}"> style="background-color: #f6fbff" </c:if>
                                                    <c:if test="${'0' eq (dutyDailyChargeIndex.index+1)%2}"> </c:if>
                                            >
                                                <span style="color: #00b7ee;float:left">${dutyDailyChargeIndex.index+1}.&nbsp;&nbsp;</span>
                                                <a &lt;%&ndash;href="#page/activity-plan/activity-plan-list?id=${dutyDailyCharge.id}&SubSecPopeDomViewId=53"&ndash;%&gt;
                                                        class="span-index-length">
                                                        ${dutyDailyCharge.jsonObject.content}
                                                </a>
                                                <span class="label label-sm  arrowed arrowed-right label-primary"  style="float:right;margin-top: -20px;margin-right: 90px;">
                                                        ${dutyDailyCharge.jsonObject.activityStatusStr}</span>
                                                <span style="float:right;margin-top: -20px">${dutyDailyCharge.jsonObject.updateTimeStr}</span>
                                            </li>
                                        </c:forEach>
                                    </ol>
                                </div>
                                <%--领导活动安排结束--%>
                            </c:if>
                            <%-- 日程安排结束 --%>

                            <%-- 更多按钮 --%>
                            <c:if test="${'75' eq userSecPopeDomView.id}">
                                <a href="#page/place/place-list?SubSecPopeDomViewId=76"  class="indexMainAgency">
                                    <button style="border-radius: 25px;overflow: hidden;background-color: #41C8E7;position: absolute;right: 8px;bottom: 8px;border: none;color: #fff;">&nbsp;&nbsp;更多 &gt;&gt;</button>
                                </a>
                            </c:if>
                            <c:if test="${'47' eq userSecPopeDomView.id}">
                                <a href="#page/submit-batch/batch-submit-list?SubSecPopeDomViewId=79"  class="indexMainAgency">
                                    <button style="border-radius: 25px;overflow: hidden;background-color: #41C8E7;position: absolute;right: 8px;bottom: 8px;border: none;color: #fff;">&nbsp;&nbsp;更多 &gt;&gt;</button>
                                </a>
                            </c:if>
                            <c:if test="${'49' eq userSecPopeDomView.id}">
                                <a href="##page/duty-daily/duty-daily-list?SubSecPopeDomViewId=50"  class="indexMainAgency">
                                    <button style="border-radius: 25px;overflow: hidden;background-color: #41C8E7;position: absolute;right: 8px;bottom: 8px;border: none;color: #fff;">&nbsp;&nbsp;更多 &gt;&gt;</button>
                                </a>
                            </c:if>
                        </c:forEach>

                    </div>
                </div>
                <div class="col-xs-6">
                    <ul class="nav nav-tabs header-table-th header-table-th-a">
                        <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView">
                            <c:if test="${'49' eq userSecPopeDomView.id}">
                                <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView1">
                                    <c:if test="${'50' eq userSecPopeDomView1.id}">
                                        <li style="float: right" onclick="workingIndex(3);" id="dutyDropdown14">
                                            <a data-toggle="tab" href="#dropdown14">值班日报</a>
                                        </li>
                                    </c:if>
                                    <c:if test="${'51' eq userSecPopeDomView1.id}">
                                        <li style="float: right" onclick="workingIndex(2);" id="workProfile4">
                                            <a data-toggle="tab" href="#profile4">一周工作情况</a>
                                        </li>
                                    </c:if>
                                    <c:if test="${'53' eq userSecPopeDomView1.id}">
                                        <li class="active" style="float: right" onclick="workingIndex(1);" id="activityHome4">
                                            <a data-toggle="tab" href="#home4">领导活动安排</a>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                        <span class="span-index-title">工作动态</span>
                    </ul>
                    <div class="tab-content tab-content1" style="height: 262px; overflow: hidden">
                        <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView">
                            <c:if test="${'53' eq userSecPopeDomView.id}">
                                <div id="home4" class="tab-pane in active">
                                    <%--<ol style="height:202px;overflow: auto;" id="activity-plan-index-main">
                                        <c:forEach varStatus="activityPlan" var="activity" items="${activityPlanListIndexMainList}">
                                            <li class="list-group-item activityLi" data-item="${activity.id}"
                                            <c:if test="${'1' eq (activityPlan.index+1)%2}"> style="background-color: #f6fbff" </c:if>
                                            <c:if test="${'0' eq (activityPlan.index+1)%2}">  </c:if>
                                            >
                                                <span style="color: #00b7ee;float:left">${activityPlan.index+1}.&nbsp;&nbsp;</span>
                                                <a &lt;%&ndash;href="#page/activity-plan/activity-plan-list?id=${activity.id}&SubSecPopeDomViewId=53"&ndash;%&gt;
                                                   class="span-index-length">
                                                     ${activity.content}
                                                </a>
                                                <span style="float:right;margin-top: -20px">${activity.jsonObject.sendTimeStr}</span>
                                            </li>
                                        </c:forEach>
                                    </ol>--%>
                                </div>
                            </c:if>
                        </c:forEach>
                        <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView">
                            <c:if test="${'51' eq userSecPopeDomView.id}">
                                <div id="profile4" class="tab-pane">
                                    <%--<ol style="height:202px;overflow: auto;" id="wekWork-index-main">
                                        <c:forEach varStatus="wekWorkList" var="wekWork" items="${wekWorkListIndexMainList}">
                                            <li class="list-group-item wekWorkLi" data-item="${wekWork.id}"
                                                    <c:if test="${'1' eq (wekWorkList.index+1)%2}"> style="background-color: #f6fbff" </c:if>
                                                    <c:if test="${'0' eq (wekWorkList.index+1)%2}"> </c:if>
                                            >
                                                <span style="color: #00b7ee;float:left">${wekWorkList.index+1}.&nbsp;&nbsp;</span>
                                                <a &lt;%&ndash;href="#page/week-work/week-work-list?id=${wekWork.id}&SubSecPopeDomViewId=51"&ndash;%&gt;
                                                        class="span-index-length">
                                                        ${wekWork.meeting}
                                                </a>
                                                <span style="float:right;margin-top: -20px">${wekWork.jsonObject.sendDateStr}</span>
                                            </li>
                                        </c:forEach>
                                    </ol>--%>
                                </div>
                            </c:if>
                        </c:forEach>
                        <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView">
                            <c:if test="${'50' eq userSecPopeDomView.id}">
                                <div id="dropdown14" class="tab-pane">
                                    <ol style="height:202px;overflow: auto;"id="dutyDaily-index-main">
                                      <%--  <c:forEach varStatus="dutyDailyList" var="dutyDaily" items="${dutyDailyListIndexMainList}">
                                            <li class="list-group-item dutyDailyLi" data-item="${dutyDaily.id}"
                                                    <c:if test="${'1' eq (dutyDailyList.index+1)%2}"> style="background-color: #f6fbff" </c:if>
                                                    <c:if test="${'0' eq (dutyDailyList.index+1)%2}">  </c:if>
                                            >
                                                <span style="color: #00b7ee;float:left">${dutyDailyList.index+1}.&nbsp;&nbsp;</span>
                                                <a &lt;%&ndash;href="#page/duty-daily/duty-daily-list?id=${dutyDaily.id}&SubSecPopeDomViewId=50"&ndash;%&gt;
                                                        class="span-index-length">
                                                        ${dutyDaily.jsonObject.indexContentStr}
                                                </a>
                                                <span style="float:right;margin-top: -20px">${dutyDaily.jsonObject.updateTimeStr}</span>
                                            </li>
                                        </c:forEach>--%>
                                    </ol>
                                </div>
                            </c:if>
                        </c:forEach>
                        <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView">
                            <c:if test="${'50' eq userSecPopeDomView.id}">
                                <a href="#page/duty-daily/duty-daily-list?SubSecPopeDomViewId=50" class="indexMainWorking">
                                    <button style="border-radius: 25px;overflow: hidden;background-color: #41C8E7;position: absolute;right: 8px;bottom: 8px;border: none;color: white">&nbsp;&nbsp;更多 &gt;&gt;</button>
                                </a>
                            </c:if>
                            <c:if test="${'51' eq userSecPopeDomView.id}">
                                <a href="#page/week-work/week-work-list?SubSecPopeDomViewId=51" class="indexMainWorking">
                                    <button style="border-radius: 25px;overflow: hidden;background-color: #41C8E7;position: absolute;right: 8px;bottom: 8px;border: none;color: white">&nbsp;&nbsp;更多 &gt;&gt;</button>
                                </a>
                            </c:if>
                            <c:if test="${'53' eq userSecPopeDomView.id}">
                                <a href="#page/activity-plan/activity-plan-list?SubSecPopeDomViewId=53" class="indexMainWorking">
                                    <button style="border-radius: 25px;overflow: hidden;background-color: #41C8E7;position: absolute;right: 8px;bottom: 8px;border: none;color: white">&nbsp;&nbsp;更多 &gt;&gt;</button>
                                </a>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="fl_l block  width-100 height-100  mar_b_20 ">
                <div class="col-xs-6">
                    <ul class="nav nav-tabs header-table-th header-table-th-a">
                        <span class="span-index-title">视察考察调研活动安排</span>
                    </ul>
                    <div class="tab-content tab-content1" style="height: 270px; overflow: hidden">
                        <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView">
                            <c:if test="${'75' eq userSecPopeDomView.id}">
                                <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView1">
                                    <c:if test="${'76' eq userSecPopeDomView1.id}">
                                        <ol style="height:210px;overflow: auto;">
                                            <c:forEach varStatus="indexMainPlace" var="place" items="${placeListIndexMain}">
                                                <li class="list-group-item placeLi" data-item="${place.id}"
                                                    <c:if test="${'1' eq (indexMainPlace.index+1)%2}"> style="background-color: #f6fbff" </c:if>
                                                    <c:if test="${'0' eq (indexMainPlace.index+1)%2}"> </c:if>
                                                >
                                                    <span style="color: #00b7ee;float:left">${indexMainPlace.index+1}.&nbsp;&nbsp;</span>
                                                    <a <%--href="#page/place/place-list?id=${place.id}&SubSecPopeDomViewId=76"--%>  class="span-index-length">
                                                            ${place.title}
                                                    </a>
                                                    <span style="float:right ;margin-top: -20px">${place.jsonObject.createTime}</span>
                                                </li>
                                            </c:forEach>
                                        </ol>
                                        <a href="#page/place/place-list?SubSecPopeDomViewId=76">
                                            <button style="border-radius: 25px; overflow: hidden;background-color: #41C8E7;position: absolute;right: 8px;bottom: 8px;border: none;color: white; ">&nbsp;&nbsp;更多 &gt;&gt;</button>
                                        </a>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                <div class="col-xs-6">
                    <ul class="nav nav-tabs header-table-th header-table-th-a"  >
                        <span class="span-index-title">公告栏</span>
                    </ul>
                    <div class="tab-content tab-content1" style="height: 270px; overflow: hidden">
                        <ol style="height:210px;overflow: auto;">
                            <c:forEach varStatus="indexMainBoard" var="bulletinBoard" items="${bulletinBoardIndexMainList}">
                                <li class="list-group-item bulletinBoardLi" data-item="${bulletinBoard.id}"
                                        <c:if test="${'1' eq (indexMainBoard.index+1)%2}"> style="background-color: #f6fbff" </c:if>
                                        <c:if test="${'0' eq (indexMainBoard.index+1)%2}">  </c:if>
                                >
                                    <span style="color: #00b7ee;float:left">${indexMainBoard.index+1}.&nbsp;&nbsp;</span>
                                    <a <%--href="#page/bulletin-board/jump-to-bulletin-board-list?id=${bulletinBoard.id}&SubSecPopeDomViewId=71"--%>
                                            class="span-index-length">
                                            ${bulletinBoard.title}
                                    </a>
                                    <span style="float:right;margin-top: -20px">${bulletinBoard.jsonObject.updateTimeIndexMain}</span>
                                </li>
                            </c:forEach>
                        </ol>
                        <a href="#page/bulletin-board/jump-to-bulletin-board-list?SubSecPopeDomViewId=71">
                            <button style="border-radius: 25px;overflow: hidden;background-color: #41C8E7;position: absolute;right: 8px;bottom: 8px;border: none;color: #fff;">&nbsp;&nbsp;更多 &gt;&gt;</button>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
        <%--<div class="boxcenter">
           &lt;%&ndash; <div class="fl_l block width667 height410 mar_b_20 ">
                <div class="th">
                    <div class="fl_l"><i class="ace-icon fa fa-camera-o bigger-120 "></i>&nbsp;&nbsp;图片新闻</div>
                    <div class="fl_l" style="margin-left: 280px;"><i class="ace-icon fa fa-bell-o "></i>&nbsp;&nbsp;最新动态</div>
                    <div id="newsNum" class="fl_l" style="margin-left: 65px;"></div>

                    <div id="newsMore" class="fl_r">
                        &lt;%&ndash;<a data-url="page/index/getMoreNewStatus?newsDisplay=${newsDisplay}&ndash;%&gt;
                        &lt;%&ndash;&hasAccdAuth=${hasAccdAuth}&hasInnerAuth=${hasInnerAuth}
                        &limitewsDay=${limitewsDay}&orgId=${orgId}&userId=${userId}"
                         href="#page/index/getMoreNewStatus?newsDisplay=${newsDisplay}&hasAccdAuth=${hasAccdAuth}
                         &hasInnerAuth=${hasInnerAuth}&limitewsDay=${limitewsDay}&orgId=${orgId}&userId=${userId}"
                          title="查看更多">&ndash;%&gt;
                        &lt;%&ndash;<img src="${basePath}/images/index/qxj_more.png" width="12" height="16"/>&ndash;%&gt;
                        &lt;%&ndash;</a>&ndash;%&gt;
                        <a href="#" title="查看更多" id="openRecentByNewWindow">
                        <img src="${basePath}/images/index/qxj_more.png" width="12" height="16"/></a>
                    </div>
                </div>
                <div class="line3_dreepblue">
                    <div class="line3_blue"></div>
                </div>

                <div class="padd20 overflow">
                    <!--图片新闻开始-->
                    <div class="bigimgblock">
                        <div class="overflow height216">
                            <div id="pictureContent" class="silder"  style="width: 327px;height: 200px">

                            </div>
                        </div>

                        <ul id="pictureTitle" class="mar_t_12">

                        </ul>
                    </div>
                    <!--图片新闻结束-->

                    <!--动态信息开始-->
                    <div class="newsblock"
                         &lt;%&ndash;style="height:338px;border: 1px solid  #a6e1ec"&ndash;%&gt;
                    >
                        &lt;%&ndash;<div  id="newStatus" style="padding: 3px">&ndash;%&gt;
                            &lt;%&ndash;&lt;%&ndash;<i class="ace-icon glyphicon glyphicon-refresh  green"></i>&ndash;%&gt;&ndash;%&gt;
                            &lt;%&ndash;&lt;%&ndash;<b class="green">&ndash;%&gt;&ndash;%&gt;
                                &lt;%&ndash;&lt;%&ndash;正在努力加载数据...&ndash;%&gt;&ndash;%&gt;
                            &lt;%&ndash;&lt;%&ndash;</b>&ndash;%&gt;&ndash;%&gt;
                        &lt;%&ndash;</div>&ndash;%&gt;
                    </div>
                    <!--动态信息结束-->
                </div>

            </div>&ndash;%&gt;

            <!--最新公告开始-->
            <div class="width315 fl_r block height165 overflow mar_b_20 ">
                <div class="th">
                    <div class="fl_l"><i class="ace-icon fa fa-bullhorn  "></i>&nbsp;&nbsp;最新公告</div>
                    <div class="fl_r"><a href="#page/announce/list?SubSecPopeDomViewId=22"
                    data-url="page/announce/list?SubSecPopeDomViewId=22" title="查看更多">
                    <img src="${basePath}/images/index/qxj_more.png" width="12" height="16"/></a></div>
                </div>
                <div class="line3_dreepblue">
                    <div class="line3_blue"></div>
                </div>
                &lt;%&ndash;<div id="announceContent" class="padd20 overflow">&ndash;%&gt;
                    &lt;%&ndash;<i class="ace-icon glyphicon glyphicon-refresh green"></i>&ndash;%&gt;
                    &lt;%&ndash;<b class="green">&ndash;%&gt;
                        &lt;%&ndash;正在努力加载数据...&ndash;%&gt;
                    &lt;%&ndash;</b>&ndash;%&gt;
                &lt;%&ndash;</div>&ndash;%&gt;
            </div>
            <!--最新公告结束-->

            <!--国家局响应开始-->
            &lt;%&ndash;<div class="width315 fl_r block height225 overflow mar_b_20 ">&ndash;%&gt;
                &lt;%&ndash;<div class="th">&ndash;%&gt;
                    &lt;%&ndash;<div class="fl_l"><i class="ace-icon fa fa-bookmark-o  "></i>&nbsp;&nbsp;国家局响应</div>&ndash;%&gt;
                    &lt;%&ndash;<div class="fl_r">
                    <a href="#page/emeg-scan/list?SubSecPopeDomViewId=5" data-url="page/emeg-scan/list?SubSecPopeDomViewId=5" title="查看更多">
                    <img src="${basePath}/images/index/qxj_more.png" width="12" height="16"/></a></div>&ndash;%&gt;
                &lt;%&ndash;</div>&ndash;%&gt;
                &lt;%&ndash;<div class="line3_dreepblue">&ndash;%&gt;
                    &lt;%&ndash;<div class="line3_blue"></div>&ndash;%&gt;
                &lt;%&ndash;</div>&ndash;%&gt;
                &lt;%&ndash;<table id="counEmegContent" width="100%" border="0" cellspacing="0" cellpadding="0" class="tablelist">&ndash;%&gt;
                    &lt;%&ndash;<tr>&ndash;%&gt;
                        &lt;%&ndash;<td align="center"><i class="ace-icon glyphicon glyphicon-refresh  green"></i>&ndash;%&gt;
                            &lt;%&ndash;<b class="green">&ndash;%&gt;
                                &lt;%&ndash;正在努力加载数据...&ndash;%&gt;
                            &lt;%&ndash;</b>&ndash;%&gt;
                        &lt;%&ndash;</td>&ndash;%&gt;
                    &lt;%&ndash;<tr>&ndash;%&gt;
                &lt;%&ndash;</table>&ndash;%&gt;
            &lt;%&ndash;</div>&ndash;%&gt;
            <!--国家局响应结束-->
        </div>--%>
</div>

<style>
    /*a标签样式*/
    .span-index-length{
    width: 50%;display: block;overflow: hidden;
    word-break: keep-all;white-space: nowrap;text-overflow: ellipsis;}
    /* 4个标题样式*/
    .span-index-title{
       /* color:gold;letter-spacing: 0;text-shadow: 0px 1px 0px #999,0px 2px 0px #888,0px 3px 0px #777,0px 4px 0px #666,
        0px 5px 0px #555,0px 6px 0px #444,0px 7px 0px #333,0px 8px 7px #001135;*/
    }
</style>
<%--孙毅添加结束--%>
<script type="text/javascript">

    /*孙毅添加*/
    //按钮事件
    function workingIndex(type) {
        if(type==1){
            <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView">
            <c:if test="${'53' eq userSecPopeDomView.id}">
            $(".indexMainWorking").attr('href','#page/activity-plan/activity-plan-list?SubSecPopeDomViewId=53');
            </c:if>
            </c:forEach>
        }else if(type==2){
            <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView">
            <c:if test="${'51' eq userSecPopeDomView.id}">
            $(".indexMainWorking").attr('href','#page/week-work/week-work-list?SubSecPopeDomViewId=51');
            </c:if>
            </c:forEach>
        }else {
            <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView">
            <c:if test="${'50' eq userSecPopeDomView.id}">
            $(".indexMainWorking").attr('href','#page/duty-daily/duty-daily-list?SubSecPopeDomViewId=50');
            </c:if>
            </c:forEach>
        }
    }
    function agencyIndex(type) {
        if(type==1){
            <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView">
            <c:if test="${'75' eq userSecPopeDomView.id}">
            $(".indexMainAgency").attr('href','#page/place/place-list?SubSecPopeDomViewId=76');
            </c:if>
            </c:forEach>
        }else if(type==2){
            <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView">
            <c:if test="${'49' eq userSecPopeDomView.id}">
            $(".indexMainAgency").attr('href','#page/duty-daily/duty-daily-list?SubSecPopeDomViewId=50');
            </c:if>
            </c:forEach>
        }else {
            <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView">
            <c:if test="${'47' eq userSecPopeDomView.id}">
            $(".indexMainAgency").attr('href','#page/submit-batch/batch-submit-list?SubSecPopeDomViewId=79');
            </c:if>
            </c:forEach>
        }
    }
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {


        //最新动态刷新每次的系统时间记录
        var interval;

        $(document).ready(function () {});

        //页面再加载时触发
        $(document).unbind('ajaxloadstart.page').bind('ajaxloadstart.page', function(){
            try {
                if(interval!=undefined && interval!=null) {
                    clearInterval(interval);
                    interval=null;
                }
            }catch (e){

            }
        });


        var indexMainRol = '-100';
        //工作动态，按钮即对应模块显示
        <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView">

            <c:if test="${'53' eq userSecPopeDomView.id}">
            $("#workProfile4").removeClass("active");
            $("#dutyDropdown14").removeClass("active");
            $("#activityHome4").addClass("active");
            $("#profile4").removeClass("active");
            $("#dropdown14").removeClass("active");
            $("#home4").addClass("active");
            </c:if>
            <c:if test="${'51' eq userSecPopeDomView.id}">
            $("#activityHome4").removeClass("active");
            $("#dutyDropdown14").removeClass("active");
            $("#workProfile4").addClass("active");
            $("#home4").removeClass("active");
            $("#dropdown14").removeClass("active");
            $("#profile4").addClass("active");
            </c:if>
            <c:if test="${'50' eq userSecPopeDomView.id}">
            $("#activityHome4").removeClass("active");
            $("#workProfile4").removeClass("active");
            $("#dutyDropdown14").addClass("active");
            $("#home4").removeClass("active");
            $("#profile4").removeClass("active");
            $("#dropdown14").addClass("active");
            </c:if>
        </c:forEach>


        refreshData();
        //五分一刷新
        var realDataInterval = setInterval(refreshData, 300000);

        $(document).one('ajaxloadstart.page', function () {
            try {
                if (realDataInterval != undefined && realDataInterval != null) {
                    clearInterval(realDataInterval);
                    realDataInterval = null;
                }
            } catch (e) {
            }
        });

        function refreshData() {

            var indexMainSysTime = $("#indexMainSysTime").val();
            <c:forEach items="${userSecPopeDomViewListIndexMain}" var="userSecPopeDomView">
                <c:if test="${'53' eq userSecPopeDomView.id}">
                    var searchActivityPlanUrl = "${basePath}/activity-plan/activity-plan-time.do";
                    $.post(searchActivityPlanUrl,{indexMainRol:indexMainRol}, function (result) {
                        if(result.result){
                            var Str = '';
                            var date = result.activityPlans;
                            Str+='<ol style="height:202px;overflow: auto;" id="activity-plan-index-main">';
                            for(var i=0;i<date.length;i++){
                                Str+='<li class="list-group-item activityLi" data-item="'+date[i].dateId+'">'+
                                    '<a class="span-index-length" /*href="#page/activity-plan/activity-plan-list?id=' +
                                    date[i].dateId + '&SubSecPopeDomViewId=53"*/> '+ date[i].count +' </a>'+
                                    '</li>';
                            }
                            Str+='</ol>';
                            $("#home4").html(Str);
                        }
                    });
                </c:if>
                <c:if test="${'51' eq userSecPopeDomView.id}">
                    var searchWeekWorkUrl = "${basePath}/week-work/week-work-time.do";
                    $.post(searchWeekWorkUrl,{indexMainSysTime:indexMainSysTime}, function (result) {
                        if(result.result){
                            var date = result.activityPlans;
                            var Str1 = '';
                            Str1+='<ol style="height:202px;overflow: auto;" id="activity-plan-index-main">';
                            for(var i=0;i<date.length;i++){
                                Str1+='<li class="list-group-item wekWorkLi" data-item="'+date[i].dateId+'">'+
                                    '<a class="span-index-length" /*href="#page/week-work/week-work-list?id=' +
                                    date[i].dateId + '&SubSecPopeDomViewId=51"*/> '+ date[i].count +' </a>'+
                                    '</li>';
                            }
                            Str1+='</ol>';
                            $("#profile4").html(Str1);
                        }
                    });
                </c:if>
                <c:if test="${'50' eq userSecPopeDomView.id}">
                    var searchDutyDailyUrl = "${basePath}/duty-daily/duty-daily-time.do";
                    $.post(searchDutyDailyUrl,{indexMainSysTime:indexMainSysTime}, function (result) {
                        if(result.result){
                            var date = result.activityPlans;
                            var Str2 = '';
                            Str2+='<ol style="height:202px;overflow: auto;" id="activity-plan-index-main">';
                            for(var i=0;i<date.length;i++){
                                Str2+='<li class="list-group-item dutyDailyLi" data-item="'+date[i].dateId+'">'+
                                    '<a class="span-index-length" /*href="#page/duty-daily/duty-daily-list?id=' +
                                    date[i].dateId + '&SubSecPopeDomViewId=50"*/> '+ date[i].count +' </a>'+
                                    '</li>';
                            }
                            Str2+='</ol>';
                            $("#dropdown14").html(Str2);
                        }
                    });
                </c:if>
            </c:forEach>
        }



        /*--------待办事项start--------*/
        //视察考察调研活动
        $('.placeAgencyLi').click(function () {
            var id = $(this).data('item');
            G.pjaxLoadPageContentDiv('#page/place/place-list?SubSecPopeDomViewId=76&id=' + id);
        });

        //值班日报
        $('.dutyDailyIndexLi').click(function () {
            var id = $(this).data('item');
            G.pjaxLoadPageContentDiv('#page/duty-daily/duty-daily-list?id=' + id + '&SubSecPopeDomViewId=50');
        });

        //一周工作情况
        $('.wekWorkChargeLi').click(function () {
            var id = $(this).data('item');
            G.pjaxLoadPageContentDiv('#page/week-work/week-work-list?id=' + id + '&SubSecPopeDomViewId=51');
        });

        //领导活动安排
        $('.dutyDailyChargeLi').click(function () {
            var id = $(this).data('item');
            G.pjaxLoadPageContentDiv('#page/activity-plan/activity-plan-list?id=' + id + '&SubSecPopeDomViewId=53');
        });

        //内行文
        $('.submitBatchLi').click(function () {
            var id = $(this).data('item');
            G.pjaxLoadPageContentDiv('#page/submit-batch/batch-submit-list?id=' + id +'&SubSecPopeDomViewId=79');
        });
        //外行文
        $('.submitBatchOutLi').click(function () {
            var id = $(this).data('item');
            G.pjaxLoadPageContentDiv('#page/submit-batch-out/batch-submit-list?indexId=' + id + '&SubSecPopeDomViewId=79');
        });
        /*--------待办事项end--------*/

        /*--------工作动态start--------*/
        //领导活动安排
        $('.activityLi').click(function () {
            var id = $(this).data('item');
            G.pjaxLoadPageContentDiv('#page/activity-plan/activity-plan-list?id=' + id + '&SubSecPopeDomViewId=53');
        });

        //一周工作情况
        $('.wekWorkLi').click(function () {
            var id = $(this).data('item');
            G.pjaxLoadPageContentDiv('#page/week-work/week-work-list?id=' + id + '&SubSecPopeDomViewId=51');
        });

        //值班日报
        $('.dutyDailyLi').click(function () {
            var id = $(this).data('item');
            G.pjaxLoadPageContentDiv('#page/duty-daily/duty-daily-list?id=' + id + '&SubSecPopeDomViewId=50');
        });
        /*--------工作动态end--------*/

        /*--------视察考察调研活动安排satrt--------*/
        $('.placeLi').click(function () {
            var id = $(this).data('item');
            G.pjaxLoadPageContentDiv('#page/place/place-list?id=' + id + '&SubSecPopeDomViewId=76');
        });
        /*--------视察考察调研活动安排end--------*/

        /*--------公告栏start--------*/
        $('.bulletinBoardLi').click(function () {
            var id = $(this).data('item');
            G.pjaxLoadPageContentDiv('#page/bulletin-board/jump-to-bulletin-board-list?id=' + id + '&SubSecPopeDomViewId=71');
        });
        /*--------公告栏end--------*/

    });
</script>

