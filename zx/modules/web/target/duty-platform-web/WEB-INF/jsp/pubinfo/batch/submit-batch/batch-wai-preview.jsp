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


<div id="model-wai" class="page" style="text-justify-trim:punctuation">
    <div class=WordSection1 style='layout-grid:15.6pt;'>
        <p class="hide" id="id">${id}</p>
        <div>
            <p class=MsoTitle style='line-height:150%'>
                <span style='font-size:22.0pt;
                line-height:150%;font-family:宋体;color: #ff0000;'>收文办理专用单</span>
                <span id="qrcode"></span>
                <img id="qrcode-img" src="" style="position: absolute; padding-left: 95px; margin-top: -46px;">
            </p>
        </div>

        <div align=center>

            <table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
                   style='border-collapse:collapse;border:none'>
                <tr style='page-break-inside:avoid;height:292.6pt'>
                    <td width=95 style='width:70.9pt;border:solid red 1.5pt;border-left:none;
                        padding:0cm 5.4pt 0cm 5.4pt;layout-flow:vertical-ideographic;height:292.6pt'>
                        <p class=MsoNormal align=center style='margin-top:0cm;margin-right:5.65pt;
                          margin-bottom:0cm;margin-left:5.65pt;margin-bottom:.0001pt;text-align:center;
                          writing-mode: vertical-lr;'><span style='font-size:14.0pt;line-height:100%;font-family:楷体;color:red'>领 导 同 志 批 示</span></p>
                    </td>
                    <td width=496 style='width:371.95pt;border-top:solid red 1.5pt;border-left:none;
                        border-bottom:solid red 1.5pt;border-right:none;padding:0cm 5.4pt 0cm 5.4pt;height:292.6pt'>
                        <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>
                    </td>
                </tr>
                <tr style='height:148.2pt'>
                    <td width=95 style='width:70.9pt;border-top:none;border-left:none;border-bottom:solid red 1.5pt;
                        border-right:solid red 1.5pt;padding:0cm 5.4pt 0cm 5.4pt; height:148.2pt'>
                        <p class=MsoNormal align=center style='text-align:center'><span
                                style='font-size:14.0pt;font-family:楷体;color:red'>办理建议</span></p>
                    </td>
                    <td width=496 style='width:371.95pt;border:none;border-bottom:solid red 1.5pt;padding:0cm 5.4pt 0cm 5.4pt;height:148.2pt'>
                        <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>
                    </td>
                </tr>

                <tr style='height:57.25pt'>
                    <td width=590 colspan=2 style='width:442.85pt;border:none;border-bottom:solid red 1.5pt;
                                  padding:0cm 5.4pt 0cm 5.4pt;height:57.25pt'>
                        <p class=MsoNormal>
                            <span style='font-size:14.0pt;font-family:楷体;color:red'>承办部门：<span lang=EN-US style='font-size:14.0pt;font-family:楷体;color:black'>${deptName}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                                <span lang=EN-US style='width: 50%;float: right; font-size:14.0pt;font-family:楷体;color:red'>承办人（处室）：
                                    <span lang=EN-US style='font-size:14.0pt;font-family:楷体;color:black'>${contractor}</span>
                                </span>
                            </span>
                        </p>
                        <p class=MsoNormal>
                            <span style='font-size:14.0pt;font-family:楷体;color:red'>联系电话：<span lang=EN-US style='font-size:14.0pt;font-family:楷体;color:black'>${tel}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                                <span lang=EN-US style='width: 50%;float: right; font-size:14.0pt;font-family:楷体;color:red'>审核人（室局）：
                                    <span lang=EN-US style='font-size:14.0pt;font-family:楷体;color:black'>${approver}</span>
                                </span>
                            </span>
                        </p>
                    </td>
                </tr>

                <tr style='height:25.15pt'>
                    <td width=590 colspan=2
                        style='width:442.85pt;border:none;padding:0cm 5.4pt 0cm 5.4pt;height:25.15pt'>
                        <p class=MsoNormal align=right style='text-align:right'>
                            <span lang=EN-US style='font-size:15.0pt;font-family:仿宋;color:red'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                            <span style='font-size:15.0pt;font-family:楷体;color:red'>政协全国委员会办公厅制</span>
                        </p>
                    </td>
                </tr>
            </table>
        </div>
        <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>
    </div>
</div>


