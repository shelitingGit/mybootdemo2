package com.po;

import java.io.Serializable;

public class Food implements Serializable {
    private String f_id;// 序号
    private String f_city;// 城市名
    private String f_shopname;// 店名
    private String f_special;// 招牌菜
    private String f_address;// 地址
    private String f_like;// 点赞数

    public Food() {
    }

    public Food(String f_id, String f_city, String f_shopname, String f_special, String f_address, String f_like) {
        this.f_id = f_id;
        this.f_city = f_city;
        this.f_shopname = f_shopname;
        this.f_special = f_special;
        this.f_address = f_address;
        this.f_like = f_like;
    }

    public String getF_id() {
        return f_id;
    }

    public String getF_city() {
        return f_city;
    }

    public String getF_shopname() {
        return f_shopname;
    }

    public String getF_special() {
        return f_special;
    }

    public String getF_address() {
        return f_address;
    }

    public String getF_like() {
        return f_like;
    }

    public void setF_id(String f_id) {
        this.f_id = f_id;
    }

    public void setF_city(String f_city) {
        this.f_city = f_city;
    }

    public void setF_shopname(String f_shopname) {
        this.f_shopname = f_shopname;
    }

    public void setF_special(String f_special) {
        this.f_special = f_special;
    }

    public void setF_address(String f_address) {
        this.f_address = f_address;
    }

    public void setF_like(String f_like) {
        this.f_like = f_like;
    }

    @Override
    public String toString() {
        return "Food{" +
                "f_id='" + f_id + '\'' +
                ", f_city='" + f_city + '\'' +
                ", f_shopname='" + f_shopname + '\'' +
                ", f_special='" + f_special + '\'' +
                ", f_address='" + f_address + '\'' +
                ", f_like='" + f_like + '\'' +
                '}';
    }
}
