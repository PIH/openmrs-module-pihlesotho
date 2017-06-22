package org.openmrs.module.pihlesotho.metadata.deploy.bundle.concept;

import org.openmrs.Concept;
import org.openmrs.api.ConceptNameType;
import org.openmrs.module.metadatadeploy.builder.ConceptBuilder;
import org.openmrs.module.metadatadeploy.builder.ConceptMapBuilder;
import org.openmrs.module.metadatadeploy.bundle.Requires;
import org.openmrs.module.pihlesotho.metadata.deploy.bundle.VersionedPihConceptBundle;
import org.springframework.stereotype.Component;

import java.util.Locale;

@Component
@Requires({ CoreConceptMetadataBundle.class })
public class ChwConcepts extends VersionedPihConceptBundle {
	
	@Override
	public int getVersion() {
		return 2;
	}
	
	public static final class Concepts {
		
		//MRPA
		public static final String MMRPA = "41F42339-CF48-4A1C-B0F2-B906DF1693F2";
		
		public static final String TB_HIV_VHW = "A2FC530E-C5BF-4771-BA10-12B2F6DC8B09";
		
		public static final String CADRE = "D476A6BB-671B-453F-820D-B688F9A2D737";
		
		//Ownership (agency responsible for payment)
		public static final String GOV_OF_LESOTHO = "228EF80F-6180-4F21-B7B0-7E6235B76323";
		
		public static final String GLOBAL_FUND = "0ABDBE95-FFDB-483A-BC49-CF954A5C1C82";
		
		public static final String PIH = "F9C619F3-AFF9-4ED3-A267-F566C438CF1C";
		
		public static final String OWNERSHIP = "6748DA89-3A50-4E19-AB22-54E62C9BAB8E";
	}
	
	@Override
	protected void installNewVersion() throws Exception {
		
		Concept mmrpa = install(new ConceptBuilder(Concepts.MMRPA)
		        .datatype(notApplicable)
		        .conceptClass(misc)
		        .name("01CC8BD4-18C1-489F-A6DB-7FD670A05E49", "MMRPA", Locale.ENGLISH, ConceptNameType.FULLY_SPECIFIED)
		        // locale-preferred
		        .description("86091BE2-8B94-42DE-B4B3-6DF672BC058B", "Maternal mortality reduction program assistant",
		            Locale.ENGLISH)
		        .mapping(
		            new ConceptMapBuilder("0D2D7378-2975-4EEE-A3D0-44C334B41CB5").type(sameAs)
		                    .ensureTerm(pih, "Maternal mortality reduction program assistant").build()).build());
		
		Concept tb_hiv = install(new ConceptBuilder(Concepts.TB_HIV_VHW)
		        .datatype(notApplicable)
		        .conceptClass(misc)
		        .name("8F6517A7-8620-498B-9ECE-D9006AB7DC00", "TB/HIV VHW", Locale.ENGLISH, ConceptNameType.FULLY_SPECIFIED)
		        // locale-preferred
		        .description("CD3FE18C-91CD-45D4-831C-9F74602231DF", "TB/HIV VHW", Locale.ENGLISH)
		        .mapping(
		            new ConceptMapBuilder("56F773AD-B068-425C-B39A-B83A7367D3C4").type(sameAs).ensureTerm(pih, "TB/HIV VHW")
		                    .build()).build());
		
		Concept cadre = install(new ConceptBuilder(Concepts.CADRE)
		        .datatype(coded)
		        .conceptClass(question)
		        .name("F64D85B8-1E9C-429E-8314-0234DEB0824A", "Cadre", Locale.ENGLISH, ConceptNameType.FULLY_SPECIFIED)
		        // locale-preferred
		        .description("CB925469-DCA4-4F73-B962-8792F81FC989", "Cadre", Locale.ENGLISH)
		        .mapping(
		            new ConceptMapBuilder("6CB25B02-AE6B-4BA0-BCE4-8DE191E42C00").type(sameAs).ensureTerm(pih, "Cadre")
		                    .build()).answers(mmrpa, tb_hiv).build());
		
		Concept govOfLesotho = install(new ConceptBuilder(Concepts.GOV_OF_LESOTHO).datatype(notApplicable)
		        .conceptClass(misc)
		        .name("D6EE525C-455E-429E-B5BA-7492EB2CCD42", "GoL", Locale.ENGLISH, ConceptNameType.FULLY_SPECIFIED)
		        // locale-preferred
		        .description("FE630234-1E7E-48C9-9C6D-AFF01F06626C", "Government of Lesotho", Locale.ENGLISH)
		        .mapping(
		            new ConceptMapBuilder("837A6F37-7E23-442D-AAF2-8B2E3AB0155D").type(sameAs)
		                    .ensureTerm(pih, "Government of Lesotho").build()).build());
		
		Concept globalFund = install(new ConceptBuilder(Concepts.GLOBAL_FUND)
		        .datatype(notApplicable)
		        .conceptClass(misc)
		        .name("2D025206-999E-49B4-A720-A0418C14F3CB", "Global Fund", Locale.ENGLISH, ConceptNameType.FULLY_SPECIFIED)
		        // locale-preferred
		        .description("AE383A94-C277-46C7-A55A-82FEA19005FE", "Global Fund", Locale.ENGLISH)
		        .mapping(
		            new ConceptMapBuilder("3F4AB397-ECC1-4D3C-AA0B-C5B821FB548C").type(sameAs)
		                    .ensureTerm(pih, "Global Fund").build()).build());
		
		Concept pihPayment = install(new ConceptBuilder(Concepts.PIH)
		        .datatype(notApplicable)
		        .conceptClass(misc)
		        .name("EDD09A57-E673-440A-B2CF-F25B21989605", "PIH", Locale.ENGLISH, ConceptNameType.FULLY_SPECIFIED)
		        // locale-preferred
		        .description("C658B64F-F3CE-4FCA-B2DF-651C8DA809EA", "PIH", Locale.ENGLISH)
		        .mapping(
		            new ConceptMapBuilder("98688A9A-F396-4CDF-BE14-BBF42C60AACD").type(sameAs).ensureTerm(pih, "PIH")
		                    .build()).build());
		
		Concept ownership = install(new ConceptBuilder(Concepts.OWNERSHIP)
		        .datatype(coded)
		        .conceptClass(question)
		        .name("DB4EC157-E012-416A-A4BA-555C320CD964", "Ownership", Locale.ENGLISH, ConceptNameType.FULLY_SPECIFIED)
		        // locale-preferred
		        .description("92E99DF7-634A-4181-A820-672A833643A6", "Ownership, agency responsible for payment",
		            Locale.ENGLISH)
		        .mapping(
		            new ConceptMapBuilder("55DD201F-4707-4BB1-83DE-55A885B51CD0").type(sameAs).ensureTerm(pih, "Ownership")
		                    .build()).answers(govOfLesotho, globalFund, pihPayment).build());
	}
}
