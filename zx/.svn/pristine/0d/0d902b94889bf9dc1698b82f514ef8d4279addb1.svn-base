package com.taiji.frame.service.systempara;

import com.taiji.frame.model.systempara.DicPara;
import com.taiji.frame.model.systempara.DicParaDtl;
import com.taiji.frame.util.BaseDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by CHX on 2016/3/10.
 * @author CHX
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = true,rollbackFor = Exception.class)
public class DicParaDtlService extends BaseDAO<DicParaDtl> {

    private Logger LOG = LoggerFactory.getLogger(DicParaDtlService.class);

    /**
     * 根据类型和id获取文件存储地址
     * @param id
     * @param type
     * @return
     */
    public String getFileDirByIdAndType(String id,String type){
        StringBuffer hql = new StringBuffer("select paraDscr from DicParaDtl where id =:id and paraType =:type");
        Map<String,Object> params = new HashMap<String, Object>();
        params.put("id",id);
        params.put("type",type);
        String fileDir = findUnique(hql.toString(),params);
        return fileDir;
    }

    /**
     * 根据id和Type获取参数表中的para_dscr数据
     * @param id
     * @param type
     * @return
     */
    public String getParaDscrByIdAndType(String id,String type){
        StringBuffer hql = new StringBuffer("select paraDscr from DicParaDtl where id =:id and paraType =:type");
        Map<String,Object> params = new HashMap<String, Object>();
        params.put("id",id);
        params.put("type",type);
        String paraDscr = findUnique(hql.toString(),params);
        return paraDscr;

    }

    /**
     * 根据id和Type获取参数表中的para_dscr数据
     * @param id
     * @param type
     * @return
     */
    public Integer getSeqByIdAndType(String id,String type){
        StringBuffer hql = new StringBuffer("select seq from DicParaDtl where id =:id and paraType =:type");
        Map<String,Object> params = new HashMap<String, Object>();
        params.put("id",id);
        params.put("type",type);
        Integer seq = findUnique(hql.toString(),params);
        return seq;

    }

    public List<DicParaDtl> getDicParaDtlByParaType(String paraType){
        StringBuffer hql = new StringBuffer("from DicParaDtl where paraType =:paraType order by seq asc");
        Map<String,Object> params = new HashMap<String, Object>();
        params.put("paraType",paraType);
        List<DicParaDtl> dicParaDtlList = find(hql.toString(),params);
        return dicParaDtlList;
    }
}

