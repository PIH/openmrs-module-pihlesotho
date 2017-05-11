package org.openmrs.module.pihlesotho.metadata.deploy.bundle;

import org.openmrs.module.metadatadeploy.bundle.AbstractMetadataBundle;
import org.springframework.stereotype.Component;

import static org.openmrs.module.metadatadeploy.bundle.CoreConstructors.relationshipType;

/**
 * Installs the relationship types required by the VHW module
 */
@Component
public class RelationshipTypeBundle extends AbstractMetadataBundle {
	
	public static final class RelationshipTypes {
		
		public static final String CHW_TO_PATIENT = "90d9ee7e-1b76-102d-b823-000c29891b1e";
	}
	
	/**
	 * Performs the installation of the metadata items
	 * 
	 * @throws Exception if an error occurs
	 */
	@Override
	public void install() throws Exception {
		install(relationshipType("CHW", "Patient", "Community health worker who supervises treatment",
		    RelationshipTypes.CHW_TO_PATIENT));
	}
}
