package com.taiji.frame.service.inspection.place;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.inspection.place.DateType;
import com.taiji.frame.model.entity.inspection.place.Place;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.inspection.place.DateTypeVo;
import com.taiji.frame.util.BaseDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * @author SY
 *
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class PlaceService extends BaseDAO<Place> {

    @Autowired
    private DateTypeService dateTypeService;


    /**
     * 分页查询考察考勤调研
     */
    public void load(Carrier<Place> carrier, Map<String, Object> map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from Place p where 1 = 1");
        if (map.containsKey("title")) {
            hql.append(" and p.title like '%").append(map.get("title")).append("%'");
        }
        if (map.containsKey("deptId")) {
            hql.append(" and p.dicDept.id = :deptId");
        }
        if (map.containsKey("place")) {
            hql.append(" and p.place like '%").append(map.get("place")).append("%'");
        }
        if (map.containsKey("nodeTime")) {

            hql.append(" and p.nowTime = :nodeTime");
        }
        if (map.containsKey("actType")) {
            hql.append(" and p.actTypeId = :actType");
        }
        if (map.containsKey("createTime")) {
            hql.append(" and to_char(p.createTime,'yyyy-MM-dd') = :createTime");

        }
        if (map.containsKey("placeIndexMainId")) {
            //主页传来的额ID
            hql.append(" and p.id = :placeIndexMainId");
        }
        if (!map.containsKey("status")) {
            //没有新增权限，查询未上报的
            hql.append(" and p.reportState != 0");
        }
        hql.append(" and p.delFlag = '0' ");
        find(carrier,hql.toString(),map);
    }

    /**
     * 设置数据
     * @param p
     * @return
     */
    public List<DateType> clashSaveNew(List<DateTypeVo> p, List<DateType> p1,Place pace) {
        for (DateTypeVo vo :p) {
            DateType dateType1 = new DateType();
            //设置时间，省分 ，地点
            dateType1.setBeginTime(DateUtil.stringToDate(vo.getBeginTimeStr(),DateUtil.FORMAT_DAY));
            dateType1.setEndTime(DateUtil.stringToDate(vo.getEndTimeStr(),DateUtil.FORMAT_DAY));
            dateType1.setDateType(vo.getDateType());
            dateType1.setDelFlag(vo.getDelFlag());
            dateType1.setId(vo.getId());
            //地点
            dateType1.setPlace(vo.getPlace());
            dateType1.setSpecialPlace(vo.getSpecialPlace());
            dateType1.setPlaceId(pace);
            dateType1.setIsClash("0");
            dateType1.setIsClashDay("0");
            dateType1.setIsClashYear("0");
            p1.add(dateType1);
        }
        return p1;
    }

    /**
     * 添加时 查询是否有冲突
     * @param
     * @return
     */
    public List<DateType> clashSaveNew(List<DateType> p1,List<DateType> list) {



        for (int i=0;i<p1.size();i++){
            DateType dateType = p1.get(i);
            String districtId = dateType.getPlace().getId();
            //判断同一时间地点冲突
            String beginTime = DateUtil.dateToString(dateType.getBeginTime(), DateUtil.FORMAT_DAY);
            String str1 = "from DateType t where to_char(t.beginTime,'yyyy-MM-dd') ='"+beginTime+"' and t.place.id = "
                    + districtId + " and t.placeId.reportState != '0' and t.delFlag = '0'";
            List<DateType> objects = find(str1);
            if(objects.size()>1){
                dateType.setIsClash("1");
                for (DateType da1:objects) {
                    da1.setIsClash("1");
                    dateTypeService.save(da1);
                }
            }else {
                if(list != null) {
                    for (DateType date : list) {
                        String begin = DateUtil.dateToString(date.getBeginTime(), DateUtil.FORMAT_DAY);
                        String district = date.getPlace().getId();
                        String strs1 = "from DateType t where to_char(t.beginTime,'yyyy-MM-dd') ='"+begin+"' and t.place.id = " + district
                                + " and t.placeId.reportState != '0' and t.delFlag = '0' and t.id != '"+date.getId()+"'";
                        List<DateType> object = find(strs1);
                        if(object.size() == 1){
                            for (DateType type1:object) {
                                type1.setIsClash("0");
                                dateTypeService.save(type1);
                            }
                        }
                    }
                }
            }

            //判断同一月内 地点冲突3次以上
            String beginTimeYYYYMM = DateUtil.dateToString(dateType.getBeginTime(), DateUtil.FORMAT_YYYY_MM);
            String str2 = "from DateType t where to_char(t.beginTime,'yyyy-MM') ='"+beginTimeYYYYMM+"' and t.place.id = "
                    + districtId + "  and t.placeId.reportState != '0' and  t.delFlag = '0'";
            List<DateType> objectsMM = find(str2);
            if(objectsMM.size()>3){
                dateType.setIsClashDay("2");
                for (DateType da2:objectsMM) {
                    da2.setIsClashDay("2");
                    dateTypeService.save(da2);
                }
            }else {
                if(list != null) {
                    for (DateType date : list) {
                        String begin = DateUtil.dateToString(date.getBeginTime(), DateUtil.FORMAT_YYYY_MM);
                        String district = date.getPlace().getId();
                        String strs1 = "from DateType t where to_char(t.beginTime,'yyyy-MM') ='"+begin+"' and t.place.id = " + district
                                + " and t.placeId.reportState != '0' and t.delFlag = '0' and t.id != '"+date.getId()+"'";
                        List<DateType> object = find(strs1);
                        if(object.size() <= 3){
                            for (DateType type2:object) {
                                type2.setIsClashDay("0");
                                dateTypeService.save(type2);
                            }
                        }
                    }
                }
            }
            //判断同一年内 地点冲突3次以上
            String beginTimeYYYY = DateUtil.dateToString(dateType.getBeginTime(), DateUtil.FORMAT_YYYY);
            String str3 = "from DateType t where to_char(t.beginTime,'yyyy') ='"+beginTimeYYYY+"' and t.place.id = " + districtId + "  and t.placeId.reportState != '0' and  t.delFlag = '0'";
            List<DateType> objectsYY = find(str3);
            if(objectsYY.size()>6){
                dateType.setIsClashYear("3");
                for (DateType da3:objectsYY) {
                    da3.setIsClashYear("3");
                    dateTypeService.save(da3);
                }
            }else {
                if(list != null) {
                    for (DateType date : list) {
                        String begin = DateUtil.dateToString(date.getBeginTime(), DateUtil.FORMAT_YYYY);
                        String district = date.getPlace().getId();
                        String strs1 = "from DateType t where to_char(t.beginTime,'yyyy') ='"+begin+"' and t.place.id = " + district
                                + " and t.placeId.reportState != '0' and t.delFlag = '0' and t.id != '"+date.getId()+"'";
                        List<DateType> object = find(strs1);
                        if(object.size() <= 6){
                            for (DateType type3:object) {
                                type3.setIsClashYear("0");
                                dateTypeService.save(type3);
                            }
                        }
                    }
                }
            }
            dateTypeService.save(dateType);
        }
        return p1;
    }


    public void clashUpDateNew(Date time,String id,String dateId) {

            String strs1 = "from DateType t where to_char(t.beginTime,'yyyy-MM-dd') ='"+DateUtil.dateToString(time,DateUtil.FORMAT_DAY)+"' and t.place.id = " + id
                    + " and t.placeId.reportState != '0' and t.delFlag = '0' and t.id != '"+dateId+"'";
            List<DateType> object1 = find(strs1);
            if(object1.size() <= 1){
                for (DateType a:object1) {
                    a.setIsClash("0");
                    dateTypeService.save(a);
                }
            }
            String strs2 = "from DateType t where to_char(t.beginTime,'yyyy-MM') ='"+DateUtil.dateToString(time,DateUtil.FORMAT_YYYY_MM)+"' and t.place.id = " + id
                    + " and t.placeId.reportState != '0' and t.delFlag = '0' and t.id != '"+dateId+"'";
            List<DateType> object2 = find(strs2);
            if(object2.size() <= 3){
                for (DateType a:object2) {
                    a.setIsClashDay("0");
                    dateTypeService.save(a);
                }
            }
            String strs3 = "from DateType t where to_char(t.beginTime,'yyyy') ='"+DateUtil.dateToString(time,DateUtil.FORMAT_YYYY)+"' and t.place.id = " + id
                    + " and t.placeId.reportState != '0' and t.delFlag = '0' and t.id != '"+dateId+"'";
            List<DateType> object3 = find(strs3);
            if(object3.size() <= 6){
                for (DateType a:object3) {
                    a.setIsClashYear("0");
                    dateTypeService.save(a);
                }
            }

    }
















    /**主页数据展示*/
    public List<Place> indexMainloadService(DicUser dicUser) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from Place p where 1 = 1");
        hql.append(" and p.reportState = '2'");
        //hql.append(" and p.dicDept.id = '"+dicUser.getDicDept().getId()+"'");
        hql.append(" and p.delFlag = '0' ");
        hql.append(" order by p.createTime desc");

        return find(hql.toString());
    }



    /**主页数据展示(待办事项)*/
    public List<Place> indexMainloadAgencyService(String placeLStrs,DicUser dicUser) {
        StringBuffer hql = new StringBuffer();
        Map<String, Object> map = new HashMap<>(1);
        hql.append(" from Place p where 1 = 1");

        if("76_13".equals(placeLStrs)){
            //值班员
            hql.append(" and p.reportState != '0'");
        }else {
            //普通用户
            hql.append(" and p.dicUser.id = '"+dicUser.getId()+"' and p.reportState = '0' ");
        }
        hql.append(" and p.delFlag = '0' ");
        hql.append(" order by p.createTime desc");
        return find(hql.toString(),map);
    }


}
