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
		return 3;
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
		
		public static final String FACILITY = "F5DABCB3-291C-41E8-A9A8-75A4593871E6";
		
		public static final String BOBETE = "F0873869-74C9-403B-952A-DC198AE592E0";
		
		public static final String LEBAKENG = "17893089-66E6-43B7-94FB-08490148FA49";
		
		public static final String MANAMANENG = "9E13A632-963B-4B75-A034-97842F16F180";
		
		public static final String METHALENENG = "8DD3FDED-79CE-486C-B355-9527F09EAF97";
		
		public static final String NOHANA = "F5DABCB3-291C-41E8-A9A8-75A4593871E6";
		
		public static final String NKAU = "0ACA6763-1ACB-4ED3-B1A5-61338E0BC2E4";
		
		public static final String TLHANYAKU = "866C7576-1189-4D2E-8737-10411DD53C1A";
		
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
		
		Concept bobete = install(new ConceptBuilder(Concepts.BOBETE)
		        .datatype(notApplicable)
		        .conceptClass(misc)
		        .name("4E56ECD6-DCFE-4AE2-A9CA-BDB4783BDBEA", "Bobete", Locale.ENGLISH, ConceptNameType.FULLY_SPECIFIED)
		        // locale-preferred
		        .description("F1EBA988-4D0D-47AA-98BD-61B6E40CB0AD", "Bobete facility location", Locale.ENGLISH)
		        .mapping(
		            new ConceptMapBuilder("8CCE16FD-7C48-493F-A520-976DC0F947B3").type(sameAs).ensureTerm(pih, "Bobete")
		                    .build()).build());
		Concept lebakeng = install(new ConceptBuilder(Concepts.LEBAKENG)
		        .datatype(notApplicable)
		        .conceptClass(misc)
		        .name("F4ACD186-5C8E-4A98-8348-2B5C231365D3", "Lebakeng", Locale.ENGLISH, ConceptNameType.FULLY_SPECIFIED)
		        // locale-preferred
		        .description("5ABA6019-32C1-4248-83DE-1A2B34C9214D", "Lebakeng facility location", Locale.ENGLISH)
		        .mapping(
		            new ConceptMapBuilder("718A755C-6DEC-42EE-9FDC-D58099AF9964").type(sameAs).ensureTerm(pih, "Lebakeng")
		                    .build()).build());
		Concept manamaneng = install(new ConceptBuilder(Concepts.MANAMANENG)
		        .datatype(notApplicable)
		        .conceptClass(misc)
		        .name("2F0EED8D-1A80-4E65-9F19-7389E9F08729", "Manamaneng", Locale.ENGLISH, ConceptNameType.FULLY_SPECIFIED)
		        // locale-preferred
		        .description("24E759BF-163A-4D8E-8490-6048848F52C9", "Manamaneng facility location", Locale.ENGLISH)
		        .mapping(
		            new ConceptMapBuilder("ECBE0BFA-44DF-4007-B9C6-5150A65D0D00").type(sameAs).ensureTerm(pih, "Manamaneng")
		                    .build()).build());
		
		Concept methaleneng = install(new ConceptBuilder(Concepts.METHALENENG)
		        .datatype(notApplicable)
		        .conceptClass(misc)
		        .name("E32B8D79-4667-4443-AE83-ECF3E1005736", "Methaleneng", Locale.ENGLISH, ConceptNameType.FULLY_SPECIFIED)
		        // locale-preferred
		        .description("CC6F9AF2-74CC-4537-B907-8D644B35337F", "Methaleneng facility location", Locale.ENGLISH)
		        .mapping(
		            new ConceptMapBuilder("72045A9C-F329-40D7-A105-8F46A334AC44").type(sameAs)
		                    .ensureTerm(pih, "Methaleneng").build()).build());
		Concept nohana = install(new ConceptBuilder(Concepts.NOHANA)
		        .datatype(notApplicable)
		        .conceptClass(misc)
		        .name("96B8DCD0-15BD-4CB5-80E3-78959F2E2594", "Nohana", Locale.ENGLISH, ConceptNameType.FULLY_SPECIFIED)
		        // locale-preferred
		        .description("0C7E96C2-22B4-4AF5-BB07-116DE41C9076", "Nohana facility location", Locale.ENGLISH)
		        .mapping(
		            new ConceptMapBuilder("1040010E-9A51-40CE-930D-A34914A4ABCE").type(sameAs).ensureTerm(pih, "Nohana")
		                    .build()).build());
		Concept nkau = install(new ConceptBuilder(Concepts.NKAU)
		        .datatype(notApplicable)
		        .conceptClass(misc)
		        .name("6994BF57-9299-4A75-9C85-C13BCB317A6D", "Nkau", Locale.ENGLISH, ConceptNameType.FULLY_SPECIFIED)
		        // locale-preferred
		        .description("7D36869E-51CB-4D8F-852C-1A5B0C105C15", "Nkau facility location", Locale.ENGLISH)
		        .mapping(
		            new ConceptMapBuilder("4A30FEFF-B9E1-4FB7-9221-FC59215CA54B").type(sameAs).ensureTerm(pih, "Nkau")
		                    .build()).build());
		Concept tlhanyaku = install(new ConceptBuilder(Concepts.TLHANYAKU)
		        .datatype(notApplicable)
		        .conceptClass(misc)
		        .name("A0CD5D2C-0DEE-43E6-8FFF-E6EDC34911FF", "Tlhanyaku", Locale.ENGLISH, ConceptNameType.FULLY_SPECIFIED)
		        // locale-preferred
		        .description("3EFAB5A4-2278-4F66-BC98-88AEB74B7A59", "Tlhanyaku facility location", Locale.ENGLISH)
		        .mapping(
		            new ConceptMapBuilder("46A40B90-F8CE-4E9E-B2FE-2C15A0954A58").type(sameAs).ensureTerm(pih, "Tlhanyaku")
		                    .build()).build());
		
		Concept facility = install(new ConceptBuilder(Concepts.FACILITY)
		        .datatype(coded)
		        .conceptClass(question)
		        .name("479EF452-B2AC-43D5-92A0-7D00A8412504", "Facility", Locale.ENGLISH, ConceptNameType.FULLY_SPECIFIED)
		        // locale-preferred
		        .description("EE349AAB-561F-4386-8620-7E05C9A73EF1", "Facility location", Locale.ENGLISH)
		        .mapping(
		            new ConceptMapBuilder("798F427D-0A78-4A8B-815A-52D1A5E743A7").type(sameAs).ensureTerm(pih, "Facility")
		                    .build()).answers(bobete, lebakeng, manamaneng, methaleneng, nohana, nkau, tlhanyaku).build());
	}
}
