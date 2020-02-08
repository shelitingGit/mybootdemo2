package com.service;

import com.po.*;
import org.apache.catalina.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IFoodService {
    public List<Food> findPageAll(PageBean pb);
    public int findMaxrows();

    // 添加
    public int add(Food food);

    // 删除信息
    public int delById(String fid);

    // 修改信息
    public int update(Food food);

    // 单个查询 根据编号
    public Food findById(String fid);

}
