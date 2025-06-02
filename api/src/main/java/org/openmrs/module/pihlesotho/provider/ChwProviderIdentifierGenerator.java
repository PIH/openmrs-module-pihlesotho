package org.openmrs.module.pihlesotho.provider;

import org.openmrs.Provider;
import org.springframework.stereotype.Component;
import org.openmrs.module.emrapi.account.ProviderIdentifierGenerator;
import org.openmrs.module.idgen.SequentialIdentifierGenerator;

@Component
/// this is autowired in the DomainWrapperFactory (which injects it into Account Domain Wrapper instances)
public class ChwProviderIdentifierGenerator implements ProviderIdentifierGenerator {
	
	@Override
	public String generateIdentifier(Provider provider) {
		
		if (provider.getId() == null) {
			throw new IllegalStateException("Cannot generate identifier for provider without primary key");
		}
		
		SequentialIdentifierGenerator generator = new SequentialIdentifierGenerator();
		generator.setBaseCharacterSet("0123456789");
		generator.setFirstIdentifierBase("00001");
		generator.setPrefix("CHW-");
		generator.setMaxLength(10);
		generator.setMinLength(5);
		
		String identifier = generator.getIdentifierForSeed(provider.getId().longValue());
		
		return identifier;
	}
}
