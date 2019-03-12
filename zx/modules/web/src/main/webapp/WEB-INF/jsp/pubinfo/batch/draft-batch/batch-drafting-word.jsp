<%--
  Created by IntelliJ IDEA.
  User: pengyx
  Date: 2018/7/4
  Time: 17:43
  新增/编辑值班日报
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    pageContext.setAttribute("basePath", basePath);
%>
<title>履职支撑平台</title>


<div bgcolor="#FFFFCC" lang=ZH-CN style='text-justify-trim:punctuation' class="page" contenteditable="true">

    <div class=WordSection1 style='layout-grid:15.6pt'>
        <div style="margin-top: 2%"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group" style="margin-top: 20px;margin-bottom: 30px">
                    <h1 align="center" style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">呈批件模板</h1>
                </div>
            </div>
        </div>

        <div id="StrId">
            <h1 style="font-size: 32px; font-weight: bold; border-bottom: 0px solid rgb(204, 204, 204); padding: 0px 4px 0px 0px; text-align: center; margin: 0px 0px 20px;">
                <span style="font-family: 宋体, SimSun; font-size: 24px;">&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;关于xxxxxxxx的请示</span>
            </h1>
            <p>
                <span style="font-family: 宋体, SimSun; font-size: 20px;">尊敬的领导xxx：</span>
            </p>
            <p>
                <span style="font-family: 宋体, SimSun; font-size: 20px;"><br/></span>
            </p>
            <p>
                <span style="font-family: 宋体, SimSun; font-size: 20px;">&nbsp; &nbsp;xxx部门有关于xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx</span>
            </p>
            <p>
                <span style="font-family: 宋体, SimSun; font-size: 20px;">xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx</span>
            </p>
            <p>
                <span style="font-family: 宋体, SimSun; font-size: 20px;">xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx,需要请示领导意见。</span>
            </p>
            <p>
                <span style="font-family: 宋体, SimSun; font-size: 20px;"><br/></span>
            </p>
            <p>
                <span style="font-family: 宋体, SimSun; font-size: 20px;">&nbsp; &nbsp;妥否，请批示。<br/></span>
            </p>
            <p style="text-align: left;">
                <br/>
            </p>
            <p style="text-align: left;">
                <span style="font-family: 宋体, SimSun; font-size: 20px;">&nbsp; &nbsp;附件：1.xxxxxxxxxxxxxxxxxxxxxxxxxx<br/></span>
            </p>
            <p style="text-align: left;">
                <span style="font-family: 宋体, SimSun; font-size: 20px;">&nbsp; &nbsp; &nbsp; &nbsp;2.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx</span><br/>
            </p>
            <p>
                <br/>
            </p>
        </div>
    </div>
</div>

