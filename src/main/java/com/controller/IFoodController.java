package com.controller;

import com.po.Food;
import com.po.PageBean;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public interface IFoodController {

    public PageBean findPageAll(HttpServletRequest request, HttpServletResponse response, Integer page, Integer rows);
    public String add(HttpServletRequest request,HttpServletResponse response,Food food);

    public String update(HttpServletRequest request,HttpServletResponse response,Food food);

    public String delById(HttpServletRequest request,HttpServletResponse response,String fid);

    public Food findById(HttpServletRequest request,HttpServletResponse response,String fid);

}
