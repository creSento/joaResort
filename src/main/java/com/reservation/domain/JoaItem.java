package com.reservation.domain;

import java.io.Serializable;
import java.sql.Date;

public class JoaItem implements Serializable {
    private static final long serialVersionUID = 1L;
    private String id;
    private String name;
    private String resv_date;
    private int room;
    private String addr;
    private String tel;
    private String in_name;
    private String comment;
    private Date write_date;
    private int processing;
    // additional attribute
    public static final String[] ROOMNAME = { "VIP룸", "일반룸", "합리적인룸" };
    public static final String[] PROCESS = { "입금대기", "입금완료", "환불요청", "환불완료", "예약취소" };

    public JoaItem(String resv_date) {
        this.resv_date = resv_date;
    }

    public JoaItem(String resv_date, int room) {
        this.resv_date = resv_date;
        this.room = room;
    }

    public JoaItem(String id, String name, String resv_date, int room, String addr, String tel, String in_name, String comment) {
        this.id = id;
        this.name = name;
        this.resv_date = resv_date;
        this.room = room;
        this.addr = addr;
        this.tel = tel;
        this.in_name = in_name;
        this.comment = comment;
    }
    
//    public JoaItem(String name, String resv_date, int room, String addr, String tel, String in_name, String comment) {
//        this.name = name;
//        this.resv_date = resv_date;
//        this.room = room;
//        this.addr = addr;
//        this.tel = tel;
//        this.in_name = in_name;
//        this.comment = comment;
//    }

    public JoaItem(String name, String resv_date, int room, String addr, String tel, String in_name, String comment, int processing) {
        this.name = name;
        this.resv_date = resv_date;
        this.room = room;
        this.addr = addr;
        this.tel = tel;
        this.in_name = in_name;
        this.comment = comment;
        this.processing = processing;
    }
    
    public JoaItem(String id, String name, String resv_date, int room, String addr, String tel, String in_name, String comment,
            Date write_date, int processing) {
        this.id = id;
        this.name = name;
        this.resv_date = resv_date;
        this.room = room;
        this.addr = addr;
        this.tel = tel;
        this.in_name = in_name;
        this.comment = comment;
        this.write_date = write_date;
        this.processing = processing;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getResv_date() {
        return resv_date;
    }

    public void setResv_date(String resv_date) {
        this.resv_date = resv_date;
    }

    public int getRoom() {
        return room;
    }

    public void setRoom(int room) {
        this.room = room;
    }

    public String[] getROOMNAME() {
        return ROOMNAME;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getIn_name() {
        return in_name;
    }

    public void setIn_name(String in_name) {
        this.in_name = in_name;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getWrite_date() {
        return write_date;
    }

    public void setWrite_date(Date write_date) {
        this.write_date = write_date;
    }

    public int getProcessing() {
        return processing;
    }

    public void setProcessing(int processing) {
        this.processing = processing;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((resv_date == null) ? 0 : resv_date.hashCode());
        result = prime * result + room;
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        JoaItem other = (JoaItem) obj;
        if (resv_date == null) {
            if (other.resv_date != null)
                return false;
        } else if (!resv_date.equals(other.resv_date))
            return false;
        if (room != other.room)
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "JoaItem [name=" + name + ", resv_date=" + resv_date + ", room=" + room + ",\n addr=" + addr + ", tel="
                + tel + ", in_name=" + in_name + ",\n comment=" + comment + ", write_date=" + write_date
                + ", processing=" + processing + "]";
    }

}
