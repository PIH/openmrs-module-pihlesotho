/**
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at http://mozilla.org/MPL/2.0/. OpenMRS is also distributed under
 * the terms of the Healthcare Disclaimer located at http://openmrs.org/license.
 *
 * Copyright (C) OpenMRS Inc. OpenMRS is a registered trademark and the OpenMRS
 * graphic logo is a trademark of OpenMRS Inc.
 */
package org.openmrs.module.pihlesotho;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.GlobalProperty;
import org.openmrs.PrivilegeListener;
import org.openmrs.User;
import org.openmrs.api.AdministrationService;
import org.openmrs.api.GlobalPropertyListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * Provides logging of privilege checks as needed to support proper role and privilege configuration
 */
@Component
public class PihLesothoPrivilegeHelper implements PrivilegeListener, GlobalPropertyListener {

	private final Log log = LogFactory.getLog(this.getClass());

	public static final String GP_LOG_PRIVILEGE_CHECKS_FOR_USERS = "pihlesotho.logPrivilegeChecksForUsers";

	@Autowired @Qualifier("adminService")
	AdministrationService administrationService;

	Set<String> usernamesToLog = null;

	@Override
	public void privilegeChecked(User user, String privilege, boolean hasPrivilege) {
		Set<String> usernamesToLog = getUsernamesToLog();
		if (user != null && user.getUsername() != null) {
			String username = user.getUsername().toLowerCase();
			if (usernamesToLog.contains(username) || usernamesToLog.contains("*")) {
				if (hasPrivilege) {
					log.warn("PRIVILEGE CHECK PASS:  " + username + " - " + privilege);
				}
				else {
					log.warn("PRIVILEGE CHECK FAIL:  " + username + " - " + privilege);
				}
			}
			}
	}

	private synchronized Set<String> getUsernamesToLog() {
		if (usernamesToLog == null) {
			usernamesToLog = new HashSet<>();
			String gpValue = administrationService.getGlobalProperty(GP_LOG_PRIVILEGE_CHECKS_FOR_USERS, "");
			if (StringUtils.isNotBlank(gpValue)) {
				usernamesToLog.addAll(Arrays.asList(gpValue.toLowerCase().split(",")));
			}
		}
		return usernamesToLog;
	}

	@Override
	public boolean supportsPropertyName(String propertyName) {
		return GP_LOG_PRIVILEGE_CHECKS_FOR_USERS.equals(propertyName);
	}

	@Override
	public void globalPropertyChanged(GlobalProperty globalProperty) {
		usernamesToLog = null;
	}

	@Override
	public void globalPropertyDeleted(String propertyName) {
		usernamesToLog = null;
	}
}
