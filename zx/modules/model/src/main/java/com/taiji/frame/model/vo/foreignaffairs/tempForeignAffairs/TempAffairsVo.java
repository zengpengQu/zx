package com.taiji.frame.model.vo.foreignaffairs.tempForeignAffairs;

import com.taiji.frame.model.entity.foreignaffairs.tempForeignAffairs.Chronicle;
import com.taiji.frame.model.entity.foreignaffairs.tempForeignAffairs.TempAffairs;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.List;

/**
 * @author yx
 * @date 2018/11/28
 */
public class TempAffairsVo extends TempAffairs implements Jsonable, Serializable {

    /**
     * 文件上传 Id
     */
    @Getter
    @Setter
    private String fileIds;

    /**
     * 临时外事大事记
     */
    @Setter
    @Getter
    private List<Chronicle> chronicleList;
}
