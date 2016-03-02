package com.sis.helpers;

import java.util.List;
import javax.persistence.EntityManager;
import com.sis.hibernate.DBConnection;

public class Finder {
    public static List<?> findAll(EntityManager em, Class persistentClass) {
        return em.createQuery("Select t from " + persistentClass.getSimpleName() + " t").getResultList();
    }

    public static void updateRecord(Object model) {
        EntityManager em = DBConnection.getEMF().createEntityManager();

        em.getTransaction().begin();
        em.merge(model);
        em.getTransaction().commit();
    }

    public static void createRecord(Object model) {
        EntityManager em = DBConnection.getEMF().createEntityManager();

        em.getTransaction().begin();
        em.persist(model);
        em.getTransaction().commit();
    }

}
