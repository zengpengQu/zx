<%--
  Created by IntelliJ IDEA.
  User: yx
  Date: 2018/10/18
  Time: 11:25
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
    @font-face
    {font-family:宋体;
        panose-1:2 1 6 0 3 1 1 1 1 1;}
    @font-face
    {font-family:宋体;
        panose-1:2 1 6 0 3 1 1 1 1 1;}
    @font-face
    {font-family:Calibri;
        panose-1:2 15 5 2 2 2 4 3 2 4;}
    @font-face
    {font-family:等线;
        panose-1:2 1 6 0 3 1 1 1 1 1;}
    @font-face
    {font-family:"\@宋体";
        panose-1:2 1 6 0 3 1 1 1 1 1;}
    @font-face
    {font-family:"\@等线";
        panose-1:2 1 6 0 3 1 1 1 1 1;}
    /* Style Definitions */
    p.MsoNormal, li.MsoNormal, div.MsoNormal
    {margin:0cm;
        margin-bottom:.0001pt;
        text-align:justify;
        text-justify:inter-ideograph;
        font-size:10.5pt;
        font-family:"Calibri","sans-serif";}
    p.MsoHeader, li.MsoHeader, div.MsoHeader
    {mso-style-link:"页眉 Char";
        margin:0cm;
        margin-bottom:.0001pt;
        text-align:center;
        layout-grid-mode:char;
        border:none;
        padding:0cm;
        font-size:9.0pt;
        font-family:"Calibri","sans-serif";}
    p.MsoFooter, li.MsoFooter, div.MsoFooter
    {mso-style-link:"页脚 Char";
        margin:0cm;
        margin-bottom:.0001pt;
        layout-grid-mode:char;
        font-size:9.0pt;
        font-family:"Calibri","sans-serif";}
    span.Char
    {mso-style-name:"页眉 Char";
        mso-style-link:页眉;}
    span.Char0
    {mso-style-name:"页脚 Char";
        mso-style-link:页脚;}
    .MsoChpDefault
    {font-family:"Calibri","sans-serif";}
    /* Page Definitions */
    @page WordSection1
    {size:841.9pt 595.3pt;
        margin:90.0pt 72.0pt 90.0pt 72.0pt;
        layout-grid:15.6pt;}
    div.WordSection1
    {page:WordSection1;}
    -->
</style>

<div class="page" contenteditable="true">

    <div class=WordSection1 style='layout-grid:15.6pt'>

        <p class=MsoNormal align=center style='text-align:center'><b><span lang=EN-US
                                                                           style='font-size:20.0pt'>&nbsp;</span></b></p>

        <p class=MsoNormal align=center style='text-align:center'><b><span lang=EN-US>&nbsp;</span></b></p>

        <p class=MsoNormal align=center style='text-align:center'><b><span
                style='font-size:20.0pt;font-family:宋体'>出国人员名单</span></b></p>

        <p class=MsoNormal align=right style='margin-right:28.0pt;text-align:right;
    word-break:break-all'><span style='font-size:14.0pt;font-family:宋体'>本单位人数：</span><span
                lang=EN-US style='font-size:14.0pt;font-family:"Times New Roman","serif"'>${innerNum}</span><span
                lang=EN-US style='font-size:14.0pt;font-family:宋体'> </span><span
                style='font-size:14.0pt;font-family:宋体'>人</span></p>

        <table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
               style='border-collapse:collapse;border:none'>
            <tr style='height:34.0pt'>
                <td width=102 style='width:76.3pt;border:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
      height:34.0pt'>
                    <p class=MsoNormal align=center style='text-align:center'><span
                            style='font-size:14.0pt;font-family:等线'>姓名</span></p>
                </td>
                <td width=85 style='width:63.8pt;border:solid windowtext 1.0pt;border-left:
      none;padding:0cm 5.4pt 0cm 5.4pt;height:34.0pt'>
                    <p class=MsoNormal align=center style='text-align:center'><span
                            style='font-size:14.0pt;font-family:等线'>性别</span></p>
                </td>
                <td width=170 style='width:127.55pt;border:solid windowtext 1.0pt;border-left:
      none;padding:0cm 5.4pt 0cm 5.4pt;height:34.0pt'>
                    <p class=MsoNormal align=center style='text-align:center'><span
                            style='font-size:14.0pt;font-family:等线'>出生日期</span></p>
                </td>
                <td width=95 style='width:70.9pt;border:solid windowtext 1.0pt;border-left:
      none;padding:0cm 5.4pt 0cm 5.4pt;height:34.0pt'>
                    <p class=MsoNormal align=center style='text-align:center'><span
                            style='font-size:14.0pt;font-family:等线'>出生地</span></p>
                </td>
                <td width=224 style='width:167.65pt;border:solid windowtext 1.0pt;border-left:
      none;padding:0cm 5.4pt 0cm 5.4pt;height:34.0pt'>
                    <p class=MsoNormal align=center style='text-align:center'><span
                            style='font-size:14.0pt;font-family:等线'>工作单位</span></p>
                </td>
                <td width=164 style='width:122.9pt;border:solid windowtext 1.0pt;border-left:
      none;padding:0cm 5.4pt 0cm 5.4pt;height:34.0pt'>
                    <p class=MsoNormal align=center style='text-align:center'><span
                            style='font-size:14.0pt;font-family:等线'>职务（职称）</span></p>
                </td>
                <td width=106 style='width:79.6pt;border:solid windowtext 1.0pt;border-left:
      none;padding:0cm 5.4pt 0cm 5.4pt;height:34.0pt'>
                    <p class=MsoNormal align=center style='text-align:center'><span
                            style='font-size:14.0pt;font-family:等线'>对外身份</span></p>
                </td>
            </tr>

            <c:forEach items="${abroadGroupList}" var="abroadGroup">
                <tr style='height:34.0pt'>
                    <td width=102 style='width:76.3pt;border:solid windowtext 1.0pt;border-top:
                        none;padding:0cm 5.4pt 0cm 5.4pt;height:34.0pt'>
                        <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
                           style='font-family:宋体'>${abroadGroup.name}</span></p>
                    </td>
                    <td width=85 style='width:63.8pt;border-top:none;border-left:none;border-bottom:
                            solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
                            height:34.0pt'>
                        <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
                             style='font-family:宋体'> <c:if test="${abroadGroup.sex eq 0}">男</c:if> <c:if test="${abroadGroup.sex eq 1}">女</c:if> </span></p>
                    </td>
                    <td width=170 style='width:127.55pt;border-top:none;border-left:none;
                          border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
                          padding:0cm 5.4pt 0cm 5.4pt;height:34.0pt'>
                        <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
                           style='font-family:宋体'>${abroadGroup.jsonObject.birthdayStr}</span></p>
                    </td>
                    <td width=95 style='width:70.9pt;border-top:none;border-left:none;border-bottom:
                          solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
                          height:34.0pt'>
                        <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
                           style='font-family:宋体'>${abroadGroup.homeplace}</span></p>
                    </td>
                    <td width=224 style='width:167.65pt;border-top:none;border-left:none;
                          border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
                          padding:0cm 5.4pt 0cm 5.4pt;height:34.0pt'>
                        <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
                           style='font-family:宋体'>${abroadGroup.org}</span></p>
                    </td>
                    <td width=164 style='width:122.9pt;border-top:none;border-left:none;
                          border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
                          padding:0cm 5.4pt 0cm 5.4pt;height:34.0pt'>
                        <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
                                                                                        style='font-family:宋体'>${abroadGroup.duty}</span></p>
                    </td>
                    <td width=106 style='width:79.6pt;border-top:none;border-left:none;
                          border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
                          padding:0cm 5.4pt 0cm 5.4pt;height:34.0pt'>
                        <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
                                                                                        style='font-family:宋体'>${abroadGroup.identity}</span></p>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <p class=MsoNormal align=right style='margin-right:28.0pt;text-align:right'><span
                lang=EN-US style='font-family:宋体'>&nbsp;</span></p>

        <p class=MsoNormal align=right style='margin-right:28.0pt;text-align:right'><span
                lang=EN-US style='font-family:宋体'>&nbsp;</span></p>

        <p class=MsoNormal align=right style='margin-right:28.0pt;text-align:right'><span
                lang=EN-US style='font-size:14.0pt;font-family:"Times New Roman","serif"'>${year}</span><span
                style='font-size:14.0pt;font-family:宋体'>年</span><span lang=EN-US
                style='font-size:14.0pt;font-family:"Times New Roman","serif"'>${month}</span><span
                style='font-size:14.0pt;font-family:宋体'>月</span><span lang=EN-US
                style='font-size:14.0pt;font-family:"Times New Roman","serif"'>${day}</span><span
                style='font-size:14.0pt;font-family:宋体'>日</span></p>

        <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US
                 style='font-size:16.0pt;font-family:宋体'>&nbsp;</span></p>
    </div>
</div>