package com.qianfeng.dao;

import com.qianfeng.bean.Users;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
public interface UsersDao {
    //查询数据总数
    int findUsersByCount();
    //只查询单个用户
    void login(Users users);
    //查询需求的用户,用于模糊查询
    void findUsers(String str);
    //查询所有用户，用于管理员操作
    List<Users> findAllUsers(@Param(value="start") int start, @Param(value="pagesize") int pagesize);
    //添加用户
    void addUsers(Users users);
    //删除用户
    void removeUsersByStatus(ArrayList<Integer> data);
    //修改用户信息
    void updateUsers(Users users);
    //搜索
    List<Users> searchUsersBylike(Map<String,String>data);
}
