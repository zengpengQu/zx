package com.taiji.frame.servlet;

import com.taiji.frame.common.ConstantV;
import com.westone.middleware.toolkit.trustService.TrustServiceException;
import com.westone.middleware.toolkit.trustService.timestamp.Timestamp;
import com.westone.middleware.toolkit.trustService.timestamp.TimestampClient;
import com.westone.middleware.toolkit.trustService.timestamp.TimestampVerifyResult;
import com.westone.security.cryptography.crypto.digests.SHA1Digest;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
/*
 * 验证票据
 */
public class TimestampServlet extends HttpServlet {

	private String identityVerifyServiceEndpoint= ConstantV.identityVerifyServiceHttpEndpoint;
	private String identityVerifyServiceAppId=ConstantV.identityVerifyServiceAppId;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//super.doGet(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		
		String errorinfo="";
		HttpSession session = req.getSession();
		String url = req.getParameter("url");
		String msg = req.getParameter("message");
		
		
		String timestampresult="timestampresult";
		String verifyresult="verifyresult";
		String errorverifyresult="verifyresult";
	
		
		////////////////////////////////////////////////////////////////////
		String hashAlgorithm = "1.3.14.3.2.26";
		byte[] messge = msg.getBytes("utf-8");
/*
 * 摘要
 */
		SHA1Digest digest = new SHA1Digest();
		digest.reset();
		byte[] hashedMsg = new byte[digest.getDigestSize()];
		digest.update(messge, 0, messge.length);
		digest.doFinal(hashedMsg, 0);
		
		
		TimestampClient client = new TimestampClient(url);
		/*
		 * 申请时间戳
		 */
		Timestamp timestamp = client.request(hashAlgorithm, hashedMsg, false);
		System.out.println(timestamp.toString());
		timestampresult=timestamp.toString();
		
		/*
		 * 验证时间戳
		 */
		byte[] wrongMsg="123".getBytes();
		TimestampVerifyResult result=null;
		try {
			result = client.verify(hashedMsg, timestamp.getTimestampToken());
			verifyresult=result.toString();
		} catch (TrustServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		TimestampVerifyResult wrongResult=null;
		try {
			wrongResult = client.verify(wrongMsg, timestamp.getTimestampToken());
			errorverifyresult=wrongResult.toString();
		} catch (TrustServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(result.getStatusCode());
		System.out.println(result.getErrorString());
		System.out.println(wrongResult.getStatusCode());
		System.out.println(wrongResult.getErrorString());
		
		////////////////////////////////////////////////////////////////////
		
        
        session.setAttribute("timestampresult", timestampresult);
        session.setAttribute("verifyresult", verifyresult);
        session.setAttribute("errorverifyresult", errorverifyresult);
        
        resp.setContentType("text/html;charset=UTF-8");
        resp.sendRedirect("timestamp.jsp");
     //   resp.getWriter().write(errorinfo);
        
       
	
	
		
	}
	
	

}
