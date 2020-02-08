package com.serviceImpl;

import com.mapper.IFoodMapper;
import com.po.*;
import com.service.IFoodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class FoodServiceImpl implements IFoodService {
    @Autowired
    private IFoodMapper idao;
    public IFoodMapper getIdao() {
        return idao;
    }
    public void setIdao(IFoodMapper idao) {
        this.idao = idao;
    }

    @Override
    public List<Food> findPageAll(PageBean pb) {
        int page=(pb.getPage()-1)*pb.getRows();
        int rows=pb.getRows();
        return idao.findPageAll(page,rows);
    }
    public int findMaxrows() {
        return idao.findMaxrows();
    }


    public int add(Food food) {
        return idao.add(food);
    }

    public int delById(String fid) {
        return idao.delById(fid);
    }

    public int update(Food food) {
        return idao.update(food);

    }

    public Food findById(String fid) {
        return idao.findById(fid);
    }


}
