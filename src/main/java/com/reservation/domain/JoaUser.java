package com.reservation.domain;

public class JoaUser {
    private String id;
    private String pwd;
    private String name;
    private String tel;
    private boolean auth;

    public JoaUser(String id, String pwd) {
        this.id = id;
        this.pwd = pwd;
    }
    
    public JoaUser(String id, String pwd, boolean auth) {
        this.id = id;
        this.pwd = pwd;
        this.auth = auth;
    }

    public JoaUser(String id, String pwd, String name, String tel, boolean auth) {
        this.id = id;
        this.pwd = pwd;
        this.name = name;
        this.tel = tel;
        this.auth = auth;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public boolean getAuth() {
        return auth;
    }

    public void setAuth(boolean auth) {
        this.auth = auth;
    }

}
