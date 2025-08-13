# openmrs-module-pihlesotho
======================================

This contains instructions for installing and configuring a Lesotho EMR SDK.

# Pre-requisites

Install the following software

* git
* mvn
* docker

# Basic Lesotho SDK instructions

These are basic SDK instructions (but should be expanded later).

The [PIH EMR README](https://github.com/PIH/openmrs-distro-pihemr/blob/master/README.md) provides useful ideas, but the PIH EMR has a different distro (including war, modules, config, etc). 

NOTE: "lesotho" is the serverId.

```
git clone https://github.com/PIH/openmrs-module-pihlesotho.git

cd pihlesotho

mvn openmrs-sdk:setup -DserverId=lesotho -Ddistro=org.openmrs.distro:pihlesotho:2.0.0-SNAPSHOT

mvn openmrs-sdk:run -DserverId=lesotho
```

If you change the Lesotho code and want to redeploy the SDK, use these commands:

```
cd pihlesotho
mvn clean install

mvn openmrs-sdk:deploy -DserverId=lesotho -Ddistro=org.openmrs.distro:pihlesotho:2.0.0-SNAPSHOT

mvn openmrs-sdk:run -DserverId=lesotho
```


