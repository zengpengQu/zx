package com.taiji.frame.servlet;

import com.alibaba.fastjson.JSONObject;
import com.taiji.frame.common.ConstantV;
import com.westone.middleware.toolkit.trustService.TrustServiceException;
import com.westone.middleware.toolkit.trustService.authorization.AuthentificationClient;
import com.westone.middleware.toolkit.trustService.authorization.AuthentificationResponse;
import com.westone.middleware.toolkit.trustService.data.TrustServiceMessage;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/*
 * 验证票据
 */
public class AuthentificationServlet extends HttpServlet {

    private String identityVerifyServiceEndpoint = ConstantV.identityVerifyServiceHttpEndpoint;
    private String identityVerifyServiceAppId = ConstantV.identityVerifyServiceAppId;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        //super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {


        JSONObject result = new JSONObject();
        String errorinfo = "errorinfodddd";

        HttpSession session = req.getSession();
        String remoteAddress = req.getParameter("url");
        String objectNoString = req.getParameter("objectid");
        String subjectNoString = req.getParameter("subjectid");
        String appIdString = req.getParameter("appid");

        AuthentificationClient aClient = new AuthentificationClient(remoteAddress, appIdString);
        TrustServiceMessage tsm = aClient.authenticate(subjectNoString, objectNoString);
        AuthentificationResponse auResponse;
        try {
            auResponse = new AuthentificationResponse(tsm.getSignatureContent());

            if (auResponse.getContent().getResult().getStatus() == 0) {
                System.out.println(auResponse.getContent().getResult().getPolicy());
                errorinfo = auResponse.getContent().getResult().getPolicy().toString();

            } else {
                System.out.println(auResponse.getContent().getResult().getFailReason());
                errorinfo = auResponse.getContent().getResult().getFailReason();
            }

//			if(auResponse.getContent().getPolicy()!=null){
//				System.out.println(auResponse.getContent().getPolicy());
//				errorinfo=auResponse.getContent().getPolicy().toString();
//			}else if(auResponse.getContent().getResult()!=null){
//				System.out.println(auResponse.getContent().getResult());
//				errorinfo=auResponse.getContent().getResult().toString();
//			}
        } catch (TrustServiceException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }


        session.setAttribute("errorinfo", errorinfo);
        resp.sendRedirect("authentification.jsp");
//        resp.setContentType("text/html;charset=UTF-8");
//		resp.getWriter().write(result.toString());
        //   resp.getWriter().write(errorinfo);


    }


}
