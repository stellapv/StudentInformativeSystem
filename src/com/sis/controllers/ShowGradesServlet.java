package com.sis.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.sis.hibernate.DBConnection;
import com.sis.models.Grade;
import com.sis.models.Student;
import com.sis.models.Subject;

/**
 * Servlet implementation class ShowGradesServlet
 */
@WebServlet("/ShowGradesServlet")
public class ShowGradesServlet extends HttpServlet {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private EntityManagerFactory emf = DBConnection.getEMF();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Subject> subjects = null;
        try {
            EntityManager em = emf.createEntityManager();
            Integer studentId = Integer.valueOf(request.getParameter("stId"));
            Student student = em.find(Student.class, studentId);
            subjects = student.getSubjectsUntilCurrentSemester(em);

            request.getSession().setAttribute("subjects", subjects);

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
