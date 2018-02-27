package org.openmrs.module.pihlesotho.metadata.deploy.bundle;

import org.openmrs.Concept;
import org.openmrs.ProviderAttributeType;
import org.openmrs.api.ConceptService;
import org.openmrs.api.ProviderService;
import org.openmrs.customdatatype.datatype.DateDatatype;
import org.openmrs.customdatatype.datatype.FreeTextDatatype;
import org.openmrs.module.coreapps.customdatatype.CodedConceptDatatype;
import org.openmrs.module.coreapps.customdatatype.LocationDatatype;
import org.openmrs.module.metadatadeploy.bundle.AbstractMetadataBundle;
import org.openmrs.module.metadatadeploy.bundle.Requires;
import org.openmrs.module.pihlesotho.metadata.deploy.bundle.concept.ChwConcepts;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import static org.openmrs.module.metadatadeploy.bundle.CoreConstructors.providerAttributeType;

/**
 * Installs CHW provider attributes
 */
@Component
@Requires(ChwConcepts.class)
public class ProviderAttributeTypeBundle extends AbstractMetadataBundle {
	
	@Autowired
	private ConceptService conceptService;
	
	@Autowired
	private ProviderService providerService;
	
	public static final class ProviderAttributeTypes {
		
		public static final String PHONE_NUMBER = "30375A78-FA92-4C5C-A2FD-7E8339EC69CF";
		
		public static final String NUMBER_OF_HOUSEHOLDS = "0c267ae8-f793-4cf8-9b27-93accaa45d86";
		
		public static final String DATE_OF_TRAINING = "c8ef8a16-a8cd-4748-b0ea-e8a1ec503fbb";
		
		public static final String CADRE = "70D039A3-DA50-43EA-8FC0-D250102A4793";
		
		public static final String OWNERSHIP = "3171BEF5-7BB2-41A7-A99A-84A99D47B620";
		
		public static final String FACILITY = "BCB608BF-2EAF-4634-B639-C40A01F13315";
	}
	
	/**
	 * Performs the installation of the metadata items
	 * 
	 * @throws Exception if an error occurs
	 */
	@Override
	public void install() throws Exception {
		
		install(providerAttributeType("Phone Number", "Provider phone number", FreeTextDatatype.class, null, 0, 1,
		    ProviderAttributeTypes.PHONE_NUMBER));
		
		install(providerAttributeType("Households", "Number of households monitored by a VHW", FreeTextDatatype.class, null,
		    0, 1, ProviderAttributeTypes.NUMBER_OF_HOUSEHOLDS));
		
		ProviderAttributeType dateHired = install(providerAttributeType("Recruitment Training Date",
		    "The date the provider was provided training.", DateDatatype.class, null, 0, 1,
		    ProviderAttributeTypes.DATE_OF_TRAINING));
		if (dateHired != null) {
			dateHired.setPreferredHandlerClassname("org.openmrs.web.attribute.handler.DateFieldGenDatatypeHandler");
			providerService.saveProviderAttributeType(dateHired);
		}
		
		Concept facilityConcept = conceptService.getConceptByUuid(ChwConcepts.Concepts.FACILITY);
		if (facilityConcept != null) {
			install(providerAttributeType("Health Facility", "Health Facility", LocationDatatype.class, "Health Facility",
			    0, 1, ProviderAttributeTypes.FACILITY));
		}
		
		Concept cadreConcept = conceptService.getConceptByUuid(ChwConcepts.Concepts.CADRE);
		if (cadreConcept != null) {
			install(providerAttributeType("Cadre", "Cadre", CodedConceptDatatype.class, cadreConcept.getConceptId()
			        .toString(), 0, 1, ProviderAttributeTypes.CADRE));
		}
		
		Concept ownershipConcept = conceptService.getConceptByUuid(ChwConcepts.Concepts.OWNERSHIP);
		if (ownershipConcept != null) {
			install(providerAttributeType("Ownership", "Ownership", CodedConceptDatatype.class, ownershipConcept
			        .getConceptId().toString(), 0, 1, ProviderAttributeTypes.OWNERSHIP));
		}
		
	}
}
