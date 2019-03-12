<%--
  Created by IntelliJ IDEA.
  User: yx
  Date: 2018/11/5
  Time: 11:00
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


<div id="model" lang=ZH-CN style='text-justify-trim:punctuation' class="page">
    <div class="WordSection1" style='layout-grid:15.6pt'>
            <div style="width: 10%;float: left;">
                <div style="padding-left: 5px;">
                    <div style="float: left;margin-top: 280px;height: 320px;font-size: 11pt;font-family: 宋体;color: red;line-height: 118px;width: 15px;">
                        装订线
                    </div>
                    <div style="width: 6px;float: left;margin-top: 325px;height: 310px;color: red;">
                        ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆
                    </div>
                </div>
            </div>

            <div style="width: 90%;float: right;">
                <div style="width: 555px;">
                    <p align="center">
                        <span style='font-size:40.0pt;font-family:宋体;color:red;'>呈 &nbsp;批 &nbsp;件</span>
                        <span id="qrcode"></span>
                        <img id="qrcode-img" style="position: absolute; padding-left: 20px; margin-top: -15px">
                    </p>
                </div>
                <table border=1 cellspacing=0 cellpadding=0 style='border-collapse:collapse;border:none'>
                    <tr style='height:254.05pt'>
                        <td width=552 colspan=2 valign=top style='width:414.3pt;border-top:solid red 1.5pt;border-left:none;
                                        border-bottom:solid red 1.5pt;border-right:none;padding:10px 5.4pt 0cm 5.4pt;height:254.05pt'>
                            <p class=MsoNormal><span style='font-size:14.0pt;font-family:宋体;color:red'>领导同志批示：</span></p>
                        </td>
                    </tr>
                    <tr style='height:125.95pt'>
                        <td width=302 rowspan=2 valign=top style='width:8.0cm;border-top:none;border-left:none;
                                border-bottom:solid red 1.5pt;border-right:solid red 1.5pt;padding:10px 5.4pt 0cm 5.4pt;height:125.95pt'>
                            <p class=MsoNormal>
                                <span style='font-size:14.0pt;color:red;font-family:宋体;'>办公厅专委会领导批示：</span>
                            </p>
                        </td>
                        <td width=250 valign=top style='width:187.5pt;border:none;border-bottom:solid red 1.5pt;
                                        padding:10px 5.4pt 0cm 5.4pt;height:125.95pt'>
                            <p class=MsoNormal>
                                <span style='font-size:14.0pt;font-family:宋体;color:red'>会签意见：</span>
                            </p>
                        </td>
                    </tr>
                    <tr style='height:125.85pt'>
                        <td width=250 valign=top style='width:187.5pt;border:none;border-bottom:solid red 1.5pt;
                                        padding:10px 5.4pt 0cm 5.4pt;height:125.85pt'>
                            <p class=MsoNormal>
                                <span style='font-size:14.0pt;font-family:宋体;color:red;'>室局负责人意见：</span>
                            </p>
                        </td>
                    </tr>
                    <tr style='height:40.9pt'>
                        <td width=552 colspan=2 valign=top style='width:414.3pt;border:none;
                                        border-bottom:solid red 1.5pt;padding:0cm 5.4pt 0cm 5.4pt;height:40.9pt;line-height: 34pt;'>
                            <p class=MsoNormal>
                                <span style='font-size:14.0pt;font-family:宋体;color:red;'>标 题：</span>
                                <span id="spanTitleNei" style='font-size:14.0pt;font-family:宋体;'>${title}</span>
                            </p>
                        </td>
                    </tr>
                    <tr style='height:40.3pt'>
                        <td width=552 colspan=2 valign=top style='width:414.3pt;border:none;
                                        border-bottom:solid red 1.5pt;padding:0cm 5.4pt 0cm 5.4pt;height:40.3pt;line-height: 34pt;'>
                            <p class=MsoNormal>
                            <div style="width: 25%;float: left;height: 46px;">
                                <span style='font-size:14.0pt;font-family:宋体;color:red;'>部门：</span>
                                <span id="spanOrg" style='font-size:14.0pt;font-family:宋体;'>${orgName}</span>
                            </div>
                            <div style="width: 25%;float: left;height: 46px;">
                                <span style='font-size:14.0pt;font-family:宋体;color:red;'>拟稿人：</span>
                                <span id="spanRep" style='font-size:14.0pt;font-family:宋体;'>${reporter}</span>
                            </div>
                            <div style="width: 25%;float: left;height: 46px;">
                                <span style='font-size:14.0pt;font-family:宋体;color:red;'>联系电话：</span>
                                <span id="spanTelNei" style='font-size:14.0pt;font-family:宋体;'>${tel}</span>
                            </div>
                            <div style="width: 25%;float: left;height: 46px;">
                                <span style='font-size:14.0pt;font-family:宋体;color:red;'>核稿人：</span>
                                <span id="spanCheck" style='font-size:14.0pt;font-family:宋体;'>${checker}</span>
                            </div>
                            </p>
                        </td>
                    </tr>
                </table>
                <p align="right" style="width: 430pt;margin-top: 5px;padding-right: 0px;">
                    <span style='font-size:14.0pt;font-family:宋体;color:red'>政协全国委员会办公厅制</span>
                </p>
            </div>
        </div>
</div>
