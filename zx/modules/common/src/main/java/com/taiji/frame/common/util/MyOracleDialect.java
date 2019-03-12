package com.taiji.frame.common.util;

import org.hibernate.dialect.Oracle10gDialect;

/**
 * 重写方言，解决Hiberate分页问题
 * Created by zhangshuai on 2016/4/13.
 */
public class MyOracleDialect extends Oracle10gDialect {

    public MyOracleDialect() {
    }

    public String getLimitString(String sql, boolean hasOffset) {
        sql = sql.trim();
        String forUpdateClause = null;
        boolean isForUpdate = false;
        int forUpdateIndex = sql.toLowerCase().lastIndexOf("for update");
        if(forUpdateIndex > -1) {
            forUpdateClause = sql.substring(forUpdateIndex);
            sql = sql.substring(0, forUpdateIndex - 1);
            isForUpdate = true;
        }

        StringBuilder pagingSelect = new StringBuilder(sql.length() + 100);
        if(hasOffset) {
            pagingSelect.append("select * from ( select row_.*, rownum rownum_ from ( ");
        } else {
         //   pagingSelect.append("select * from ( ");
            pagingSelect.append("select * from ( select row_.*, rownum rownum_ from ( ");
        }

        pagingSelect.append(sql);
        if(hasOffset) {
      //      pagingSelect.append(" ) row_ where rownum <= ?) where rownum_ > ?");
            pagingSelect.append(" ) row_  ) where rownum_ <= ? and rownum_ > ?");
        } else {
//            pagingSelect.append(" ) where rownum <= ?");
            pagingSelect.append(" ) row_  ) where rownum_ <= ? and rownum_ > 0");
        }

        if(isForUpdate) {
            pagingSelect.append(" ");
            pagingSelect.append(forUpdateClause);
        }

        return pagingSelect.toString();
    }
}
