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
		return 1;
	}
	
	public static final class Concepts {
		
		public static final String MMRPA = "41F42339-CF48-4A1C-B0F2-B906DF1693F2";
		
		public static final String TB_HIV_VHW = "A2FC530E-C5BF-4771-BA10-12B2F6DC8B09";
		
		public static final String CADRE = "D476A6BB-671B-453F-820D-B688F9A2D737";
		
	}
	
	@Override
	protected void installNewVersion() throws Exception {
		
		Concept mmrpa = install(new ConceptBuilder(Concepts.MMRPA)
		        .datatype(notApplicable)
		        .conceptClass(misc)
		        .name("01CC8BD4-18C1-489F-A6DB-7FD670A05E49", "MMRPA",
		            Locale.ENGLISH, ConceptNameType.FULLY_SPECIFIED)
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
	}
}
