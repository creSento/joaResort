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
                name = String.format("홍길%d", i);
                resv_date = LocalDate.of(2021, 7, i);
                room = (int) (Math.random() * 3);
                in_name = name;
                comment = String.format("resv%d", i);
                processing = (int) (Math.random() * 3 + 1);
                query = String.format(
                            "insert into joaresort values(" 
                            + "'%s', '%s', %d, '%s', '%s', " 
                            + "'%s', '%s', '%s', %d);",
                            name, resv_date.toString(), room, addr, tel, 
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
                        new JoaItem(rset.getString(1), rset.getDate(2).toString(), rset.getInt(3),
                        rset.getString(4), rset.getString(5), rset.getString(6), 
                        rset.getString(7), rset.getDate(8), rset.getInt(9)));
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
                oneDaily = new JoaItem(rset.getString(1), rset.getDate(2).toString(), rset.getInt(3), 
                        rset.getString(4), rset.getString(5), rset.getString(6), 
                        rset.getString(7), rset.getDate(8), rset.getInt(9));
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
        String sql = "insert into joaresort values (?, ?, ?, ?, ?, ?, ?, NOW(), 1);";
        int result = 0;
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newResv.getName());
            pstmt.setString(2, newResv.getResv_date());
            pstmt.setInt(3, newResv.getRoom());
            pstmt.setString(4, newResv.getAddr());
            pstmt.setString(5, newResv.getTel());
            pstmt.setString(6, newResv.getIn_name());
            pstmt.setString(7, newResv.getComment());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

}
