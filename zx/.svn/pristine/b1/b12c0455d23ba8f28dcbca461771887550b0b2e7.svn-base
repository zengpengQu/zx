package com.taiji.frame.common.util;

public class StringUtil {

    /**
     * 获取字符串数组的最大值
     * @param str
     * @return
     */
    public static String getMaxString(String[] str){
        for (int i = 0; i < str.length; i++) {
            for (int j = i+1; j < str.length; j++) {
                //对象排序用camparTo方法
                if(str[i].compareTo(str[j])>0){
                    String t = str[i];
                    str[i] = str[j];
                    str[j] = t;
                }
            }
        }
        String max = str[str.length - 1];
        return max;
    }

    /**
     * 十六进制转十进制
     * @param hex
     * @return
     */
    public static int hexStringToAlgorism(String hex) {
        hex = hex.toUpperCase();
        int max = hex.length();
        int result = 0;
        for (int i = max; i > 0; i--) {
            char c = hex.charAt(i - 1);
            int algorism = 0;
            if (c >= '0' && c <= '9') {
                algorism = c - '0';
            } else {
                algorism = c - 55;
            }
            result += Math.pow(16, max - i) * algorism;
        }
        return result;
    }

    /**
     * 十进制转十六进制
     * @param algorism
     * @return
     */
    public static String algorismToHEXString(int algorism) {
        String result = "";
        result = Integer.toHexString(algorism);

        if (result.length() % 2 == 1) {
            result = "0" + result;

        }
        result = result.toUpperCase();

        return result;
    }

    /**
     * 获取字符串前半部分
     * @param str
     * @return
     */
    public static String prefixStr(String str){
        String prefixStr = str.substring(0, str.length() - 1);
        return prefixStr;
    }

    /**
     * 获取字符串的最后一个字符
     * @param str
     * @return
     */
    public static String subffixStr(String str){
        String subffixStr = str.substring(str.length() - 1, str.length());
        return subffixStr;
    }
}
