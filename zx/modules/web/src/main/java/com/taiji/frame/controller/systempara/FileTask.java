package com.taiji.frame.controller.systempara;

import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.service.systempara.DicUploadFileService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.File;
import java.util.List;

/**
 * 文件清理定时器
 *
 * @author yx
 * @date 2018.12.19
 */
@Component
public class FileTask {

    private static final Logger LOG = LoggerFactory.getLogger(FileTask.class);

    @Autowired
    private DicUploadFileService dicUploadFileService;


    public void clearTempFiles() {
        // 临时文件列表
        List<DicUploadFile> fileList = dicUploadFileService.findDiscard(0);

        System.out.println("====================开始清除临时文件====================");

        // 删除临时文件
        for(DicUploadFile file : fileList) {
            String filePath = file.getTempPath();
            File temp = new File(filePath);
            if (temp.exists()) {
                Boolean deleted =  temp.delete();
                if (deleted) {
                    LOG.debug("删除临时文件成功: ", file.getFileName());
                    dicUploadFileService.delete(file);
                } else {
                    LOG.debug("删除临时文件失败: ", file.getFileName());
                }
            } else {
                LOG.debug("删除临时文件数据库记录: ", file.getFileName());
                dicUploadFileService.delete(file);
            }
        }

        System.out.println("====================清除临时文件结束====================");
    }

    public void clearDeletedFiles() {
        List<DicUploadFile> fileList = dicUploadFileService.findDiscard(2);
        for(DicUploadFile file : fileList) {
            String filePath = file.getPath();
            File temp = new File(filePath);
            if (temp.exists()) {
                Boolean deleted =  temp.delete();
                if (deleted) {
                    LOG.debug("删除已删除的文件成功: ", file.getFileName());
                    dicUploadFileService.delete(file);
                } else {
                    LOG.debug("删除已删除的文件失败: ", file.getFileName());
                }
            } else {
                LOG.debug("删除已删除的文件数据库记录: ", file.getFileName());
                dicUploadFileService.delete(file);
            }
        }
    }

    /**
     * 定时计算。每10秒执行一次
     */
    public void show() {
        System.out.println("show method 2");
    }

    /**
     * 启动时执行一次，之后每隔2秒执行一次
     */
    public void print() {
        System.out.println("print method 2");
    }
}
