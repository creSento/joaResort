package com.reservation.service;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.List;

import com.reservation.dao.JoaDao;
import com.reservation.dao.JoaDaoImpl;
import com.reservation.domain.JoaCalendar;
import com.reservation.domain.JoaItem;
import com.reservation.domain.JoaUser;

public class JoaServiceImpl implements JoaService {

    JoaDao dao = JoaDaoImpl.getInstance();

    private static JoaServiceImpl instance;

    public static JoaServiceImpl getInstance() {
        if (instance == null) {
            instance = new JoaServiceImpl();
        }
        return instance;
    }

    private JoaServiceImpl() {
    }

    @Override
    public void init() {
        dao.createResvTable();
        dao.insertInitData();
    }

    @Override
    public int login(String id, String pwd) {
        return dao.login(id, pwd);
    }
    
    @Override
    public int join(JoaUser user) {
        return dao.join(user);
    }
    
    @Override
    public JoaUser getUser(String id) {
        return dao.getUser(id);
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
                if (joa.getResv_date().equals(dateString[i]) && joa.getProcessing() != 4) {
                    isBooked[i][joa.getRoom()] = true;
                }
            }
        }
        return new JoaCalendar(year, month, endOfMonth, dayOfweek, dateString, isBooked, monthly);
    }
    
    @Override
    public JoaCalendar getCalendar(String year, String month) {
        int calYear = 0;
        int calMonth = 0;
        if ( year == null || month == null) {
            calYear = LocalDate.now().getYear();
            calMonth = LocalDate.now().getMonthValue();
        } else {
          calYear = Integer.parseInt(year);
          calMonth = Integer.parseInt(month);
        }
        return getCalendar(calYear, calMonth);
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

    @Override
    public int updateReservation(JoaItem updateResv) {
        return dao.updateReservation(updateResv);
    }
    
    @Override
    public int cancleReservation(JoaItem resv) {
        return dao.cancleReservation(resv);
    }
    
    @Override
    public int refundReservation(JoaItem resv) {
        return dao.refundReservation(resv);
    }

    @Override
    public List<JoaItem> getMyList(String id) {
        return dao.getMyList(id);
    }

}
