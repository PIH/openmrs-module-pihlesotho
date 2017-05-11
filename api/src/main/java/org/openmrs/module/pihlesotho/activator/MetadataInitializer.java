package org.openmrs.module.pihlesotho.activator;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.api.context.Context;
import org.openmrs.module.metadatadeploy.api.MetadataDeployService;
import org.openmrs.module.metadatadeploy.bundle.MetadataBundle;

public class MetadataInitializer implements Initializer {
	
	protected static final Log log = LogFactory.getLog(MetadataInitializer.class);
	
	/**
	 * Run during the activator started method
	 */
	@Override
	public void started() {
		MetadataDeployService deployService = Context.getService(MetadataDeployService.class);
		deployService.installBundles(Context.getRegisteredComponents(MetadataBundle.class));
		
	}
	
	/**
	 * Run during the activator stopped method
	 */
	@Override
	public void stopped() {
		
	}
}
