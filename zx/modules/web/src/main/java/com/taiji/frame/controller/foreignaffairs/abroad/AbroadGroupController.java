package com.taiji.frame.controller.foreignaffairs.abroad;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.StringUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadGroup;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadInfo;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadNation;
import com.taiji.frame.model.entity.pubinfo.schedule.DutyDaily;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.abroad.AbroadGroupVo;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadGroupService;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadGroupUserService;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadInfoService;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadNationService;
import com.taiji.frame.service.systempara.DicParamService;
import com.taiji.frame.service.systempara.DicUserService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping(value = "/abroad-group")
public class AbroadGroupController extends BaseController<AbroadGroup> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private AbroadInfoService abroadInfoService;

    @Autowired
    private AbroadGroupService abroadGroupService;

    @Autowired
    private DicParamService dicParamService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private AbroadGroupUserService abroadGroupUserService;

    @Autowired
    private AbroadNationService abroadNationService;

    @Autowired
    private DicUserService dicUserService;
    @Autowired
    private SysLogService sysLogService;


    /**
     * 页面跳转
     */
    @RequestMapping(value = "/abroad-group-list", method = RequestMethod.GET)
    public String list(String abroadInfoId, ModelMap modelMap) {
        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_YYYYMMDD);
        modelMap.addAttribute("abroadInfoId", abroadInfoId);
        modelMap.addAttribute("sysDate", sysDate);
        return "foreignaffairs/abroad/abroad-group-list";
    }

    /**
     * load grid表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-group-list-in.do", produces = "text/html;charset=UTF-8")
    public String groupListLoadIn(Carrier<AbroadGroup> carrier, AbroadGroupVo abroadGroupVo) {
        HashMap map = new HashMap(16);
        try {
            if (!StringUtils.isEmpty(abroadGroupVo.getAbroadInfoId())) {
                map.put("abroadInfoId", abroadGroupVo.getAbroadInfoId());
            }
            map.put("flag", "in");
            abroadGroupService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 新增/编辑弹窗
     */
    @RequestMapping(value = "/load-group-edit.do", method = RequestMethod.GET)
    public String abroadGroupEdit(ModelMap modelMap, String id, String flag) {
        AbroadGroup abroadGroup = null;
        if (!StringUtils.isEmpty(id)) {
            abroadGroup = abroadGroupService.get(id);
        }
        modelMap.addAttribute("abroadGroup", abroadGroup);

        List<DicParam> roleList = dicParamService.getParamByGroupId(12);

        List<DicParam> list = new ArrayList<>();
        for (DicParam dicParam : roleList) {
            if (!"团长".equals(dicParam.getName())) {
                list.add(dicParam);
            }
        }

        // 外部人员不能选择为团长
        if ("out".equals(flag)) {
            modelMap.addAttribute("roleList", list);
        } else {
            modelMap.addAttribute("roleList", roleList);
        }

        return "foreignaffairs/abroad/abroad-group-edit";
    }

    /**
     * 新增/编辑保存
     */
    @ResponseBody
    @RequestMapping(value = "/abroad-group-edit-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveAbroadGroup(HttpServletRequest request, AbroadGroupVo abroadGroupVo) {
        Map<String, Object> map = new HashMap<>(2);

        AbroadGroup abroadGroup;
        String id = abroadGroupVo.getId();
        AbroadInfo abroadInfo = abroadInfoService.get(abroadGroupVo.getAbroadInfoId());
        DicParam role = dicParamService.get(abroadGroupVo.getRoleId());


        if (id != null) {
            abroadGroup = abroadGroupService.get(id);
            String gId = abroadGroup.getDicUser() == null ? "" : abroadGroup.getDicUser().getId();

            // 当旧团长被修改为其他角色时，将团组中的团长置为空
            DicUser groupLeader = abroadInfo.getGroupLeader();
            if (groupLeader != null && groupLeader.getId().equals(gId) && !"1201".equals(role.getId())) {
                abroadInfo.setGroupLeader(null);
                map.put("change", true);
                map.put("leaderName", "");
            }
        } else {
            // 新增外部人员
            abroadGroup = new AbroadGroup();
            abroadGroup.setSorting(abroadGroupVo.getPeopleNum() + 1);
            abroadGroup.setCreateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
        }

        try {
            abroadGroup.setAbroadInfo(abroadInfo);

            abroadGroup.setName(abroadGroupVo.getName());
            abroadGroup.setSex(abroadGroupVo.getSex());

            if (StringUtils.isNotEmpty(abroadGroupVo.getBirthdayStr())) {
                Date birthday = DateUtil.stringToDate(abroadGroupVo.getBirthdayStr(), DateUtil.FORMAT_DAY);
                abroadGroup.setBirthday(birthday);
            }
            abroadGroup.setHomeplace(abroadGroupVo.getHomeplace());
            abroadGroup.setOrg(abroadGroupVo.getOrg());
            abroadGroup.setDuty(abroadGroupVo.getDuty());
            abroadGroup.setTel(abroadGroupVo.getTel());

            // 设置团组信息中团长
            if ("1201".equals(role.getId())) {
                abroadInfo.setGroupLeader(abroadGroup.getDicUser());
                abroadInfo.setLeaderName(abroadGroup.getDicUser().getEmpName());
                map.put("change", true);
                map.put("leaderName", abroadGroup.getName());
            }
            abroadGroup.setRole(role);

            abroadGroup.setIdentity(abroadGroupVo.getIdentity());
            abroadGroup.setAdminLevel(abroadGroupVo.getAdminLevel());
            abroadGroup.setPersonFlag(abroadGroupVo.getPersonFlag());
            abroadGroup.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
            abroadGroup.setDelFlag("0");

            abroadInfoService.save(abroadInfo);
            abroadGroupService.save(abroadGroup);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("出访信息");
            if(org.apache.commons.lang.StringUtils.isEmpty(abroadGroupVo.getId())){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(abroadGroup.getName());
            sysLogVo.setEntityId(abroadGroup.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 删除
     */
    @ResponseBody
    @RequestMapping(value = "/abroad-group-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteAbroadGroup(String id) {
        Map<String, Object> map = new HashMap<>(2);
        try {
            AbroadGroup abroadGroup = abroadGroupService.get(id);
            String gId = abroadGroup.getDicUser() == null ? "" : abroadGroup.getDicUser().getId();
            AbroadInfo abroadInfo = abroadGroup.getAbroadInfo();
            DicUser groupLeader = abroadInfo.getGroupLeader();

            if (groupLeader != null) {
                if (groupLeader.getId().equals(gId) || "".equals(gId)) {
                    abroadInfo.setGroupLeader(null);
                    abroadInfoService.save(abroadInfo);
                    map.put("delLeader", true);
                }
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("出访信息");
                    sysLogVo.setRecordType(2);
                sysLogVo.setEntityName(abroadGroup.getName());
                sysLogVo.setEntityId(abroadGroup.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }

            abroadGroupService.delete(abroadGroup);
            map.put("result", true);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 保存导入的人员
     *
     * @param request
     * @param abroadGroupVo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/abroad-group-user-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveAbroadGroupUser(HttpServletRequest request, AbroadGroupVo abroadGroupVo) {
        Map<String, Object> map = new HashMap<>(2);

        try {
            AbroadInfo abroadInfo = abroadInfoService.get(abroadGroupVo.getAbroadInfoId());
            JSONArray array = JSONArray.fromObject(abroadGroupVo.getUserIds());
            for (int i = 0; i < array.size(); i++) {
                AbroadGroup abroadGroup = new AbroadGroup();
                abroadGroup.setAbroadInfo(abroadInfo);

                DicUser user = dicUserService.get((String) array.get(i));
                abroadGroup.setDicUser(user);

                abroadGroup.setName(user.getEmpName());
                abroadGroup.setSex(user.getSex());
                abroadGroup.setBirthday(user.getBirthday());
                abroadGroup.setHomeplace(user.getBirthplace());
                abroadGroup.setOrg(user.getDicDept().getDeptName());
                abroadGroup.setDuty(user.getMainDuty());
                abroadGroup.setTel(StringUtils.isNotEmpty(user.getMobile()) ? user.getMobile() : user.getPhone());
                abroadGroup.setAdminLevel(user.getDicParam() == null ? null : user.getDicParam().getName());
                abroadGroup.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
                abroadGroup.setCreateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
                abroadGroup.setSorting(i + 1);
                abroadGroup.setDelFlag("0");

                abroadGroupService.save(abroadGroup);
            }
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("保存导入的人员");
            sysLogVo.setRecordType(0);
            sysLogVo.setEntityName(abroadGroupVo.getName());
            sysLogVo.setEntityId(abroadGroupVo.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * load grid表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-group-list-out.do", produces = "text/html;charset=UTF-8")
    public String groupListLoadOut(Carrier<AbroadGroup> carrier, AbroadGroupVo abroadGroupVo) {
        HashMap map = new HashMap(16);
        try {
            if (!StringUtils.isEmpty(abroadGroupVo.getAbroadInfoId())) {
                map.put("abroadInfoId", abroadGroupVo.getAbroadInfoId());
            }
            map.put("flag", "out");
            abroadGroupService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    @RequestMapping(value = "/group-preview-in.do", method = RequestMethod.GET)
    public String findGroupIn(ModelMap modelMap, String data, String type) {
        AbroadInfo abroadInfo = null;
        List<AbroadGroup> abroadGroupList = new ArrayList<>();
        if ("part".equals(type)) {
            JSONArray array = JSONArray.fromObject(data);
            for (int i = 0; i < array.size(); i++) {
                AbroadGroup abroadGroup = abroadGroupService.get((String) array.get(i));
                abroadGroupList.add(abroadGroup);
                if (i == 0) {
                    abroadInfo = abroadGroup.getAbroadInfo();
                }
            }
        } else {
            JSONObject jsonObject = JSONObject.fromObject(data);
            String abroadInfoId = jsonObject.getString("abroadInfoId");
            abroadInfo = abroadInfoService.get(abroadInfoId);
            abroadGroupList = abroadGroupService.findAbroadGroupByParams(abroadInfoId, "in");
        }
        modelMap.addAttribute("abroadGroupList", abroadGroupList);

        modelMap.addAttribute("batchNumber", abroadInfo.getBatchNumber());
        modelMap.addAttribute("groupLeader", abroadInfo.getGroupLeader());
        modelMap.addAttribute("totalNum", abroadInfo.getTotalNum());
        modelMap.addAttribute("startDateStr", ((JSONObject) abroadInfo.getJsonObject()).get("startDateStr"));
        modelMap.addAttribute("endDateStr", ((JSONObject) abroadInfo.getJsonObject()).get("endDateStr"));

        Calendar calendar = Calendar.getInstance();

        Date startDate = abroadInfo.getStartDate();
        calendar.setTime(startDate);
        modelMap.addAttribute("startYear", calendar.get(Calendar.YEAR));
        modelMap.addAttribute("startMonth", calendar.get(Calendar.MONTH));
        modelMap.addAttribute("startDate", calendar.get(Calendar.DATE));

        Date endDate = abroadInfo.getEndDate();
        calendar.setTime(endDate);
        modelMap.addAttribute("endYear", calendar.get(Calendar.YEAR));
        modelMap.addAttribute("endMonth", calendar.get(Calendar.MONTH));
        modelMap.addAttribute("endDate", calendar.get(Calendar.DATE));

        StringBuffer nations = new StringBuffer();
        StringBuffer trses = new StringBuffer();
        List<AbroadNation> abroadNationList = abroadNationService.findAbroadNationList(abroadInfo.getId());
        for (int i = 0; i < abroadNationList.size(); i++) {
            if (i == 0) {
                nations.append(abroadNationList.get(i).getNationName());
                if (StringUtils.isNotBlank(abroadNationList.get(i).getTrsCountry())) {
                    trses.append(abroadNationList.get(i).getTrsCountry());
                }
            } else {
                nations.append("、" + abroadNationList.get(i).getNationName());
                if (StringUtils.isNotBlank(abroadNationList.get(i).getTrsCountry())) {
                    trses.append("、" + abroadNationList.get(i).getTrsCountry());
                }
            }
        }
        modelMap.addAttribute("nations", nations.toString());
        modelMap.addAttribute("trses", trses.toString());

        modelMap.addAttribute("abroadTask", abroadInfo.getAbroadTask().getName());
        modelMap.addAttribute("abroadDays", abroadInfo.getAbroadDays());
        modelMap.addAttribute("costSource", abroadInfo.getCostSource().getName());

        Date sysDate = utilService.getSysTime();
        calendar.setTime(sysDate);
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        int day = calendar.get(Calendar.DAY_OF_MONTH);
        modelMap.addAttribute("year", year);
        modelMap.addAttribute("month", month);
        modelMap.addAttribute("day", day);

        return "foreignaffairs/abroad/abroad-group-preview-in";
    }

    @RequestMapping(value = "/group-namebook-in.do", method = RequestMethod.GET)
    public String findNamebookIn(ModelMap modelMap, String data, String type) {
        AbroadInfo abroadInfo = null;
        List<AbroadGroup> abroadGroupList = new ArrayList<>();
        if ("part".equals(type)) {
            JSONArray array = JSONArray.fromObject(data);
            for (int i = 0; i < array.size(); i++) {
                AbroadGroup abroadGroup = abroadGroupService.get((String) array.get(i));
                abroadGroupList.add(abroadGroup);
                if (i == 0) {
                    abroadInfo = abroadGroup.getAbroadInfo();
                }
            }
        } else {
            JSONObject jsonObject = JSONObject.fromObject(data);
            String abroadInfoId = jsonObject.getString("abroadInfoId");
            abroadInfo = abroadInfoService.get(abroadInfoId);
            abroadGroupList = abroadGroupService.findAbroadGroupByParams(abroadInfoId, "in");
        }
        modelMap.addAttribute("abroadGroupList", abroadGroupList);
        Date sysDate = utilService.getSysTime();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(sysDate);
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        int day = calendar.get(Calendar.DAY_OF_MONTH);
        modelMap.addAttribute("year", year);
        modelMap.addAttribute("month", month);
        modelMap.addAttribute("day", day);
        modelMap.addAttribute("innerNum", abroadGroupList.size());
        return "foreignaffairs/abroad/abroad-group-namebook-in";
    }


    @RequestMapping(value = "/group-preview-out.do", method = RequestMethod.GET)
    public String findGroupOut(ModelMap modelMap, String data, String type) {
        AbroadInfo abroadInfo = null;
        String org = null;
        String num = null;
        StringBuffer names = new StringBuffer();
        List<AbroadGroup> abroadGroupList = new ArrayList<>();
        if ("part".equals(type)) {
            JSONArray array = JSONArray.fromObject(data);
            num = String.valueOf(array.size());
            for (int i = 0; i < array.size(); i++) {
                AbroadGroup abroadGroup = abroadGroupService.get((String) array.get(i));
                abroadGroupList.add(abroadGroup);
                if (i == 0) {
                    abroadInfo = abroadGroup.getAbroadInfo();
                    org = abroadGroup.getOrg();
                    names.append(abroadGroup.getName());
                } else {
                    names.append("、" + abroadGroup.getName());
                }
            }
        } else {
            JSONObject jsonObject = JSONObject.fromObject(data);
            String abroadInfoId = jsonObject.getString("abroadInfoId");
            abroadInfo = abroadInfoService.get(abroadInfoId);
            abroadGroupList = abroadGroupService.findAbroadGroupByParams(abroadInfoId, "out");
            num = String.valueOf(abroadGroupList.size());
            for (int i = 0; i < abroadGroupList.size(); i++) {
                if (i == 0) {
                    org = abroadGroupList.get(i).getOrg();
                    names.append(abroadGroupList.get(i).getName());
                } else {
                    names.append("、" + abroadGroupList.get(i).getName());
                }
            }
        }
        modelMap.addAttribute("num", num);
        modelMap.addAttribute("names", names);
        modelMap.addAttribute("abroadGroupList", abroadGroupList);

        modelMap.addAttribute("org", org);
        modelMap.addAttribute("batchNumber", abroadInfo.getBatchNumber());
        modelMap.addAttribute("groupLeader", abroadInfo.getGroupLeader());
        modelMap.addAttribute("totalNum", abroadInfo.getTotalNum());
        modelMap.addAttribute("startDateStr", ((JSONObject) abroadInfo.getJsonObject()).get("startDateStr"));
        modelMap.addAttribute("endDateStr", ((JSONObject) abroadInfo.getJsonObject()).get("endDateStr"));
        Calendar calendar = Calendar.getInstance();

        Date startDate = abroadInfo.getStartDate();
        calendar.setTime(startDate);
        modelMap.addAttribute("startYear", calendar.get(Calendar.YEAR));
        modelMap.addAttribute("startMonth", calendar.get(Calendar.MONTH));
        modelMap.addAttribute("startDate", calendar.get(Calendar.DATE));

        Date endDate = abroadInfo.getEndDate();
        calendar.setTime(endDate);
        modelMap.addAttribute("endYear", calendar.get(Calendar.YEAR));
        modelMap.addAttribute("endMonth", calendar.get(Calendar.MONTH));
        modelMap.addAttribute("endDate", calendar.get(Calendar.DATE));


        StringBuffer nations = new StringBuffer();
        StringBuffer trses = new StringBuffer();
        List<AbroadNation> abroadNationList = abroadNationService.findAbroadNationList(abroadInfo.getId());
        for (int i = 0; i < abroadNationList.size(); i++) {
            if (i == 0) {
                nations.append(abroadNationList.get(i).getNationName());
                if (StringUtils.isNotBlank(abroadNationList.get(i).getTrsCountry())) {
                    trses.append(abroadNationList.get(i).getTrsCountry());
                }
            } else {
                nations.append("、" + abroadNationList.get(i).getNationName());
                if (StringUtils.isNotBlank(abroadNationList.get(i).getTrsCountry())) {
                    trses.append("、" + abroadNationList.get(i).getTrsCountry());
                }
            }
        }
        modelMap.addAttribute("nations", nations.toString());
        modelMap.addAttribute("trses", trses.toString());

        modelMap.addAttribute("abroadTask", abroadInfo.getAbroadTask().getName());
        modelMap.addAttribute("abroadDays", abroadInfo.getAbroadDays());
        modelMap.addAttribute("costSource", abroadInfo.getCostSource().getName());

        Date sysDate = utilService.getSysTime();
        calendar.setTime(sysDate);
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        int day = calendar.get(Calendar.DAY_OF_MONTH);
        modelMap.addAttribute("year", year);
        modelMap.addAttribute("month", month);
        modelMap.addAttribute("day", day);

        return "foreignaffairs/abroad/abroad-group-preview-out";
    }

    /**
     * 表格换行，更新排序号
     *
     * @param id
     * @param rowIndex
     */
    @ResponseBody
    @RequestMapping(value = "/update-row-index.do", method = RequestMethod.POST)
    public Map<String, Object> updateRowIndex(String id, String rowIndex, String flag) {
        Map<String, Object> map = new HashMap<>(2);

        AbroadGroup abroadGroup;
        List<AbroadGroup> abroadGroupList;

        if (StringUtils.isNotEmpty(id) && StringUtils.isNotEmpty(rowIndex)) {
            abroadGroup = abroadGroupService.get(id);
            int oldSorting = abroadGroup.getSorting();
            int newSorting = Integer.parseInt(rowIndex);

            AbroadInfo abroadInfo = abroadGroup.getAbroadInfo();
            abroadGroupList = abroadGroupService.findAbroadGroupByParams(abroadInfo.getId(), flag);

            for (AbroadGroup ag : abroadGroupList) {
                // 从上往下移动
                if (oldSorting < ag.getSorting() && newSorting >= ag.getSorting()) {
                    ag.setSorting(ag.getSorting() - 1);
                    ag.setUpdateTime(utilService.getSysTime());
                }

                // 从下往上移动
                if (newSorting <= ag.getSorting() && oldSorting > ag.getSorting()) {
                    ag.setSorting(ag.getSorting() + 1);
                }

                try {
                    abroadGroupService.save(ag);
                } catch (Exception e) {
                    LOG.debug(e.getMessage(), e);
                    map.put("result", false);
                }
            }

            abroadGroup.setSorting(newSorting);
            try {
                abroadGroupService.save(abroadGroup);
            } catch (Exception e) {
                LOG.debug(e.getMessage(), e);
                map.put("result", false);
                return map;
            }
        }

        map.put("result", true);
        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("更新排序号");
        sysLogVo.setRecordType(0);
        sysLogVo.setEntityName("");
        sysLogVo.setEntityId("");
        sysLogVo.setResult("true");
        sysLogService.record(sysLogVo);
        return map;
    }

}
