package com.taiji.frame.common.util;

import org.apache.commons.lang.StringUtils;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.*;

import static com.taiji.frame.common.util.FileUtil.encodeContent;

/**
 * Created by BT4900 on 2016/12/6.
 */
public class OtherUtil {

    /**
     * 将字符串（"1，3，4"）转换成long集合，便于查询表数据
     * @param reqIds
     * @return List<Long>
     */
    public static List<Long> strToLongList(String reqIds){
        List<Long> longList = new ArrayList<>();
        try {
            if(null != reqIds && ""!= reqIds) {
                String[] strArray = reqIds.split(",");
                List<String> strList = Arrays.asList(strArray);
                if (strList != null && strList.size() > 0) {
                }
                for (String str : strList) {
                    if (null != str && !"".equals(str)) {
                        longList.add(Long.valueOf(str));
                    }
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        return longList;
    }

    /**
     * 将字符串（"1,2,3"）转换成String集合，便于查询表数据
     * */
    public static List<String> strToStringList(String str) {

        List<String> stringList = new ArrayList<>();

        if (StringUtils.isNotEmpty(str)) {

            String[] strArray = str.split(",");
            stringList = Arrays.asList(strArray);
        }
        return stringList;
    }


    /**
    *  将list 转换成已 concatChar 连接的字符串
     *  @param list
     *  @param concatChar 例：','  ...
     *  @return String
    */
    public static String listToString(List<String> list,String concatChar){
        String returnStr = "";
        if(null != list && list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                String str = list.get(i);
                str = str.trim();
                if (0 == i) {
                    returnStr += str;
                } else {
                    returnStr += concatChar + str;
                }
            }
        }
        return returnStr;
    }

    /**
     *  将list 转换成已 concatChar 连接的字符串
     *  @param list
     *  @param concatChar 例：','  ...
     *  @return String
     */
    public static String listLongToString(List<Long> list,String concatChar){
        String returnStr = "";
        if(null != list && list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                String str = list.get(i)+"";
                str = str.trim();
                if (0 == i) {
                    returnStr += str;
                } else {
                    returnStr += concatChar + str;
                }
            }
        }
        return returnStr;
    }

    /**
     * 获取两个逗号隔开字符串的交集
     */
    public static List<String> stringIntersect(String str1,String str2){
        List<String> intersectStr = new ArrayList<>();
        if(StringUtils.isNotEmpty(str1) && StringUtils.isNotEmpty(str2)){
            Map<String,Object> map = new HashMap<>();
            String [] str1Array = str1.split(",");
            for (String str : str1Array) {
                if(map.containsKey(str)){
                    map.put(str,true);
                }else{
                    map.put(str,false);
                }
            }
            
            String [] str2Array = str2.split(",");
            for (String str : str2Array) {
                if(map.containsKey(str)){
                    map.put(str,true);
                }else{
                    map.put(str,false);
                }
            }

            for (String s : map.keySet()) {
                if((boolean)map.get(s)){
                    intersectStr.add(s);
                }
            }
        }
        return intersectStr;
    }


    /**
     * 获取字符串--字符的交集
     */
    public static String stringCharIntersect(String str1,String str2){
        String outStr = "";
        if(StringUtils.isNotEmpty(str1) && StringUtils.isNotEmpty(str2)){
            for(int i= 0;i<str1.length();i++){
                String str1Char = str1.substring(i,i+1);
                if(str2.indexOf(str1Char) > -1){
                    outStr += str1Char;
                }
            }
        }
        return outStr;
    }

//    public static void main(String [] ags){
//        List<String> str = stringIntersect("1,2,3,4","2,4,9");
//        System.out.println(str);
//        System.out.println(stringCharIntersect("1234567","1357"));
//    }

    /**
     * 格式化时间
     */
    public static String getTimeFormat(String time){
        if(StringUtils.isNotEmpty(time)){
            if(time.contains(":")){
                String [] timeArray = time.split(":");
                String hh = timeArray[0];
                if(hh.length() > 0 && hh.length() <2){
                    time = "0"+time;
                }else if(hh.length() <1 ){
                    time = "00"+time;
                }
            };
            if(time.length() == 5){
                time = time+":00";
            }
        }
        return time;
    }

    /**
     * 设置输入流参数
     * @return
     */
    public static ServletOutputStream getOutputStream(String fileName, HttpServletRequest request, HttpServletResponse response) throws IOException {
        String header = request.getHeader("User-Agent");
        if (header.toLowerCase().indexOf("firefox") > 0) {
            //firefox
            fileName = new String(fileName.getBytes("UTF-8"), "ISO8859-1");//此处和encodeContent(str)是相反的
        } else if (header.toUpperCase().indexOf("MSIE") > 0) {
            //ie
            fileName = URLEncoder.encode(fileName, "UTF-8");
        } else {
            //主要针对Chrome等浏览器， IE7、8也适用
            fileName = URLEncoder.encode(fileName, "UTF-8");
            fileName = encodeContent(fileName);//比IE多一步
        }
        response.reset();
        response.setContentType("application/vnd.ms-excel;charset=UTF-8");//不同类型的文件对应不同的MIME类型
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
        return response.getOutputStream();
    }

}
