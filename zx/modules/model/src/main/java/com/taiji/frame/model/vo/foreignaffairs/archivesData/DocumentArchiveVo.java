package com.taiji.frame.model.vo.foreignaffairs.archivesData;

import com.taiji.frame.model.entity.foreignaffairs.archivesData.DocumentArchive;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * 案卷-文件多条件复合查询VO类
 * Created by yuLei on 2018/8/10.
 */
public class DocumentArchiveVo extends DocumentArchive implements Jsonable, Serializable {

    @Getter
    @Setter
    public String type;//数据加载方式（tree:点击树状结构加载、search:点击搜索加载）

    @Getter
    @Setter
    public String teamId;

    @Getter
    @Setter
    public String parentId;//父ID

    @Getter
    @Setter
    public String startTime;

    @Getter
    @Setter
    public String endTime;

}
