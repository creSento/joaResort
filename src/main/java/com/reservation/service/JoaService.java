package com.reservation.service;

import java.time.LocalDate;
import java.util.List;

import com.reservation.domain.JoaCalendar;
import com.reservation.domain.JoaItem;
import com.reservation.domain.JoaUser;

public interface JoaService {
    void init();
    
    int login(String id, String pwd);
    
    int join(JoaUser user); 
    
    JoaUser getUser(String id);

    JoaCalendar getCalendar(int year, int month);
    
    JoaCalendar getCalendar(String year, String month);

    boolean[] dailyBooked(JoaCalendar cal, String dateString);

    JoaItem getDaily(LocalDate day, int room);
    
    List<JoaItem> getDailyList(int year, int month, int room);

    int totalRoom();

    int addReservation(JoaItem newResv);
    
    int updateReservation(JoaItem updateResv);
    
    int cancleReservation(JoaItem resv);
    
    int refundReservation(JoaItem resv);
    
    List<JoaItem> getMyList(String id);
}
