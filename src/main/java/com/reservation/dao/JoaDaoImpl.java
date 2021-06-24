package com.reservation.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.reservation.domain.JoaItem;
import com.reservation.domain.JoaUser;

public class JoaDaoImpl implements JoaDao {
    private static JoaDaoImpl instance;

    public static JoaDaoImpl getInstance() {
        if (instance == null) {
            instance = new JoaDaoImpl();
        }
        return instance;
    }

    private JoaDaoImpl() {
    }

    Connection conn = DatabaseConnection.getConnection();

    @Override
    public void createResvTable() {
        try {
            Statement drop = conn.createStatement();
            drop.execute("drop table if exists joaresort;");
            Statement create = conn.createStatement();
            create.execute("create table joaresort (" 
                    + "id varchar(20) not null," 
                    + "name varchar(20),"
                    + "resv_date date not null,"
                    + "room int not null," 
                    + "addr varchar(100)," 
                    + "tel varchar(20)," 
                    + "in_name varchar(20),"
                    + "comment text," 
                    + "write_date date," 
                    + "processing int default 1,"
                    + "primary key(resv_date, room))" 
                    + "default charset=utf8;");
            drop.close();
            create.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertInitData() {
        try {
            Statement stmt = conn.createStatement();
            conn.setAutoCommit(false);
            String id = "";
            String name = "";
            LocalDate resv_date = null;
            int room = 0;
            String addr = "경기도 분당시 폴리텍";
            String tel = "010-1234-5678";
            String in_name = "";
            String comment = "";
            LocalDate today = LocalDate.now();
            int processing = 0;
            String query = "";
            for (int i = 1; i < 31; i++) {
                id = String.format("test%d", (int) (Math.random() * 3));
                name = String.format("홍길%d", i);
                resv_date = LocalDate.of(today.getYear(), today.getMonthValue(), i);
                room = (int) (Math.random() * 3);
                in_name = name;
                comment = String.format("resv%d", i);
                processing = (int) (Math.random() * 4);
                query = String.format(
                            "insert into joaresort values(" 
                            + "'%s', '%s', '%s', %d, '%s', '%s', " 
                            + "'%s', '%s', '%s', %d);",
                            id, name, resv_date.toString(), room, addr, tel, 
                            in_name, comment, today.toString(), processing);
                stmt.addBatch(query);
            }
            stmt.executeBatch();
            conn.commit();
            conn.setAutoCommit(true);
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }

    @Override
    public int login(String id, String pwd) {
        int result = 0;
        JoaUser loginUser = null;
        String sql = "select * from joa_user where id = ?;";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            ResultSet rset = pstmt.executeQuery();
            while(rset.next()) {
                loginUser = new JoaUser(rset.getString("id"), rset.getString("pwd"), rset.getBoolean("auth"));
            }
            if (loginUser == null) {
                return -1;
            } else {
                if (loginUser.getPwd().equals(pwd) && !loginUser.getAuth()) {
                    result = 1;
                } else if (loginUser.getPwd().equals(pwd) && loginUser.getAuth()) {
                    result = 2;
                } else {
                    result = 0;
                }
            }
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    
    @Override
    public int join(JoaUser user) {
        int result = 0;
        String sql = "insert into joa_user values(?, ?, ?, ?, 0);";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getId());
            pstmt.setString(2, user.getPwd());
            pstmt.setString(3, user.getName());
            pstmt.setString(4, user.getTel());
            result = pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    
    @Override
    public JoaUser getUser(String id) {
        JoaUser loginUser = null;
        String sql = "select * from joa_user where id = ?;";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            ResultSet rset = pstmt.executeQuery();
            while(rset.next()) {
                loginUser = new JoaUser(rset.getString("id"), rset.getString("pwd"), 
                        rset.getString("name"), rset.getString("tel"), rset.getBoolean("auth"));
            }
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return loginUser;
    }
    
    @Override
    public List<JoaItem> getMonthly(LocalDate calendardate) {
        List<JoaItem> monthly = new ArrayList<JoaItem>();
        String sql = "select * from joaresort where resv_date like concat(?, '%');";
        String calendar = String.format("%d-%02d", calendardate.getYear(), calendardate.getMonthValue());
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, calendar);
            ResultSet rset = pstmt.executeQuery();
            while (rset.next()) {
                monthly.add(
                        new JoaItem(rset.getString("id"), rset.getString("name"), rset.getDate("resv_date").toString(), 
                                rset.getInt("room"), rset.getString("addr"), rset.getString("tel"),
                                rset.getString("in_name"),  rset.getString("comment"), rset.getDate("write_date"), rset.getInt("processing")));
            }
            rset.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return monthly;
    }

    @Override
    public JoaItem getDaily(LocalDate day, int room) {
        JoaItem oneDaily = null;
        String sql = "select * from joaresort where resv_date like concat(?, '%') and room = ?;";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, day.toString());
            pstmt.setInt(2, room);
            ResultSet rset = pstmt.executeQuery();
            while (rset.next()) {
                oneDaily = new JoaItem(rset.getString("id"), rset.getString("name"), rset.getDate("resv_date").toString(), 
                        rset.getInt("room"), rset.getString("addr"), rset.getString("tel"),
                        rset.getString("in_name"),  rset.getString("comment"), rset.getDate("write_date"), rset.getInt("processing"));
            }
            rset.close();
            pstmt.close();
            if (oneDaily == null) {
                oneDaily = new JoaItem(day.toString(), -1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return oneDaily;
    }

    @Override
    public int totalRoom() {
        int totalRoom = 0;
        try {
            Statement stmt = conn.createStatement();
            ResultSet roomSize = stmt.executeQuery("select max(room +1) from joaresort;");
            while (roomSize.next()) {
                totalRoom = roomSize.getInt(1);
            }
            roomSize.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalRoom;
    }

    @Override
    public int addReservation(JoaItem newResv) {
        String sql = "insert into joaresort values (?, ?, ?, ?, ?, ?, ?, ?, NOW(), 0);";
        int result = 0;
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newResv.getId());
            pstmt.setString(2, newResv.getName());
            pstmt.setString(3, newResv.getResv_date());
            pstmt.setInt(4, newResv.getRoom());
            pstmt.setString(5, newResv.getAddr());
            pstmt.setString(6, newResv.getTel());
            pstmt.setString(7, newResv.getIn_name());
            pstmt.setString(8, newResv.getComment());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public int updateReservation(JoaItem updateResv) {
        System.out.println(updateResv.toString());
        String sql = "update joaresort set name = ?, addr = ?, tel = ?, in_name = ?, comment = ?, processing = ? where resv_date = ? and room = ?;";
        int result = 0;
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, updateResv.getName());
            pstmt.setString(2, updateResv.getAddr());
            pstmt.setString(3, updateResv.getTel());
            pstmt.setString(4, updateResv.getIn_name());
            pstmt.setString(5, updateResv.getComment());
            pstmt.setInt(6, updateResv.getProcessing());
            pstmt.setString(7, updateResv.getResv_date());
            pstmt.setInt(8, updateResv.getRoom());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    
    @Override
    public int cancleReservation(JoaItem resv) {
        String sql = "update joaresort set processing = 4 where resv_date = ? and room = ?";
        int result = 0;
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, resv.getResv_date());
            pstmt.setInt(2, resv.getRoom());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public int refundReservation(JoaItem resv) {
        String sql = "update joaresort set processing = 2 where resv_date = ? and room = ?";
        int result = 0;
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, resv.getResv_date());
            pstmt.setInt(2, resv.getRoom());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    
    @Override
    public List<JoaItem> getMyList(String id) {
        List<JoaItem> myList = new ArrayList<JoaItem>();
        String sql = "select * from joaresort where id = ?;";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            ResultSet rset = pstmt.executeQuery();
            while (rset.next()) {
                myList.add(new JoaItem(rset.getString("id"), rset.getString("name"), rset.getDate("resv_date").toString(), 
                        rset.getInt("room"), rset.getString("addr"), rset.getString("tel"),
                        rset.getString("in_name"),  rset.getString("comment"), rset.getDate("write_date"), rset.getInt("processing")));
            }
            rset.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return myList;
    }

}
