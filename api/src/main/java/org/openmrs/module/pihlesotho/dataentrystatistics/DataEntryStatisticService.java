/**
 * The contents of this file are subject to the OpenMRS Public License
 * Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://license.openmrs.org
 * <p>
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 * <p>
 * Copyright (C) OpenMRS, LLC.  All Rights Reserved.
 */
package org.openmrs.module.pihlesotho.dataentrystatistics;

import org.hibernate.Query;
import org.openmrs.EncounterType;
import org.openmrs.Form;
import org.openmrs.Person;
import org.openmrs.User;
import org.openmrs.api.db.hibernate.DbSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Queries for data entry statistics
 */
@Component("pihlesothoDataEntryStatisticsService")
public class DataEntryStatisticService {

    @Autowired
    DbSessionFactory sessionFactory;

    /**
     * Creates a list of data entry stats from <code>fromDate</code> to <code>toDate</code>
     * EncounterUserColumn is a column in the encounter table like <code>creator</code>,
     * <code>provider</code>, etc (defaults to creator) EncounterUserColumn is a column in the
     * encounter table like <code>creator</code>, <code>orderer</code>, etc (defaults to orderer)
     *
     * @param fromDate
     * @param toDate
     * @param encounterUserColumn
     * @param orderUserColumn
     * @param groupBy (optional)
     * @return the list of DataEntryStatistics
     */
    // Authorization?
    public List<DataEntryStatistic> getDataEntryStatistics(Date fromDate, Date toDate, String encounterUserColumn,
                                                           String orderUserColumn, String groupBy) {

        // for all encounters, find user, form name, and number of entries

        // default userColumn to creator
        if (encounterUserColumn == null) {
            encounterUserColumn = "creator";
        }
        encounterUserColumn = encounterUserColumn.toLowerCase();

        List<DataEntryStatistic> ret = new ArrayList<DataEntryStatistic>();

        // data entry stats with extended info
        // check if there's anything else to group by
        if (groupBy == null) {
            groupBy = "";
        }
        if (groupBy.length() != 0) {
            groupBy = "e." + groupBy + ", ";
        }

        String hql = "select " + groupBy + "e." + encounterUserColumn + ", e.encounterType"
                + ", e.form, count(distinct e.encounterId), count(o.obsId) " + "from Obs o right join o.encounter as e ";
        if (fromDate != null || toDate != null) {
            String s = "where ";
            if (fromDate != null) {
                s += "e.dateCreated >= :fromDate ";
            }
            if (toDate != null) {
                if (fromDate != null) {
                    s += "and ";
                }
                s += "e.dateCreated <= :toDate ";
            }
            hql += s;
        }

        //remove voided obs and encounters.
        if (fromDate != null || toDate != null) {
            hql += " and ";
        }
        else {
            hql += " where ";
        }
        hql += " e.voided = :voided and o.voided = :voided ";


        hql += "group by ";
        if (groupBy.length() > 0) {
            hql += groupBy + " ";
        }
        hql += "e." + encounterUserColumn + ", e.encounterType, e.form ";

        Query q = sessionFactory.getCurrentSession().createQuery(hql);
        if (fromDate != null) {
            q.setParameter("fromDate", fromDate);
        }
        if (toDate != null) {
            q.setParameter("toDate", toDate);
        }

        q.setParameter("voided", false);

        List<Object[]> l = q.list();
        for (Object[] holder : l) {
            DataEntryStatistic s = new DataEntryStatistic();
            int offset = 0;
            if (groupBy.length() > 0) {
                s.setGroupBy(holder[0]);
                offset = 1;
            }

            Object temp = holder[0 + offset];
            if (temp instanceof User) {
                s.setUser(((User) temp).getPerson());
            }
            else {
                s.setUser((Person) holder[0 + offset]);
            }
            EncounterType encType = ((EncounterType) holder[1 + offset]);
            Form form = ((Form) holder[2 + offset]);
            s.setEntryType(form != null ? form.getName() : (encType != null ? encType.getName() : "null"));
            int numEncounters = ((Number) holder[3 + offset]).intValue();
            int numObs = ((Number) holder[4 + offset]).intValue();
            s.setNumberOfEntries(numEncounters); // not sure why this comes out as a Long instead of an Integer
            s.setNumberOfObs(numObs);
            ret.add(s);
        }

        // default userColumn to creator
        if (orderUserColumn == null) {
            orderUserColumn = "creator";
        }
        orderUserColumn = orderUserColumn.toLowerCase();

        // for orders, count how many were created. (should eventually count something with voided/changed)
        hql = "select o." + orderUserColumn + ", o.orderType.name, count(*) " + "from Order o ";
        if (fromDate != null || toDate != null) {
            String s = "where ";
            if (fromDate != null) {
                s += "o.dateCreated >= :fromDate ";
            }
            if (toDate != null) {
                if (fromDate != null) {
                    s += "and ";
                }
                s += "o.dateCreated <= :toDate ";
            }
            hql += s;
        }

        //remove voided orders.
        if (fromDate != null || toDate != null) {
            hql += " and ";
        }
        else {
            hql += " where ";
        }
        hql += " o.voided = :voided ";

        hql += "group by o." + orderUserColumn + ", o.orderType.name ";
        q = sessionFactory.getCurrentSession().createQuery(hql);
        if (fromDate != null) {
            q.setParameter("fromDate", fromDate);
        }
        if (toDate != null) {
            q.setParameter("toDate", toDate);
        }

        q.setParameter("voided", false);

        l = q.list();
        for (Object[] holder : l) {
            DataEntryStatistic s = new DataEntryStatistic();
            Object temp = holder[0];
            if (temp instanceof User) {
                s.setUser(((User) temp).getPerson());
            }
            else {
                s.setUser((Person) temp);
            }
            s.setEntryType((String) holder[1]);
            s.setNumberOfEntries(((Number) holder[2]).intValue()); // not sure why this comes out as a Long instead of an Integer
            s.setNumberOfObs(0);
            ret.add(s);
        }

        return ret;
    }
}
