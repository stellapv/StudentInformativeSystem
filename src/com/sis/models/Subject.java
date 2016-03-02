package com.sis.models;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.Id;
import javax.persistence.NoResultException;
import javax.persistence.OneToMany;

@Entity
public class Subject {

    @Id
    @Column(name = "id")
    private int id;
    private String name;
    private int semester;
    private String form_of_control;
    @OneToMany(mappedBy = "subject")
    private List<Grade> grades;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getFormOfControl() {
        return form_of_control;
    }

    public void setFormOfControl(String form_of_control) {
        this.form_of_control = form_of_control;
    }

    public Grade getSubjectGrade(EntityManager em, Student student) {
        Grade grade = null;

        try {
            grade = (Grade) em
                    .createQuery(
                            "SELECT g "
                            + "FROM Grade g "
                            + "JOIN g.subject sb "
                            + "JOIN g.student st "
                            + "where sb =:subject "
                            + "and st =:student")
                    .setParameter("subject", this).setParameter("student", student).getSingleResult();
        } catch (NoResultException | NullPointerException e) {
            System.out.println("No grade found for student " + student.getId() + " and subject " + this.getName());
        }

        return grade;
    }

}
