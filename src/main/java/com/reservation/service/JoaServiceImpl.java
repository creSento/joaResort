package com.reservation.service;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.List;

import com.reservation.dao.JoaDao;
import com.reservation.dao.JoaDaoImpl;
import com.reservation.domain.JoaCalendar;
import com.reservation.domain.JoaItem;

public class JoaServiceImpl implements JoaService {

    private static JoaServiceImpl instance;

    public static JoaServiceImpl getInstance() {
        if (instance == null) {
            instance = new JoaServiceImpl();
        }
        return instance;
    }

    private JoaServiceImpl() {
    }

    JoaDao dao = JoaDaoImpl.getInstance();

    @Override
    public void init() {
        dao.createResvTable();
        dao.insertInitData();
    }

    @Override
    public JoaItem getDaily(LocalDate day, int room) {
        return dao.getDaily(day, room);
    }

    @Override
    public List<JoaItem> getDailyList(int year, int month, int room) {
        List<JoaItem> dailyList = new ArrayList<JoaItem>();
        LocalDate calendardate = LocalDate.of(year, month, 1);
        LocalDate oneDay = calendardate;
        int endOfMonth = YearMonth.from(calendardate).lengthOfMonth();
        for (int i = 0; i < endOfMonth; i++) {
            oneDay = calendardate.plusDays((long) i);
            dailyList.add(dao.getDaily(oneDay, room));
        }
        return dailyList;
    }

    @Override
    public JoaCalendar getCalendar(int year, int month) {
        if ((Integer) year == null || (Integer) month == null) {
            year = LocalDate.now().getYear();
            month = LocalDate.now().getMonthValue();
        }
        LocalDate calendardate = LocalDate.of(year, month, 1);
        LocalDate oneDay = calendardate;
        int endOfMonth = YearMonth.from(calendardate).lengthOfMonth();
        String[] dayOfweek = new String[endOfMonth];
        String[] dateString = new String[endOfMonth];
        List<JoaItem> monthly = dao.getMonthly(calendardate);
        boolean[][] isBooked = new boolean[endOfMonth][totalRoom()];
        for (int i = 0; i < endOfMonth; i++) {
            oneDay = calendardate.plusDays((long) i);
            dayOfweek[i] = oneDay.getDayOfWeek().toString();
            dateString[i] = oneDay.toString();
            for (JoaItem joa : monthly) {
                if (joa.getResv_date().equals(dateString[i])) {
                    isBooked[i][joa.getRoom()] = true;
                }
            }
        }
        return new JoaCalendar(endOfMonth, dayOfweek, dateString, isBooked, monthly);
    }

    public boolean[] dailyBooked(JoaCalendar cal, String dateString) {
        boolean[] dailyBookd = new boolean[totalRoom()];
        int date = LocalDate.parse(dateString).getDayOfMonth();
        for (int i = 0; i < dailyBookd.length; i++) {
            dailyBookd[i] = cal.getIsBooked()[date - 1][i];
        }
        return dailyBookd;
    }

    @Override
    public int totalRoom() {
        return dao.totalRoom();
    }

    @Override
    public int addReservation(JoaItem newResv) {
        return dao.addReservation(newResv);
    }

}
