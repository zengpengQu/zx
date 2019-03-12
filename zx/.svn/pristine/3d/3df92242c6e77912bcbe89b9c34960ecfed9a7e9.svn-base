package com.taiji.frame.controller.inspection.place;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.OtherUtil;
import com.taiji.frame.model.entity.inspection.place.DateType;
import com.taiji.frame.model.entity.inspection.place.District;
import com.taiji.frame.model.entity.inspection.place.Place;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.service.inspection.census.CensusService;
import com.taiji.frame.service.inspection.place.DateTypeService;
import com.taiji.frame.service.inspection.place.DistrictService;
import com.taiji.frame.service.systempara.SysLogService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.util.*;


/**
 * @author sy
 * 活动安排
 */
@Controller
@RequestMapping(value = "/dateType")
public class DateTypeController extends BaseController<DateType> {

    private static final Logger LOG = LoggerFactory.getLogger(DateTypeController.class);
    @Autowired
    private CensusService censusService;
    @Autowired
    private DateTypeService dateTypeService;
    @Autowired
    private DistrictService districtService;
    @Autowired
    private SysLogService sysLogService;
    /**
     * 活动安排信息删除
     */
    @ResponseBody
    @RequestMapping(value = "/dateType-delete.do", method = RequestMethod.POST)
    public Map<String,Object> logicGuideDelete(String id) {
        Map<String,Object> map = new HashMap<>(1);

        if (StringUtils.isNotEmpty(id)) {
            try {
                dateTypeService.delete(id);
                map.put("result",true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("活动安排信息");
                    sysLogVo.setRecordType(2);
                    sysLogVo.setEntityId(id);
                    sysLogVo.setEntityName("");
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);

            } catch (Exception e) {
                LOG.error("活动安排删除失败" + e.getMessage(),e);
                map.put("result",false);
            }
        } else {
            map.put("result",true);
        }
        return map;
    }

    /**
     * 计算冲突
     * load grid单位表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-clash-list.do", produces = "text/html;charset=UTF-8")
    public String clashLoad(Carrier<DateType> carrier,String sortName) {
        HashMap map = new HashMap(1);
        try {
            map.put("sortName",sortName);
            dateTypeService.clashLoad(carrier,map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 时间地点分布列表(统计各月次数)
     */
    @ResponseBody
    @RequestMapping(value = "/load-placeDateTable-list.do", method = RequestMethod.POST)
    public List<HashMap<String,String>> placeDateTable(String dateYear,String place ) {
        try {
            List<District> districts = new ArrayList<>();
            if(StringUtils.isEmpty(place)) {
                districts = districtService.districtParentCode();
            }else {
                districts.add(districtService.get(place));
            }
            if(StringUtils.isEmpty(dateYear)) {
                //默认加载系统时间年份的数据，如需加载下一年，将 count：0  改为 加或减去，对应年份
                dateYear = DateUtil.dateToString(DateUtil.addYear(new Date(), 1), DateUtil.FORMAT_YYYY);
            }
            List<HashMap<String,String>> dateTypes = dateTypeService.datePlace(districts,dateYear);
            return dateTypes;
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            return null;
        }
    }


    /**
     *  时间 分表
     */
    @ResponseBody
    @RequestMapping(value = "/load-timeTable-list.do", method = RequestMethod.POST)
    public List<HashMap<String,String>> loadTimeTable(String dateYear, String createTime ) {
        try {
            if(StringUtils.isEmpty(dateYear)) {
                //默认加载系统时间年份的数据，如需加载下一年，将 count：0  改为 加或减去，对应年份
                dateYear = DateUtil.dateToString(DateUtil.addYear(new Date(), 1), DateUtil.FORMAT_YYYY);
            }
            List<HashMap<String,String>> dateTypeVoNoExes =  dateTypeService.timePlace(dateYear,createTime);
            return dateTypeVoNoExes;
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            return null;
        }

    }

    /**
     *  地区 分表
     */
    @ResponseBody
    @RequestMapping(value = "/load-placeTable-list.do", method = RequestMethod.POST)
    public List<HashMap<String,String>> loadPlaceTable(String dateYear, String place ) {
        try {
            List<District> districts = new ArrayList<>();
            if(StringUtils.isEmpty(dateYear)) {
                //默认加载系统时间年份的数据，如需加载下一年，将 count：0  改为 加或减去，对应年份
                dateYear = DateUtil.dateToString(DateUtil.addYear(new Date(), 1), DateUtil.FORMAT_YYYY);
            }
            if(StringUtils.isEmpty(place)){
                districts =  districtService.districtParentCode();
            }else {
                districts.add(districtService.get(place));
            }
            List<HashMap<String,String>> dateTypeVoNoExes =  dateTypeService.placeTable(dateYear,districts);
            return dateTypeVoNoExes;
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            return null;
        }

    }


    /**
     *  时间地点 相对集中
     */
    @ResponseBody
    @RequestMapping(value = "/load-placeTimeTable-list.do", method = RequestMethod.POST)
    public List<HashMap<String,String>> loadPlaceTimeTable(String dateYear, String place ,String createTime) {
        try {
            List<District> districts = new ArrayList<>();
            if(StringUtils.isEmpty(dateYear)) {
                //默认加载系统时间年份的数据，如需加载下一年，将 count：0  改为 加或减去，对应年份
                dateYear = DateUtil.dateToString(DateUtil.addYear(new Date(), 1), DateUtil.FORMAT_YYYY);
            }
            if(StringUtils.isEmpty(place)){
                districts =  districtService.districtParentCode();
            }else {
                districts.add(districtService.get(place));
            }
            List<HashMap<String,String>> dateTypeVoNoExes =  dateTypeService.placeTimeTable(dateYear,districts,createTime);
            return dateTypeVoNoExes;
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            return null;
        }
    }


    /**
     * 导出Excel
     * @param excelDateOns 前台需要导出的那种表格类型
     *                     2：时间分表 3：地区分表 4：时间地点分布表，5：时间地点相对集中表
     */
    @ResponseBody
    @RequestMapping(value = "/export-excel.do",method = RequestMethod.GET)
    public void exportExcel(HttpServletRequest request, HttpServletResponse response,
                            String dateYear,String place,String createTime,String excelDateOns){
        try {
            String fileName, excelDate1;
            List<District> districts = new ArrayList<>();
            //设置输入流参数
            OutputStream os;
            switch (excelDateOns) {
                case "2":
                    //时间分表
                    fileName = "视察考察调研活动安排时间分表.xls";
                    excelDate1 = "视察考察调研活动安排时间分表";
                    if(StringUtils.isEmpty(dateYear)) {
                        //默认加载系统时间年份的数据，如需加载下一年，将 count：0  改为 加或减去，对应年份
                        dateYear = DateUtil.dateToString(DateUtil.addYear(new Date(), 1), DateUtil.FORMAT_YYYY);
                    }
                    os = OtherUtil.getOutputStream(fileName, request, response);
                    dateTypeService.createExcel(os, fileName,
                            dateTypeService.timePlace(dateYear,createTime),excelDate1,null);
                    break;
                case "3":
                    //地区分表
                    fileName = "视察考察调研活动安排地区分表.xls";
                    excelDate1 = "视察考察调研活动安排地区分表";
                    if(StringUtils.isEmpty(dateYear)) {
                        //默认加载系统时间年份的数据，如需加载下一年，将 count：0  改为 加或减去，对应年份
                        dateYear = DateUtil.dateToString(DateUtil.addYear(new Date(), 1), DateUtil.FORMAT_YYYY);
                    }
                    if(StringUtils.isEmpty(place)){
                        districts =  districtService.districtParentCode();
                    }else {
                        districts.add(districtService.get(place));
                    }
                    os = OtherUtil.getOutputStream(fileName, request, response);
                    dateTypeService.createExcel(os, fileName,
                            dateTypeService.placeTable(dateYear,districts),excelDate1,null);
                    break;
                case "4":
                    //时间地点分布表
                    fileName = "视察考察调研活动安排时间地点分布表.xls";
                    excelDate1 = "视察考察调研活动安排时间地点分布表";
                    if(StringUtils.isEmpty(place)) {
                        districts = districtService.districtParentCode();
                    }else {
                        districts.add(districtService.get(place));
                    }
                    if(StringUtils.isEmpty(dateYear)) {
                        //默认加载系统时间年份的数据，如需加载下一年，将 count：0  改为 加或减去，对应年份
                        dateYear = DateUtil.dateToString(DateUtil.addYear(new Date(), 1), DateUtil.FORMAT_YYYY);
                    }
                    os = OtherUtil.getOutputStream(fileName, request, response);
                    dateTypeService.createExcel(os, fileName,
                            dateTypeService.datePlace(districts,dateYear),excelDate1,null);
                    break;
                case "5":
                    //时间地点相对集中表
                    fileName = "视察考察调研活动安排时间地点相对集中表.xls";
                    excelDate1 = "视察考察调研活动安排时间地点相对集中表";
                    if(StringUtils.isEmpty(dateYear)) {
                        //默认加载系统时间年份的数据，如需加载下一年，将 count：0  改为 加或减去，对应年份
                        dateYear = DateUtil.dateToString(DateUtil.addYear(new Date(), 1), DateUtil.FORMAT_YYYY);
                    }
                    if(StringUtils.isEmpty(place)){
                        districts =  districtService.districtParentCode();
                    }else {
                        districts.add(districtService.get(place));
                    }
                    os = OtherUtil.getOutputStream(fileName, request, response);
                    dateTypeService.createExcel(os, fileName,
                            dateTypeService.placeTimeTable(dateYear,districts,createTime),excelDate1,null);
                    break;
                default:
                    //活动安排表
                    fileName = "视察考察调研活动安排详细信息.xls";
                    excelDate1 = "视察考察调研活动安排详细信息表";
                        List<Place> list = censusService.load(null);
                    os = OtherUtil.getOutputStream(fileName, request, response);
                    dateTypeService.createExcel(os, fileName,null,excelDate1,list);
            }
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("视察考察调研活动");
            sysLogVo.setRecordType(7);
            sysLogVo.setEntityId("");
            sysLogVo.setEntityName("");
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);

        }catch (Exception e){
            LOG.error(e.getMessage(),e);
        }
    }


}
