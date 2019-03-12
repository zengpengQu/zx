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
    <!--
    /* Font Definitions */
    @font-face {
        font-family: Wingdings;
        panose-1: 5 0 0 0 0 0 0 0 0 0;
    }

    @font-face {
        font-family: 宋体;
        panose-1: 2 1 6 0 3 1 1 1 1 1;
    }

    @font-face {
        font-family: 黑体;
        panose-1: 2 1 6 9 6 1 1 1 1 1;
    }

    @font-face {
        font-family: "Cambria Math";
        panose-1: 2 4 5 3 5 4 6 3 2 4;
    }

    @font-face {
        font-family: Calibri;
        panose-1: 2 15 5 2 2 2 4 3 2 4;
    }

    @font-face {
        font-family: 仿宋_GB2312;
        panose-1: 2 1 6 9 3 1 1 1 1 1;
    }

    @font-face {
        font-family: 楷体;
        panose-1: 2 1 6 9 6 1 1 1 1 1;
    }

    @font-face {
        font-family: Cambria;
        panose-1: 2 4 5 3 5 4 6 3 2 4;
    }

    @font-face {
        font-family: "\@黑体";
        panose-1: 2 1 6 0 3 1 1 1 1 1;
    }

    @font-face {
        font-family: "\@仿宋_GB2312";
    }

    @font-face {
        font-family: "\@宋体";
        panose-1: 2 1 6 0 3 1 1 1 1 1;
    }

    @font-face {
        font-family: "\@楷体";
    }

    /* Style Definitions */
    p.MsoNormal, li.MsoNormal, div.MsoNormal {
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 10.5pt;
        font-family: "Calibri", sans-serif;
    }

    p.MsoHeader, li.MsoHeader, div.MsoHeader {
        mso-style-link: "页眉 Char";
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: center;
        layout-grid-mode: char;
        border: none;
        padding: 0cm;
        font-size: 9.0pt;
        font-family: "Calibri", sans-serif;
    }

    p.MsoFooter, li.MsoFooter, div.MsoFooter {
        mso-style-link: "页脚 Char";
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: left;
        layout-grid-mode: char;
        font-size: 9.0pt;
        font-family: "Calibri", sans-serif;
    }

    p.MsoTitle, li.MsoTitle, div.MsoTitle {
        mso-style-link: "标题 Char";
        margin-top: 12.0pt;
        margin-right: 0cm;
        margin-bottom: 3.0pt;
        margin-left: 0cm;
        text-align: center;
        font-size: 16.0pt;
        font-family: "Cambria", serif;
        font-weight: bold;
    }

    p.MsoDate, li.MsoDate, div.MsoDate {
        mso-style-link: "日期 Char";
        margin-top: 0cm;
        margin-right: 0cm;
        margin-bottom: 0cm;
        margin-left: 5.0pt;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 10.5pt;
        font-family: "Calibri", sans-serif;
    }

    p.MsoDocumentMap, li.MsoDocumentMap, div.MsoDocumentMap {
        mso-style-link: "文档结构图 Char";
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 9.0pt;
        font-family: 宋体;
    }

    p {
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 12.0pt;
        font-family: "Times New Roman", serif;
    }

    p.MsoAcetate, li.MsoAcetate, div.MsoAcetate {
        mso-style-link: "批注框文本 Char";
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 9.0pt;
        font-family: "Calibri", sans-serif;
    }

    p.MsoNoSpacing, li.MsoNoSpacing, div.MsoNoSpacing {
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 10.5pt;
        font-family: "Calibri", sans-serif;
    }

    p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph {
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        text-indent: 21.0pt;
        font-size: 10.5pt;
        font-family: "Calibri", sans-serif;
    }

    span.Char {
        mso-style-name: "页脚 Char";
        mso-style-link: 页脚;
        font-family: "Calibri", sans-serif;
    }

    span.Char0 {
        mso-style-name: "页眉 Char";
        mso-style-link: 页眉;
    }

    span.Char1 {
        mso-style-name: "批注框文本 Char";
        mso-style-link: 批注框文本;
    }

    p.Char2, li.Char2, div.Char2 {
        mso-style-name: Char;
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 10.5pt;
        font-family: "Times New Roman", serif;
    }

    span.Char3 {
        mso-style-name: "日期 Char";
        mso-style-link: 日期;
    }

    p.CharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharChar, li.CharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharChar, div.CharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharCharChar {
        mso-style-name: "Char Char Char Char Char Char Char Char Char Char Char Char Char Char Char Char Char Char Char Char Char Char";
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 10.5pt;
        font-family: "Times New Roman", serif;
    }

    span.Char4 {
        mso-style-name: "标题 Char";
        mso-style-link: 标题;
        font-family: "Cambria", serif;
        font-weight: bold;
    }

    p.CharCharCharChar, li.CharCharCharChar, div.CharCharCharChar {
        mso-style-name: "Char Char Char Char";
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 10.5pt;
        font-family: "Times New Roman", serif;
    }

    p.CharCharCharChar3, li.CharCharCharChar3, div.CharCharCharChar3 {
        mso-style-name: "Char Char Char Char3";
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 10.5pt;
        font-family: "Times New Roman", serif;
    }

    p.CharCharCharChar2, li.CharCharCharChar2, div.CharCharCharChar2 {
        mso-style-name: "Char Char Char Char2";
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 10.5pt;
        font-family: "Times New Roman", serif;
    }

    p.Char10, li.Char10, div.Char10 {
        mso-style-name: Char1;
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 10.5pt;
        font-family: "Times New Roman", serif;
    }

    p.CharCharCharChar1, li.CharCharCharChar1, div.CharCharCharChar1 {
        mso-style-name: "Char Char Char Char1";
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 10.5pt;
        font-family: "Times New Roman", serif;
    }

    p.CharCharCharChar4, li.CharCharCharChar4, div.CharCharCharChar4 {
        mso-style-name: "Char Char Char Char4";
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 10.5pt;
        font-family: "Times New Roman", serif;
    }

    p.normal, li.normal, div.normal {
        mso-style-name: normal;
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 10.0pt;
        font-family: "Calibri", sans-serif;
    }

    span.normalchar1 {
        mso-style-name: normal__char1;
        font-family: "Calibri", sans-serif;
    }

    p.dash6b636587, li.dash6b636587, div.dash6b636587 {
        mso-style-name: dash6b63_6587;
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 10.0pt;
        font-family: "Times New Roman", serif;
    }

    span.dash6b636587char1 {
        mso-style-name: dash6b63_6587__char1;
        font-family: "Times New Roman", serif;
    }

    p.Char5, li.Char5, div.Char5 {
        mso-style-name: " Char";
        margin: 0cm;
        margin-bottom: .0001pt;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 10.5pt;
        font-family: "Times New Roman", serif;
    }

    span.Char6 {
        mso-style-name: "文档结构图 Char";
        mso-style-link: 文档结构图;
        font-family: 宋体;
    }

    p.xmsonormal, li.xmsonormal, div.xmsonormal {
        mso-style-name: x_msonormal;
        margin-right: 0cm;
        margin-left: 0cm;
        text-align: left;
        font-size: 12.0pt;
        font-family: 宋体;
    }

    p.normal00200028web0029, li.normal00200028web0029, div.normal00200028web0029 {
        mso-style-name: normal_0020_0028web_0029;
        margin-top: 5.0pt;
        margin-right: 0cm;
        margin-bottom: 5.0pt;
        margin-left: 0cm;
        text-align: left;
        font-size: 12.0pt;
        font-family: 宋体;
    }

    span.normal00200028web0029char1 {
        mso-style-name: normal_0020_0028web_0029__char1;
        font-family: 宋体;
    }

    p.dash666e901a00287f517ad90029, li.dash666e901a00287f517ad90029, div.dash666e901a00287f517ad90029 {
        mso-style-name: dash666e_901a_0028_7f51_7ad9_0029;
        margin-top: 5.0pt;
        margin-right: 0cm;
        margin-bottom: 5.0pt;
        margin-left: 0cm;
        text-align: justify;
        text-justify: inter-ideograph;
        font-size: 12.0pt;
        font-family: 宋体;
    }

    span.dash666e901a00287f517ad90029char1 {
        mso-style-name: dash666e_901a_0028_7f51_7ad9_0029__char1;
        font-family: 宋体;
    }

    .MsoChpDefault {
        font-family: "Calibri", sans-serif;
    }

    /* Page Definitions */
    @page WordSection1 {
        size: 595.3pt 841.9pt;
        margin: 2.5cm 2.75cm 2.5cm 3.0cm;
        layout-grid: 15.6pt;
    }

    div.WordSection1 {
        page: WordSection1;
    }

    /* List Definitions */
    ol {
        margin-bottom: 0cm;
    }

    ul {
        margin-bottom: 0cm;
    }

    -->
</style>


<div bgcolor="#FFFFCC" lang=ZH-CN style='text-justify-trim:punctuation' class="page">

    <div class=WordSection1 style='layout-grid:15.6pt'>

        <p class=MsoNormal align=center style='text-align:center;line-height:29.0pt'><span
                lang=EN-US style='font-size:18.0pt;font-family:"Times New Roman",serif'>&nbsp;</span></p>

        <p class=MsoNormal align=center style='text-align:center;line-height:29.0pt'><span
                lang=EN-US style='font-size:18.0pt;font-family:"Times New Roman",serif'>&nbsp;</span></p>

        <p class=MsoNormal align=center style='text-align:center;line-height:29.0pt'><span
                lang=EN-US style='font-size:18.0pt;font-family:"Times New Roman",serif'>&nbsp;</span></p>

        <p class=MsoNormal align=center style='text-align:center;line-height:29.0pt'><span
                lang=EN-US style='font-size:18.0pt;font-family:"Times New Roman",serif'>&nbsp;</span></p>

        <p class=MsoNormal align=center style='text-align:center;line-height:29.0pt'><span
                lang=EN-US style='font-size:18.0pt;font-family:"Times New Roman",serif'>&nbsp;</span></p>

        <p class=MsoNormal align=center style='text-align:center;line-height:29.0pt'><span
                lang=EN-US style='font-size:18.0pt;font-family:"Times New Roman",serif'>&nbsp;</span></p>

        <p class=MsoNormal align=center style='text-align:center;line-height:18.0pt'><span
                lang=EN-US style='font-size:18.0pt;font-family:"Times New Roman",serif'>&nbsp;</span></p>

        <p class=MsoNormal align=center style='text-align:center;line-height:29.0pt'>
            <span style='font-size:16.0pt;font-family:仿宋_GB2312'>第</span>
            <span lang=EN-US style='font-size:16.0pt;font-family:"Times New Roman",serif'>116</span>
            <span style='font-size:16.0pt;font-family:仿宋_GB2312'>期</span>
        </p>

        <p class=MsoNormal style='margin-right:-2.05pt;line-height:29.0pt'>
            <span style='font-size:16.0pt;font-family:仿宋_GB2312'>办公厅秘书局</span>
            <span lang=EN-US style='font-size:16.0pt;font-family:"Times New Roman",serif'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
            <span lang=EN-US style='font-size:16.0pt;font-family:"Times New Roman",serif;
color:black'>${year}</span>
            <span style='font-size:16.0pt;font-family:仿宋_GB2312;
color:black'>年</span>
            <span lang=EN-US style='font-size:16.0pt;font-family:"Times New Roman",serif;
color:black'>${month}</span>
            <span style='font-size:16.0pt;font-family:仿宋_GB2312;
color:black'>月</span>
            <span lang=EN-US style='font-size:16.0pt;font-family:"Times New Roman",serif;
color:black'>${day}</span>
            <span style='font-size:16.0pt;font-family:仿宋_GB2312;
color:black'>日</span>
        </p>

        <p class=MsoNormal style='text-indent:32.0pt;line-height:30.0pt;layout-grid-mode:
char'><span lang=EN-US style='font-size:16.0pt;font-family:仿宋_GB2312;
color:black'>&nbsp;</span></p>

        <c:if test="${!empty sectionMap}">
            <c:forEach items="${sectionMap}" var="item">

                <p class=MsoNormal style='text-indent:32.0pt;line-height:30.0pt;layout-grid-mode:
char'><span lang=EN-US style='font-size:16.0pt;font-family:仿宋_GB2312;
color:black'>&nbsp;</span></p>

                <p class=MsoNormal align=center style='text-align:center;line-height:28.0pt;
layout-grid-mode:char'>
                    <span lang=EN-US style='font-size:18.0pt;font-family:
"宋体",serif;color:black'>※</span>
                    <span lang=EN-US style='font-size:18.0pt;font-family:
"Times New Roman",serif;color:black'>&nbsp;&nbsp;</span>
                    <span style='font-size:18.0pt;
font-family:黑体;color:black'>${fn:substring(item.key, 2,item.key.length())}</span>
                    <span lang=EN-US style='font-size:18.0pt;font-family:
"Times New Roman",serif;color:black'>&nbsp;&nbsp;</span>
                    <span lang=EN-US style='font-size:18.0pt;
font-family:"宋体",serif;color:black'>※</span>
                </p>
                <c:forEach items="${item.value}" var="dutyDaily">
                    <div class="wordContent">
                            ${dutyDaily.content}
                    </div>
                </c:forEach>
            </c:forEach>
        </c:if>

        <p class=MsoNormal style='text-indent:32.0pt;line-height:28.0pt;layout-grid-mode:
char'><span lang=EN-US style='font-size:16.0pt;font-family:仿宋_GB2312;
color:black'>&nbsp;</span></p>

        <p class=MsoNormal style='line-height:28.0pt;layout-grid-mode:char'>
            <span lang=EN-US style='font-size:16.0pt;font-family:仿宋_GB2312;color:black'>&nbsp;</span>
        </p>

        <p class=MsoNormal style='line-height:1.0pt'><span lang=EN-US style='font-size:
16.0pt;font-family:仿宋_GB2312;color:black'>&nbsp;</span></p>

        <table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 width=578
               style='width:433.5pt;margin-left:1.4pt;border-collapse:collapse;border:none'>
            <tr style='height:91.4pt'>
                <td width=578 valign=top style='width:433.5pt;border-top:solid windowtext 1.0pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:none;
  padding:0cm 1.4pt 0cm 1.4pt;height:91.4pt'>
                    <p class=MsoNormal style='margin-left:45.0pt;text-indent:-45.0pt;line-height:
  23.0pt;vertical-align:baseline'>
                        <span style='font-size:15.0pt;font-family:
  仿宋_GB2312'>分送：政协全国委员会主席、副主席，副秘书长，机关领导班子成员，各专委会主任、驻会副主任。</span>
                    </p>
                    <p class=MsoNormal align=left style='margin-left:44.75pt;text-align:left;
  line-height:23.0pt;vertical-align:baseline'>
                        <span style='font-size:15.0pt;
  font-family:仿宋_GB2312'>中共中央统战部，各民主党派中央、全国工商联，政协各省、</span>
                    </p>
                    <p class=MsoNormal align=left style='margin-left:44.75pt;text-align:left;
  line-height:23.0pt;vertical-align:baseline'>
                        <span style='font-size:15.0pt;
  font-family:仿宋_GB2312'>自治区、直辖市和副省级市委员会。</span>
                    </p>
                </td>
            </tr>
        </table>

        <p class=MsoNormal style='margin-bottom:6.0pt;line-height:25.0pt'>
            <span style='font-size:15.0pt;font-family:楷体'>编校：唐</span>
            <span lang=EN-US style='font-size:15.0pt;font-family:"Times New Roman",serif'>&nbsp; </span>
            <span style='font-size:15.0pt;font-family:楷体'>捷</span>
            <span lang=EN-US style='font-size:15.0pt;font-family:"Times New Roman",serif'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
            <span style='font-size:
15.0pt;font-family:楷体'>审核：宿正伯</span>
            <span style='font-size:15.0pt;font-family:"Times New Roman",serif'>
                <span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
            </span>
            <span style='font-size:15.0pt;font-family:楷体'>共印</span><span lang=EN-US style='font-size:15.0pt;font-family:"Times New Roman",serif'>370</span>
            <span style='font-size:15.0pt;font-family:楷体'>份</span>
        </p>
    </div>
</div>

<script>

    $(document).ready(function () {

        $.each($('.wordContent p'), function (index, item) {

            if ($(this).find('span').length === 0) {
                $(this).wrapInner('<span></span>');
            }
        });

        $('.wordContent p').removeClass().addClass('MsoNormal').css({
            'text-indent': '32.0pt',
            'line-height': '30.0pt',
            'layout-grid-mode': 'char'
        }).wrapInner('<span style="font-size: 16pt;font-family: 仿宋_GB2312, Arial, Helvetica, sans-serif ;color: black"></span>')
            .prepend('<span style="font-size: 16pt;font-family: 仿宋_GB2312, Arial, Helvetica, sans-serif ;color: black">△</span>');

        $('.wordContent p span').css({

            'font-size': '16pt',
            'font-family': '仿宋_GB2312, Arial, Helvetica, sans-serif',
            'color': 'black'

        })
    })
</script>
