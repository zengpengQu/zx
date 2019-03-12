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
        font-family: 宋体;
        panose-1: 2 1 6 0 3 1 1 1 1 1;
    }

    @font-face {
        font-family: "\@宋体";
        panose-1: 2 1 6 0 3 1 1 1 1 1;
    }

    @font-face {
        font-family: 仿宋;
        panose-1: 2 1 6 9 6 1 1 1 1 1;
    }

    @font-face {
        font-family: "\@仿宋";
        panose-1: 2 1 6 9 6 1 1 1 1 1;
    }

    @font-face {
        font-family: 华文楷体;
        panose-1: 2 1 6 0 4 1 1 1 1 1;
    }

    @font-face {
        font-family: "\@华文楷体";
        panose-1: 2 1 6 0 4 1 1 1 1 1;
    }

    @font-face {
        font-family: 华文中宋;
        panose-1: 2 1 6 0 4 1 1 1 1 1;
    }

    @font-face {
        font-family: "\@华文中宋";
        panose-1: 2 1 6 0 4 1 1 1 1 1;
    }

    /* Style Definitions */
    p.MsoNormal, li.MsoNormal, div.MsoNormal {
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 10.5pt;
        font-family: "Calibri", "sans-serif";
    }

    .MsoChpDefault {
        font-family: "Calibri", "sans-serif";
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

<div lang=ZH-CN style='text-justify-trim:punctuation' class="page">

<div class=WordSection1 style='layout-grid:15.6pt'>

    <p class=MsoNormal align=center style='text-align:center'><b><span
            style='font-size:28.0pt;font-family:华文中宋'>督 查 事 项 反 馈 单</span></b></p>

    <p class=MsoNormal align=center style='text-align:center'><b><span lang=EN-US
                   style='font-family:华文中宋'>&nbsp;</span></b></p>

    <p class=MsoNormal align=left style='text-align:left;text-indent:14.0pt'><span
            style='font-size:14.0pt;font-family:华文楷体'>承办单位：<span lang=EN-US>${supervisionFeedBack.jsonObject.deptName}&nbsp;&nbsp;&nbsp;&nbsp;
</span>审批人：${supervisionFeedBack.jsonObject.createName}</span></p>

    <table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
           style='border-collapse:collapse;border:none'>
        <tr style='height:40.0pt'>
            <td width=186 style='width:111.75pt;border:solid windowtext 1.0pt;border-left:
  solid windowtext 1.5pt;padding:0cm 5.4pt 0cm 5.4pt;height:40.0pt'>
                <p class=MsoNormal align=center style='text-align:center'><b><span
                        style='font-size:16.0pt;font-family:仿宋'>督查事项编号</span></b></p>
            </td>
            <td width=59 style='width:35.4pt;border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:40.0pt'>
                <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
                    style='font-size:14.0pt;font-family:仿宋'>${supervisionMatter.jsonObject.serialNumber}</span></p>
            </td>
            <td width=130 style='width:78.0pt;border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:40.0pt'>
                <p class=MsoNormal align=center style='text-align:center'><b><span
                        style='font-size:16.0pt;font-family:仿宋'>是否办结</span></b></p>
            </td>
            <td width=59 style='width:35.4pt;border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:40.0pt'>
                <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
                    style='font-size:14.0pt;font-family:仿宋'>${supervisionFeedBack.jsonObject.isTransfer}</span></p>
            </td>
            <td width=130 style='width:78.0pt;border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:40.0pt'>
                <p class=MsoNormal align=center style='text-align:center'><b><span
                        style='font-size:16.0pt;font-family:仿宋'>反馈日期</span></b></p>
            </td>
            <td width=146 style='width:87.55pt;border-top:solid windowtext 1.0pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:40.0pt'>
                <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
                    style='font-size:14.0pt;font-family:仿宋'>${feedBackDate}</span></p>
            </td>
        </tr>
        <tr style='height:489.05pt'>
            <td width=710 colspan=6 valign=top style='width:426.1pt;border:solid windowtext 1.5pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:489.05pt'>
                <p class=MsoNormal align=left style='text-align:left'><b><span
                        style='font-size:18.0pt;font-family:仿宋'>办理情况概要：</span></b><span
                        style='font-size:18.0pt;font-family:仿宋'>（可附页）</span></p>
                <p class=MsoNormal align=left style='text-align:left;text-indent:31.5pt;
                    mso-char-indent-count:3.0'>${supervisionMatter.jsonObject.supMatter}</p>
            </td>
        </tr>
    </table>

    <p class=MsoNormal align=left style='text-align:left'><b><span
            style='font-size:14.0pt;font-family:仿宋'>注：</span></b><span style='font-size:
14.0pt;font-family:仿宋'>此表请打印填写，原件经室局负责同志签字后交秘书局督查室，电子版发至督查室内网邮箱。</span></p>

</div>

</>