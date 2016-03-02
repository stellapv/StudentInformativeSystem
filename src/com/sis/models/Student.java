package com.sis.models;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.NoResultException;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import com.sis.helpers.Finder;

@Entity
public class Student {

    @Id
    private int id;
    private String first_name;
    private String last_name;
    private String faculty_number;
    private String EGN;
    private int semester;
    @OneToMany(mappedBy = "student")
    private List<Grade> grades;
    @OneToOne
    @JoinColumn(name = "EGN", insertable = false, updatable = false)
    private User user;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFisrtName() {
        return first_name;
    }

    public void setFisrtName(String first_name) {
        this.first_name = first_name;
    }

    public String getLastName() {
        return last_name;
    }

    public void setLastName(String last_name) {
        this.last_name = last_name;
    }

    public String getFacultyNumber() {
        return faculty_number;
    }

    public void setFacultyNumber(String faculty_number) {
        this.faculty_number = faculty_number;
    }

    public String getEGN() {
        return EGN;
    }

    public void setEGN(String eGN) {
        EGN = eGN;
    }

    public int getSemester() {
        return semester;
    }

    public void setSemester(int semester) {
        this.semester = semester;
    }

    public List<Grade> getGrades() {
        return grades;
    }

    public void setGrades(List<Grade> grades) {
        this.grades = grades;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Subject> getSubjectsUntilCurrentSemester(EntityManager em) {
        List<Subject> subjects = null;

        subjects = (List<Subject>) em
                .createQuery(
                        "SELECT sb "
                        + "FROM Subject sb, Student st "
                        + "WHERE st = :student "
                        + "AND st.semester >= sb.semester")
                .setParameter("student", this)
                .getResultList();

        return subjects;
    }

}
