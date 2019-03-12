<%--
  Created by IntelliJ IDEA.
  User: BT4900
  Date: 2018/8/27
  Time: 17:27
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    pageContext.setAttribute("basePath", basePath);
%>
<title>履职支撑平台</title>

<style>
    <!--
    /* Font Definitions */
    @font-face {
        font-family: 宋体;
        panose-1: 2 1 6 0 3 1 1 1 1 1;
    }

    @font-face {
        font-family: "Cambria Math";
        panose-1: 2 4 5 3 5 4 6 3 2 4;
    }

    @font-face {
        font-family: 等线;
        panose-1: 2 1 6 0 3 1 1 1 1 1;
    }

    @font-face {
        font-family: 楷体;
        panose-1: 2 1 6 9 6 1 1 1 1 1;
    }

    @font-face {
        font-family: "\@宋体";
        panose-1: 2 1 6 0 3 1 1 1 1 1;
    }

    @font-face {
        font-family: "\@楷体";
    }

    @font-face {
        font-family: "\@等线";
        panose-1: 2 1 6 0 3 1 1 1 1 1;
    }

    /* Style Definitions */
    p.MsoNormal, li.MsoNormal, div.MsoNormal {
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 10.5pt;
        font-family: 等线;
    }

    p.MsoHeader, li.MsoHeader, div.MsoHeader {
        mso-style-link: "页眉 字符";
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: center;
        layout-grid-mode: char;
        border: none;
        padding: 0cm;
        font-size: 9.0pt;
        font-family: 等线;
    }

    p.MsoFooter, li.MsoFooter, div.MsoFooter {
        mso-style-link: "页脚 字符";
        margin: 0cm;
        margin-bottom: .0001pt;
        layout-grid-mode: char;
        font-size: 9.0pt;
        font-family: 等线;
    }

    p.MsoDate, li.MsoDate, div.MsoDate {
        mso-style-link: "日期 字符";
        margin-top: 0cm;
        margin-right: 0cm;
        margin-bottom: 0cm;
        margin-left: 5.0pt;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 10.5pt;
        font-family: 等线;
    }

    span.a {
        mso-style-name: "页眉 字符";
        mso-style-link: 页眉;
    }

    span.a0 {
        mso-style-name: "页脚 字符";
        mso-style-link: 页脚;
    }

    span.a1 {
        mso-style-name: "日期 字符";
        mso-style-link: 日期;
    }

    .MsoChpDefault {
        font-family: 等线;
    }

    /* Page Definitions */
    @page WordSection1 {
        size: 595.3pt 841.9pt;
        margin: 72.0pt 90.0pt 72.0pt 90.0pt;
        layout-grid: 15.6pt;
    }

    div.WordSection1 {
        page: WordSection1;
    }

    -->
</style>

<div class="page" contenteditable="true">

    <div class=WordSection1 style='layout-grid:15.6pt'>

        <p class=MsoNormal align=center style='text-align:center'><b><span
                style='font-size:22.0pt;font-family:宋体'>秘书长碰头会通知</span></b></p>

        <p class=MsoNormal align=center style='text-align:center'><b><span lang=EN-US
                                                                           style='font-size:22.0pt;font-family:宋体'>&nbsp;</span></b>
        </p>

        <p class=MsoNormal style='text-indent:21.0pt'><span style='font-size:16.0pt;
font-family:楷体'>${planReceipt.activityPlan.content}</span></p>

        <p class=MsoNormal style='text-indent:21.0pt'><span lang=EN-US
                                                            style='font-size:16.0pt;font-family:楷体'>&nbsp;</span>
        </p>

        <p class=MsoNormal style='text-indent:21.0pt'><span lang=EN-US
                                                            style='font-size:16.0pt;font-family:楷体'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
                style='font-size:16.0pt;font-family:楷体'>秘书局总值班室</span></p>

        <p class=MsoNormal style='text-indent:21.0pt'><span lang=EN-US
                                                            style='font-size:16.0pt;font-family:楷体'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
                lang=EN-US style='font-size:16.0pt;font-family:"Times New Roman",serif'>${year}</span><span
                style='font-size:16.0pt;font-family:楷体'>年</span><span lang=EN-US
                                                                      style='font-size:16.0pt;font-family:"Times New Roman",serif'>${month}</span><span
                style='font-size:16.0pt;font-family:楷体'>月</span><span lang=EN-US
                                                                      style='font-size:16.0pt;font-family:"Times New Roman",serif'>${day}</span><span
                style='font-size:16.0pt;font-family:楷体'>日</span></p>

        <div style='border:none;border-bottom:solid windowtext 1.0pt;padding:0cm 0cm 1.0pt 0cm'>

            <p class=MsoNormal style='border:none;padding:0cm'><span lang=EN-US
                                                                     style='font-size:16.0pt;font-family:楷体'>&nbsp;</span>
            </p>

        </div>

        <p class=MsoNormal><span lang=EN-US style='font-size:16.0pt;font-family:楷体'>&nbsp;</span></p>

        <p class=MsoNormal align=center style='text-align:center'><b><span
                style='font-size:22.0pt;font-family:宋体'>会议回执</span></b></p>

        <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
                                                                        style='font-size:16.0pt;font-family:楷体'>&nbsp;</span>
        </p>

        <div align=center>

            <table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
                   style='border-collapse:collapse;border:none'>
                <tr style='height:24.05pt'>
                    <td width=113 style='width:84.8pt;border:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:24.05pt'>
                        <p class=MsoNormal align=center style='text-align:center'><b><span
                                style='font-family:宋体'>与会领导</span></b></p>
                    </td>
                    <td width=440 colspan=2 style='width:330.0pt;border:solid windowtext 1.0pt;
  border-left:none;padding:0cm 5.4pt 0cm 5.4pt;height:24.05pt'>
                        <p class=MsoNormal style='text-align:justify;text-justify:distribute-all-lines'><span
                                lang=EN-US style='font-family:宋体'>${planReceipt.leaderName}</span></p>
                    </td>
                </tr>
                <tr style='height:24.05pt'>
                    <td width=113 rowspan=2 style='width:84.8pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:24.05pt'>
                        <p class=MsoNormal align=center style='text-align:center'><b><span
                                style='font-family:宋体'>参会情况</span></b></p>
                    </td>
                    <td width=440 colspan=2 style='width:330.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:24.05pt'>
                        <p class=MsoNormal align=left style='text-align:left'><span style='font-family:
  宋体'>参 会：<c:if test="${planReceipt.isAttend eq '0'}">
                            &nbsp;√&nbsp;
                        </c:if></span></p>
                    </td>
                </tr>
                <tr style='height:52.5pt'>
                    <td width=123 style='width:92.15pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:52.5pt'>
                        <p class=MsoNormal align=left style='text-align:left'><span style='font-family:
  宋体'>不参会：<c:if test="${planReceipt.isAttend eq '1'}">
                            &nbsp;√&nbsp;
                        </c:if></span></p>
                    </td>
                    <td width=317 style='width:237.85pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:52.5pt'>
                        <p class=MsoNormal align=left style='text-align:left'><span style='font-family:
  宋体'>请假原因：${planReceipt.reason}</span></p>
                    </td>
                </tr>
                <tr style='height:141.1pt'>
                    <td width=553 colspan=3 valign=top style='width:414.8pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:141.1pt'>
                        <p class=MsoNormal align=left style='text-align:left'><span style='font-family:
  宋体'>下周工作安排：（${planReceipt.jsonObject.startDateStr}至${planReceipt.jsonObject.endDateStr}）</span><br/>
                            ${planReceipt.workPlan}
                        </p>
                    </td>
                </tr>
            </table>

        </div>
        <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>
    </div>
</div>

