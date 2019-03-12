package com.taiji.frame.service.systempara;

import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.BeanCopyUtil;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.FileUtil;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.util.BaseDAO;
import com.taiji.frame.util.UtilService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 上传文件
 *
 * @author yx
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class DicUploadFileService extends BaseDAO<DicUploadFile> {

    @Autowired
    UtilService utilService;

    /**
     * 上传文件
     *
     * @param file
     * @param basePath
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    public Map<String, Object> upload(MultipartFile file, String basePath) throws Exception {

        Map<String, Object> map = new HashMap<>(2);

        String tempPath = basePath + File.separator + "temp" + File.separator;
        File tempDir = new File(tempPath);
        if (!tempDir.exists()) {
            tempDir.mkdirs();
        }

        if (!file.isEmpty()) {
            Map param = FileUtil.uploadFile(file, tempPath);
            String realName = String.valueOf(param.get("realName"));
            String fileDir = String.valueOf(param.get("fileDir"));


            DicUploadFile uploadFile = new DicUploadFile();

            uploadFile.setStatus(0);
            uploadFile.setFileName(realName);
            uploadFile.setTempPath(fileDir);
            uploadFile.setCreateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(),
                    DateUtil.FORMAT_DAY_HOUR_MIN));

            try {
                save(uploadFile);
            } catch (Exception e) {
                e.printStackTrace();
            }

            map.put("realName", realName);
            map.put("fileId", uploadFile.getId());
        }

        return map;
    }

    /**
     * 将文件从临时文件夹转移到正式文件夹
     *
     * @param uploadFile
     * @param dstDir
     */
    @Transactional(rollbackFor = Exception.class)
    public void transfer(DicUploadFile uploadFile, String dstDir) throws IOException {

        Assert.notNull(uploadFile, "uploadFile must not be null");

        String basePath = UploadConstant.uploadBaseDir;
        String path = basePath + File.separator + dstDir + File.separator;

        int byteRead;
        String tempPath = uploadFile.getTempPath();
        File tempFile = new File(tempPath);

        String uuidName = tempPath.substring(tempPath.lastIndexOf(File.separator) + 1);
        String dstPath = path + uuidName;

        File dir = new File(path);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        if (tempFile.exists()) {
            InputStream inputStream = new FileInputStream(tempFile);
            FileOutputStream fos = new FileOutputStream(dstPath);
            byte[] buffer = new byte[2048];
            while ((byteRead = inputStream.read(buffer)) != -1) {
                fos.write(buffer, 0, byteRead);
            }
            inputStream.close();
            fos.close();
        }

        uploadFile.setStatus(1);
        uploadFile.setPath(dstPath);

        try {
            save(uploadFile);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void save(DicUploadFile uploadFile) {

        Assert.notNull(uploadFile, "uploadFile must not be null!");

        if (uploadFile.getId() == null) {
            super.save(uploadFile);
        } else {
            DicUploadFile temp = this.get(uploadFile.getId());
            try {
                new BeanCopyUtil().copyNotNullProperties(uploadFile, temp, true);
                super.save(temp);
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 上传多个文件
     * @param files
     * @param basePath
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    public Map<String,Object> uploads(MultipartFile[] files, String basePath) throws Exception  {
        Map<String, Object> map = new HashMap<>(2);
        List<DicUploadFile> fileList = new ArrayList<>();
        String tempPath = basePath + File.separator + "temp" + File.separator;
        File tempDir = new File(tempPath);
        if (!tempDir.exists()) {
            tempDir.mkdirs();
        }
        if (files.length > 0 && files != null){
            for (MultipartFile file:files) {
                if (!file.isEmpty()) {
                    Map param = FileUtil.uploadFile(file, tempPath);
                    String realName = String.valueOf(param.get("realName"));
                    String fileDir = String.valueOf(param.get("fileDir"));
                    DicUploadFile uploadFile = new DicUploadFile();
                    uploadFile.setStatus(0);
                    uploadFile.setFileName(realName);
                    uploadFile.setTempPath(fileDir);
                    uploadFile.setCreateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(),
                            DateUtil.FORMAT_DAY_HOUR_MIN));
                    try {
                        save(uploadFile);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    fileList.add(uploadFile);
                }
            }
            map.put("fileList", fileList);
//            map.put("realName", realName);
//            map.put("fileId", uploadFile.getId());
        }
        return map;
    }

    /**
     * * 将附件状态置为 2（删除）
     *
     * @param fileId 文件Id
     */
    @Transactional(rollbackFor = Exception.class)
    public void logicDeleteFile(String fileId) {
        // 将旧文件状态设置为 2（删除）
        if (StringUtils.isNotEmpty(fileId)) {
            DicUploadFile oldFile = get(fileId);
            oldFile.setStatus(2);
            try {
                save(oldFile);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }


    public List<DicUploadFile> findDiscard(Integer status) {
        Map<String, Object> map = new HashMap<>(1);
        StringBuffer hql = new StringBuffer();

        hql.append(" from DicUploadFile t where 1=1");
        if (null != status) {
            hql.append(" and t.status=:status ");
            map.put("status", status);
        } else {
            hql.append(" and (t.status=0 or t.status=2)");
        }

        return find(hql.toString(), map);
    }
}
