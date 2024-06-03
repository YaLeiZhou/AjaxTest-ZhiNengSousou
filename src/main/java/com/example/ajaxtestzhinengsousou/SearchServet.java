package com.example.ajaxtestzhinengsousou;

import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/search")
public class SearchServet extends HttpServlet {


    static List<String> datas = new ArrayList<String>();
    //模拟数据
    static {

        datas.add("ajax");
        datas.add("ajax post");
        datas.add("becky");
        datas.add("bill");
        datas.add("james");
        datas.add("jerry");
        datas.add("hao");

    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        //获取客户端数据
        String keyword = request.getParameter("keyword");
        //获取关键字
        List<String> listData = getData(keyword);

        //返回json格式
        Gson gson = new Gson();
        //System.out.println(gson.toJson(listData));  //测试根据前端输入  后端获得的json
        response.getWriter().write(gson.toJson(listData).toString());

    }

    public List<String> getData(String keyword){
        List<String> list = new ArrayList<String>();
        for (String data:datas) {
            if(data.contains(keyword)){
                list.add(data);
            }
        }
        return  list;
    }

}
