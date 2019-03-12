package com.taiji.frame.common.constants;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * @author yx
 * @date 2018/11/29
 *
 * 文件上传路径配置类
 */
public class UploadConstant {
    public static String bulletinBoard = "";
    public static String businessPassport = "";
    public static String comeReception = "";
    public static String comeReport = "";
    public static String document = "";
    public static String dutyFile = "";
    public static String feedBack = "";
    public static String fileManage = "";
    public static String hkMacao = "";
    public static String preparement = "";
    public static String privatePassport = "";
    public static String taiwanCard = "";
    public static String taiwanParty = "";
    public static String telegraphManage = "";
    public static String tempAffairs = "";

    public static String uploadBaseDir = "";

    static {
        Properties p = new Properties();
        InputStream in;
        in = UploadConstant.class.getClassLoader().getResourceAsStream("upload.properties");
        try {
            p.load(in);
            bulletinBoard = p.getProperty("bulletinBoard");
            businessPassport = p.getProperty("businessPassport");
            comeReception = p.getProperty("comeReception");
            comeReport = p.getProperty("comeReport");
            document = p.getProperty("document");
            dutyFile = p.getProperty("dutyFile");
            feedBack = p.getProperty("feedBack");
            fileManage = p.getProperty("fileManage");
            hkMacao = p.getProperty("hkMacao");
            preparement = p.getProperty("preparement");
            privatePassport = p.getProperty("privatePassport");
            taiwanCard = p.getProperty("taiwanCard");
            taiwanParty = p.getProperty("taiwanParty");
            telegraphManage = p.getProperty("telegraphManage");
            tempAffairs = p.getProperty("tempAffairs");
            uploadBaseDir = p.getProperty("uploadBaseDir");

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
