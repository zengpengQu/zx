package com.taiji.frame.service.systempara;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.systempara.SecRole;
import com.taiji.frame.model.systempara.SysLog;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.util.BaseDAO;
import com.taiji.frame.util.UtilService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.Map;

/**
 * Created by CHX on 2016/5/11.
 * @author CHX
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = true,rollbackFor = Exception.class)
public class SysLogService extends BaseDAO<SysLog> {

    @Autowired
    private UtilService utilService;

    public void load(Carrier<SecRole> carrier,Map<String,Object> map){
        StringBuffer hql = new StringBuffer( "from SysLog t where 1=1");
        if(map.containsKey("searchName")){
            hql.append(" and t.updEmpName like:searchName");
        }
        if(map.containsKey("startTime")){
            hql.append(" and to_char(t.updDate,'yyyy-MM-dd') >=:startTime");
        }
        if(map.containsKey("endTime")){
            hql.append(" and to_char(t.updDate,'yyyy-MM-dd') <=:endTime");
        }
        if(map.containsKey("userId")){
            hql.append(" and t.updEmpId=:userId");
        }
        find(carrier,hql.toString(),map);
    }

    /**
     * 记录日志
     * @param sysLogVo
     */
    @Transactional(rollbackFor = Exception.class)
    public void record(SysLogVo sysLogVo) {
        SysLog sysLog = new SysLog();
        Date curDate = utilService.getSysTime();
        sysLog.setUpdDate(curDate);
        sysLog.setFromIp(sysLogVo.getFromIp());
        sysLog.setUpdEmpId(sysLogVo.getUpdEmpId());
        sysLog.setUpdEmpName(sysLogVo.getUpdEmpName());
        int recordType = sysLogVo.getRecordType();
        String resultStr;
        if (sysLogVo.getResult().equals("true")) {
            resultStr = "成功";
        }else {
            resultStr = "失败";
        }
        String recordTypeStr ="";
        StringBuffer dscr = new StringBuffer("");

        if (recordType == 0){
            recordTypeStr = "新增";
        }else if (recordType == 1){
            recordTypeStr = "编辑";
        }else if (recordType == 2){
            recordTypeStr = "删除";
        }else if (recordType == 6){
            recordTypeStr = "导入";
        }else if (recordType == 7){
            recordTypeStr = "导出";
        }else if (recordType == 8){
            recordTypeStr = "上报";
        }else if (recordType == 9){
            recordTypeStr = "查收";
        }else if (recordType == 10){
            recordTypeStr = "打印";
        }else if (recordType == 11){
            recordTypeStr = "办结";
        }else if (recordType == 12){
            recordTypeStr = "流转记录";
        }else if (recordType == 13){
            recordTypeStr = "移动";
        }else if (recordType == 14){
            recordTypeStr = "下载";
        }else if (recordType == 15){
            recordTypeStr = "反馈";
        }else if (recordType == 16){
            recordTypeStr = "撤销反馈";
        }else if (recordType == 17){
            recordTypeStr = "下发";
        }else if (recordType == 18){
            recordTypeStr = "获取";
        }else if (recordType == 19){
            recordTypeStr = "注销";
        }else if (recordType == 20){
            recordTypeStr = "销毁";
        }else if (recordType == 21){
                recordTypeStr = "注销并销毁";
        }else if (recordType == 22){
            recordTypeStr = "借出";
        }else if (recordType == 23){
            recordTypeStr = "归还";
        }else if (recordType == 24){
            recordTypeStr = "催还";
        }else if (recordType == 25){
            recordTypeStr = "统计";
        }else if (recordType == 3){
            sysLog.setUrlDscr("【登录】");
            dscr.append("登录名:" + sysLogVo.getEntityName() + ";结果:"+ resultStr +";");
        }else if (recordType == 4){
            //重置密码
            sysLog.setUrlDscr("【" + sysLogVo.getTypeName() + "】" + "信息");
            dscr.append("ID:" + sysLogVo.getEntityId() + ";");
            dscr.append("名称:重置" + sysLogVo.getEntityName() + "的密码信息;");
            dscr.append("操作类型:" + sysLogVo.getTypeName() + ";");
            dscr.append("结果:" + resultStr +";");
        }else if (recordType == 5){
            //激活 & 禁用
            sysLog.setUrlDscr("【" + sysLogVo.getTypeName() + "】" + sysLogVo.getEntityName() + "用户信息");
            dscr.append("ID:" + sysLogVo.getEntityId() + ";");
            dscr.append("名称:" + sysLogVo.getTypeName() + sysLogVo.getEntityName() + "的信息;");
            dscr.append("操作类型:" + sysLogVo.getTypeName() + ";");
            dscr.append("结果:" + resultStr +";");
        }else if (recordType == -1){
            sysLog.setUrlDscr("操作" + sysLogVo.getEntityName() + "信息");
            dscr.append("结果:" + resultStr +";");
        }
        if(recordType != 3 & recordType != 4 & recordType != 5) {
            sysLog.setUrlDscr("【" + recordTypeStr + "】" + sysLogVo.getTypeName() + "信息");
            dscr.append("ID:" + sysLogVo.getEntityId() + ";");
            dscr.append("名称:" + recordTypeStr + sysLogVo.getEntityName() + "的" + sysLogVo.getTypeName() + "信息;");
            dscr.append("操作类型:" + recordTypeStr + ";");
            dscr.append("结果:" + resultStr +";");
        }
        sysLog.setDscr(dscr.toString());
        save(sysLog);
    }
}
