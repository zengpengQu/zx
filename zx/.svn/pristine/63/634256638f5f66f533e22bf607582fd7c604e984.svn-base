package com.taiji.frame.service.inspection.place;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.inspection.place.DateType;
import com.taiji.frame.model.entity.inspection.place.District;
import com.taiji.frame.model.entity.inspection.place.Place;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.RegionUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.io.OutputStream;
import java.util.*;

/**
 * @author SY
 *
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class DateTypeService extends BaseDAO<DateType> {

    /**
     * 统计查询 根据不同的排序规则
     */
    public void load(Carrier<DateType> carrier, Map<String, Object> map) {
        StringBuffer hql = new StringBuffer();
        String sort =(String) map.get("sortName");
        carrier.setSidx(sort);
        hql.append(" from  DateType dt where 1 = 1");
        hql.append(" and dt.placeId.reportState != '0' ");
        hql.append(" and dt.delFlag = '0' ");
        hql.append(" and dt.placeId.delFlag = '0' ");

        find(carrier,hql.toString(),map);
    }

    /**
     * 冲突查询
     */
    public void clashLoad(Carrier<DateType> carrier, Map<String, Object> map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from  DateType dt where 1 = 1");
        String type = (String) map.get("sortName");
        if(type==null){
            hql.append(" and dt.isClash = '1'");
        }
        if("placeTime".equals(type)){
        //同时间地点
            hql.append(" and dt.isClash = '1'");
        }
        if ("monthTime".equals(type)){
        //一月三次以上
            hql.append(" and dt.isClashDay = '2'");
        }
        if("yearTime".equals(type)){
        //一年6次以上
            hql.append(" and dt.isClashYear = '3'");
        }
        //hql.append(" and dt.placeId.reportState != '0' ");
        hql.append(" and dt.placeId.delFlag = '0' ");
        hql.append(" and dt.delFlag = '0' ");
        carrier.setSidx("placeId.id,placeId.title,placeId.actTypeId");
        find(carrier,hql.toString(),map);
    }


    /**
     * 时间地点分布列表，一年度 月份统计
     */
    public List<HashMap<String,String>> datePlace(List<District> districtList,String dateYear) {
        StringBuffer hql1 = new StringBuffer();
        List<HashMap<String,String>> hashMapList = new ArrayList<>();
        for (int i = 0 ;i<districtList.size();i++) {
            HashMap<String,String> hashMap = new HashMap<>();
            //得到时间集合（年月）
            String Str = "select to_char(dt.beginTime,'yyyy-mm')from  DateType dt where dt.place.id = '"+districtList.get(i).getId()+"'";
            Str+=" and dt.placeId.reportState != '0' ";
            Str+=" and dt.placeId.nowTime = '"+dateYear+"'";
            Str+=" and dt.placeId.delFlag = '0' ";
            Str+=" and dt.delFlag = '0'";
            Str+=" group by to_char(dt.beginTime,'yyyy-mm'),dt.place.id ";
            //得到每月活动次数
            String Str2 = "select count(dt.place.id) from  DateType dt where dt.place.id = '"+districtList.get(i).getId()+"'";
            Str2+=" and dt.placeId.reportState != '0' ";
            Str2+=" and dt.placeId.nowTime = '"+dateYear+"'";
            Str2+=" and dt.placeId.delFlag = '0' ";
            Str2+=" and dt.delFlag = '0'";
            Str2+=" group by to_char(dt.beginTime,'yyyy-mm'),dt.place.id";
            List<String> dateTypeList = find(Str);
            List<Integer> dateTypeList1 = find(Str2);
            Integer count =0;
            for(int j=0;j<dateTypeList.size();j++){
                //string 表示不同的月分（截取前 yyyy-mm） ；s：表示不同的月分（截取后 mm）
                String string = dateTypeList.get(j);
                String s ;
                if(string!=null) {
                    s = string.substring(5, string.length());
                }else {
                    s = "0001";
                }
                //每月次数
                String string1 = String.valueOf(dateTypeList1.get(j));
                //全年总数
                count += Integer.parseInt(string1);
                //put 每月的次数
                switch (s){
                    case "01":hashMap.put("yi",string1);break;
                    case "02":hashMap.put("er",string1);break;
                    case "03":hashMap.put("san",string1);break;
                    case "04":hashMap.put("si",string1);break;
                    case "05":hashMap.put("wu",string1);break;
                    case "06":hashMap.put("liu",string1);break;
                    case "07":hashMap.put("qi",string1);break;
                    case "08":hashMap.put("ba",string1);break;
                    case "09":hashMap.put("jiu",string1);break;
                    case "10":hashMap.put("shi",string1);break;
                    case "11":hashMap.put("yy",string1);break;
                    case "12":hashMap.put("ye",string1);break;
                    case "0001":hashMap.put("ding",string1);break;
                    default:  hashMap.put("res","0");break;
                }
            }
            //总数，省份，年度
            hashMap.put("count", count+"");
            hashMap.put("place",districtList.get(i).getDistrictName());
            hashMap.put("dateYear",dateYear);
            hashMapList.add(hashMap);
        }
        return hashMapList;
    }

    /**
     * 活动安排时间分表
     * dateYear 年，createTime：年月
     */
    public List<HashMap<String,String>> timePlace(String dateYear, String createTime){

        String Str = " from  DateType dt where 1=1 ";
        if(StringUtils.isNotEmpty(createTime)){
            Str+=" and to_char(dt.beginTime,'yyyy-mm') = '"+createTime+"'";
        }
        Str+=" and dt.placeId.reportState != '0' ";
        Str+=" and dt.placeId.nowTime = '"+dateYear+"'";
        Str+=" and dt.delFlag = '0'";
        Str+=" and dt.placeId.delFlag = '0' order by dt.beginTime,dt.place.id";
        List<DateType> dateTypeList = find(Str);
        return  placeListMap(dateTypeList,dateYear,-11);

    }

    /**
     * 活动安排 地区分表
     * dateYear 年， districtList：地区集合，
     */
    public List<HashMap<String,String>> placeTable(String dateYear, List<District> districtList){
        List<HashMap<String,String>> hashMapList = new ArrayList<>();
            for(int i=0;i<districtList.size();i++){
                String Str = " from  DateType dt where 1=1 ";
                Str+=" and dt.place.id = '"+districtList.get(i).getId()+"'";
                Str+=" and dt.placeId.reportState != '0' ";
                Str+=" and dt.placeId.nowTime = '"+dateYear+"'";
                Str+=" and dt.delFlag = '0'";
                Str+=" and dt.placeId.delFlag = '0' order by dt.place.id,dt.placeId.title,dt.beginTime";
                List<DateType> dateTypeList = find(Str);
                    for(int j=0;j<dateTypeList.size();j++){
                        String beginTimeStr = "",endTimeStr="";
                        DateType dateType = dateTypeList.get(j);
                        //判断开始结束时间属于 上中下旬
                        if(dateType.getBeginTime()!=null) { beginTimeStr =  DateUtil.getDateEarly(dateType.getBeginTime()); }
                        if(dateType.getEndTime()!=null){ endTimeStr = DateUtil.getDateEarly(dateType.getEndTime()); }
                        HashMap<String,String> hashMap = new HashMap<>(10);

                        String yes = "false";
                        if(j<dateTypeList.size()-1) {
                            if(dateTypeList.get(j+1).getPlaceId().getTitle().equals(dateType.getPlaceId().getTitle())){
                                yes = "true";
                            }
                        }
                        hashMap.put("titleYesStr",yes);
                        hashMap.put("dateYear",dateYear);
                        hashMap.put("title",dateType.getPlaceId().getTitle());
                        hashMap.put("deptName",dateType.getPlaceId().getDicDept().getDeptName());
                        hashMap.put("notes",dateType.getPlaceId().getNotes());
                        hashMap.put("placeId",dateType.getPlaceId().getId());
                        hashMap.put("beginTimeStr",beginTimeStr);
                        hashMap.put("endTimeStr",endTimeStr);
                        hashMap.put("place",dateType.getPlace().getDistrictName());
                        hashMap.put("i",i+"");
                        hashMapList.add(hashMap);
                    }
            }
       return hashMapList;
    }

    /**
     * 时间地点相对集中
     * @param dateYear 年
     * @param districtList 地点集合
     * @param  createTime,月份
     * @return
     */
    public List<HashMap<String,String>> placeTimeTable(String dateYear, List<District> districtList,String createTime){
        List<HashMap<String,String>> hashMapList = new ArrayList<>();
        for(int i=0;i<districtList.size();i++){
            String Str = " from  DateType dt where 1=1 ";
            Str+=" and dt.place.id = '"+districtList.get(i).getId()+"'";
            if(StringUtils.isNotEmpty(createTime)){
                Str+=" and to_char(dt.beginTime,'yyyy-mm') = '"+createTime+"'";
            }
            Str+=" and dt.placeId.reportState != '0' ";
            Str+=" and dt.placeId.nowTime = '"+dateYear+"'";
            Str+=" and dt.delFlag = '0'";
            Str+=" and dt.placeId.delFlag = '0' order by dt.place.id,dt.beginTime";
            List<DateType> dateTypeList = find(Str);
            List<HashMap<String,String>> hashMapList1 =  placeListMap(dateTypeList,dateYear,i);
            hashMapList.addAll(hashMapList1);
        }
        return hashMapList;
    }

    /**
     * 数据封装公共方法
     * @param dateTypeList  dateType集合
     * @param dateYear   年
     * @param k  循环生成的i，代表不同的省份
     * @return
     */
    public List<HashMap<String,String>> placeListMap(List<DateType> dateTypeList ,String dateYear,int k){
        List<HashMap<String,String>> hashMapList = new ArrayList<>();
        int j = 0;
        for (int i=0;i<dateTypeList.size();i++){
            HashMap<String,String> hashMap = new HashMap<>();
            DateType dateType = dateTypeList.get(i);
            String beginTimeStr = "",endTimeStr="";
            //判断开始结束时间属于 上中下旬
            if(dateType.getBeginTime()!=null) { beginTimeStr =  DateUtil.getDateEarly(dateType.getBeginTime()); }
            if(dateType.getEndTime()!=null){ endTimeStr = DateUtil.getDateEarly(dateType.getEndTime()); }
            //得到当前开始月份并截取为 01，02
            if(dateType.getBeginTime()!=null) {
                String daTime = DateUtil.dateToString(dateType.getBeginTime(),DateUtil.FORMAT_YYYYMM);
                String ss = daTime.substring(4, daTime.length());
                //设置createTime，为1-12（月）
                switch (ss){
                    case "01":hashMap.put("createTime","1");break;
                    case "02":hashMap.put("createTime","2");break;
                    case "03":hashMap.put("createTime","3");break;
                    case "04":hashMap.put("createTime","4");break;
                    case "05":hashMap.put("createTime","5");break;
                    case "06":hashMap.put("createTime","6");break;
                    case "07":hashMap.put("createTime","7");break;
                    case "08":hashMap.put("createTime","8");break;
                    case "09":hashMap.put("createTime","9");break;
                    case "10":hashMap.put("createTime","10");break;
                    case "11":hashMap.put("createTime","11");break;
                    case "12":hashMap.put("createTime","12");break;
                    default:  hashMap.put("createTime","0");break;
                }
            }
            String yes = "false";
            if(i<dateTypeList.size()-1) {
                if(dateTypeList.get(i+1).getPlaceId().getTitle().equals(dateType.getPlaceId().getTitle())){
                    yes = "true";
                    j++;
                }
            }
            if("false".equals(yes)){
                hashMap.put("tableOrder",j+"");
                j=0;
            } else {
                hashMap.put("tableOrder","0");
            }
            hashMap.put("titleYesStr",yes);
            hashMap.put("dateYear",dateYear);
            hashMap.put("title",dateType.getPlaceId().getTitle());
            hashMap.put("deptName",dateType.getPlaceId().getDicDept().getDeptName());
            hashMap.put("notes",dateType.getPlaceId().getNotes());
            hashMap.put("placeId",dateType.getPlaceId().getId());
            hashMap.put("beginTimeStr",beginTimeStr);
            hashMap.put("endTimeStr",endTimeStr);
            hashMap.put("place",dateType.getPlace().getDistrictName());
            hashMap.put("i",k+"");
            hashMapList.add(hashMap);
        }
        return hashMapList;
    }

    /**
     * 创建EXCEL
     *@param list 除详细信息表 以外的数据集合
     *@param placeList  详细信息表  的数据
     */
    @Transactional(rollbackFor = Exception.class)
    public void createExcel(OutputStream os, String fileName,
                            List<HashMap<String,String>> list,String excelDateOns,
                            List<Place> placeList)throws IOException,IndexOutOfBoundsException {
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(fileName);
        process(workbook, sheet, list,excelDateOns,placeList);
        workbook.write(os);
    }

    /**
     * 将数据写入Excel中
     * @param list 除详细信息表 以外的数据集合
     * @param placeList  详细信息表  的数据
     */
    public void process(HSSFWorkbook workbook, HSSFSheet sheet,  List<HashMap<String,String>> list,
                        String excelDateOns,List<Place> placeList) {
        //count:表格行数，c：表示列 ，默认为5列，分布表时为15列;
        int count = 0,c=4;
        if("视察考察调研活动安排时间地点分布表".equals(excelDateOns)){
            c = 14;
            sheet.setDefaultColumnWidth(25);
        }else {
            sheet.setDefaultColumnWidth(35);
        }

        //第一行 标题样式
        CellStyle sty = workbook.createCellStyle();
        //设置标题字体格式
        Font fon = workbook.createFont();
        //设置字体样式, 设置字体大小
        fon.setFontHeightInPoints((short) 18);
        // 设置字体，是什么类型例如：宋体
        fon.setFontName("宋体");
        //加粗,居中
        fon.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        sty.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        sty.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        //表格边框
        sty.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        sty.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        sty.setBorderRight(HSSFCellStyle.BORDER_THIN);
        sty.setBorderTop(HSSFCellStyle.BORDER_THIN);
        // 将字体格式加入到style中
        sty.setFont(fon);
        Row titleRow = sheet.createRow(count);
        sheet.addMergedRegion(new CellRangeAddress(count, (short) count, 0, (short) c));
        //创建一个单元格
        Cell cell1 = titleRow.createCell(count);
        cell1.setCellStyle(sty);
        cell1.setCellValue(excelDateOns);
        count++;

        //样式对象 数据样式
        CellStyle style = workbook.createCellStyle();
        //设置标题字体格式
        Font font = workbook.createFont();
        //设置字体样式, 设置字体大小
        font.setFontHeightInPoints((short) 10);
        // 设置字体，是什么类型例如：黑体
        font.setFontName("黑体");
        //加粗,居中
        font.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        //表格边框
        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
        //自动换行,不能设置 行高
        style.setFont(font);
        style.setWrapText(true);



        //表头样式
        CellStyle style1 = workbook.createCellStyle();
        style1.setFillForegroundColor(HSSFColor.WHITE.index);
        style1.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);

        style1.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style1.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style1.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style1.setBorderTop(HSSFCellStyle.BORDER_THIN);
        //设置标题字体格式
        Font font1 = workbook.createFont();
        //设置字体样式
        font1.setFontHeightInPoints((short) 14);
        font1.setFontName("黑体");
        font1.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        style1.setFont(font1);
        //1-4行相同，设置样式及数据-结束

        //副表头样式
        CellStyle style1_1 = workbook.createCellStyle();
        style1_1.setFillForegroundColor(HSSFColor.WHITE.index);
        style1_1.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);

        style1_1.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style1_1.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

        style1_1.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style1_1.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style1_1.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style1_1.setBorderTop(HSSFCellStyle.BORDER_THIN);
        //设置标题字体格式
        Font font1_1 = workbook.createFont();
        //设置字体样式
        font1_1.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        font1_1.setFontHeightInPoints((short) 14);
        font1_1.setFontName("宋体");
        font1_1.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        style1_1.setFont(font1_1);


        //地区分布表开始
        if("视察考察调研活动安排时间地点分布表".equals(excelDateOns)){
            //地点分布表
            String dateYear = "";
            if(list.size()>0){
                dateYear = list.get(0).get("dateYear");
            }
            //第五行（表格标题）
            CellRangeAddress address =  new CellRangeAddress(count, (short) count, 0, (short) c);
            sheet.addMergedRegion(address);
            Row row4 = sheet.createRow(count);
            Cell cell5 = row4.createCell(0);
            cell5.setCellStyle(style1_1);
            cell5.setCellValue("( "+dateYear+" )  时间地点分布列表");
            count++;

            //第六行（表头）
            Row row5 = sheet.createRow(count);
            Cell cell5_0 = row5.createCell(0);
            cell5_0.setCellStyle(style1);
            cell5_0.setCellValue("地区");

            Cell cell5_1 = row5.createCell(1);
            cell5_1.setCellStyle(style1);
            cell5_1.setCellValue("全年总数");

            Cell cell5_2 = row5.createCell(2);
            cell5_2.setCellStyle(style1);
            cell5_2.setCellValue(" 一月 ");

            Cell cell5_3 = row5.createCell(3);
            cell5_3.setCellStyle(style1);
            cell5_3.setCellValue(" 二月 ");
            Cell cell5_4 = row5.createCell(4);
            cell5_4.setCellStyle(style1);
            cell5_4.setCellValue(" 三月 ");
            Cell cell5_5 = row5.createCell(5);
            cell5_5.setCellStyle(style1);
            cell5_5.setCellValue(" 四月 ");
            Cell cell5_6 = row5.createCell(6);
            cell5_6.setCellStyle(style1);
            cell5_6.setCellValue(" 五月 ");
            Cell cell5_7 = row5.createCell(7);
            cell5_7.setCellStyle(style1);
            cell5_7.setCellValue(" 六月 ");
            Cell cell5_8 = row5.createCell(8);
            cell5_8.setCellStyle(style1);
            cell5_8.setCellValue(" 七月 ");
            Cell cell5_9 = row5.createCell(9);
            cell5_9.setCellStyle(style1);
            cell5_9.setCellValue(" 八月 ");
            Cell cell5_10 = row5.createCell(10);
            cell5_10.setCellStyle(style1);
            cell5_10.setCellValue(" 九月 ");
            Cell cell5_11 = row5.createCell(11);
            cell5_11.setCellStyle(style1);
            cell5_11.setCellValue(" 十月 ");
            Cell cell5_12 = row5.createCell(12);
            cell5_12.setCellStyle(style1);
            cell5_12.setCellValue("十一月");
            Cell cell5_13 = row5.createCell(13);
            cell5_13.setCellStyle(style1);
            cell5_13.setCellValue("十二月");
            Cell cell5_14 = row5.createCell(14);
            cell5_14.setCellStyle(style1);
            cell5_14.setCellValue(" 待定 ");
            count++;
            for(int i = 2;i<15;i++) {
                // 3-15列 数据自适应
                sheet.autoSizeColumn(i);
            }
            for(int i=0;i<list.size();i++){
                HashMap<String,String> jsonObject = list.get(i);
                if(jsonObject.get("yi")==null){jsonObject.put("yi","0");}
                if(jsonObject.get("er")==null){jsonObject.put("er","0");}
                if(jsonObject.get("san")==null){jsonObject.put("san","0");}
                if(jsonObject.get("si")==null){jsonObject.put("si","0");}
                if(jsonObject.get("wu")==null){jsonObject.put("wu","0");}
                if(jsonObject.get("liu")==null){jsonObject.put("liu","0");}
                if(jsonObject.get("qi")==null){jsonObject.put("qi","0");}
                if(jsonObject.get("ba")==null){jsonObject.put("ba","0");}
                if(jsonObject.get("jiu")==null){jsonObject.put("jiu","0");}
                if(jsonObject.get("shi")==null){jsonObject.put("shi","0");}
                if(jsonObject.get("yy")==null){jsonObject.put("yy","0");}
                if(jsonObject.get("ye")==null){jsonObject.put("ye","0");}
                if(jsonObject.get("ding")==null){jsonObject.put("ding","0");}

                Row row = sheet.createRow(count);
                Cell cell_0 = row.createCell(0);
                cell_0.setCellStyle(style);
                cell_0.setCellValue(jsonObject.get("place"));
                Cell cell_1 = row.createCell(1);
                cell_1.setCellStyle(style);
                cell_1.setCellValue(jsonObject.get("count"));
                Cell cell_2 = row.createCell(2);
                cell_2.setCellStyle(style);
                cell_2.setCellValue(jsonObject.get("yi"));
                Cell cell_3 = row.createCell(3);
                cell_3.setCellStyle(style);
                cell_3.setCellValue(jsonObject.get("er"));
                Cell cell_4 = row.createCell(4);
                cell_4.setCellStyle(style);
                cell_4.setCellValue(jsonObject.get("san"));
                Cell cell_5 = row.createCell(5);
                cell_5.setCellStyle(style);
                cell_5.setCellValue(jsonObject.get("si"));
                Cell cell_6 = row.createCell(6);
                cell_6.setCellStyle(style);
                cell_6.setCellValue(jsonObject.get("wu"));
                Cell cell_7 = row.createCell(7);
                cell_7.setCellStyle(style);
                cell_7.setCellValue(jsonObject.get("liu"));
                Cell cell_8 = row.createCell(8);
                cell_8.setCellStyle(style);
                cell_8.setCellValue(jsonObject.get("qi"));
                Cell cell_9 = row.createCell(9);
                cell_9.setCellStyle(style);
                cell_9.setCellValue(jsonObject.get("ba"));
                Cell cell_10 = row.createCell(10);
                cell_10.setCellStyle(style);
                cell_10.setCellValue(jsonObject.get("jiu"));
                Cell cell_11 = row.createCell(11);
                cell_11.setCellStyle(style);
                cell_11.setCellValue(jsonObject.get("shi"));
                Cell cell_12 = row.createCell(12);
                cell_12.setCellStyle(style);
                cell_12.setCellValue(jsonObject.get("yy"));
                Cell cell_13 = row.createCell(13);
                cell_13.setCellStyle(style);
                cell_13.setCellValue(jsonObject.get("ye"));
                Cell cell_14 = row.createCell(14);
                cell_14.setCellStyle(style);
                cell_14.setCellValue(jsonObject.get("ding"));
                count++;
            }
            setRegionBorder(1,address,sheet,workbook);
            //地区分布表-结束
        }else{
            //其余4种导出样式-开始
            //第五行（表头，相同）
            style1.setAlignment(HSSFCellStyle.ALIGN_CENTER);
            style1.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            Row row4 = sheet.createRow(count);
            Cell cell5_0 = row4.createCell(0);
            cell5_0.setCellStyle(style1);
            cell5_0.setCellValue("承办单位");

            Cell cell5_1 = row4.createCell(1);
            cell5_1.setCellStyle(style1);
            cell5_1.setCellValue("标题");

            Cell cell5_2 = row4.createCell(2);
            cell5_2.setCellStyle(style1);
            cell5_2.setCellValue("时间");

            Cell cell5_3 = row4.createCell(3);
            cell5_3.setCellStyle(style1);
            cell5_3.setCellValue("地点");
            Cell cell5_4 = row4.createCell(4);
            cell5_4.setCellStyle(style1);
            cell5_4.setCellValue("备注");
            count++;
            //地区分表-开始
            if("视察考察调研活动安排地区分表".equals(excelDateOns)){
                //第六行
                String j = "-1";
                int jjjj = 0;
                for (int i = 0; i < list.size(); i ++) {
                    HashMap<String,String> jsonObject = list.get(i);
                    //34表示34个省，封装数据时i,代表不同的省，来区分词条数据属于哪个省分
                    for(int k=0;k<34;k++) {
                        if (jsonObject.get("i").equals((k+""))) {
                            if (!jsonObject.get("i").equals(j)) {
                                j = jsonObject.get("i");
                                CellRangeAddress address = new CellRangeAddress(count, (short) count, 0, (short) 4);
                                sheet.addMergedRegion(address);
                                Row row_1 = sheet.createRow(count);
                                Cell cell_1_1 = row_1.createCell(0);
                                cell_1_1.setCellStyle(style1_1);
                                cell_1_1.setCellValue(""+jsonObject.get("dateYear") + "年视察考察调研活动安排地区表（" + jsonObject.get("place") + ")");
                                count++;
                                setRegionBorder(1,address,sheet,workbook);
                            }
                            Row row = sheet.createRow(count);
                            String deptName = null == jsonObject.get("deptName") ? "" :  jsonObject.get("deptName");
                            String title = null == jsonObject.get("title") ? "" :  jsonObject.get("title");
                            String time1 = null == jsonObject.get("beginTimeStr") ? "" :  jsonObject.get("beginTimeStr");
                            String time2 = null == jsonObject.get("endTimeStr") ? "" :  jsonObject.get("endTimeStr");
                            String time = time1 + "至" + time2;
                            String place = null == jsonObject.get("place") ? "" :  jsonObject.get("place");
                            String notes = null == jsonObject.get("notes") ? "" :  jsonObject.get("notes");
                            if("true".equals(jsonObject.get("titleYesStr"))){
                                jjjj++;
                                setCellSpan(count,jjjj,0,row,style,deptName,sheet);
                                setCellSpan(count,jjjj,1,row,style,title,sheet);
                                setCellSpan(count,jjjj,4,row,style,notes,sheet);
                            }else {
                                setCellSpan1(count,jjjj,0,row,style,deptName,sheet);
                                setCellSpan1(count,jjjj,1,row,style,title,sheet);
                                setCellSpan1(count,jjjj,4,row,style,notes,sheet);
                                jjjj = 0;
                            }

                            Cell cell_2 = row.createCell(2);
                            cell_2.setCellStyle(style);
                            cell_2.setCellValue(time);
                            Cell cell_3 = row.createCell(3);
                            cell_3.setCellStyle(style);
                            cell_3.setCellValue(place);
                            Cell cell_4 = row.createCell(4);
                            cell_4.setCellStyle(style);
                            cell_4.setCellValue(notes);
                            count++;
                        }
                    }
                }
                //地区分表-结束
            }else if("视察考察调研活动安排时间分表".equals(excelDateOns)){
                //时间分表-开始
                String j = "0000";
                int jjjj = 0;
                for(int i=0;i<list.size();i++){
                    HashMap<String,String> jsonObject = list.get(i);
                    //12表示1-12月，封装数据时 createTime为0-12；用来区分此条数据属于那个月份
                    for(int p=0;p<=12;p++){
                        if((p+"").equals(jsonObject.get("createTime"))){
                            if(!j.equals(p+"")){
                                j=p+"";
                                CellRangeAddress address = new CellRangeAddress(count, (short) count, 0, (short) 4);
                                sheet.addMergedRegion(address);
                                Row row_1 = sheet.createRow(count);
                                Cell cell_1_1 = row_1.createCell(0);
                                cell_1_1.setCellStyle(style1_1);
                                cell_1_1.setCellValue(""+jsonObject.get("dateYear") + "视察考察调研活动安排时间分表（" + jsonObject.get("createTime") + "月)");
                                count++;
                                setRegionBorder(1,address,sheet,workbook);
                            }
                            Row row = sheet.createRow(count);
                            String deptName = null == jsonObject.get("deptName") ? "" :  jsonObject.get("deptName");
                            String title = null == jsonObject.get("title") ? "" :  jsonObject.get("title");
                            String time1 = null == jsonObject.get("beginTimeStr") ? "" :  jsonObject.get("beginTimeStr");
                            String time2 = null == jsonObject.get("endTimeStr") ? "" :  jsonObject.get("endTimeStr");
                            String time = time1 + "至" + time2;
                            String place = null == jsonObject.get("place") ? "" :  jsonObject.get("place");
                            String notes = null == jsonObject.get("notes") ? "" :  jsonObject.get("notes");

                            if("true".equals(jsonObject.get("titleYesStr"))){
                                jjjj++;
                                setCellSpan(count,jjjj,0,row,style,deptName,sheet);
                                setCellSpan(count,jjjj,1,row,style,title,sheet);
                                setCellSpan(count,jjjj,4,row,style,notes,sheet);
                            }else {
                                setCellSpan1(count,jjjj,0,row,style,deptName,sheet);
                                setCellSpan1(count,jjjj,1,row,style,title,sheet);
                                setCellSpan1(count,jjjj,4,row,style,notes,sheet);
                                jjjj = 0;
                            }
                            Cell cell_2 = row.createCell(2);
                            cell_2.setCellStyle(style);
                            cell_2.setCellValue(time);
                            Cell cell_3 = row.createCell(3);
                            cell_3.setCellStyle(style);
                            cell_3.setCellValue(place);
                            Cell cell_4 = row.createCell(4);
                            cell_4.setCellStyle(style);
                            cell_4.setCellValue(notes);
                            count++;
                        }
                    }
                }
                //时间分表-结束
            }else if("视察考察调研活动安排时间地点相对集中表".equals(excelDateOns)){
                //相对集中表-开始
                String j = "-1";
                String jj= "-1";
                int jjjj = 0;
                for(int i=0;i<list.size();i++){
                    HashMap<String,String> jsonObject = list.get(i);
                    //34个省
                    for(int k=0;k<34;k++) {
                        if ((k+"").equals(jsonObject.get("i"))) {
                            if (!j.equals(jsonObject.get("i"))) {
                                j = jsonObject.get("i");
                                CellRangeAddress address = new CellRangeAddress(count, (short) count, 0, (short) 4);
                                sheet.addMergedRegion(address);
                                Row row_1 = sheet.createRow(count);
                                Cell cell_1_1 = row_1.createCell(0);
                                style.setFillForegroundColor(HSSFColor.CORAL.index);
                                cell_1_1.setCellStyle(style1_1);
                                cell_1_1.setCellValue(""+jsonObject.get("dateYear") + "  年度  " + jsonObject.get("place"));
                                count++;
                                setRegionBorder(1,address,sheet,workbook);
                            }
                            //不同省份中区分12个月份
                            for(int p=0;p<=12;p++){
                                if((p+"").equals(jsonObject.get("createTime"))){
                                    if(!jj.equals(p+"")) {
                                        jj=p+"";
                                        CellRangeAddress address = new CellRangeAddress(count, (short) count, 0, (short) 4);
                                        sheet.addMergedRegion(address);
                                        Row row_1 = sheet.createRow(count);
                                        Cell cell_1_1 = row_1.createCell(0);
                                        cell_1_1.setCellStyle(style);
                                        cell_1_1.setCellValue("  视察考察调研活动安排  （" + jsonObject.get("createTime")+"月)");
                                        count++;
                                        setRegionBorder(1,address,sheet,workbook);
                                    }
                                    Row row = sheet.createRow(count);
                                    String deptName = null == jsonObject.get("deptName") ? "" :  jsonObject.get("deptName");
                                    String title = null == jsonObject.get("title") ? "" :  jsonObject.get("title");
                                    String time1 = null == jsonObject.get("beginTimeStr") ? "" :  jsonObject.get("beginTimeStr");
                                    String time2 = null == jsonObject.get("endTimeStr") ? "" :  jsonObject.get("endTimeStr");
                                    String time = time1 + "至" + time2;
                                    String place = null == jsonObject.get("place") ? "" :  jsonObject.get("place");
                                    String notes = null == jsonObject.get("notes") ? "" :  jsonObject.get("notes");

                                    //导出时  合并单元格
                                    if("true".equals(jsonObject.get("titleYesStr"))){
                                        jjjj++;
                                        setCellSpan(count,jjjj,0,row,style,deptName,sheet);
                                        setCellSpan(count,jjjj,1,row,style,title,sheet);
                                        setCellSpan(count,jjjj,4,row,style,notes,sheet);
                                    }else {
                                        setCellSpan1(count,jjjj,0,row,style,deptName,sheet);
                                        setCellSpan1(count,jjjj,1,row,style,title,sheet);
                                        setCellSpan1(count,jjjj,4,row,style,notes,sheet);
                                        jjjj = 0;
                                    }

                                    Cell cell_0 = row.createCell(0);
                                    cell_0.setCellStyle(style);
                                    cell_0.setCellValue(deptName);
                                    Cell cell_1 = row.createCell(1);
                                    cell_1.setCellStyle(style);
                                    cell_1.setCellValue(title);
                                    Cell cell_2 = row.createCell(2);
                                    cell_2.setCellStyle(style);
                                    cell_2.setCellValue(time);
                                    Cell cell_3 = row.createCell(3);
                                    cell_3.setCellStyle(style);
                                    cell_3.setCellValue(place);
                                    Cell cell_4 = row.createCell(4);
                                    cell_4.setCellStyle(style);
                                    cell_4.setCellValue(notes);
                                    count++;
                                }
                            }
                        }
                    }
                }
                //相对集中表-结束
            }else if("视察考察调研活动安排详细信息表".equals(excelDateOns)){

                for(int i=0;i<placeList.size();i++) {
                    Place place = placeList.get(i);
                    String deptName = null == place.getDicDept().getDeptName() ? "" :  place.getDicDept().getDeptName();
                    String title = null == place.getTitle() ? "" :  place.getTitle();
                    String notes = null == place.getNotes() ? "" :  place.getNotes();
                    List<DateType> dateTypes = place.getDateTypeLists();
                    if(dateTypes.size()>0) {
                        for (int j = 0; j < dateTypes.size(); j++) {
                            DateType dateType = dateTypes.get(j);
                            String time1 = "", time2 = "";
                            if (dateType.getBeginTime() != null) {
                                time1 = DateUtil.getDateEarly(dateType.getBeginTime());
                            }
                            if (dateType.getEndTime() != null) {
                                time2 = DateUtil.getDateEarly(dateType.getEndTime());
                            }
                            String time = time1 + "至" + time2;
                            String strPlace = null == dateType.getPlace().getDistrictName() ? "" : dateType.getPlace().getDistrictName();
                            Row row1_1_2 = sheet.createRow(count);
                            Cell cell_2_0 = row1_1_2.createCell(0);
                            cell_2_0.setCellStyle(style);
                            cell_2_0.setCellValue(deptName);

                            Cell cell_2_1 = row1_1_2.createCell(1);
                            cell_2_1.setCellStyle(style);
                            cell_2_1.setCellValue(title);

                            Cell cell_2_2 = row1_1_2.createCell(2);
                            cell_2_2.setCellStyle(style);
                            cell_2_2.setCellValue(time);
                            //自适应表格宽度
                            Cell cell_2_3 = row1_1_2.createCell(3);
                            cell_2_3.setCellStyle(style);
                            cell_2_3.setCellValue(strPlace);
                            Cell cell_2_4 = row1_1_2.createCell(4);
                            cell_2_4.setCellStyle(style);
                            cell_2_4.setCellValue(notes);
                            count++;

                        }
                    }else {
                        Row row1_1_2 = sheet.createRow(count);
                        Cell cell_2_0 = row1_1_2.createCell(0);
                        cell_2_0.setCellStyle(style);
                        cell_2_0.setCellValue(deptName);
                        Cell cell_2_1 = row1_1_2.createCell(1);
                        cell_2_1.setCellStyle(style);
                        cell_2_1.setCellValue(title);
                        Cell cell_2_2 = row1_1_2.createCell(2);
                        cell_2_2.setCellStyle(style);
                        cell_2_2.setCellValue("暂无");
                        Cell cell_2_3 = row1_1_2.createCell(3);
                        cell_2_3.setCellStyle(style);
                        cell_2_3.setCellValue("暂无");
                        Cell cell_2_4 = row1_1_2.createCell(4);
                        cell_2_4.setCellStyle(style);
                        cell_2_4.setCellValue("暂无");
                        count++;
                    }

                }

                //合并单元格
                String deptNameCell = sheet.getRow(2).getCell(1).getStringCellValue();
                int r = 1;int t = 2;
                for(int i=3;i<sheet.getPhysicalNumberOfRows();i++){
                    HSSFRow row = sheet.getRow(i);
                    String deptNameCellNow =row.getCell(1).getStringCellValue();
                    if(deptNameCell.equals(deptNameCellNow)){
                        r++;
                    }else {
                        CellRangeAddress address1 = new CellRangeAddress(t, (short) (t + r - 1), 0, (short) 0);
                        CellRangeAddress address2 = new CellRangeAddress(t, (short) (t + r - 1), 1, (short) 1);
                        CellRangeAddress address3 = new CellRangeAddress(t, (short) (t + r - 1), 4, (short) 4);
                        sheet.addMergedRegion(address1);
                        sheet.addMergedRegion(address2);
                        sheet.addMergedRegion(address3);
                        setRegionBorder(1,address1,sheet,workbook);
                        setRegionBorder(1,address2,sheet,workbook);
                        setRegionBorder(1,address3,sheet,workbook);
                        deptNameCell = deptNameCellNow;
                        t=t+r;
                        r=1;
                    }
                    if(i==(sheet.getPhysicalNumberOfRows()-1)){
                        CellRangeAddress address1 = new CellRangeAddress(t, (short) (t + r - 1), 0, (short) 0);
                        CellRangeAddress address2 = new CellRangeAddress(t, (short) (t + r - 1), 1, (short) 1);
                        CellRangeAddress address3 = new CellRangeAddress(t, (short) (t + r - 1), 4, (short) 4);
                        sheet.addMergedRegion(address1);
                        sheet.addMergedRegion(address2);
                        sheet.addMergedRegion(address3);
                        setRegionBorder(1,address1,sheet,workbook);
                        setRegionBorder(1,address2,sheet,workbook);
                        setRegionBorder(1,address3,sheet,workbook);
                    }
                }
                //合并单元格结束

            }
            //详细信息表-结束
        }
        //其余4种导出样式结束
    }


    public static void setRegionBorder(int border,CellRangeAddress address,HSSFSheet sheet,Workbook wb){
        RegionUtil.setBorderBottom(border,address,sheet,wb);
        RegionUtil.setBorderLeft(border,address,sheet,wb);
        RegionUtil.setBorderRight(border,address,sheet,wb);
        RegionUtil.setBorderTop(border,address,sheet,wb);
    }
    public void setCellSpan(int count,int jjjj,int cell,Row row,CellStyle style,String value,HSSFSheet sheet){
        sheet.addMergedRegion(new CellRangeAddress((count-jjjj), (short) (count + jjjj), cell, (short) cell));
        Cell cell_0 = row.createCell(cell);
        cell_0.setCellStyle(style);
        cell_0.setCellValue(value);
    }
    public void setCellSpan1(int count,int jjjj,int cell,Row row,CellStyle style,String value,HSSFSheet sheet){
        sheet.addMergedRegion(new CellRangeAddress((count-jjjj), (short) (count), cell, (short) cell));
        Cell cell_0 = row.createCell(cell);
        cell_0.setCellStyle(style);
        cell_0.setCellValue(value);
    }

}
