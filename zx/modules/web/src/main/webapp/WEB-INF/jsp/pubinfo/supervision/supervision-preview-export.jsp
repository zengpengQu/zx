<%--
  Created by IntelliJ IDEA.
  User: pengyx
  Date: 2018/6/14
  Time: 17:11
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
    @font-face
    {font-family:宋体;
        panose-1:2 1 6 0 3 1 1 1 1 1;
        mso-font-alt:SimSun;
        mso-font-charset:134;
        mso-generic-font-family:auto;
        mso-font-pitch:variable;
        mso-font-signature:3 680460288 22 0 262145 0;}
    @font-face
    {font-family:"Cambria Math";
        panose-1:2 4 5 3 5 4 6 3 2 4;
        mso-font-charset:0;
        mso-generic-font-family:roman;
        mso-font-pitch:variable;
        mso-font-signature:3 0 0 0 1 0;}
    @font-face
    {font-family:等线;
        panose-1:2 1 6 0 3 1 1 1 1 1;
        mso-font-alt:DengXian;
        mso-font-charset:134;
        mso-generic-font-family:auto;
        mso-font-pitch:variable;
        mso-font-signature:-1610612033 953122042 22 0 262159 0;}
    @font-face
    {font-family:"\@等线";
        panose-1:2 1 6 0 3 1 1 1 1 1;
        mso-font-charset:134;
        mso-generic-font-family:auto;
        mso-font-pitch:variable;
        mso-font-signature:-1610612033 953122042 22 0 262159 0;}
    @font-face
    {font-family:"\@宋体";
        panose-1:2 1 6 0 3 1 1 1 1 1;
        mso-font-charset:134;
        mso-generic-font-family:auto;
        mso-font-pitch:variable;
        mso-font-signature:3 680460288 22 0 262145 0;}
    p.MsoNormal, li.MsoNormal, div.MsoNormal
    {mso-style-unhide:no;
        mso-style-qformat:yes;
        mso-style-parent:"";
        margin:0cm;
        margin-bottom:.0001pt;
        text-align:justify;
        text-justify:inter-ideograph;
        mso-pagination:none;
        font-size:10.5pt;
        mso-bidi-font-size:11.0pt;
        font-family:等线;
        mso-ascii-font-family:等线;
        mso-ascii-theme-font:minor-latin;
        mso-fareast-font-family:等线;
        mso-fareast-theme-font:minor-fareast;
        mso-hansi-font-family:等线;
        mso-hansi-theme-font:minor-latin;
        mso-bidi-font-family:"Times New Roman";
        mso-bidi-theme-font:minor-bidi;
        mso-font-kerning:1.0pt;}
    h1
    {mso-style-priority:9;
        mso-style-unhide:no;
        mso-style-qformat:yes;
        mso-style-link:"标题 1 字符";
        mso-style-next:正文;
        margin-top:17.0pt;
        margin-right:0cm;
        margin-bottom:16.5pt;
        margin-left:0cm;
        text-align:justify;
        text-justify:inter-ideograph;
        line-height:240%;
        mso-pagination:lines-together;
        page-break-after:avoid;
        mso-outline-level:1;
        font-size:22.0pt;
        font-family:等线;
        mso-ascii-font-family:等线;
        mso-ascii-theme-font:minor-latin;
        mso-fareast-font-family:等线;
        mso-fareast-theme-font:minor-fareast;
        mso-hansi-font-family:等线;
        mso-hansi-theme-font:minor-latin;
        mso-bidi-font-family:宋体;
        mso-font-kerning:22.0pt;}
    p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
    {mso-style-priority:34;
        mso-style-unhide:no;
        mso-style-qformat:yes;
        margin:0cm;
        margin-bottom:.0001pt;
        text-align:justify;
        text-justify:inter-ideograph;
        text-indent:21.0pt;
        mso-char-indent-count:2.0;
        mso-pagination:none;
        font-size:10.5pt;
        mso-bidi-font-size:11.0pt;
        font-family:等线;
        mso-ascii-font-family:等线;
        mso-ascii-theme-font:minor-latin;
        mso-fareast-font-family:等线;
        mso-fareast-theme-font:minor-fareast;
        mso-hansi-font-family:等线;
        mso-hansi-theme-font:minor-latin;
        mso-bidi-font-family:"Times New Roman";
        mso-bidi-theme-font:minor-bidi;
        mso-font-kerning:1.0pt;}
    p.msonormal0, li.msonormal0, div.msonormal0
    {mso-style-name:msonormal;
        mso-style-unhide:no;
        mso-margin-top-alt:auto;
        margin-right:0cm;
        mso-margin-bottom-alt:auto;
        margin-left:0cm;
        mso-pagination:widow-orphan;
        font-size:12.0pt;
        font-family:宋体;
        mso-bidi-font-family:宋体;}
    span.1
    {mso-style-name:"标题 1 字符";
        mso-style-priority:9;
        mso-style-unhide:no;
        mso-style-locked:yes;
        mso-style-link:"标题 1";
        mso-ansi-font-size:22.0pt;
        mso-bidi-font-size:22.0pt;
        mso-font-kerning:22.0pt;
        font-weight:bold;}
    span.GramE
    {mso-style-name:"";
        mso-gram-e:yes;}
    .MsoChpDefault
    {mso-style-type:export-only;
        mso-default-props:yes;
        font-size:10.0pt;
        mso-ansi-font-size:10.0pt;
        mso-bidi-font-size:10.0pt;
        mso-ascii-font-family:"Times New Roman";
        mso-hansi-font-family:"Times New Roman";
        mso-font-kerning:0pt;}
    @page
    {mso-page-border-surround-header:no;
        mso-page-border-surround-footer:no;}
    @page WordSection1
    {size:595.3pt 841.9pt;
        margin:72.0pt 90.0pt 72.0pt 90.0pt;
        mso-header-margin:42.55pt;
        mso-footer-margin:49.6pt;
        mso-paper-source:0;
        layout-grid:15.6pt;}
    div.WordSection1
    {page:WordSection1;}
</style>
<style>
    table.MsoNormalTable
    {mso-style-name:普通表格;
        mso-tstyle-rowband-size:0;
        mso-tstyle-colband-size:0;
        mso-style-noshow:yes;
        mso-style-priority:99;
        mso-style-parent:"";
        mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
        mso-para-margin:0cm;
        mso-para-margin-bottom:.0001pt;
        mso-pagination:widow-orphan;
        font-size:10.0pt;
        font-family:"Times New Roman",serif;}
    table.MsoTableGrid
    {mso-style-name:网格型;
        mso-tstyle-rowband-size:0;
        mso-tstyle-colband-size:0;
        mso-style-priority:39;
        mso-style-unhide:no;
        border:solid windowtext 1.0pt;
        mso-border-alt:solid windowtext .5pt;
        mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
        mso-border-insideh:.5pt solid windowtext;
        mso-border-insidev:.5pt solid windowtext;
        mso-para-margin:0cm;
        mso-para-margin-bottom:.0001pt;
        mso-pagination:widow-orphan;
        font-size:10.5pt;
        mso-bidi-font-size:11.0pt;
        font-family:等线;
        mso-ascii-font-family:等线;
        mso-ascii-theme-font:minor-latin;
        mso-fareast-font-family:等线;
        mso-fareast-theme-font:minor-fareast;
        mso-hansi-font-family:等线;
        mso-hansi-theme-font:minor-latin;
        mso-font-kerning:1.0pt;}
</style>

<div bgcolor="#FFFFCC" lang=ZH-CN style='text-justify-trim:punctuation' class="page">
    <div class=WordSection1 style='layout-grid:15.6pt'>

        <p class=MsoNormal align=center style='text-align:center'>
            <b style='mso-bidi-font-weight:normal'>
                <span style='font-size:36.0pt;mso-bidi-font-size:11.0pt'>督查事项反馈单</span>
            </b>
        </p>

        <p class=MsoNormal align=left style='text-align:left'>
            <b style='mso-bidi-font-weight:normal'>
                <span style='font-size:16.0pt;mso-bidi-font-size:11.0pt'>承办单位：</span>
            </b>
            <span style='font-size:12.0pt;mso-bidi-font-size:11.0pt'>${supervisionFeedBack.jsonObject.deptName}
                <span lang=EN-US>
                    <span style='mso-spacerun:yes'>   </span></span></span>
            <b style='mso-bidi-font-weight:normal'>
                <span lang=EN-US style='font-size:16.0pt;mso-bidi-font-size:11.0pt'>
                    <span style='mso-spacerun:yes'>                    </span></span>
            </b>
            <b style='mso-bidi-font-weight:normal'>
                <span style='font-size:16.0pt;mso-bidi-font-size:11.0pt'>审批人：</span>
            </b>
            <span style='font-size:12.0pt;mso-bidi-font-size:11.0pt'>${supervisionFeedBack.jsonObject.createName}
                <span lang=EN-US></span>
            </span>
        </p>

        <table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 width=557
               style='width:417.95pt;border-collapse:collapse;border:none;
           mso-border-alt:solid windowtext .5pt;mso-yfti-tbllook:1184;mso-padding-alt:0cm 5.4pt 0cm 5.4pt'>
            <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
                <td width=113 valign=top style='width:84.8pt;border:solid windowtext 1.0pt;
                    mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
                    <p class=MsoNormal align=center style='text-align:center'>
                        <b style='mso-bidi-font-weight:normal'>
                            <span style='font-size:12.0pt;mso-bidi-font-size:11.0pt'>督查事项编号</span>
                            <span lang=EN-US></span>
                        </b>
                    </p>
                </td>
                <td width=71 valign=top style='width:53.4pt;border:solid windowtext 1.0pt;
                    border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
                    solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
                    <p class=MsoNormal align=center style='text-align:center'>
                        <span style='font-size:12.0pt;mso-bidi-font-size:11.0pt'>${supervisionMatter.jsonObject.serialNumber}</span>
                    </p>
                </td>
                <td width=80 valign=top style='width:60.0pt;border:solid windowtext 1.0pt;
                    border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
                    solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
                    <p class=MsoNormal align=left style='text-align:left'>
                        <b style='mso-bidi-font-weight:normal'>
                            <span style='font-size:12.0pt;mso-bidi-font-size:11.0pt'>是否办结</span>
                            <span lang=EN-US></span></b></p>
                </td>
                <td width=47 valign=top style='width:35.45pt;border:solid windowtext 1.0pt;
                    border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
                    solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
                    <p class=MsoNormal align=center style='text-align:center'>
                        <span style='font-size:12.0pt;mso-bidi-font-size:11.0pt'>${supervisionFeedBack.jsonObject.isTransfer}</span>
                    </p>
                </td>
                <td width=85 valign=top style='width:63.8pt;border:solid windowtext 1.0pt;
                    border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
                    solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
                    <p class=MsoNormal align=left style='text-align:left'>
                        <b style='mso-bidi-font-weight:normal'>
                            <span style='font-size:12.0pt;mso-bidi-font-size:11.0pt'>反馈日期</span>
                            <span lang=EN-US></span>
                        </b>
                    </p>
                </td>
                <td width=161 valign=top style='width:120.5pt;border:solid windowtext 1.0pt;
                    border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
                    solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
                    <p class=MsoNormal align=center style='text-align:center'>
                        <span lang=EN-US style='font-size:12.0pt;mso-bidi-font-size:11.0pt'>${feedBackDate}</span>
                        <span lang=EN-US></span>
                    </span>
                    </p>
                </td>
            </tr>
            <tr style='mso-yfti-irow:1;mso-yfti-lastrow:yes;height:483.9pt'>
                <td width=557 colspan=6 valign=top style='width:417.95pt;border:solid windowtext 1.0pt;
                    border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
                    padding:0cm 5.4pt 0cm 5.4pt;height:483.9pt'>
                    <p class=MsoNormal align=left style='text-align:left'>
                        <b style='mso-bidi-font-weight:normal'>
                        <span style='font-size:16.0pt;mso-bidi-font-size:11.0pt'>办理情况概要
                            <span lang=EN-US>:</span></span>
                        </b>
                    </p>
                    <p class=MsoNormal align=left style='text-align:left;text-indent:31.5pt;
                    mso-char-indent-count:3.0'>${supervisionMatter.jsonObject.supMatter}</p>
                </td>
            </tr>
        </table>

        <p class=MsoNormal align=left style='text-align:left'>
        <span style='font-size:14.0pt;mso-bidi-font-size:11.0pt'>注：此
            <span class=GramE>此</span>表请打印填写，原件
            <span class=GramE>经室局</span>负责同志签字后交秘书局督查<br>室，电子版发至督查室内网邮箱
        </span>
        </p>

    </div>
</div>

