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

import java.util.ArrayList;
import java.util.List;

/**
 * This class contains the logic that is run every time this module is either started or shutdown
 */
public class PihLesothoModuleActivator extends BaseModuleActivator {
	
	private Log log = LogFactory.getLog(this.getClass());
	
	@Override
	public void contextRefreshed() {
		log.info("PIH Lesotho Module refreshed");
	}
	
	@Override
	public void willRefreshContext() {
		log.info("Refreshing PIH Lesotho Module");
	}
	
	@Override
	public void willStart() {
		log.info("Starting PIH Lesotho Module");
	}
	
	@Override
	public void willStop() {
		log.info("Stopping PIH Lesotho Module");
	}
	
	public List<Initializer> getInitializers() {
		List<Initializer> initializers = new ArrayList<Initializer>();
		initializers.add(new MetadataInitializer());
		return initializers;
	}
	
	/**
	 * @see #started()
	 */
	public void started() {
		
		log.info("Started PIH Lesotho Module");
		for (Initializer initializer : getInitializers()) {
			initializer.started();
		}
	}
	
	/**
	 * @see #shutdown()
	 */
	public void shutdown() {
		
		log.info("Shutdown PIH Lesotho Module");
		for (int i = getInitializers().size() - 1; i >= 0; i--) {
			getInitializers().get(i).stopped();
		}
	}
	
}
