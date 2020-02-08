package com.mapper;

import com.po.Food;
import org.apache.catalina.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface IFoodMapper {

    // 分页查询
    public List<Food> findPageAll(@Param(value = "page") Integer page,@Param(value = "rows")Integer rows);
    public int findMaxrows();

    // 添加
    public int add(Food food);

    // Food--删除信息
    public int delById(String f_id);

    // Food--修改信息
    public int update(Food food);

    // 单个查询 根据编号
    public Food findById(String f_id);


}
