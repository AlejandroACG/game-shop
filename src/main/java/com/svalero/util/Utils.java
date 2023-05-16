package com.svalero.util;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.Period;

public class Utils {
    public static LocalDate dateReverseFormatter(String date) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return LocalDate.parse(date, formatter);
    }
    public static LocalDate dateFormatter(String day, String month, String year) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        return LocalDate.parse(day+"-"+month+"-"+year, formatter);
    }
    public static LocalDate dateFormatter(String date) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        return LocalDate.parse(date, formatter);
    }
    public static int getAge(LocalDate birthDate) {
        LocalDate currentDate = LocalDate.now();
        return Period.between(birthDate, currentDate).getYears();
    }
}
