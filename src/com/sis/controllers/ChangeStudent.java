package com.sis.controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sis.helpers.Finder;
import com.sis.hibernate.DBConnection;
import com.sis.models.Student;
import com.sis.models.User;

/**
 * Servlet implementation class UpdateStudent
 */
@WebServlet("/ChangeStudent")
public class ChangeStudent extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        try {
            int studentId = Integer.valueOf(request.getParameter("stId"));
            Student student = DBConnection.getEMF().createEntityManager().find(Student.class, studentId);
            student.setFisrtName(request.getParameter("fName"));
            student.setLastName(request.getParameter("lName"));
            student.setFacultyNumber(request.getParameter("fNumber"));
            int studentSemester = Integer.valueOf(request.getParameter("semester"));
            student.setSemester(studentSemester);
            student.setEGN(request.getParameter("EGN"));
            Finder.updateRecord(student);

            User user = (User) DBConnection.getEMF().createEntityManager().find(User.class,
                    request.getParameter("un"));
            createSession(request, user);
            createDispatcher(request, response, "/Info.jsp");
        } catch (Exception e) {
            System.out.println();
            // TODO: handle exception
        }
    }

    private HttpSession createSession(HttpServletRequest request, User user) {
        HttpSession session = request.getSession(true);
        session.setAttribute("currentSessionUser", user);
        return session;
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
