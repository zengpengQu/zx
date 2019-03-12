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
    {font-family:Calibri;
        panose-1:2 15 5 2 2 2 4 3 2 4;
        mso-font-charset:0;
        mso-generic-font-family:swiss;
        mso-font-pitch:variable;
        mso-font-signature:-536859905 -1073732485 9 0 511 0;}
    @font-face
    {font-family:华文中宋;
        panose-1:2 1 6 0 4 1 1 1 1 1;
        mso-font-charset:134;
        mso-generic-font-family:auto;
        mso-font-pitch:variable;
        mso-font-signature:647 135200768 16 0 262303 0;}
    @font-face
    {font-family:仿宋;
        panose-1:2 1 6 9 6 1 1 1 1 1;
        mso-font-charset:134;
        mso-generic-font-family:modern;
        mso-font-pitch:fixed;
        mso-font-signature:-2147482945 953122042 22 0 262145 0;}
    @font-face
    {font-family:"\@华文中宋";
        mso-font-charset:134;
        mso-generic-font-family:auto;
        mso-font-pitch:variable;
        mso-font-signature:647 135200768 16 0 262303 0;}
    @font-face
    {font-family:"\@宋体";
        panose-1:2 1 6 0 3 1 1 1 1 1;
        mso-font-charset:134;
        mso-generic-font-family:auto;
        mso-font-pitch:variable;
        mso-font-signature:3 680460288 22 0 262145 0;}
    @font-face
    {font-family:"\@仿宋";
        mso-font-charset:134;
        mso-generic-font-family:modern;
        mso-font-pitch:fixed;
        mso-font-signature:-2147482945 953122042 22 0 262145 0;}
    p.MsoNormal, li.MsoNormal, div.MsoNormal
    {mso-style-unhide:no;
        mso-style-qformat:yes;
        mso-style-parent:"";
        margin:0cm;
        margin-bottom:.0001pt;
        mso-pagination:widow-orphan;
        font-size:12.0pt;
        font-family:宋体;
        mso-bidi-font-family:宋体;}
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
    @page WordSection1
    {size:595.3pt 841.9pt;
        margin:72.0pt 90.0pt 72.0pt 90.0pt;
        mso-header-margin:42.55pt;
        mso-footer-margin:49.6pt;
        mso-paper-source:0;}
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
</style>


<div bgcolor="#FFFFCC" lang=ZH-CN style='text-justify-trim:punctuation' class="page">
    <div class=WordSection1>

        <div contenteditable=true>
            <div>
                <p class=MsoNormal align=center style='text-align:center'>
                    <b>
                        <span lang=EN-US style='font-size:22.0pt;font-family:华文中宋;color:red'>
                        &nbsp;
                        </span>
                    </b>
                </p>
                <p class=MsoNormal align=center style='text-align:center'>
                    <b>
                        <span style='font-size:22.0pt;font-family:华文中宋;color:red'>中国人民政治协商会议全国委员会办公厅
                            <span lang=EN-US></span>
                        </span>
                    </b>
                </p>
            </div>
            <div style='margin-top:15.0pt;margin-bottom:14.25pt;max-height: 1px;min-height: 1px;overflow:hidden'>
                <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>
            </div>
            <div>
                <p class=MsoNormal align=center style='text-align:center'>
                    <b>
                        <span style='font-size:22.0pt;font-family:华文中宋;color:red'>
                            赴
                            <span lang=EN-US>&nbsp;&nbsp;</span>
                            台
                            <span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;</span>
                            任务通知书
                            <span lang=EN-US></span>
                        </span>
                    </b>
                </p>
            </div>
            <div style='margin-top:7.5pt;margin-bottom:6.75pt;max-height: 1px;min-height: 1px;overflow:hidden'>
                <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>
            </div>
            <div style='margin-top:7.5pt;margin-bottom:6.75pt;max-height: 1px;min-height: 1px;overflow:hidden'>
                <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>
            </div>
            <div>
                <div style='margin-top:7.5pt;margin-bottom:6.75pt;max-height: 1px;min-height: 1px;overflow:hidden'>
                    <p class=MsoNormal align=right style='text-align:right'>
                        <span lang=EN-US>&nbsp;</span>
                        <b style='mso-bidi-font-weight:normal'>
                            <span style='color:red'>全国政协台出字〔
                                <span lang=EN-US>
                                    <span style='mso-spacerun:yes'></span>
                                </span>
                                〕第
                                <span lang=EN-US>
                                    <span style='mso-spacerun:yes'></span>
                                </span>号
                            </span>
                            <span lang=EN-US></span>
                        </b>
                    </p>
                </div>
                <div>
                    <p class=MsoNormal style='margin-bottom:16.0pt'>
                        <span style='font-size:16.0pt;font-family:仿宋'>
                           **********：
                            <span lang=EN-US>
                                <br><br>
                            </span>
                        </span>
                        <span lang=EN-US style='font-size:16.0pt;font-family:"Calibri",sans-serif;mso-fareast-font-family:仿宋'>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                        <span class=GramE>
                            <span style='font-size:16.0pt;font-family:仿宋'>根据全国政协领导批准和全政协台出字〔&nbsp;&nbsp;&nbsp;&nbsp;〕
                                第&nbsp;&nbsp;&nbsp;&nbsp;号赴台任务批件，批准由</span>
                        </span>
                        <span lang=EN-US style='font-size:16.0pt;font-family:仿宋'>${taiWanInfoUserName}</span>
                        <span style='font-size:16.0pt;font-family:仿宋'>等
                            <span lang=EN-US>${taiWanInfo.taiWanInfoUserList.size()}</span>人组团自
                            <span lang=EN-US>${beginTime}</span>
                            至
                            <span lang=EN-US>${endTime}</span>前往台湾执行“
                            <span lang=EN-US>${taiWanInfo.groupName}</span>”交流参访任务，在台湾停留
                            <span lang=EN-US>${time}</span>天。你单位****等**人参加，出访费用由全国政协支付。
                            <span lang=EN-US>
                                <br><br>
                            </span>
                        </span>
                        <span lang=EN-US style='font-size:16.0pt;font-family:"Calibri",sans-serif;mso-fareast-font-family:仿宋'>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                        <span style='font-size:16.0pt;font-family:仿宋'>附注：无
                            <span lang=EN-US>
                                <br><br>
                            </span>
                        </span>
                        <span lang=EN-US style='font-size:16.0pt;font-family:"Calibri",sans-serif;mso-fareast-font-family:仿宋'>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </span>
                        <span style='font-size:16.0pt;font-family:仿宋'>名单附后。
                            <span lang=EN-US></span>
                        </span>
                    </p>
                    <div>
                        <p class=MsoNormal align=right style='text-align:right'>
                            <span style='font-size:16.0pt;font-family:仿宋;color:black'>
                                政协全国委员会办公厅
                                <span lang=EN-US></span>
                            </span>
                        </p>
                    </div>
                    <div>
                        <p class=MsoNormal align=right style='text-align:right'>
                            <span style='font-size:16.0pt;font-family:仿宋;color:black'>
                                台港澳侨联络局
                                <span lang=EN-US></span>
                            </span>
                        </p>
                    </div>
                    <div>
                        <p class=MsoNormal align=right style='text-align:right'>
                            <span lang=EN-US style='font-size:16.0pt;font-family:仿宋;color:black'>${sysDate}</span>
                        </p>
                    </div>
                    <p class=MsoNormal style='margin-bottom:16.0pt'>
                        <span lang=EN-US style='font-size:16.0pt;font-family:仿宋'>
                            <br>
                            <br>
                            <br>
                            <br style='mso-special-character:line-break'>
                            <br style='mso-special-character:line-break'>
                        </span>
                    </p>
                    <p class=MsoNormal style='margin-bottom:16.0pt'>
                        <span lang=EN-US style='font-size:16.0pt;font-family:仿宋'>&nbsp;</span>
                    </p>

                    <p class=MsoNormal style='margin-bottom:16.0pt'>
                        <b style='mso-bidi-font-weight:normal'>
                            <span style='font-size:16.0pt;font-family:仿宋'>附件
                                <span lang=EN-US></span>
                            </span>
                        </b>
                    </p>

                </div>
            </div>
        </div>

        <div contenteditable=true>
            <div>
                <p class=MsoNormal align=center style='text-align:center'>
                    <b>
                        <span style='font-size:24.0pt;font-family:华文中宋;color:red'>
                            赴台人员名单
                            <span lang=EN-US></span>
                        </span>
                    </b>
                </p>
            </div>

            <div>
                <div>
                    <p class=MsoNormal align=center style='text-align:center'>
                        <span lang=EN-US style='font-size:16.0pt;color:black'>
                            (${taiWanInfo.taiWanInfoUserList.size()}&nbsp;&nbsp;
                        </span>
                        <span style='font-size:16.0pt;color:black'>人
                            <span lang=EN-US>) </span>
                        </span>
                    </p>
                </div>
                <div>
                    <div>
                        <div align=right>
                            <table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 width="100%"
                                   style='border-collapse:collapse;mso-table-layout-alt:fixed;border:none;
                                    mso-border-alt:solid #0F0F0F .75pt;mso-yfti-tbllook:1184'>
                                <thead>
                                <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
                                    <td width=56 style='width:42.15pt;border:solid #0F0F0F 1.0pt;mso-border-alt:
                                            solid #0F0F0F .75pt;padding:.75pt .75pt .75pt .75pt'>
                                        <p class=MsoNormal align=center style='text-align:center'>
                                            <b>姓名<span lang=EN-US></span></b>
                                        </p>
                                    </td>
                                    <td width=47 style='width:35.45pt;border:solid #0F0F0F 1.0pt;border-left:
                                            none;mso-border-left-alt:solid #0F0F0F .75pt;mso-border-alt:solid #0F0F0F .75pt;
                                            padding:.75pt .75pt .75pt .75pt'>
                                        <p class=MsoNormal align=center style='text-align:center'><b>性别
                                            <span lang=EN-US></span></b>
                                        </p>
                                    </td>
                                    <td width=85 style='width:63.75pt;border:solid #0F0F0F 1.0pt;border-left:
                                            none;mso-border-left-alt:solid #0F0F0F .75pt;mso-border-alt:solid #0F0F0F .75pt;
                                            padding:.75pt .75pt .75pt .75pt'>
                                        <p class=MsoNormal align=center style='text-align:center'><b>出生日期
                                            <span lang=EN-US></span></b>
                                        </p>
                                    </td>
                                    <td width=136 style='width:101.65pt;border:solid #0F0F0F 1.0pt;border-left:
                                        none;mso-border-left-alt:solid #0F0F0F .75pt;mso-border-alt:solid #0F0F0F .75pt;
                                        padding:.75pt .75pt .75pt .75pt'>
                                        <p class=MsoNormal align=center style='text-align:center'><b>工作单位
                                            <span lang=EN-US></span></b>
                                        </p>
                                    </td>
                                    <td width=72 style='width:54.3pt;border:solid #0F0F0F 1.0pt;border-left:
                                        none;mso-border-left-alt:solid #0F0F0F .75pt;mso-border-alt:solid #0F0F0F .75pt;
                                        padding:.75pt .75pt .75pt .75pt'>
                                        <p class=MsoNormal align=center style='text-align:center'><b>赴台身份
                                            <span lang=EN-US></span></b>
                                        </p>
                                    </td>
                                    <td width=85 style='width:63.8pt;border:solid #0F0F0F 1.0pt;border-left:
                                        none;mso-border-left-alt:solid #0F0F0F .75pt;mso-border-alt:solid #0F0F0F .75pt;
                                        padding:.75pt .75pt .75pt .75pt'>
                                        <p class=MsoNormal align=center style='text-align:center'><b>户口所在地
                                            <span lang=EN-US></span></b>
                                        </p>
                                    </td>
                                    <td width=71 style='width:53.4pt;border:solid #0F0F0F 1.0pt;border-left:
                                        none;mso-border-left-alt:solid #0F0F0F .75pt;mso-border-alt:solid #0F0F0F .75pt;
                                        padding:.75pt .75pt .75pt .75pt'>
                                        <p class=MsoNormal align=center style='text-align:center'><b>备注
                                            <span lang=EN-US></span></b>
                                        </p>
                                    </td>
                                </tr>
                                </thead>
                                <c:if test="${taiWanInfo.id ne null}">
                                    <c:forEach items="${taiWanInfo.taiWanInfoUserList}" var="chronicle">
                                        <tr style='mso-yfti-irow:1'>
                                            <td width=56 style='width:42.15pt;border:solid #0F0F0F 1.0pt;border-top:none;
          mso-border-top-alt:solid #0F0F0F .75pt;mso-border-alt:solid #0F0F0F .75pt;
          padding:.75pt .75pt .75pt .75pt'>
                                                <p class=MsoNormal align=center style='text-align:center'>${chronicle.dicUser.empName}</p>
                                            </td>
                                            <td width=47 style='width:35.45pt;border-top:none;border-left:none;
                                                    border-bottom:solid #0F0F0F 1.0pt;border-right:solid #0F0F0F 1.0pt;
                                                    mso-border-top-alt:solid #0F0F0F .75pt;mso-border-left-alt:solid #0F0F0F .75pt;
                                                    mso-border-alt:solid #0F0F0F .75pt;padding:.75pt .75pt .75pt .75pt'>
                                                <p class=MsoNormal align=center style='text-align:center'>${chronicle.dicUser.jsonObject.sexStr}</p>
                                            </td>
                                            <td width=85 style='width:63.75pt;border-top:none;border-left:none;
                                                    border-bottom:solid #0F0F0F 1.0pt;border-right:solid #0F0F0F 1.0pt;
                                                    mso-border-top-alt:solid #0F0F0F .75pt;mso-border-left-alt:solid #0F0F0F .75pt;
                                                    mso-border-alt:solid #0F0F0F .75pt;padding:.75pt .75pt .75pt .75pt'>
                                                <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>${chronicle.dicUser.jsonObject.birthdayStr}</span></p>
                                            </td>
                                            <td width=136 style='width:101.65pt;border-top:none;border-left:none;
                                                    border-bottom:solid #0F0F0F 1.0pt;border-right:solid #0F0F0F 1.0pt;
                                                    mso-border-top-alt:solid #0F0F0F .75pt;mso-border-left-alt:solid #0F0F0F .75pt;
                                                    mso-border-alt:solid #0F0F0F .75pt;padding:.75pt .75pt .75pt .75pt'>
                                                <p class=MsoNormal><span lang=EN-US>${chronicle.dicDept.deptName}</span></p>
                                            </td>
                                            <td width=72 style='width:54.3pt;border-top:none;border-left:none;border-bottom:
                                                    solid #0F0F0F 1.0pt;border-right:solid #0F0F0F 1.0pt;mso-border-top-alt:solid #0F0F0F .75pt;
                                                    mso-border-left-alt:solid #0F0F0F .75pt;mso-border-alt:solid #0F0F0F .75pt;
                                                    padding:.75pt .75pt .75pt .75pt'>
                                                <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>${chronicle.degree}</span></p>
                                            </td>
                                            <td width=85 style='width:63.8pt;border-top:none;border-left:none;border-bottom:
                                                    solid #0F0F0F 1.0pt;border-right:solid #0F0F0F 1.0pt;mso-border-top-alt:solid #0F0F0F .75pt;
                                                    mso-border-left-alt:solid #0F0F0F .75pt;mso-border-alt:solid #0F0F0F .75pt;
                                                    padding:.75pt .75pt .75pt .75pt'>
                                                <p class=MsoNormal align=center style='text-align:center'>${chronicle.dicUser.birthplace}</p>
                                            </td>
                                            <td width=71 style='width:53.4pt;border-top:none;border-left:none;border-bottom:
                                                    solid #0F0F0F 1.0pt;border-right:solid #0F0F0F 1.0pt;mso-border-top-alt:solid #0F0F0F .75pt;
                                                    mso-border-left-alt:solid #0F0F0F .75pt;mso-border-alt:solid #0F0F0F .75pt;
                                                    padding:.75pt .75pt .75pt .75pt'>
                                                <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>${chronicle.notes}</span></p>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            $(document).ready(function () {
                var signArray = [];
                signArray.push('<font style="font-size: 10.5pt;font-family:仿宋, Arial, Helvetica, sans-serif; ">');
                signArray.push('<span>&nbsp;</span>');
                signArray.push('</font>');
                $('.param').find('p').prepend(signArray.join('')).css('text-indent','32pt');
            })
        </script>

    </div>
</div>
