package com.reservation.dao;

import java.time.LocalDate;
import java.util.List;

import com.reservation.domain.JoaItem;
import com.reservation.domain.JoaUser;

public interface JoaDao {

    void createResvTable();

    void insertInitData();

    int login(String id, String pwd);

    int join(JoaUser user);

    JoaUser getUser(String id);

    List<JoaItem> getMonthly(LocalDate calendardate);

    JoaItem getDaily(LocalDate day, int room);

    int totalRoom();

    int addReservation(JoaItem newResv);

    int updateReservation(JoaItem updateResv);

    int cancleReservation(JoaItem resv);

    int refundReservation(JoaItem resv);

    List<JoaItem> getMyList(String id);

}
