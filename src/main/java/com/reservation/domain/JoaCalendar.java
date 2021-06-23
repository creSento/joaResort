package com.reservation.domain;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;

public class JoaCalendar implements Serializable {
    private static final long serialVersionUID = 1L;

    private int year;
    private int month;
    private int endOfMonth;
    private String[] dayOfweek;
    private String[] dateString;
    private boolean[][] isBooked;
    private List<JoaItem> monthly;

    public JoaCalendar() {

    }

    public JoaCalendar(int year, int month) {
        this.year = year;
        this.month = month;
    }

    public JoaCalendar(int endOfMonth, String[] dayOfweek, String[] dateString, List<JoaItem> monthly) {
        this.endOfMonth = endOfMonth;
        this.dayOfweek = dayOfweek;
        this.dateString = dateString;
        this.monthly = monthly;
    }

    public JoaCalendar(int endOfMonth, String[] dayOfweek, String[] dateString, boolean[][] isBooked,
            List<JoaItem> monthly) {
        this.endOfMonth = endOfMonth;
        this.dayOfweek = dayOfweek;
        this.dateString = dateString;
        this.isBooked = isBooked;
        this.monthly = monthly;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public int getEndOfMonth() {
        return endOfMonth;
    }

    public void setEndOfMonth(int endOfMonth) {
        this.endOfMonth = endOfMonth;
    }

    public String[] getDayOfweek() {
        return dayOfweek;
    }

    public void setDayOfweek(String[] dayOfweek) {
        this.dayOfweek = dayOfweek;
    }

    public String[] getDateString() {
        return dateString;
    }

    public void setDateString(String[] dateString) {
        this.dateString = dateString;
    }

    public boolean[][] getIsBooked() {
        return isBooked;
    }

    public void setIsBooked(boolean[][] isBooked) {
        this.isBooked = isBooked;
    }

    public List<JoaItem> getMonthly() {
        return monthly;
    }

    public void setMonthly(List<JoaItem> monthly) {
        this.monthly = monthly;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + Arrays.hashCode(dateString);
        result = prime * result + Arrays.hashCode(dayOfweek);
        result = prime * result + endOfMonth;
        result = prime * result + Arrays.deepHashCode(isBooked);
        result = prime * result + month;
        result = prime * result + ((monthly == null) ? 0 : monthly.hashCode());
        result = prime * result + year;
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
        JoaCalendar other = (JoaCalendar) obj;
        if (!Arrays.equals(dateString, other.dateString))
            return false;
        if (!Arrays.equals(dayOfweek, other.dayOfweek))
            return false;
        if (endOfMonth != other.endOfMonth)
            return false;
        if (!Arrays.deepEquals(isBooked, other.isBooked))
            return false;
        if (month != other.month)
            return false;
        if (monthly == null) {
            if (other.monthly != null)
                return false;
        } else if (!monthly.equals(other.monthly))
            return false;
        if (year != other.year)
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "JoaCalendar [year=" + year + ", month=" + month + ", endOfMonth=" + endOfMonth + ", dayOfweek="
                + Arrays.toString(dayOfweek) + ", dateString=" + Arrays.toString(dateString) + ", isBooked="
                + Arrays.toString(isBooked) + ", monthly=" + monthly + "]";
    }

}
