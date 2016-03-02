package com.sis.controllers;

import java.io.IOException;

import javax.persistence.EntityManagerFactory;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sis.helpers.Finder;
import com.sis.hibernate.DBConnection;
import com.sis.models.Grade;
import com.sis.models.Student;
import com.sis.models.Subject;
import com.sis.models.User;

/**
 * Servlet implementation class UpdateGradeServlet
 */
@WebServlet("/UpdateGradeServlet")
public class UpdateGradeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EntityManagerFactory emf = DBConnection.getEMF();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int studentId = Integer.valueOf(request.getParameter("stId"));
            Student student = DBConnection.getEMF().createEntityManager().find(Student.class, studentId);
            int subjectId = Integer.valueOf(request.getParameter("sbId"));
            Subject subject = DBConnection.getEMF().createEntityManager().find(Subject.class, subjectId);
            Grade grade = subject.getSubjectGrade(emf.createEntityManager(), student);
            int mark = Integer.valueOf(request.getParameter("mark"));
            if (grade == null) {
                Grade gradeRecord = new Grade();
                gradeRecord.setStudent(student);
                gradeRecord.setSubject(subject);
                gradeRecord.setMark(mark);
                Finder.createRecord(gradeRecord);
            } else {
                grade.setStudent(student);
                grade.setSubject(subject);
                grade.setMark(mark);
                Finder.updateRecord(grade);
            }
            User user = (User) DBConnection.getEMF().createEntityManager().find(User.class,
                    request.getParameter("un"));
            request.getSession().setAttribute("currentSessionUser", user);
            
            createDispatcher(request, response, "/ShowGrades.jsp");
        } catch (Exception e) {
            System.out.println();
            // TODO: handle exception
        }
    }

    private RequestDispatcher createDispatcher(HttpServletRequest request, HttpServletResponse response, String redirectEndpoint)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redirectEndpoint);
        if (dispatcher != null) {
            dispatcher.forward(request, response);
        }
        return dispatcher;
    }
}
