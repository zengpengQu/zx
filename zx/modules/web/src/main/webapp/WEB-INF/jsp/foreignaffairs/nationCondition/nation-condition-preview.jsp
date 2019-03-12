<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    pageContext.setAttribute("basePath", basePath);
%>
<title>履职支撑平台</title>

<div class="page" contenteditable="true">
    <div align="center">
        <font style="font-size: 16pt;font-family:仿宋, Arial, Helvetica, sans-serif; ">
            <span style="letter-spacing:3px">国家情况详细信息（${nation.jsonObject.nationName}）</span>
        </font>
    </div>
    <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
    <div align="justify">
        <font style="font-size: 16pt;font-family:仿宋, Arial, Helvetica, sans-serif;">
            <span>所属地区：${nation.belongArea}</span>
        </font>
        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
        <font style="font-size: 16pt;font-family: 仿宋, Arial, Helvetica, sans-serif;">
            <span style="letter-spacing:1px;float: right !important;margin-right: 0px">${year}年${month}月${day}日</span>
        </font>
    </div>
    <hr style="height: 1px;border: none; color: black; width: 100%;margin-top: 10px;margin-bottom: 10px"/>

    <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
    <div>
        <div align="center">
            <font style="font-size: 18pt;font-family:黑体, Arial, Helvetica, sans-serif; ">
                <span>※&nbsp;国家情况概况&nbsp;※</span>
            </font>
        </div>
        <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
        <div>
            &nbsp;&nbsp;
            <font style="font-size: 10pt;font-family:黑体, Arial, Helvetica, sans-serif; ">
                <span>&nbsp;一带一路国家：&nbsp;${nation.jsonObject.isOborNationVal}</span>
            </font>
            &nbsp;&nbsp;&nbsp;
            <font style="font-size: 10pt;font-family:黑体, Arial, Helvetica, sans-serif; ">
                <span>&nbsp;阿拉伯国家：&nbsp;${nation.jsonObject.isArabNationVal}</span>
            </font>
            &nbsp;&nbsp;&nbsp;
            <font style="font-size: 10pt;font-family:黑体, Arial, Helvetica, sans-serif; ">
                <span>&nbsp;周边国家：&nbsp;${nation.jsonObject.isAroundNationVal}</span>
            </font>
        </div>
        <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
        <div>
            &nbsp;&nbsp;
            <font style="font-size: 10pt;font-family:黑体, Arial, Helvetica, sans-serif; ">
                <span>&nbsp;西方发达国家：&nbsp;${nation.jsonObject.isWestNationVal}</span>
            </font>
            &nbsp;&nbsp;&nbsp;
            <font style="font-size: 10pt;font-family:黑体, Arial, Helvetica, sans-serif; ">
                <span>&nbsp;其他国家：&nbsp;${nation.jsonObject.isOtherNationVal}</span>
            </font>
        </div>
        <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
        <div align="center">
            <font style="font-size: 14pt;font-family:黑体, Arial, Helvetica, sans-serif; ">
                <span>&nbsp;风俗礼仪禁忌&nbsp;</span>
            </font>
        </div>
        <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
        <div class="param" style="font-size: 16pt;font-family:仿宋, Arial, Helvetica, sans-serif; ">
            &nbsp;&nbsp;${nation.moresProtocolTaboo}
        </div>
        <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
        <div align="center">
            <font style="font-size: 14pt;font-family:黑体, Arial, Helvetica, sans-serif; ">
                <span>&nbsp;入境注意事项&nbsp;</span>
            </font>
        </div>
        <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
        <div class="param" style="font-size: 16pt;font-family:仿宋, Arial, Helvetica, sans-serif; ">
            &nbsp;&nbsp;${nation.ehtryNotices}
        </div>
        <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
        <div align="center">
            <font style="font-size: 14pt;font-family:黑体, Arial, Helvetica, sans-serif; ">
                <span>&nbsp;国家简介&nbsp;</span>
            </font>
        </div>
        <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
        <div class="param" style="font-size: 16pt;font-family:仿宋, Arial, Helvetica, sans-serif; ">
            ${nation.nationIntro}
        </div>
    </div>

    <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
    <div>
        <div align="center">
            <font style="font-size: 18pt;font-family:黑体, Arial, Helvetica, sans-serif; ">
                <span>※&nbsp;主要人物简介&nbsp;※</span>
            </font>
        </div>
        <c:forEach items="${vipPersonIntroList}" var="vipPersonIntro">
            <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
            <div align="center">
                <font style="font-size: 14pt;font-family:黑体, Arial, Helvetica, sans-serif; ">
                    <span>&nbsp;${vipPersonIntro.chineseName}（${vipPersonIntro.foreignName}）&nbsp;</span>
                </font>
            </div>
            <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
            <div class="param" style="font-size: 16pt;font-family:仿宋, Arial, Helvetica, sans-serif; ">
                    ${vipPersonIntro.personIntro}
            </div>
        </c:forEach>
    </div>

    <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
    <div>
        <div align="center">
            <font style="font-size: 18pt;font-family:黑体, Arial, Helvetica, sans-serif; ">
                <span>※&nbsp;重要议会简介&nbsp;※</span>
            </font>
        </div>
        <c:forEach items="${parliamentIntroList}" var="parliamentIntro">
            <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
            <div align="center">
                <font style="font-size: 14pt;font-family:黑体, Arial, Helvetica, sans-serif; ">
                    <span>&nbsp;${parliamentIntro.parliamentName}&nbsp;</span>
                </font>
            </div>
            <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
            <div class="param" style="font-size: 16pt;font-family:仿宋, Arial, Helvetica, sans-serif; ">
                    ${parliamentIntro.parliamentIntro}
            </div>
        </c:forEach>
    </div>

    <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
    <div>
        <div align="center">
            <font style="font-size: 18pt;font-family:黑体, Arial, Helvetica, sans-serif; ">
                <span>※&nbsp;交往情况&nbsp;※</span>
            </font>
        </div>
        <c:forEach items="${contactConditionList}" var="contactCondition">
            <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
            <div align="center">
                <font style="font-size: 14pt;font-family:黑体, Arial, Helvetica, sans-serif; ">
                    <span>&nbsp;${contactCondition.jsonObject.contactTypeVal}-${contactCondition.jsonObject.contactDate}&nbsp;</span>
                </font>
            </div>
            <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
            <div class="param" style="font-size: 16pt;font-family:仿宋, Arial, Helvetica, sans-serif; ">
                    ${contactCondition.contactCondition}
            </div>
        </c:forEach>
    </div>

    <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
    <div>
        <div align="center">
            <font style="font-size: 18pt;font-family:黑体, Arial, Helvetica, sans-serif; ">
                <span>※&nbsp;城市/景点简介&nbsp;※</span>
            </font>
        </div>
        <c:forEach items="${citySceneryIntroList}" var="citySceneryIntro">
            <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
            <div align="center">
                <font style="font-size: 14pt;font-family:黑体, Arial, Helvetica, sans-serif; ">
                    <span>&nbsp;${citySceneryIntro.citySceneryName}&nbsp;</span>
                </font>
            </div>
            <div style="max-height: 1px;min-height: 1px;overflow: hidden;margin: 10px 0 9px">&nbsp;</div>
            <div class="param" style="font-size: 16pt;font-family:仿宋, Arial, Helvetica, sans-serif; ">
                    ${citySceneryIntro.citySceneryIntro}
            </div>
        </c:forEach>
    </div>

</div>
