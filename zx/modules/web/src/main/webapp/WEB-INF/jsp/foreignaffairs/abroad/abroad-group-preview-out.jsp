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
    {font-family:"\@宋体";
        panose-1:2 1 6 0 3 1 1 1 1 1;}
    @font-face
    {font-family:"\@华文中宋";
        panose-1:2 1 6 0 4 1 1 1 1 1;}
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
    p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
    {mso-style-link:"批注框文本 Char";
        margin:0cm;
        margin-bottom:.0001pt;
        text-align:justify;
        text-justify:inter-ideograph;
        font-size:9.0pt;
        font-family:"Calibri","sans-serif";}
    span.Char
    {mso-style-name:"批注框文本 Char";
        mso-style-link:批注框文本;}
    span.Char0
    {mso-style-name:"页眉 Char";
        mso-style-link:页眉;}
    span.Char1
    {mso-style-name:"页脚 Char";
        mso-style-link:页脚;}
    .MsoChpDefault
    {font-family:"Calibri","sans-serif";}
    /* Page Definitions */
    @page WordSection1
    {size:595.3pt 841.9pt;
        margin:72.0pt 90.0pt 72.0pt 90.0pt;
        layout-grid:15.6pt;}
    div.WordSection1
    {page:WordSection1;}

    @page WordSection2
    {size:595.3pt 841.9pt;
        margin:72.0pt 90.0pt 72.0pt 90.0pt;
        layout-grid:15.6pt;}
    div.WordSection2
    {page:WordSection2;}
    -->
</style>

<div class="page" contenteditable="true">
    <div class=WordSection1 style='layout-grid:15.6pt'>

        <p class=MsoNormal align=center style='margin-top:31.2pt;text-align:center'><span
                style='font-size:26.0pt;font-family:华文中宋;color:red'>中国人民政治协商会议全国委员会</span></p>

        <p class=MsoNormal>

        <table cellpadding=0 cellspacing=0 align=left>
            <tr>
                <td width=170 height=6></td>
                <td width=125></td>
                <td width=13></td>
                <td width=198></td>
            </tr>
            <tr>
                <td height=17></td>
                <td rowspan=3 align=left valign=top><img width=125 height=105
                    src="${basePath}/images/foreignaffairs/abroad/tasknotification/image001.png" alt="出  国&#13;&#10;赴港澳&#13;&#10;"></td>
            </tr>
            <tr>
                <td height=73></td>
                <td></td>
                <td align=left valign=top><img width=198 height=73
                    src="${basePath}/images/foreignaffairs/abroad/tasknotification/image002.png" alt=任务通知书></td>
            </tr>
            <tr>
                <td height=15></td>
            </tr>
        </table>

        <span lang=EN-US>&nbsp;</span></p>

        <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>

        <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>

        <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>

        <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>

        <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>

        <br clear=ALL>

        <p class=MsoNormal align=right style='margin-right:10.0pt;text-align:right'><span
                style='font-size:16.0pt;font-family:宋体'>全办外通字 </span><span style='font-size:
            16.0pt;font-family:宋体'>﹝</span><span lang=EN-US style='font-size:16.0pt;
            font-family:"Times New Roman","serif"'>${year}</span><span style='font-size:
            16.0pt;font-family:宋体'>﹞</span><span style='font-size:16.0pt;font-family:"Times New Roman","serif"'>
            <span lang=EN-US>xx</span></span><span style='font-size:16.0pt;font-family:宋体'>号</span></p>

        <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US
           style='font-size:16.0pt;font-family:宋体'><span style='text-decoration:none'>&nbsp;</span></span></p>

        <p class=MsoNormal align=left style='text-align:left'><u><span
                style='font-size:16.0pt;font-family:宋体'>${org}：</span></u></p>

        <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US
           style='font-size:16.0pt;font-family:宋体'><span style='text-decoration:none'>&nbsp;</span></span></p>

        <p class=MsoNormal align=left style='text-align:left;text-indent:32.0pt'><span
                style='font-size:16.0pt;font-family:宋体'>根据<u> 全办外出字<span lang=EN-US>[${year}]x </span>号
                </u>出国、赴港澳任务批件，批准由<u><span lang=EN-US> ${groupLeader.getEmpName()} </span></u>等<u><span
                lang=EN-US> ${totalNum} </span></u>人组团</span><span style='font-size:16.0pt;
                font-family:宋体'>自<u><span lang=EN-US> ${startYear} </span></u>年<u><span
                lang=EN-US> ${startMonth} </span></u>月<u><span lang=EN-US> ${startDate} </span></u>日至<u><span
                lang=EN-US> ${endYaer} </span></u>年<u><span lang=EN-US> ${endMonth} </span></u>月<u><span
                lang=EN-US> ${endDate} </span></u>日经<u> <span lang=EN-US><c:if test="${empty trses}">/</c:if><c:if test="${!empty trses}">${trses}</c:if> </span></u>前往<u><span
                lang=EN-US>&nbsp; ${nations} </span></u>（国家、地区）执行<u><span lang=EN-US>&nbsp;
                ${abroadTask}&nbsp; </span></u>任务，在国（境）外停留<u><span lanng=EN-US> ${abroadDays} </span></u>天。其中请你单位派<u>
                ${num} </u>人参加。</span></p>

        <p class=MsoNormal align=left style='text-align:left;text-indent:32.0pt'><span
                style='font-size:16.0pt;font-family:宋体'>附  注：<u>${names}</u>同志，出访费用由<u>${costSource}</u>。</span></p>

        <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US
            style='font-size:16.0pt;font-family:宋体'>&nbsp;</span></p>

        <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US
            style='font-size:16.0pt;font-family:宋体'>&nbsp;</span></p>

        <p class=MsoNormal align=right style='margin-right:10.0pt;text-align:right'><span
                style='font-size:16.0pt;font-family:宋体'>政协全国委员会办公厅</span></p>

        <p class=MsoNormal align=right style='margin-right:16.0pt;text-align:right'><span
                lang=EN-US style='font-size:16.0pt;font-family:"Times New Roman","serif"'>${year} </span><span
                style='font-size:16.0pt;font-family:宋体'>年 </span><span lang=EN-US
                 style='font-size:16.0pt;font-family:"Times New Roman","serif"'>${month} </span><span
                style='font-size:16.0pt;font-family:宋体'>月 </span><span lang=EN-US
                 style='font-size:16.0pt;font-family:"Times New Roman","serif"'>${day} </span><span
                style='font-size:16.0pt;font-family:宋体'>日</span></p>
        <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>

    </div>
</div>

<div class="page" contenteditable="true">

    <div class=WordSection2 style='layout-grid:15.6pt'>

        <p class=MsoNormal align=center style='margin-top:31.2pt;text-align:center'><span
                style='font-size:26.0pt;font-family:华文中宋;color:red'>中国人民政治协商会议全国委员会</span></p>

        <p class=MsoNormal>

        <table cellpadding=0 cellspacing=0 align=left>
            <tr>
                <td width=170 height=6></td>
                <td width=125></td>
                <td width=13></td>
                <td width=198></td>
            </tr>
            <tr>
                <td height=17></td>
                <td rowspan=3 align=left valign=top><img width=125 height=105
                    src="${basePath}/images/foreignaffairs/abroad/taskconfirmation/image001.png" alt="出  国&#13;&#10;赴港澳&#13;&#10;"></td>
            </tr>
            <tr>
                <td height=73></td>
                <td></td>
                <td align=left valign=top><img width=198 height=73
                    src="${basePath}/images/foreignaffairs/abroad/taskconfirmation/image002.png" alt=任务确认件></td>
            </tr>
            <tr>
                <td height=15></td>
            </tr>
        </table>

        <span lang=EN-US>&nbsp;</span></p>

        <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>

        <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>

        <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>

        <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>

        <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>

        <br clear=ALL>

        <p class=MsoNormal align=right style='margin-right:10.0pt;text-align:right'><span
                style='font-size:16.0pt;font-family:宋体'>全办外确字 </span><span style='font-size:
        16.0pt;font-family:宋体'>﹝</span><span lang=EN-US style='font-size:16.0pt;
        font-family:"Times New Roman","serif"'>${year}</span><span style='font-size:
        16.0pt;font-family:宋体'>﹞</span><span style='font-size:16.0pt;font-family:"Times New Roman","serif"'>
        <span lang=EN-US>xx</span></span><span style='font-size:16.0pt;font-family:宋体'>号</span></p>

        <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US
           style='font-size:16.0pt;font-family:宋体'><span style='text-decoration:none'>&nbsp;</span></span></p>

        <p class=MsoNormal align=left style='text-align:left'><u><span
                style='font-size:16.0pt;font-family:宋体'>${org}：</span></u></p>

        <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US
           style='font-size:16.0pt;font-family:宋体'><span style='text-decoration:none'>&nbsp;</span></span></p>

        <p class=MsoNormal align=left style='text-align:left;text-indent:32.0pt'><span
                style='font-size:16.0pt;font-family:宋体'>根据<u> 全办外通字<span lang=EN-US>[${year}]x </span>号
                </u>出国、赴港澳任务通知书，同意<u> ${names} </u>同志等<u><span lang=EN-US> ${num} </span></u><span
                lang=EN-US>人,</span></span><span style='font-size:16.0pt;font-family:宋体'>经<u> <span
                lang=EN-US><c:if test="${empty trses}">/</c:if><c:if test="${!empty trses}">${trses}</c:if> </span></u>前往<u><span lang=EN-US> ${nations} </span></u>（国家、地区）执行<u><span
                lang=EN-US>&nbsp;${abroadTask}&nbsp;</span></u>任务，在国（境）外停留<u><span
                lang=EN-US> ${abroadDays} </span></u>天。</span></p>

        <p class=MsoNormal align=left style='text-align:left;text-indent:32.0pt'><span
                style='font-size:16.0pt;font-family:宋体'>费用来源：由<u>&nbsp;&nbsp;</u>负担。</span></p>

        <p class=MsoNormal align=left style='text-align:left;text-indent:32.0pt'><span
                style='font-size:16.0pt;font-family:宋体'>附  注：<u>${names}</u>同志。</span></p>

        <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US
           style='font-size:16.0pt;font-family:宋体'>&nbsp;</span></p>

        <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US
           style='font-size:16.0pt;font-family:宋体'>&nbsp;</span></p>

        <p class=MsoNormal align=right style='margin-right:10.0pt;text-align:right'><span
                style='font-size:16.0pt;font-family:宋体'>政协全国委员会办公厅</span></p>

        <p class=MsoNormal align=right style='margin-right:16.0pt;text-align:right'><span
                lang=EN-US style='font-size:16.0pt;font-family:"Times New Roman","serif"'>${year} </span><span
                style='font-size:16.0pt;font-family:宋体'>年 </span><span lang=EN-US
                style='font-size:16.0pt;font-family:"Times New Roman","serif"'>${month} </span><span
                style='font-size:16.0pt;font-family:宋体'>月 </span><span lang=EN-US
                style='font-size:16.0pt;font-family:"Times New Roman","serif"'>${day} </span><span
                style='font-size:16.0pt;font-family:宋体'>日</span></p>

        <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>

    </div>
</div>

