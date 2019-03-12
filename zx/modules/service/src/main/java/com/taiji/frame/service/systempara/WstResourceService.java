package com.taiji.frame.service.systempara;

import com.taiji.frame.common.constants.ResourceStatus;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.constants.DefaultPassword;
import com.taiji.frame.common.util.MD5Util;
import com.taiji.frame.common.constants.WstResourceOid;
import com.taiji.frame.model.systempara.*;
import com.taiji.frame.util.BaseDAO;
import com.taiji.frame.util.UtilService;
import com.westone.middleware.toolkit.trustService.data.TrustServiceResponse;
import com.westone.middleware.toolkit.trustService.resource.Resource;
import com.westone.middleware.toolkit.trustService.resource.ResourceProperty;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.ArrayList;
import java.util.List;


/**
 * 卫士通资源服务
 *
 * @author yx
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class WstResourceService extends BaseDAO<WstResource> {
    private static final Logger log = LoggerFactory.getLogger(WstResourceService.class);

    @Autowired
    UtilService utilService;

    @Autowired
    DicUserService dicUserService;

    @Autowired
    DicDeptService dicDeptService;

    @Autowired
    WstUserService wstUserService;

    @Autowired
    WstDeptService wstDeptService;

    @Autowired
    SecRoleService secRoleService;

    /**
     * 保存用户资源
     * @param rc
     * @param tsResponse
     */
    @Transactional(rollbackFor = Exception.class)
    public void saveUser(Resource rc, TrustServiceResponse tsResponse) {

        // 根据推送资源版本判断是否更新数据
        int version = rc.getVersion();

        String rmsNo = rc.getNo();
        WstResource wstResource;

        wstResource= this.findUniqueBy("rmsNo", rmsNo);
        if (null == wstResource) {
            wstResource = new WstResource();
        } else if (wstResource.getRmsVersion() == version) {
            tsResponse.setStatus(0);
            return;
        }

        // 保存资源
        wstResource.setRmsNo(rmsNo);
        wstResource.setRmsName(rc.getName());
        wstResource.setRmsRmsid(rc.getRmsId());
        wstResource.setRmsStatus(rc.getStatus());
        wstResource.setRmsVersion(version);

        try {
            save(wstResource);

            //TODO：确定 rc.getName 是名称，还是 .40 是名称
            DicUser dicUser;

            dicUser = dicUserService.findUniqueBy("rmsNo", rmsNo);
            if (null == dicUser) {
                dicUser = new DicUser();
                dicUser.setCreateDate(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY));
                // 赋予普通用户权限
                SecRole secRole = secRoleService.get("4");
                List<SecRole> secRoleList = new ArrayList<>();
                secRoleList.add(secRole);
                dicUser.setRoleList(secRoleList);
            }
            // 资源信息状态：0-在用，1-停用，2-销毁
            if (ResourceStatus.DEPRECATED.value() == rc.getStatus() ||
                    ResourceStatus.DESTROYED.value() == rc.getStatus()) {
                // dicUser.isActive： 激活标志 1有效，0无效
                dicUser.setIsactive(0);
            } else {
                dicUser.setIsactive(1);
            }
            dicUser.setEmpName(rc.getName());
            dicUser.setUserId(rc.getName());
            dicUser.setRmsNo(rc.getNo());
            dicUser.setUpdDate(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY));
            dicUser.setUpdEmp("westone");

            List<ResourceProperty> propertyList =  rc.getProperties();
            for (ResourceProperty rp: propertyList) {
                String oid = rp.getOid();
                String value = rp.getValue();

                // 密码
                if(WstResourceOid.RMS_PASSWORD.value().equals(oid)) {
                    dicUser.setPassword(value);
                }
                // 性别
                else if (WstResourceOid.RMS_GENDER.value().equals(oid)) {
                    if ("男".equals(value)) {
                        dicUser.setSex("0");
                    } else if ("女".equals(value)) {
                        dicUser.setSex("1");
                    }
                }
                // 民族
                else if (WstResourceOid.RMS_NATIONALITY.value().equals(oid)) {
                    dicUser.setNation(value);
                }
                // 出生日期
                else if (WstResourceOid.RMS_BIRTHDAY.value().equals(oid)) {
                    dicUser.setBirthday(DateUtil.stringToDate(value, DateUtil.FORMAT_DAY));
                }
                // 出生地
                else if(WstResourceOid.RMS_HOME_PLACE.value().equals(oid)) {
                    dicUser.setBirthplace(value);
                }
                // 职务
                else if(WstResourceOid.RMS_POST_NO.value().equals(oid)) {
                    dicUser.setMainDuty(value);
                }
                // 职务级别
                else if(WstResourceOid.RMS_POST_LEVEL_NO.value().equals(oid)) {
                    // dicUser.setMainDuty(value);
                }
                // 联系电话
                else if(WstResourceOid.RMS_TELEPHONE_NUMBER.value().equals(oid)) {
                    dicUser.setPhone(value);
                }
                // 部门
//                else if(WstResourceOid.RMS_ORG_NO.value().equals(oid)) {
//                    DicDept dicDept = dicDeptService.findUniqueBy("rmsNo", value);
//                    dicUser.setDicDept(dicDept);
//                }
                // 电子邮件
                else if (WstResourceOid.RMS_EMAIL.value().equals(oid)) {
                    dicUser.setEmail(value);
                }
            }

            if (null == dicUser.getPassword() || "".equals(dicUser.getPassword())) {
                String md5Password = MD5Util.MD5(DefaultPassword.pass.value());
                dicUser.setPassword(md5Password);
            }

            dicUserService.save(dicUser);
            tsResponse.setStatus(0);
        } catch (Exception e) {
            e.printStackTrace();
            // 资源保存失败
            tsResponse.setStatus(1);
        }
    }

    /**
     * 保存机构信息资源
     * @param rc
     * @param tsResponse
     */
    @Transactional(rollbackFor = Exception.class)
    public void saveOrg(Resource rc, TrustServiceResponse tsResponse) {

        // 根据推送资源版本判断是否更新数据
        int version = rc.getVersion();

        String rmsNo = rc.getNo();
        WstResource wstResource;

        wstResource= this.findUniqueBy("rmsNo", rmsNo);
        if (null == wstResource) {
            wstResource = new WstResource();
        } else if (wstResource.getRmsVersion() == version) {
            tsResponse.setStatus(0);
            return;
        }

        // 保存资源
        wstResource.setRmsNo(rc.getNo());
        wstResource.setRmsName(rc.getName());
        wstResource.setRmsRmsid(rc.getRmsId());
        wstResource.setRmsStatus(rc.getStatus());
        wstResource.setRmsVersion(version);

        try {
            save(wstResource);
        } catch (Exception e) {
            e.printStackTrace();
            // 资源保存失败
            tsResponse.setStatus(1);
        }

        //TODO: 确认 rc.getName 与 .40
        DicDept dicDept;

        dicDept = dicDeptService.findUniqueBy("deptCode", rmsNo);
        if (null == dicDept) {
            dicDept = new DicDept();
        }

         // 资源信息状态：0-在用，1-停用，2-销毁
        if (ResourceStatus.DEPRECATED.value() == rc.getStatus() ||
                ResourceStatus.DESTROYED.value() == rc.getStatus()) {
            // dicDept.status： 是否删除(1：未删除,0：已删除)
            dicDept.setStatus(0);
        } else {
            dicDept.setStatus(1);
        }
        dicDept.setStatus(0);

//        dicDept.setRmsNo(rc.getNo());
        dicDept.setDeptCode(rc.getNo());
        dicDept.setDeptName(rc.getName());
        dicDept.setUpdEmp("westone");
        dicDept.setUpdDate(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY));

        List<ResourceProperty> propertyList = rc.getProperties();
        for (ResourceProperty rp : propertyList) {
            String oid = rp.getOid();
            String value = rp.getValue();

            // 名称
            if (WstResourceOid.RMS_NAME.value().equals(oid)) {
                dicDept.setDeptName(value);
            }
            // 上级组织架构编码
            else if (WstResourceOid.RMS_PARENT_NO.value().equals(oid)) {
                dicDept.setParentCode(value);
            }
        }

        try {
            dicDeptService.save(dicDept);
            tsResponse.setStatus(0);
        } catch (Exception e) {
            e.printStackTrace();
            tsResponse.setStatus(1);
        }
    }

    /**
     * 保存用户资源
     *
     * @param rc
     * @param tsResponse
     */
    @Transactional(rollbackFor = Exception.class)
    public void saveUserNew(Resource rc, TrustServiceResponse tsResponse) {

        // 根据推送资源版本判断是否更新数据
        int version = rc.getVersion();

        String rmsNo = rc.getNo();
        WstResource wstResource;

        wstResource= this.findUniqueBy("rmsNo", rmsNo);
        if (null == wstResource) {
            wstResource = new WstResource();
        } else if (wstResource.getRmsVersion() == version) {
            tsResponse.setStatus(0);
            return;
        }

        // 保存资源
        wstResource.setRmsNo(rmsNo);
        wstResource.setRmsName(rc.getName());
        wstResource.setRmsRmsid(rc.getRmsId());
        wstResource.setRmsStatus(rc.getStatus());
        wstResource.setRmsVersion(version);

        try {
            save(wstResource);

            WstUser wstUser;

            wstUser = wstUserService.findUniqueBy("rmsNo", rmsNo);
            if (null == wstUser) {
                wstUser = new WstUser();
            }

            wstUser.setRmsName(rc.getName());

//            List<WstUser> wstUserList = wstUserService.findBy("userId", )

            wstUser.setUserId(rc.getName());
            wstUser.setRmsNo(rc.getNo());
            wstUser.setRmsStatus(rc.getStatus());
            wstUser.setUpdDate(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY));
            wstUser.setUpdEmp("westone");

            List<ResourceProperty> propertyList =  rc.getProperties();
            for (ResourceProperty rp: propertyList) {
                String oid = rp.getOid();
                String value = rp.getValue();

                // 密码
                if(WstResourceOid.RMS_PASSWORD.value().equals(oid)) {
                    wstUser.setRmsPassword(value);
                }
                // 性别
                else if (WstResourceOid.RMS_GENDER.value().equals(oid)) {
                    if ("男".equals(value)) {
                        wstUser.setRmsGender("0");
                    } else if ("女".equals(value)) {
                        wstUser.setRmsGender("1");
                    }
                }
                // 民族
                else if (WstResourceOid.RMS_NATIONALITY.value().equals(oid)) {
                    wstUser.setRmsNationality(value);
                }
                // 出生日期
                else if (WstResourceOid.RMS_BIRTHDAY.value().equals(oid)) {
                    wstUser.setRmsBirthday(DateUtil.stringToDate(value, DateUtil.FORMAT_DAY));
                }
                // 出生地
                else if(WstResourceOid.RMS_HOME_PLACE.value().equals(oid)) {
                    wstUser.setRmsHomePlace(value);
                }
                // 职务
                else if(WstResourceOid.RMS_POST_NO.value().equals(oid)) {
                    wstUser.setRmsPostNo(value);
                }
                // 职务级别
                else if(WstResourceOid.RMS_POST_LEVEL_NO.value().equals(oid)) {
                     wstUser.setRmsPostLevelNo(value);
                }
                // 联系电话
                else if(WstResourceOid.RMS_TELEPHONE_NUMBER.value().equals(oid)) {
                    wstUser.setRmsTelephoneNumber(value);
                }
                // 部门
                else if(WstResourceOid.RMS_ORG_NO.value().equals(oid)) {
                    wstUser.setRmsOrgNo(value);
                }
                // 电子邮件
                else if (WstResourceOid.RMS_EMAIL.value().equals(oid)) {
                    wstUser.setRmsEmail(value);
                }
            }

            wstUserService.save(wstUser);
            // 复制人员信息到系统表
            updateDicUser(wstUser);
            // 资源保存成功
            tsResponse.setStatus(0);
        } catch (Exception e) {
            e.printStackTrace();
            // 资源保存失败
            tsResponse.setStatus(1);
        }
    }


    /**
     * 保存机构信息资源
     *
     * @param rc
     * @param tsResponse
     */
    @Transactional(rollbackFor = Exception.class)
    public void saveOrgNew(Resource rc, TrustServiceResponse tsResponse) {

        // 根据推送资源版本判断是否更新数据
        int version = rc.getVersion();

        String rmsNo = rc.getNo();
        WstResource wstResource;

        wstResource= this.findUniqueBy("rmsNo", rmsNo);
        if (null == wstResource) {
            wstResource = new WstResource();
        } else if (wstResource.getRmsVersion() == version) {
            tsResponse.setStatus(0);
            return;
        }

        // 保存资源
        wstResource.setRmsNo(rc.getNo());
        wstResource.setRmsName(rc.getName());
        wstResource.setRmsRmsid(rc.getRmsId());
        wstResource.setRmsStatus(rc.getStatus());
        wstResource.setRmsVersion(version);

        try {
            save(wstResource);
        } catch (Exception e) {
            e.printStackTrace();
            // 资源保存失败
            tsResponse.setStatus(1);
            return;
        }

        WstDept wstDept;

        wstDept = wstDeptService.findUniqueBy("rmsNo", rmsNo);
        if (null == wstDept) {
            wstDept = new WstDept();
        }
        wstDept.setRmsNo(rc.getNo());
        wstDept.setRmsName(rc.getName());
        wstDept.setUpdEmp("westone");
        wstDept.setUpdDate(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY));
        wstDept.setRmsStatus(rc.getStatus());

        List<ResourceProperty> propertyList = rc.getProperties();
        for (ResourceProperty rp : propertyList) {
            String oid = rp.getOid();
            String value = rp.getValue();

            // 名称
            if (WstResourceOid.RMS_NAME.value().equals(oid)) {
                wstDept.setRmsName(value);
            }
            // 上级组织架构编码
            else if (WstResourceOid.RMS_PARENT_NO.value().equals(oid)) {
                wstDept.setRmsParentNo(value);
            }
            // 行政级别 允许值(0-国家、1-省、2-市（地、州）、3-县（区）、4-下级单位、5-直属单位、6-部门、7-小组）
            else if (WstResourceOid.RMS_LEVEL.value().equals(oid)) {
                wstDept.setRmsLevel(value);
            }
        }
        try {
            wstDeptService.save(wstDept);
            // 复制部门信息到系统表
            updateDicDept(wstDept);
            tsResponse.setStatus(0);
        } catch (Exception e) {
            e.printStackTrace();
            tsResponse.setStatus(1);
        }
    }


    /**
     * 更新系统用户表
     *
     * @param wstUser
     */
    private void updateDicUser(WstUser wstUser) {
        Assert.notNull(wstUser, "wstUser不能为空");

        DicUser dicUser;

        dicUser = dicUserService.findUniqueBy("rmsNo", wstUser.getRmsNo());
        if (null == dicUser) {
            dicUser = new DicUser();
            dicUser.setCreateDate(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY));
            // 赋予普通用户权限
            SecRole secRole = secRoleService.get("4");
            List<SecRole> secRoleList = new ArrayList<>();
            secRoleList.add(secRole);
            dicUser.setRoleList(secRoleList);
        }

        copyUser(wstUser, dicUser);
        try {
            dicUserService.save(dicUser);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    /**
     * 更新系统部门表
     *
     * @param wstDept
     */
    private void updateDicDept(WstDept wstDept) {
        Assert.notNull(wstDept, "wstDept不能为空");

        DicDept dicDept;

        dicDept = dicDeptService.findUniqueBy("rmsNo", wstDept.getRmsNo());
        if (null == dicDept) {
            dicDept = new DicDept();
        }

        copyDept(wstDept, dicDept);
        try {
            dicDeptService.save(dicDept);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /**
     * 拷贝用户信息
     *
     * @param wstUser
     * @param dicUser
     */
    private void copyUser(WstUser wstUser, DicUser dicUser) {

        // 设置部门
        String deptNo = wstUser.getRmsOrgNo();
        DicDept dicDept = dicDeptService.findUniqueBy("rmsNo", deptNo);
        dicUser.setDicDept(dicDept);

        dicUser.setRmsNo(wstUser.getRmsNo());
        dicUser.setEmail(wstUser.getRmsEmail());
        dicUser.setPhone(wstUser.getRmsTelephoneNumber());
        dicUser.setEmpName(wstUser.getRmsName());


        // 设置登录名 userId
        List<DicUser> userList = dicUserService.findBy("empName", wstUser.getRmsName());
        // userId 设置为 用户姓名 加上 同名用户的个数 - 1(如有别3个同名用户,则第三个用户的  userId 为 "empName2")
        if (userList != null && userList.size() > 1) {
            dicUser.setUserId(wstUser.getRmsName() + (userList.size() - 1));
        } else {
            // 默认为 用户姓名
            dicUser.setUserId(wstUser.getRmsName());
        }

        dicUser.setSex(wstUser.getRmsGender());

        // 密码
        if (StringUtils.isEmpty(wstUser.getRmsPassword())) {
            String md5Password = MD5Util.MD5(DefaultPassword.pass.value());
            dicUser.setPassword(md5Password);
        } else {
            dicUser.setPassword(wstUser.getRmsPassword());
        }

        dicUser.setCreateDate(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY));

        // WstUser 资源状态（0：在用，1-停用，2-销毁）
        if (wstUser.getRmsStatus().equals(ResourceStatus.DEPRECATED.value()) ||
                wstUser.getRmsStatus().equals(ResourceStatus.DESTROYED.value())) {
            dicUser.setIsactive(0);
        } else {
            dicUser.setIsactive(1);
        }
        dicUser.setUpdEmp(wstUser.getUpdEmp());
        dicUser.setUpdDate(wstUser.getUpdDate());

        dicUser.setBirthday(wstUser.getRmsBirthday());
        dicUser.setBirthplace(wstUser.getRmsHomePlace());
        dicUser.setNation(wstUser.getRmsNationality());
        // 主要职务
        // dicUser.setMainDuty(wstUser.getRmsPostNo());
    }


    /**
     * 拷贝部门信息
     *
     * @param wstDept
     * @param dicDept
     */
    private void copyDept(WstDept wstDept, DicDept dicDept) {
        dicDept.setRmsNo(wstDept.getRmsNo());
        dicDept.setDeptName(wstDept.getRmsName());
        dicDept.setUpdEmp(wstDept.getUpdEmp());
        dicDept.setUpdDate(wstDept.getUpdDate());
        dicDept.setDeptCode(wstDept.getRmsNo());
        dicDept.setParentCode(wstDept.getRmsParentNo());
        // WstDept 资源状态（0：在用，1-停用，2-销毁）
        if (wstDept.getRmsStatus().equals(ResourceStatus.DEPRECATED.value()) ||
                wstDept.getRmsStatus().equals(ResourceStatus.DESTROYED.value())) {
            dicDept.setStatus(0);
        } else {
            dicDept.setStatus(1);
        }
    }
}