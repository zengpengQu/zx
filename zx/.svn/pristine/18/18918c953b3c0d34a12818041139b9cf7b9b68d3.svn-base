package com.taiji.frame.servlet;

import com.alibaba.fastjson.JSONObject;
import com.taiji.frame.common.ConstantV;
import com.westone.middleware.toolkit.trustService.identity.IdentityVerifyServiceClient;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
/*
 * 获取随机数
 */
public class IdentityChallengeWsServlet extends HttpServlet {

	private String identityVerifyServiceEndpoint= ConstantV.identityVerifyServiceWsEndpoint_challenge;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doGet(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		System.out.println("webservice");
		JSONObject result = new JSONObject();
		HttpSession session = req.getSession();
		//httppostclient
	/*	IdentityVerifyServiceClient_httpPost ivsc=new IdentityVerifyServiceClient_httpPost(identityVerifyServiceEndpoint);*/
		//String challenge=ivsc.generatorChallenge();
		
		// webservice client
		 IdentityVerifyServiceClient ivsc=new IdentityVerifyServiceClient(identityVerifyServiceEndpoint);
			String challenge=ivsc.generatorChallenge();
		 
//	String challenge = userService.getIdentityVerifyChallenge();
		System.out.println(challenge);
		if(challenge==null){
			result.put("code", -1);
			result.put("message", "申请随机数失败");
					}else if(!challenge.equals("")){
			session.setAttribute("challenge", challenge);
			result.put("code", 0);
			result.put("message", challenge);

		}else{
			result.put("code", -1);
			result.put("message", "申请随机数失败");

		}
		
		try {
			resp.setContentType("text/html;charset=UTF-8");
			resp.getWriter().write(result.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	
}
