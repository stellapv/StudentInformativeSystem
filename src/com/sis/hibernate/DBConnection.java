package com.sis.hibernate;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class DBConnection {

    private  static final String PERSISTENCE_PROVIDER = "SIS";
    private  static EntityManagerFactory emf;

    public static EntityManagerFactory getEMF() {
        if (emf == null) {
            emf = Persistence.createEntityManagerFactory(PERSISTENCE_PROVIDER);
        }

        return emf;
    }
}
