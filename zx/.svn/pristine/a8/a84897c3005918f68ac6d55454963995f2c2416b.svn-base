package com.taiji.frame.controller.foreignaffairs.taiwan;

import com.lowagie.text.*;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.rtf.RtfWriter2;
import com.lowagie.text.rtf.style.RtfFont;
import com.taiji.frame.BaseController;
import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.FileUtil;
import com.taiji.frame.model.entity.foreignaffairs.taiwan.TaiWanParty;
import com.taiji.frame.model.entity.foreignaffairs.taiwan.TaiWanPartyFile;
import com.taiji.frame.model.entity.foreignaffairs.taiwan.TaiWanPolitics;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.taiwan.TaiWanPartyVo;
import com.taiji.frame.service.foreignaffairs.taiwan.TaiWanPartyFileService;
import com.taiji.frame.service.foreignaffairs.taiwan.TaiWanPartyService;
import com.taiji.frame.service.foreignaffairs.taiwan.TaiWanPoliticsService;
import com.taiji.frame.service.systempara.DicUploadFileService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.filechooser.FileSystemView;
import java.awt.*;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.ParseException;
import java.util.*;
import java.util.List;


/**
 * @author qzp
 * @date 2018/08/07
 * 台湾社团信息控制器
 */
@Controller
@RequestMapping(value = "/taiwan-party")
public class TaiWanPartyController extends BaseController<TaiWanParty> {
    private static final Logger LOGGER = LoggerFactory.getLogger(TaiWanPartyController.class);

    @Autowired
    private TaiWanPartyService taiWanPartyService;

    @Autowired
    private TaiWanPartyFileService taiWanPartyFileService;

    @Autowired
    private DicUploadFileService dicUploadFileService;

    @Autowired
    private TaiWanPoliticsService taiWanPoliticsService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private SysLogService sysLogService;
    /**
     * 页面跳转
     * @return
     */
    @RequestMapping(value = "/taiwan-party-list",method = RequestMethod.GET)
    public String jumpToPage(){
        return "foreignaffairs/taiwan/taiwan-party-list";
    }

    /**
     * 台湾社团信息列表
     * @param carrier
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-taiwan-party-list.do",produces = "text/html;charset=UTF-8")
    public String list(Carrier<TaiWanParty> carrier,String partyName){
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            if (StringUtils.isNotEmpty(partyName)){
                map.put("partyName","%" + partyName + "%");
            }
            taiWanPartyService.load(carrier,map);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(),e);
        }
        String s = gridResult(carrier);
        System.out.println("sr12:"+s);
        return gridResult(carrier);
    }

    /**
     * 跳转到新增或编辑页面
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/load-taiwan-party-edit",method = RequestMethod.GET)
    public String jumpEditPage(ModelMap modelMap, String id){
        TaiWanParty taiWanParty = null;
        JSONArray jsonFileList = new JSONArray();
        if(StringUtils.isNotEmpty(id)){
            //编辑
            taiWanParty = taiWanPartyService.get(id);
            List<TaiWanPartyFile> list = taiWanParty.getWanPartyFileList();
            if(list.isEmpty()){
                modelMap.put("jsonFileList", null);
            }else {
                for (TaiWanPartyFile taiWanPartyFile :list){
                    JSONObject jsonObject = new JSONObject();
                    String fileId = taiWanPartyFile.getFileId();
                    String fileName = taiWanPartyFile.getFileName();
                    jsonObject.put("id",fileId);
                    jsonObject.put("fileName",fileName);
                    jsonFileList.add(jsonObject);
                }
                modelMap.put("jsonFileList", jsonFileList);
            }
        }
        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        modelMap.addAttribute("sysDate", sysDate);
        modelMap.addAttribute("taiWanParty",taiWanParty);
        modelMap.addAttribute("filesList",null);
        return "foreignaffairs/taiwan/taiwan-party-edit";
    }

    /**
     * 新增或编辑数据保存
     * @param taiWanPartyVo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-taiwan-party-save.do",method = RequestMethod.POST)
    public Map<String,Object> saveOrUpdate(@RequestBody TaiWanPartyVo taiWanPartyVo, HttpServletRequest request) throws ParseException{
        String basePath = UploadConstant.uploadBaseDir;
        Map<String,Object> map = taiWanPartyService.saveData(taiWanPartyVo,basePath,getSysLogVo());
        return map;
    }

    /**
     * 删除某个文件
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/taiwan-party-file-delete.do",method = RequestMethod.POST)
    public Map<String,Object> documentDeleteById(String id){
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            if (StringUtils.isNotEmpty(id)){
                TaiWanPartyFile taiWanPartyFile =taiWanPartyFileService.findByFileId(id);
                DicUploadFile uploadFile = dicUploadFileService.get(id);
                String path = uploadFile.getPath();
                taiWanPartyFileService.delete(taiWanPartyFile.getId());
                File file = new File(path);
                if (file.exists()){
                    file.delete();
                    map.put("result",true);
                    SysLogVo sysLogVo = getSysLogVo();
                    sysLogVo.setTypeName("台湾社团信息");
                        sysLogVo.setRecordType(1);
                    sysLogVo.setEntityName("删除某个文件");
                    sysLogVo.setEntityId("");
                    sysLogVo.setResult("true");
                    sysLogService.record(sysLogVo);


                }else {
                    map.put("result",false);
                }
            }
        } catch (Exception e) {
            LOGGER.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 查看详情
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/load-taiwan-party-view",method = RequestMethod.GET)
    public String view (ModelMap modelMap,String id){
        TaiWanParty taiWanParty = null;
        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(id)){
            taiWanParty = taiWanPartyService.get(id);
            modelMap.addAttribute("taiWanParty",taiWanParty);
            List<TaiWanPartyFile> list = taiWanParty.getWanPartyFileList();
            modelMap.addAttribute("list",list);
            map.put("id",id);
            List<TaiWanPolitics> politicsList = taiWanPoliticsService.findByCardId(map);
            modelMap.addAttribute("politicsList",politicsList);
        }else {
            modelMap.addAttribute("taiWanParty", null);
        }
        return "foreignaffairs/taiwan/taiwan-party-view";
    }

    /**
     * 生成Word预览
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/load-taiwan-party-preview.do",method = RequestMethod.GET)
    public String preview (ModelMap modelMap,String id){
        TaiWanParty taiWanParty = null;
        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(id)){
            taiWanParty = taiWanPartyService.get(id);
            modelMap.addAttribute("taiWanParty",taiWanParty);
            List<TaiWanPartyFile> list = taiWanParty.getWanPartyFileList();
            modelMap.addAttribute("list",list);
            map.put("id",id);
            List<TaiWanPolitics> politicsList = taiWanPoliticsService.findByCardId(map);
            modelMap.addAttribute("politicsList",politicsList);
        }else {
            modelMap.addAttribute("taiWanParty", null);
        }
        return "foreignaffairs/taiwan/taiwan-party-preview";
    }

    /**
     * 删除某条信息
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-taiwan-party-delete.do",method = RequestMethod.POST)
    public Map<String,Object> delTaiwanParty(String id){
        HashMap<String, Object> map = new HashMap<>(3);
        try {
            TaiWanParty taiWanParty = taiWanPartyService.get(id);
            taiWanParty.setDelFlag("1");
            List<TaiWanPolitics> taiWanPoliticsList = taiWanParty.getTaiWanPoliticsList();
            for (TaiWanPolitics p:taiWanPoliticsList) {
                p.setDelFlag("1");
            }
            taiWanPartyService.save(taiWanParty);
            map.put("result",true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("台湾社团信息");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(taiWanParty.getPartyName());
            sysLogVo.setEntityId(taiWanParty.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);

        } catch (Exception e) {
            LOGGER.error(e.getMessage(),e);
            map.put("result",false);
            return map;
        }
        return map;
    }

    /**
     * 导出Word文件
     */
    @RequestMapping(value = "/load-taiwan-party-export",method = RequestMethod.POST)
    public void ExportWord(String id,HttpServletRequest request,HttpServletResponse response)throws Exception{
        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(id)){
            TaiWanParty taiWanParty = taiWanPartyService.get(id);
            List<TaiWanPartyFile> picList = taiWanParty.getWanPartyFileList();
            List<DicUploadFile> files = new ArrayList<>();
            map.put("id",id);
            List<TaiWanPolitics> politicsList = taiWanPoliticsService.findByCardId(map);
            if(null != picList && picList.size() > 0){
                for (TaiWanPartyFile taiWanPartyFile :picList){
                    String fileId = taiWanPartyFile.getFileId();
                    DicUploadFile dicUploadFile = dicUploadFileService.get(fileId);
                    files.add(dicUploadFile);
                }
            }
            //导出Word
            this.export(taiWanParty,files,politicsList,request,response);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("台湾社团信息");
            sysLogVo.setRecordType(7);
            sysLogVo.setEntityName(taiWanParty.getPartyName());
            sysLogVo.setEntityId(taiWanParty.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        }
    }

    /**
     * 导出Word文件
     * @param taiWanParty
     * @param files
     * @param politicsList
     * @throws DocumentException
     * @throws IOException
     * @throws BadElementException
     */
    private void export(TaiWanParty taiWanParty,
                        List<DicUploadFile> files,
                              List<TaiWanPolitics> politicsList,
                        HttpServletRequest request,
                        HttpServletResponse response)
            throws DocumentException,
            IOException {
        //设置纸张大小
        Document document = new Document(PageSize.A4);
        //建立一个书写器与document对象关联,通过书写器(writer)将文档写到磁盘中
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        // 创建临时文件
        String uploadPath = request.getSession().getServletContext().getRealPath("upload");
        File f = new File(uploadPath);
        //文件夹不存在
        if(!f.exists())
        {
            f.mkdirs();
        }
        String fileName = taiWanParty.getPartyName() + ".doc";
        String temp = uploadPath + File.separator + fileName;
        File file = new File(temp);
        RtfWriter2.getInstance(document,new FileOutputStream(file));
        document.open();
        /*********************文字**********************/
        //设置中文字体
        //设置标题字体风格

        RtfFont titleFont1 = new RtfFont("黑 体", 20, Font.BOLD, Color.red);

        RtfFont titleFont = new RtfFont("黑 体", 16, Font.BOLD, Color.BLACK);
        //设置正文字体风格
        RtfFont contextFont = new RtfFont("宋 体", 12, Font.NORMAL, Color.BLACK);
        //标题 --- 社团名称
        String strTitle = taiWanParty.getPartyName();
        Paragraph title = new Paragraph(strTitle,titleFont1);
        //设置标题格式对齐方式
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);

        Paragraph partyDes = new Paragraph("社团简介：",titleFont);
        //设置标题格式对齐方式
        partyDes.setAlignment(Element.ALIGN_MIDDLE);
        //离上一段落(标题)空的行数
        partyDes.setSpacingBefore(5);
        document.add(partyDes);

        //社团简介
        Paragraph partyDesc = new Paragraph(taiWanParty.getPartyDesc(),contextFont);
        //设置正文格式对齐方式
        partyDesc.setAlignment(Element.ALIGN_LEFT);
        //离上一段落(标题)空的行数
        partyDesc.setSpacingBefore(5);
        //设置第一行空的列数
        partyDesc.setFirstLineIndent(20);
        document.add(partyDesc);

        /*********************表格**********************/
        //创建一个row行5列的表格
        Paragraph partyDes1 = new Paragraph("台湾主要人士：",titleFont);
        //设置标题格式对齐方式
        partyDes1.setAlignment(Element.ALIGN_MIDDLE);
        partyDes1.setSpacingBefore(5);
        document.add(partyDes1);

        if (null != politicsList && politicsList.size() > 0) {
            int row = politicsList.size() + 1;
            Table table = new Table(5, row);
            int width[] = {20,20,20,20,20};
            //设置每列宽度比例
            table.setWidths(width);
            table.setWidth(90);
            //自动填满
            table.setAutoFillEmptyCells(true);
            table.setAlignment(Element.ALIGN_CENTER);
            //边框宽度
            table.setBorderWidth(1);
            //设置表头
            RtfFont cellFont = new RtfFont("黑 体", 14, Font.NORMAL, Color.BLACK);
            Paragraph paragraph1 = new Paragraph("姓  名", cellFont);
            paragraph1.setAlignment(Element.ALIGN_CENTER);
            table.addCell(paragraph1);

            Paragraph paragraph2 = new Paragraph("性  别", cellFont);
            paragraph2.setAlignment(Element.ALIGN_CENTER);
            table.addCell(paragraph2);

            Paragraph paragraph3 = new Paragraph("出生 日期", cellFont);
            paragraph3.setAlignment(Element.ALIGN_CENTER);
            table.addCell(paragraph3);

            Paragraph paragraph4 = new Paragraph("单  位", cellFont);
            paragraph4.setAlignment(Element.ALIGN_CENTER);
            table.addCell(paragraph4);

            Paragraph paragraph5 = new Paragraph("职  务", cellFont);
            paragraph5.setAlignment(Element.ALIGN_CENTER);
            table.addCell(paragraph5);

            for (TaiWanPolitics taiWanPolitics : politicsList){

                Paragraph paragraph1_1 = new Paragraph(taiWanPolitics.getMainName(), contextFont);
                paragraph1_1.setAlignment(Element.ALIGN_CENTER);
                table.addCell(paragraph1_1);

                String gender = taiWanPolitics.getGender();
                switch (gender){
                    case "0":gender="男";break;
                    case "1":gender="女";break;
                    default:gender="未知";
                }
                Paragraph paragraph1_2 = new Paragraph(gender, contextFont);
                paragraph1_2.setAlignment(Element.ALIGN_CENTER);
                table.addCell(paragraph1_2);

                Paragraph paragraph1_3 = new Paragraph(DateUtil.dateToString(taiWanPolitics.getBirthday(), DateUtil.FORMAT_DAY), contextFont);
                paragraph1_3.setAlignment(Element.ALIGN_CENTER);
                table.addCell(paragraph1_3);

                Paragraph paragraph1_4 = new Paragraph(taiWanPolitics.getBelongOrg(), contextFont);
                paragraph1_4.setAlignment(Element.ALIGN_CENTER);
                table.addCell(paragraph1_4);

                Paragraph paragraph1_5 = new Paragraph(taiWanPolitics.getDuty(), contextFont);
                paragraph1_5.setAlignment(Element.ALIGN_CENTER);
                table.addCell(paragraph1_5);
            }
            document.add(table);
        }

        Paragraph cppccInterac = new Paragraph("与政协交往情况：",titleFont);
        //设置标题格式对齐方式
        cppccInterac.setAlignment(Element.ALIGN_MIDDLE);
        //离上一段落(标题)空的行数
        cppccInterac.setSpacingBefore(5);
        //与政协交往情况
        document.add(cppccInterac);

        Paragraph cppccInteract = new Paragraph(taiWanParty.getCppccInteract(),contextFont);
        //设置正文格式对齐方式
        cppccInteract.setAlignment(Element.ALIGN_LEFT);
        //离上一段落(标题)空的行数
        cppccInteract.setSpacingBefore(5);
        //设置第一行空的列数
        cppccInteract.setFirstLineIndent(20);
        //离下一段落空的行数
        cppccInteract.setSpacingAfter(5);
        document.add(cppccInteract);

        /*********************图片**********************/

        Paragraph cppccInteracImg = new Paragraph("社团图片：",titleFont);
        //设置标题格式对齐方式
        cppccInteracImg.setAlignment(Element.ALIGN_MIDDLE);
        //离上一段落(标题)空的行数
        cppccInteracImg.setSpacingBefore(5);
        document.add(cppccInteracImg);

        if (null != files && files.size() > 0){
            for (DicUploadFile uploadFile : files){
                //图片的路径
                String filePath = uploadFile.getPath();
                Image img = Image.getInstance(filePath);
                img.setAbsolutePosition(0,0);
                //设置图片显示的位置
                img.setAlignment(Image.ALIGN_CENTER);
                //直接设置显示尺寸
                img.scaleAbsolute(60,60);
                //标识显示的大小为原尺寸的100%
                //img.scalePercent(100);
                //图片高宽的显示比例
                //img.scalePercent(40,22);
                img.scalePercent(30,20);
                //图片旋转一定角度
                //img.setRotation(30);
                //把图片添加到文档中
                document.add(img);
            }
        }

        document.close();
        baos.close();

        FileUtil.downOrPreview(fileName,temp,response,request,"0");
        file.delete();
    }

}
