package com.sis.controllers;

import java.io.IOException;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sis.hibernate.DBConnection;
import com.sis.models.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    private EntityManagerFactory emf = DBConnection.getEMF();

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws java.io.IOException {

        try {

            User user = findWithName(request.getParameter("un"), request.getParameter("pw"));

            createSession(request, user);

            if (user == null) {
                response.sendRedirect("Error.jsp");
            } else {
                createDispatcher(request, response, "/Info.jsp");
            }
        }

        catch (Throwable theException) {
            response.sendRedirect("Error.jsp");

            System.out.println(theException);
        }
    }

    private User findWithName(String name, String password) {
        EntityManager em = emf.createEntityManager();
        return (User) em.createQuery("SELECT u FROM User u WHERE u.name=?1 and u.password=?2").setParameter(1, name)
                .setParameter(2, password).getSingleResult();
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
