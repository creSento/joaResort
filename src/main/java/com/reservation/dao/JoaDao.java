package com.reservation.dao;

import java.time.LocalDate;
import java.util.List;

import com.reservation.domain.JoaItem;

public interface JoaDao {

    void createResvTable();

    void insertInitData();

    List<JoaItem> getMonthly(LocalDate calendardate);

    JoaItem getDaily(LocalDate day, int room);

    int totalRoom();

    int addReservation(JoaItem newResv);


}
