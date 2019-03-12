<%--
  Created by IntelliJ IDEA.
  User: yx
  Date: 2018/12/29
  Time: 13:34
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
    {font-family:华文中宋;
        panose-1:2 1 6 0 4 1 1 1 1 1;}
    @font-face
    {font-family:仿宋;
        panose-1:2 1 6 9 6 1 1 1 1 1;}
    @font-face
    {font-family:"\@华文中宋";
        panose-1:2 1 6 0 4 1 1 1 1 1;}
    @font-face
    {font-family:"\@仿宋";
        panose-1:2 1 6 9 6 1 1 1 1 1;}
    @font-face
    {font-family:"\@宋体";
        panose-1:2 1 6 0 3 1 1 1 1 1;}
    /* Style Definitions */
    p.MsoNormal, li.MsoNormal, div.MsoNormal
    {margin:0cm;
        margin-bottom:.0001pt;
        text-align:justify;
        text-justify:inter-ideograph;
        font-size:10.5pt;
        font-family:"Calibri","sans-serif";}
    p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
    {margin:0cm;
        margin-bottom:.0001pt;
        text-align:justify;
        text-justify:inter-ideograph;
        text-indent:21.0pt;
        font-size:10.5pt;
        font-family:"Calibri","sans-serif";}
    .MsoChpDefault
    {font-family:"Calibri","sans-serif";}
    /* Page Definitions */
    @page WordSection1
    {size:595.3pt 841.9pt;
        margin:72.0pt 90.0pt 72.0pt 90.0pt;
        layout-grid:15.6pt;}
    div.WordSection1
    {page:WordSection1;}
    -->
</style>

<div lang=ZH-CN style='text-justify-trim:punctuation' class="page">

<div class=WordSection1 style='layout-grid:15.6pt'>

    <p class=MsoNormal align=center style='text-align:center'><b><span
            style='font-size:26.0pt;font-family:华文中宋'>督 查 事 项 交 办 单</span></b></p>

    <table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
           style='border-collapse:collapse;border:none'>
        <tr style='height:40.0pt'>
            <td width=139 style='width:83.4pt;border:solid windowtext 1.5pt;border-bottom:
  solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;height:40.0pt'>
                <p class=MsoNormal align=center style='text-align:center'><b><span
                        style='font-size:18.0pt;font-family:仿宋'>督查事项</span></b></p>
            </td>
            <td width=571 colspan=3 style='width:342.7pt;border-top:solid windowtext 1.5pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:40.0pt'>
                <p class=MsoNormal><span lang=ZH-CN>${supMatter}</span></p>
            </td>
        </tr>
        <tr style='height:40.0pt'>
            <td width=139 style='width:83.4pt;border:solid windowtext 1.5pt;border-top:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:40.0pt'>
                <p class=MsoNormal align=center style='text-align:center'><b><span
                        style='font-size:18.0pt;font-family:仿宋'>主办单位</span></b></p>
            </td>
            <td width=224 style='width:134.65pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.5pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:40.0pt'>
                <p class=MsoNormal><span lang=ZH-CN>${hostDeptName}</span></p>
            </td>
            <td width=142 style='width:3.0cm;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.5pt;border-right:solid windowtext 1.5pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:40.0pt'>
                <p class=MsoNormal><b><span style='font-size:18.0pt;font-family:仿宋'>协办单位</span></b></p>
            </td>
            <td width=205 style='width:123.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.5pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:40.0pt'>
                <p class=MsoNormal><span lang=ZH-CN>${deptName}</span></p>
            </td>
        </tr>
        <tr style='height:203.35pt'>
            <td width=710 colspan=4 valign=top style='width:426.1pt;border:solid windowtext 1.5pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:203.35pt'>
                <p class=MsoNormal align=left style='text-align:left'><b><span
                        style='font-size:18.0pt;font-family:仿宋'>领导批示：</span></b></p>
            </td>
        </tr>
        <tr style='height:141.0pt'>
            <td width=710 colspan=4 valign=top style='width:426.1pt;border:solid windowtext 1.5pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:141.0pt'>
                <p class=MsoNormal align=left style='text-align:left'><b><span
                        style='font-size:18.0pt;font-family:仿宋'>局领导意见：</span></b></p>
            </td>
        </tr>
        <tr style='height:127.2pt'>
            <td width=710 colspan=4 valign=top style='width:426.1pt;border:solid windowtext 1.5pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:127.2pt'>
                <p class=MsoNormal align=left style='text-align:left'><b><span
                        style='font-size:18.0pt;font-family:仿宋'>办理要求：</span></b></p>
                <p class=MsoNormal align=left style='text-align:left;text-indent:36.6pt'><span
                        lang=EN-US style='font-size:16.0pt;font-family:仿宋'>${requirements}</span></p>
                <p class=MsoNormal align=left style='text-align:left;text-indent:36.6pt'><span
                        lang=EN-US style='font-size:16.0pt;font-family:仿宋'>2. ...</span></p>
                <p class=MsoNormal align=left style='text-align:left;text-indent:36.6pt'><span
                        lang=EN-US style='font-size:16.0pt;font-family:仿宋'>3. </span><span
                        style='font-size:16.0pt;font-family:仿宋'>请从机关内网“通知公告”栏下载并填写《督查事项反馈单》，按要求回复。</span></p>
            </td>
        </tr>
    </table>

    <p class=MsoNormal align=left style='text-align:left;text-indent:28.8pt'><span
            style='font-size:16.0pt;font-family:仿宋'>督查事项编号：<span lang=EN-US>${serialNumber}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>秘书局督查室</span></p>

    <p class=MsoNormal align=left style='text-align:left;text-indent:260pt'><span
            lang=EN-US style='text-align: right; font-size:16.0pt;font-family:仿宋'>2018</span><span
            style='font-size:16.0pt;font-family:仿宋'>年<span lang=EN-US>12</span>月<span
            lang=EN-US>29</span>日发</span></p>

</div>

</div>
