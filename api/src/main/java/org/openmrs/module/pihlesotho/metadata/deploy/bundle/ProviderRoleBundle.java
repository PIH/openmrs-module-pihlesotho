package org.openmrs.module.pihlesotho.metadata.deploy.bundle;

import org.openmrs.ProviderAttributeType;
import org.openmrs.RelationshipType;
import org.openmrs.api.PersonService;
import org.openmrs.api.ProviderService;
import org.openmrs.module.metadatadeploy.bundle.AbstractMetadataBundle;
import org.openmrs.module.metadatadeploy.bundle.Requires;
import org.openmrs.module.providermanagement.ProviderRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashSet;
import java.util.Set;

import static org.openmrs.module.pihlesotho.metadata.deploy.PihConstructors.providerRole;

/**
 * Install VHW Provider Roles
 */
@Component
@Requires({ ProviderAttributeTypeBundle.class, RelationshipTypeBundle.class })
public class ProviderRoleBundle extends AbstractMetadataBundle {
	
	@Autowired
	private PersonService personService;
	
	@Autowired
	private ProviderService providerService;
	
	public static final class ProviderRoles {
		
		public static final String CHW = "68624C4C-9E10-473B-A849-204820D16C45";
		
		public static final String CHW_SUPERVISOR = "11C1A56D-82F7-4269-95E8-2B67B9A3D837";
		
		public static final String CHW_COORDINATOR = "E050AA6E-AFFB-4D31-B00F-CE118ECDEF18";
	}
	
	/**
	 * Performs the installation of the metadata items
	 * 
	 * @throws Exception if an error occurs
	 */
	@Override
	public void install() throws Exception {
		
		Set<RelationshipType> relationshipTypes = null;
		RelationshipType vhwToPatient = personService
		        .getRelationshipTypeByUuid(RelationshipTypeBundle.RelationshipTypes.CHW_TO_PATIENT);
		if (vhwToPatient != null) {
			relationshipTypes = new HashSet<RelationshipType>();
			relationshipTypes.add(vhwToPatient);
		}
		
		Set<ProviderAttributeType> providerAttributes = new HashSet<ProviderAttributeType>();
		ProviderAttributeType providerAttributeType = providerService
		        .getProviderAttributeTypeByUuid(ProviderAttributeTypeBundle.ProviderAttributeTypes.FACILITY);
		if (providerAttributeType != null) {
			providerAttributes.add(providerAttributeType);
		}
		providerAttributeType = providerService
		        .getProviderAttributeTypeByUuid(ProviderAttributeTypeBundle.ProviderAttributeTypes.DATE_OF_TRAINING);
		if (providerAttributeType != null) {
			providerAttributes.add(providerAttributeType);
		}
		providerAttributeType = providerService
		        .getProviderAttributeTypeByUuid(ProviderAttributeTypeBundle.ProviderAttributeTypes.PHONE_NUMBER);
		if (providerAttributeType != null) {
			providerAttributes.add(providerAttributeType);
		}
		providerAttributeType = providerService
		        .getProviderAttributeTypeByUuid(ProviderAttributeTypeBundle.ProviderAttributeTypes.NUMBER_OF_HOUSEHOLDS);
		if (providerAttributeType != null) {
			providerAttributes.add(providerAttributeType);
		}
		providerAttributeType = providerService
		        .getProviderAttributeTypeByUuid(ProviderAttributeTypeBundle.ProviderAttributeTypes.CADRE);
		if (providerAttributeType != null) {
			providerAttributes.add(providerAttributeType);
		}
		providerAttributeType = providerService
		        .getProviderAttributeTypeByUuid(ProviderAttributeTypeBundle.ProviderAttributeTypes.CHW_STATUS);
		if (providerAttributeType != null) {
			providerAttributes.add(providerAttributeType);
		}
		providerAttributeType = providerService
		        .getProviderAttributeTypeByUuid(ProviderAttributeTypeBundle.ProviderAttributeTypes.OWNERSHIP);
		if (providerAttributeType != null) {
			providerAttributes.add(providerAttributeType);
		}
		
		ProviderRole vhwSupervisee = install(providerRole("CHW", null, relationshipTypes, providerAttributes,
		    ProviderRoles.CHW));
		
		Set<ProviderRole> superviseeRoles = null;
		if (vhwSupervisee != null) {
			superviseeRoles = new HashSet<ProviderRole>();
			superviseeRoles.add(vhwSupervisee);
		}
		
		ProviderRole vhwSupervisor = install(providerRole("CHW Supervisor", superviseeRoles, relationshipTypes,
		    providerAttributes, ProviderRoles.CHW_SUPERVISOR));
		Set<ProviderRole> chwSupervisorRoles = null;
		if (vhwSupervisor != null) {
			chwSupervisorRoles = new HashSet<ProviderRole>();
			chwSupervisorRoles.add(vhwSupervisor);
		}
		
		install(providerRole("CHW Coordinator", chwSupervisorRoles, relationshipTypes, providerAttributes,
		    ProviderRoles.CHW_COORDINATOR));
		
	}
}
