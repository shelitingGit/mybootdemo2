package com.controller;

import com.po.Food;
import com.po.PageBean;
import com.service.IFoodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class FoodController implements IFoodController {
    @Autowired
    private IFoodService ibiz;

    public IFoodService getSbiz() {
        return ibiz;
    }

    public void setSbiz(IFoodService sbiz) {
        this.ibiz = sbiz;
    }
    @RequestMapping(value = "check_users.do",method = RequestMethod.GET)
    public String check(HttpServletRequest request, HttpServletResponse response){

        return "hello 这是我的第一个boot程序";
    }

    @Override
    @RequestMapping(value = "findAll.do")
    public PageBean findPageAll(HttpServletRequest request, HttpServletResponse response, Integer page, Integer rows) {
        System.out.println("findPageAll_Food.do");
        System.out.println("conn：page=" + page);
        System.out.println("conn：rows=" + rows);


        HttpSession session=request.getSession();
        PageBean pb =(PageBean)session.getAttribute("pb");
        pb=pb==null?new PageBean():pb;
        page=page==null||page<1?pb.getPage():page;
        rows=rows==null||rows<1?pb.getRows():rows;
        System.out.println("pb:::"+pb);
        System.out.println("page:::"+page);
        System.out.println("rows:::"+rows);
        int maxrows=ibiz.findMaxrows();
        System.out.println("maxrows:::"+maxrows);
        int maxpage=1;
        if(maxrows>0){
            maxpage=maxrows%rows==0?maxrows/rows:maxrows/rows+1;
        }
        if(page>maxpage)page=maxpage;
        pb.setPage(page);
        pb.setRows(rows);
        List<Food> lsfo=ibiz.findPageAll(pb);
        pb.setMaxpage(maxpage);
        pb.setPagelist(lsfo);

        return pb;
    }


    @RequestMapping(value="add_Food.do")
    public String add(HttpServletRequest request, HttpServletResponse response, Food food) {
        System.out.println("11111111");
        Food ofood=food;

        System.out.println("222222");

        System.out.println(ofood.toString());
        int flag=ibiz.add(ofood);

        if(flag>0){
            return 1+"";
        }else {
            return 0+"";
        }
    }

    @RequestMapping(value="update_Food.do")
    public String update(HttpServletRequest request, HttpServletResponse response, Food food) {
        System.out.println("old-----"+food.toString());
        int flag=ibiz.update(food);
        String Jsonstr;
        if(flag>0){
            return 1+"";
        }else {
            return 0+"";
        }
    }


    @RequestMapping(value="delById_Food.do")
    public String delById(HttpServletRequest request, HttpServletResponse response, String f_id) {

        System.out.println("f_id---"+f_id);
        int flag=ibiz.delById(f_id);
        String Jsonstr;
        if(flag>0){
            return 1+"";
        }else {
            return 0+"";
        }

    }

    @RequestMapping(value="findById_Food.do")
    public Food findById(HttpServletRequest request, HttpServletResponse response, String f_id) {
        Food oldfood=ibiz.findById(f_id);
        System.out.println("findById_Food====="+oldfood);
//		request.setAttribute("oldfood", oldfood);

        return oldfood;
    }




}
