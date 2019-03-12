package com.taiji.frame.service.foreignaffairs.bulletinBoard;

import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.bulletinBoard.BulletinBoard;
import com.taiji.frame.model.entity.foreignaffairs.bulletinBoard.BulletinBoardFile;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.bulletinBoard.BulletinBoardVo;
import com.taiji.frame.service.foreignaffairs.tempForeignAffairs.ChronicleService;
import com.taiji.frame.service.systempara.DicUploadFileService;
import com.taiji.frame.util.BaseDAO;
import com.taiji.frame.util.UtilService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author qzp
 * @date 2018/7/18
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true,rollbackFor = Exception.class)
public class BulletinBoardService extends BaseDAO<BulletinBoard> {
    private static final Logger log = LoggerFactory.getLogger(ChronicleService.class);

    @Autowired
    private UtilService utilService;

    @Autowired
    private BulletinBoardFileService bulletinBoardFileService;

    @Autowired
    private DicUploadFileService dicUploadFileService;

    /**
     * 公告栏列表
     * @param carrier
     * @param map
     */
    @Transactional(rollbackFor = Exception.class)
    public void load(Carrier<BulletinBoard> carrier, HashMap map) {
        StringBuilder hql = new StringBuilder();
        hql.append(" from BulletinBoard bb where 1 = 1");
        if (map.containsKey("title")){
            hql.append(" and bb.title like :title");
        }
        if(map.containsKey("publishTime")){
            hql.append(" and to_char(bb.publishTime,'yyyy-MM-dd') = :publishTime");
        }
        if (map.containsKey("publisher")){
            hql.append(" and bb.dicUser.empName like :publisher");
        }
        //sunyi添加
        if (map.containsKey("bulletinIndexMainId")){
            hql.append(" and bb.id = :bulletinIndexMainId");
        }
        hql.append(" and bb.delFlag = '0'");
        find(carrier,hql.toString(),map);
    }

    /**
     * @author sunyi
     * 首页 公告栏列表
     */
    public List<BulletinBoard> loadIndexMain() {
        StringBuilder hql = new StringBuilder();
        hql.append(" from BulletinBoard bb where 1 = 1");
        hql.append(" and bb.delFlag = '0'");
        hql.append(" and bb.updateTime is not null ");
        hql.append(" order by bb.updateTime desc");
       return find(hql.toString());
    }


    /**
     * 保存或修改公告栏信息
     * @param
     * @return
     */
    /*@Transactional(rollbackFor = Exception.class)
    public BulletinBoard saveBulletinBoard(BulletinBoardVo bulletinBoardVo,DicUser curUser) throws ParseException {
        BulletinBoard bulletinBoard;
        if (StringUtils.isEmpty(bulletinBoardVo.getId())){
            bulletinBoard = new BulletinBoard();
            //设置创建时间
            bulletinBoard.setCreateTime(new Date());
        }else {
            bulletinBoard = this.get(bulletinBoardVo.getId());
        }
        String title = bulletinBoardVo.getTitle();
        bulletinBoard.setTitle(title);
        String content = bulletinBoardVo.getContent();
        bulletinBoard.setContent(content);
        String publishTime = bulletinBoardVo.getPublishTimeStr();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        bulletinBoard.setPublishTime(sdf.parse(publishTime));

        bulletinBoard.setDicUser(curUser);

        String notes = bulletinBoardVo.getNotes();
        bulletinBoard.setNotes(notes);
        // 设置更新时间
        Date updateTime = DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY_HOUR_MIN);
        bulletinBoard.setUpdateTime(updateTime);
        //设置删除标志  0未删除  1已删除
        bulletinBoard.setDelFlag("0");
        try {
            this.save(bulletinBoard);
        }catch (Exception e){
            log.error("保存公告栏失败" + e.getMessage(),e);
        }
        return bulletinBoard;
    }
*/
    /**
     * 保存或修改公告栏附件信息
     * @param
     * @param
     */
    /*@Transactional(rollbackFor = Exception.class)
    public void saveBulletinBoardFile(BulletinBoard bulletinBoard, DicUploadFile uploadFile) {
        Assert.notNull(bulletinBoard, "bulletinBoard must not be null");
        Assert.notNull(uploadFile, "uploadFile must not be null");

        BulletinBoardFile bulletinBoardFile = new BulletinBoardFile();
        bulletinBoardFile.setBulletinBoard(bulletinBoard);
        bulletinBoardFile.setDicUploadFile(uploadFile);
        bulletinBoardFile.setSeq(0);
        try {
            bulletinBoardFileService.save(bulletinBoardFile);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
*/
    @Transactional(rollbackFor = Exception.class)
    public Map<String,Object> saveData(BulletinBoardVo bulletinBoardVo, String basePath, DicUser curUser) {
        Map<String, Object> map = new HashMap<>(3);
        String dstDir = UploadConstant.bulletinBoard;
        String id = bulletinBoardVo.getId();
        BulletinBoard bulletinBoard = null;
        try {
            if (StringUtils.isNotEmpty(id)){
                //编辑
                bulletinBoard = this.get(id);
                //给对象赋值
                this.setData(bulletinBoard,bulletinBoardVo,curUser);
                this.save(bulletinBoard);
                String fileIds = bulletinBoardVo.getFileIds();
                if (StringUtils.isNotEmpty(fileIds)){
                    JSONArray jsonArray = JSONArray.fromObject(fileIds);
                    for (int i=0; i < jsonArray.size(); i++) {
                        JSONObject jsonObject = JSONObject.fromObject(jsonArray.get(i));
                        String fileId = String.valueOf(jsonObject.get("fileId"));

                        Boolean isExist = bulletinBoardFileService.findByFileId(fileId, id);
                        if (!isExist) {
                            //不存在
                            DicUploadFile uploadFile = dicUploadFileService.get(fileId);
                            dicUploadFileService.transfer(uploadFile, dstDir);
                            BulletinBoardFile file = bulletinBoardFileService.getBulletinBoardFile(fileId);
                            if (file != null) {
                                //之前上传过附件,更新
                                file.setDicUploadFile(uploadFile);
                                bulletinBoardFileService.save(file);
                            } else {
                                //原本就不存在附件,新增
                                BulletinBoardFile bulletinBoardFile = new BulletinBoardFile();
                                bulletinBoardFile.setDicUploadFile(uploadFile);
                                bulletinBoardFile.setBulletinBoard(bulletinBoard);
                                bulletinBoardFile.setSeq(0);
                                bulletinBoardFileService.save(bulletinBoardFile);
                            }
                        }
                    }
                }
                map.put("result",true);
            }else {
                //新增
                bulletinBoard = new BulletinBoard();
                //设置创建时间
                bulletinBoard.setCreateTime(new Date());
                //给对象赋值
                this.setData(bulletinBoard,bulletinBoardVo,curUser);
                this.save(bulletinBoard);
                //附件上传
                String fileIds = bulletinBoardVo.getFileIds();
                if (StringUtils.isNotEmpty(fileIds)) {
                    JSONArray jsonArray = JSONArray.fromObject(fileIds);
                    for (Object json : jsonArray) {
                        JSONObject jsonObject = JSONObject.fromObject(json);
                        String fileId = String.valueOf(jsonObject.get("fileId"));
                        DicUploadFile uploadFile = dicUploadFileService.get(fileId);
                        try {
                            dicUploadFileService.transfer(uploadFile, dstDir);
                            this.saveBoardFile(bulletinBoard, uploadFile);
                        } catch (IOException e) {
                            e.printStackTrace();
                            map.put("result",false);
                            return map;
                        }
                    }
                }
                map.put("id", bulletinBoard.getId());
                map.put("result", true);
            }
        }catch (Exception e){
            e.printStackTrace();
            map.put("result",false);
            return map;
        }
        return map;
    }

    @Transactional(rollbackFor = Exception.class)
    public void saveBoardFile(BulletinBoard bulletinBoard, DicUploadFile uploadFile) {
        Assert.notNull(bulletinBoard, "bulletinBoard must not be null");
        Assert.notNull(uploadFile, "uploadFile must not be null");
        BulletinBoardFile bulletinBoardFile = new BulletinBoardFile();
        bulletinBoardFile.setBulletinBoard(bulletinBoard);
        bulletinBoardFile.setDicUploadFile(uploadFile);
        bulletinBoardFile.setSeq(0);
        try {
            bulletinBoardFileService.save(bulletinBoardFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void setData(BulletinBoard bulletinBoard, BulletinBoardVo bulletinBoardVo, DicUser curUser) throws Exception {
        String title = bulletinBoardVo.getTitle();
        bulletinBoard.setTitle(title);
        String content = bulletinBoardVo.getContent();
        bulletinBoard.setContent(content);
        String publishTime = bulletinBoardVo.getPublishTimeStr();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        bulletinBoard.setPublishTime(sdf.parse(publishTime));

        bulletinBoard.setDicUser(curUser);

        String notes = bulletinBoardVo.getNotes();
        bulletinBoard.setNotes(notes);
        // 设置更新时间
        Date updateTime = DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY_HOUR_MIN);
        bulletinBoard.setUpdateTime(updateTime);
        //设置删除标志  0未删除  1已删除
        bulletinBoard.setDelFlag("0");
    }

}
