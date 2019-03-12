package com.taiji.frame.controller.foreignaffairs.come;

import com.lowagie.text.*;
import com.lowagie.text.Font;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.rtf.RtfWriter2;
import com.lowagie.text.rtf.style.RtfFont;
import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.FileUtil;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeAccompany;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeInfo;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeVisitor;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.come.ComeAccompanyVo;
import com.taiji.frame.model.vo.foreignaffairs.come.ComeVisitorVo;
import com.taiji.frame.service.foreignaffairs.come.ComeAccompanyService;
import com.taiji.frame.service.foreignaffairs.come.ComeInfoService;
import com.taiji.frame.service.foreignaffairs.come.ComePeopleInfoService;
import com.taiji.frame.service.foreignaffairs.come.ComeVisitorService;
import com.taiji.frame.service.systempara.DicParamService;
import com.taiji.frame.service.systempara.DicUserService;
import com.taiji.frame.service.systempara.SysLogService;
import net.sf.json.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.filechooser.FileSystemView;
import java.awt.*;
import java.io.*;
import java.util.*;
import java.util.List;

/**
 * 来访人员名单
 *
 * @author yx
 */
@Controller
@RequestMapping(value = "/come/come-nameBook")
public class ComeNameBookController extends BaseController<ComeAccompany> {
    private static final Logger LOG = LoggerFactory.getLogger(ComeNameBookController.class);

    @Autowired
    ComeAccompanyService comeAccompanyService;

    @Autowired
    ComePeopleInfoService comePeopleInfoService;

    @Autowired
    ComeVisitorService comeVisitorService;

    @Autowired
    DicParamService dicParamService;

    @Autowired
    DicUserService dicUserService;

    @Autowired
    ComeInfoService comeInfoService;

    @Autowired
    private SysLogService sysLogService;
    /**
     * 加载来访人员名单页面
     * @param modelMap
     * @param comeInfoId
     * @return
     */
    @RequestMapping(value = "/load-come-nameBook", method = RequestMethod.GET)
    public String loadNameBook(ModelMap modelMap, String comeInfoId) {
        if (StringUtils.isNotEmpty(comeInfoId))  {
            // 组装陪同人员信息
            List<ComeAccompanyVo> comeAccompanyList  = comeAccompanyService.findAccompanyByComeInfoId(comeInfoId);

            // 组装来访人员信息
            List<ComeVisitorVo> comeVisitorList = comeVisitorService.findVisitorByComeInfoId(comeInfoId);

            // 角色
            List<DicParam> accompanyRoles = dicParamService.getParamByGroupId(5);
            List<DicParam> visitorRoles = dicParamService.getParamByGroupId(6);

            modelMap.addAttribute("comeInfoId", comeInfoId);
            modelMap.addAttribute("accompanyRoles", accompanyRoles);
            modelMap.addAttribute("visitorRoles", visitorRoles);
            modelMap.addAttribute("comeAccompanyList", comeAccompanyList);
            modelMap.addAttribute("comeVisitorList", comeVisitorList);

        }

        return "foreignaffairs/come/come-nameBook";
    }

    /**
     * load grid 陪同人员表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-accompany-list.do", produces = "text/html;charset=UTF-8")
    public String loadAccompanyList(Carrier<ComeAccompany> carrier, String comeInfoId) {
        HashMap map = new HashMap(1);
        try {
            if (!StringUtils.isEmpty(comeInfoId)) {
                map.put("comeInfoId", comeInfoId);
            }
            comeAccompanyService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 拖拽换行
     *
     * @param id
     * @param rowIndex
     * @param flag
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/update-row-index.do", method = RequestMethod.POST)
    public Map<String, Object> updateRowIndex(String id, String rowIndex, String flag) {
        Map<String, Object> map = new HashMap<>(2);


        ComeAccompany comeAccompany;
        List<ComeAccompanyVo> accompanyList;

        if (StringUtils.isNotEmpty(id) && StringUtils.isNotEmpty(rowIndex)) {
            comeAccompany = comeAccompanyService.get(id);
            int oldSorting = comeAccompany.getSeq();
            int newSorting = Integer.parseInt(rowIndex);

            ComeInfo comeInfo = comeAccompany.getComeInfo();
            accompanyList = comeAccompanyService.findAccompanyByComeInfoId(comeInfo.getId());

            for (ComeAccompany accompany : accompanyList) {
                // 从上往下移动
                if (oldSorting < accompany.getSeq() && newSorting >= accompany.getSeq()) {
                    accompany.setSeq(accompany.getSeq() - 1);
                }

                // 从下往上移动
                if (newSorting <= accompany.getSeq() && oldSorting > accompany.getSeq()) {
                    accompany.setSeq(accompany.getSeq() + 1);
                }

                try {
                    comeAccompanyService.save(accompany);
                } catch (Exception e) {
                    LOG.debug(e.getMessage(), e);
                    map.put("result", false);
                }
            }

            comeAccompany.setSeq(newSorting);
            try {
                comeAccompanyService.save(comeAccompany);
            } catch (Exception e) {
                LOG.debug(e.getMessage(), e);
                map.put("result", false);
                return map;
            }
        }

        map.put("result", true);
        return map;
    }


    /**
     * 新增/编辑一条陪同人员
     */
    @ResponseBody
    @RequestMapping(value = "/add-accompany-row.do", method = RequestMethod.POST)
    public Map<String, Object> addAccompanyRow(ComeAccompanyVo comeAccompanyVo) {
        Map<String, Object> map = new HashMap<>(2);

        try {
            ComeInfo comeInfo = comeInfoService.get(comeAccompanyVo.getComeInfoId());
            ComeAccompany comeAccompany = new ComeAccompany();

            BeanUtils.copyProperties(comeAccompanyVo, comeAccompany);

            comeAccompany.setComeInfo(comeInfo);

            String birthdayStr = comeAccompanyVo.getBirthdayStr();
            Date birthday = DateUtil.stringToDate(birthdayStr, DateUtil.FORMAT_DAY);
            comeAccompany.setBirthday(birthday);

            String roleId = comeAccompanyVo.getRoleId();
            DicParam role = dicParamService.get(roleId);
            comeAccompany.setDicParam(role);

            comeAccompany.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT_DAY_HOUR_MIN));
            comeAccompany.setDelFlag("0");

            comeAccompanyService.save(comeAccompany);
            map.put("result", true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("来访人员名单");
            if(org.apache.commons.lang.StringUtils.isEmpty(comeAccompanyVo.getId())){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(comeAccompany.getName());
            sysLogVo.setEntityId(comeAccompany.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }

        return map;
    }

    /**
     * 获取一条陪同人员记录
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/get-one-accompany.do", method = RequestMethod.POST)
    public Map<String, Object> getOneAccompany(String id) {

        Map<String, Object> map = new HashMap<>(2);

        if (StringUtils.isNotEmpty(id)) {

            try {
                ComeAccompany comeAccompany = comeAccompanyService.get(id);

                map.put("accompany", comeAccompany.getJsonObject());
                map.put("result", true);
            } catch (Exception e) {
                map.put("result", false);
                LOG.debug(e.getMessage(), e);
            }
        }
        return map;
    }

    /**
     * 批量导入陪同人员
     */
    @ResponseBody
    @RequestMapping(value = "/import-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveAccompanyImport(ComeAccompanyVo comeAccompanyVo) {
        Map<String, Object> map = new HashMap<>(2);

        try {
            ComeInfo comeInfo = comeInfoService.get(comeAccompanyVo.getComeInfoId());
            JSONArray array = JSONArray.fromObject(comeAccompanyVo.getUserIds());
            for (int i = 0; i < array.size(); i++) {
                ComeAccompany comeAccompany = new ComeAccompany();
                comeAccompany.setComeInfo(comeInfo);

                DicUser user = dicUserService.get((String) array.get(i));
                comeAccompany.setDicUser(user);

                comeAccompany.setName(user.getEmpName());
                comeAccompany.setSex(user.getSex());
                comeAccompany.setBirthday(user.getBirthday());
                comeAccompany.setPersonnelOrg(user.getDicDept().getDeptName());
                comeAccompany.setMainDuty(user.getMainDuty());
                comeAccompany.setTel(StringUtils.isNotEmpty(user.getMobile()) ? user.getMobile() : user.getPhone());

                comeAccompany.setCppccFlag("0");
                comeAccompany.setSeq(i + 1);
                comeAccompany.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT_DAY_HOUR_MIN));
                comeAccompany.setDelFlag("0");

                comeAccompanyService.save(comeAccompany);
            }
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("批量导入陪同人员");
                sysLogVo.setRecordType(6);
            sysLogVo.setEntityName("");
            sysLogVo.setEntityId("");
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }


    /**
     * 删除一条陪同人员记录
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/accompany-delete.do", method = RequestMethod.POST)
    public Map<String, Object> logicDeleteAccompany(String id) {
        Map<String, Object> map = new HashMap<>(1);

        try {
            ComeAccompany accompany = comeAccompanyService.get(id);
            accompany.setDelFlag("1");
            comeAccompanyService.save(accompany);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("陪同人员");
            sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(accompany.getName());
            sysLogVo.setEntityId(accompany.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
            map.put("result", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("result", false);
        }

        return map;
    }

    /**
     * 新增/编辑一条来访人员
     */
    @ResponseBody
    @RequestMapping(value = "/add-visitor-row.do", method = RequestMethod.POST)
    public Map<String, Object> addVisitorRow(ComeVisitorVo comeVisitorVo) {
        Map<String, Object> map = new HashMap<>(2);

        try {
            ComeInfo comeInfo = comeInfoService.get(comeVisitorVo.getComeInfoId());
            ComeVisitor comeVisitor = new ComeVisitor();

            BeanUtils.copyProperties(comeVisitorVo, comeVisitor);

            comeVisitor.setComeInfo(comeInfo);

            String birthdayStr = comeVisitorVo.getBirthdayStr();
            Date birthday = DateUtil.stringToDate(birthdayStr, DateUtil.FORMAT_DAY);
            comeVisitor.setBirthday(birthday);

            String roleId = comeVisitorVo.getRoleId();
            DicParam role = dicParamService.get(roleId);
            comeVisitor.setDicParam(role);

            comeVisitor.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT_DAY_HOUR_MIN));
            comeVisitor.setDelFlag("0");

            comeVisitorService.save(comeVisitor);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("来访人员");
            if(org.apache.commons.lang.StringUtils.isEmpty(comeVisitorVo.getId())){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(comeVisitor.getName());
            sysLogVo.setEntityId(comeVisitor.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }

        return map;
    }

    /**
     * 获取一条来访人员记录
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/get-one-visitor.do", method = RequestMethod.POST)
    public Map<String, Object> getOneVisitor(String id) {

        Map<String, Object> map = new HashMap<>(2);

        if (StringUtils.isNotEmpty(id)) {
            try {
                ComeVisitor comeVisitor = comeVisitorService.get(id);

                map.put("visitor", comeVisitor.getJsonObject());
                map.put("result", true);
            } catch (Exception e) {
                map.put("result", false);
                LOG.debug(e.getMessage(), e);
            }
        }
        return map;
    }


    /**
     * 删除一条来访人员记录
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/visitor-delete.do", method = RequestMethod.POST)
    public Map<String, Object> logicDeleteVisitor(String id) {
        Map<String, Object> map = new HashMap<>(1);


        try {
            ComeVisitor visitor = comeVisitorService.get(id);
            visitor.setDelFlag("1");
            comeVisitorService.save(visitor);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("来访人员");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(visitor.getName());
            sysLogVo.setEntityId(visitor.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("result", false);
        }

        return map;
    }


    /**
     * 导出Word 来访人员名单
     */
    @RequestMapping(value = "/come-visitor-export.do",method = RequestMethod.POST)
    public void exportWord(String comeInfoId, HttpServletRequest request, HttpServletResponse response)
            throws IOException, DocumentException {
        if (StringUtils.isNotEmpty(comeInfoId)){
            ComeInfo comeInfo = comeInfoService.get(comeInfoId);
            List<ComeVisitorVo> comeVisitorList = comeVisitorService.findVisitorByComeInfoId(comeInfoId);
            //导出Word
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("导出Word 来访人员名单");
            sysLogVo.setRecordType(7);
            sysLogVo.setEntityName("");
            sysLogVo.setEntityId("");
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
            this.export(comeInfo, comeVisitorList, request, response);
        }
    }

    /**
     * 导出Word 文件
     * @param comeInfo
     * @param comeVisitorList
     * @param request
     * @throws DocumentException
     * @throws IOException
     */
    private void export(ComeInfo comeInfo, List<ComeVisitorVo> comeVisitorList,
                        HttpServletRequest request, HttpServletResponse response)
            throws DocumentException, IOException {
        //设置纸张大小
        Document document = new Document(PageSize.A4, 90.0F, 90.0F, 72.0F, 72.0F);

        // 创建临时文件
        String uploadPath = request.getSession().getServletContext().getRealPath("upload");
        File f = new File(uploadPath);
        //文件夹不存在
        if(!f.exists())
        {
            f.mkdirs();
        }
        String fileName =  comeInfo.getGroupName() + "一行名单.doc";
        String temp = uploadPath + File.separator + fileName;
        File file = new File(temp);

        RtfWriter2.getInstance(document, new FileOutputStream(file));
        document.open();

        //设置标题字体风格
        RtfFont titleFont = new RtfFont("华文中宋", 22, Font.BOLD, Color.BLACK);

        //设置正文字体风格
        float contextFontSize = 12;
        RtfFont contextFont = new RtfFont("宋体", contextFontSize, Font.NORMAL);

        //标题 --- 来访人员名单
        String titleStr = comeInfo.getGroupName() + "名单";
        Paragraph title = new Paragraph(titleStr);
        //设置标题格式对齐方式
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(24);
        title.setFont(titleFont);
        document.add(title);

        int count = 0;
        for(ComeVisitor visitor : comeVisitorList) {
            count += 1;

            // 中文名
            String cnNameStr = (visitor.getCnName() == null ? "" : visitor.getCnName());
            Paragraph cnName = new Paragraph(String.valueOf(count) + "、 " + cnNameStr);
            cnName.setSpacingAfter(6);
            cnName.setFont(contextFont);

            // 外文名
            String nameStr = (visitor.getName() == null ? "" :visitor.getName());
            Paragraph name = new Paragraph(nameStr);
            name.setFont(contextFont);
            name.setSpacingAfter(6);
            name.setIndentationLeft(contextFontSize * 2);

            // 职务信息等
            String sexStr;
            String sex = visitor.getSex();
            if ("0".equals(sex)) {
                sexStr = "男";
            } else if ("1".equals(sex)) {
                sexStr = "女";
            } else {
                sexStr = "未知";
            }
            String dutyStr = visitor.getDuty();
            String descriptionStr = sexStr + "，" + dutyStr;
            Paragraph description = new Paragraph(descriptionStr);
            description.setFont(contextFont);
            description.setSpacingAfter(6);
            description.setIndentationLeft(contextFontSize * 2);

            document.add(cnName);
            document.add(name);
            document.add(description);
        }

        document.close();

        FileUtil.downOrPreview(fileName, temp, response, request,"0");

        file.delete();
    }
}
