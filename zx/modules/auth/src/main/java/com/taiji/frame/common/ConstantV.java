package com.taiji.frame.common;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConstantV {

	// 需要以下参数： ip:port 应用服务器标识
	public static String identityVerifyServiceHttpEndpoint="http://192.168.1.100:8088";
	public static String identityVerifyServiceAppId="1111";
	public static String identityVerifyServiceWsEndpoint_challenge="http://192.168.1.100:8088/verify/verify.dll";
	public static String identityVerifyServiceWsEndpoint_verifyTicket="http://192.168.1.100:8088/verify/verify.dll";
	public static byte[] cert;
	public static byte[] identityCert;
	static{
		Properties p=new Properties();
		InputStream in;		
		in=ConstantV.class.getClassLoader().getResourceAsStream("config.properties");
		try {
			p.load(in);
			identityVerifyServiceAppId=p.getProperty("identityVerifyServiceAppId");
			identityVerifyServiceHttpEndpoint=p.getProperty("identityVerifyServiceHpEndpoint");
			identityVerifyServiceWsEndpoint_challenge=p.getProperty("identityVerifyServiceWsEndpoint_challenge");
			identityVerifyServiceWsEndpoint_verifyTicket=p.getProperty("identityVerifyServiceWsEndpoint_verifyticket");
			
			in.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}	

}
