package com.taiji.frame.servlet;

import com.alibaba.fastjson.JSONObject;
import com.taiji.frame.common.ConstantV;
import com.westone.middleware.toolkit.trustService.identity.IdentityVerifyServiceClient_httpPost;
import com.westone.middleware.toolkit.trustService.identity.VerifyIdTRet;
import com.westone.middleware.toolkit.trustService.identity.VerifyIdentityTicketResult;
import com.westone.middleware.toolkit.trustService.identity.VerifyIdentityTicketResult.Userinfo;
import com.westone.utilities.XmlUtilities;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
/*
 * 验证票据
 */
public class IdentityTicketHttpServlet extends HttpServlet {

	private String identityVerifyServiceEndpoint=ConstantV.identityVerifyServiceHttpEndpoint;
	private String identityVerifyServiceAppId= ConstantV.identityVerifyServiceAppId;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//super.doGet(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//super.doPost(req, resp);
//			IdentityVerifyServiceClient_httpPost ivsc=new IdentityVerifyServiceClient_httpPost(identityVerifyServiceEndpoint);
//			verifyIdTRet=ivsc.VerifyIdentityTicket(challenge, signAndToken, identityVerifyServiceAppId);
		System.out.println("httppost");
		JSONObject result=new JSONObject();
		String errorinfo="";
		VerifyIdTRet verifyIdTRet=null;
		HttpSession session = req.getSession();
		String ticket = req.getParameter("signAndToken");
		String challenge = (String) session.getAttribute("challenge");
		IdentityVerifyServiceClient_httpPost ivsc=new IdentityVerifyServiceClient_httpPost(identityVerifyServiceEndpoint);
		verifyIdTRet=ivsc.VerifyIdentityTicket(challenge, ticket, identityVerifyServiceAppId);
		if(verifyIdTRet==null){
			result.put("code", "-1");
			result.put("message", "验证失败");
			
        	System.out.println("验证失败");
        	errorinfo="验证失败";
        }
        if(verifyIdTRet.getResult()==null){
        	result.put("code", "-1");
			result.put("message", "验证失败");
        	System.out.println("验证失败");
        	errorinfo="验证失败";
        }
        VerifyIdentityTicketResult vitr;
        if(verifyIdTRet.getResult().length()>1){
        	//String result=new String(Base64.decode(verifyIdTRet.getResult()));
//    		System.out.println(result);
    		vitr=XmlUtilities.deserialize(VerifyIdentityTicketResult.class, verifyIdTRet.getResult());
//    		System.out.println(vitr);    
    		if(vitr.getResult()==0){
    			result.put("code", "0");
    			result.put("message", "验证成功");
    			 Userinfo userinfo=vitr.getUserinfo();
    			 session.setAttribute("userinfo", userinfo);
    			 errorinfo=userinfo.toString()+"\n";
    			 errorinfo+=vitr.toString();
              
    		}else{
    			result.put("code", "-1");
    			result.put("message", "验证失败");
    			System.out.println(vitr.getError());
    			errorinfo=vitr.getError();
    			
    		}
            
        }else{
        	result.put("code", "-1");
			result.put("message", "验证失败");
        	System.out.println("验证失败");
        	errorinfo="验证失败";
        }
        
        session.setAttribute("errorinfo", errorinfo);
        
        resp.setContentType("text/html;charset=UTF-8");
		resp.getWriter().write(result.toString());
     //   resp.getWriter().write(errorinfo);
        
       
	
	
		
	}
	
	

}
