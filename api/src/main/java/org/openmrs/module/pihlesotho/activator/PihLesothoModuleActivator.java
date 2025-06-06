/**
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at http://mozilla.org/MPL/2.0/. OpenMRS is also distributed under
 * the terms of the Healthcare Disclaimer located at http://openmrs.org/license.
 *
 * Copyright (C) OpenMRS Inc. OpenMRS is a registered trademark and the OpenMRS
 * graphic logo is a trademark of OpenMRS Inc.
 */
package org.openmrs.module.pihlesotho.activator;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.module.BaseModuleActivator;

/**
 * This class contains the logic that is run every time this module is either started or shutdown
 */
public class PihLesothoModuleActivator extends BaseModuleActivator {
	
	private final Log log = LogFactory.getLog(this.getClass());

	private final ReportInitializer reportInitializer = new ReportInitializer();

	@Override
	public void started() {
		reportInitializer.started();
		log.info("Started PIH Lesotho Module");
	}

	@Override
	public void stopped() {
		log.info("Shutdown PIH Lesotho Module");
	}

}
