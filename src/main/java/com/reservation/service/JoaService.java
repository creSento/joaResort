package com.reservation.service;

import java.time.LocalDate;
import java.util.List;

import com.reservation.domain.JoaCalendar;
import com.reservation.domain.JoaItem;

public interface JoaService {
    void init();

    JoaCalendar getCalendar(int year, int month);

    boolean[] dailyBooked(JoaCalendar cal, String dateString);

    JoaItem getDaily(LocalDate day, int room);
    
    List<JoaItem> getDailyList(int year, int month, int room);

    int totalRoom();

    int addReservation(JoaItem newResv);
}
