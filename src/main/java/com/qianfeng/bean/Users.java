package com.qianfeng.bean;

import java.io.Serializable;


public class Users implements Serializable {
    private int id;
    private String users_account;
    private String users_pwd;
    private int users_status;

    public Users() {
    }

    public Users(int id, String users_account, String users_pwd, int users_status) {
        this.id = id;
        this.users_account = users_account;
        this.users_pwd = users_pwd;
        this.users_status = users_status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsers_account() {
        return users_account;
    }

    public void setUsers_account(String users_account) {
        this.users_account = users_account;
    }

    public String getUsers_pwd() {
        return users_pwd;
    }

    public void setUsers_pwd(String users_pwd) {
        this.users_pwd = users_pwd;
    }

    public int getUsers_status() {
        return users_status;
    }

    public void setUsers_status(int users_status) {
        this.users_status = users_status;
    }
}
