angular.module('importChwApp', ['ngDialog'])
    .service('ImportChwService', ['$q', '$http',
        function($q, $http) {
            var CONSTANTS = {
                URLS: {
                    PERSON: "/" + OPENMRS_CONTEXT_PATH + "/ws/rest/v1/person",
                    PATIENT: "/" + OPENMRS_CONTEXT_PATH + "/ws/rest/v1/patient",
                    PROVIDER: "/" + OPENMRS_CONTEXT_PATH + "/ws/rest/v1/provider",
                    PROVIDER_ATTRIBUTE: "/" + OPENMRS_CONTEXT_PATH + "/ws/rest/v1/provider/{UUID}/attribute",
                    PROVIDERMANAGEMENT_ROLE: "/" + OPENMRS_CONTEXT_PATH + "/providermanagement/providerEdit/assignProviderRoleToPerson.action",
                    IDENTIFIER_SOURCE: "/" + OPENMRS_CONTEXT_PATH + "/ws/rest/v1/idgen/identifiersource",
                    PROVIDER_PAGE: "/" + OPENMRS_CONTEXT_PATH + "/coreapps/providermanagement/editProvider.page?personId=",
                },
                PATIENT_CUSTOM_REP: "v=custom:(uuid,display,identifiers:(uuid,identifier,identifierType:(uuid),preferred),person:(uuid,display,gender,age,birthdate,birthdateEstimated,dead,deathDate,causeOfDeath,names,addresses,attributes))",
                PROVIDER_CUSTOM_REP: "v=custom:(uuid,identifier,display,person:(uuid,personId,display,gender,age,birthdate,birthdateEstimated,names,addresses))",
                PERSON_CUSTOM_REP: "v=custom:(uuid,personId,display,gender,age,birthdate,birthdateEstimated,names,addresses)",
                CHW_IDENTIFIER_SOURCE: "CHW Identifier Source",
                PROVIDER_ROLES: {
                    CHW_PROVIDER_ROLE: "68624C4C-9E10-473B-A849-204820D16C45",
                    CHW_SENIOR_PROVIDER_ROLE: "11C1A56D-82F7-4269-95E8-2B67B9A3D837",
                    CHW_SITE_SUPERVISOR_PROVIDER_ROLE: "E050AA6E-AFFB-4D31-B00F-CE118ECDEF18"
                },
                PROVIDER_ATTRIBUTES: {
                    HEALTH_FACILITY: "BCB608BF-2EAF-4634-B639-C40A01F13315",
                    PHONE_NUMBER: "30375A78-FA92-4C5C-A2FD-7E8339EC69CF",
                    CADRE: "70D039A3-DA50-43EA-8FC0-D250102A4793"
                }
            };

            var PROVIDER_ROLES_MAP = new Map([
                ["CHW", { uuid: CONSTANTS.PROVIDER_ROLES.CHW_PROVIDER_ROLE}],
                ["Senior CHW", { uuid: CONSTANTS.PROVIDER_ROLES.CHW_SENIOR_PROVIDER_ROLE}],
                ["CHW Site Supervisor", { uuid: CONSTANTS.PROVIDER_ROLES.CHW_SITE_SUPERVISOR_PROVIDER_ROLE}]

            ]);

            var locationsMap = new Map([
                ["BOBETE" , { code: "BOBET", uuid: "62094c52-1b76-102d-b823-000c29891b1e" }]
            ]);

            var cadreMap = new Map([
                ["MMR" , { code: "MMRPA", uuid: "41F42339-CF48-4A1C-B0F2-B906DF1693F2" }],
                ["VHW" , { code: "TB/HIV VHW", uuid: "A2FC530E-C5BF-4771-BA10-12B2F6DC8B09" }]
            ]);

            this.CONSTANTS = CONSTANTS;
            this.PROVIDER_ROLES_MAP = PROVIDER_ROLES_MAP;

            this.getIdentifierSource = function () {
                return $http.get(CONSTANTS.URLS.IDENTIFIER_SOURCE + "?v=full").then(function(resp) {
                    var idSource= null;
                    if (resp.status == 200) {
                        for (j = 0; j < resp.data.results.length; j++){
                            if (resp.data.results[0].name === CONSTANTS.CHW_IDENTIFIER_SOURCE) {
                                idSource = resp.data.results[0].uuid;
                                break;
                            }
                        }

                    }
                    return idSource;
                }, function (error) {
                    console.log(JSON.stringify(error, undefined, 4));
                });
            };


            this.getNextIdentifier = function (chw, sourceUuid) {

                var generateIdentifiers = {
                    generateIdentifiers: true,
                    comment: "new CHW ID",
                    numberToGenerate: 1,
                    sourceUuid: sourceUuid
                };

                if (chw.identifier != null ) {
                    return new Promise(function (resolve, reject) {
                        resolve(chw.identifier);
                    });
                } else {
                    return $http.post(CONSTANTS.URLS.IDENTIFIER_SOURCE, generateIdentifiers).then(function (resp) {
                        if (resp.status == 201) {
                            // identifier generated
                            if (resp.data && resp.data.identifiers && resp.data.identifiers.length > 0) {
                                // one identifier has been generated
                                return locationsMap.get(chw.healthCenter).code + " " + resp.data.identifiers[0];
                            }
                            return null;
                        } else {
                            return null;
                        }
                    }, function (error) {
                        console.log("failed to generate identifier: " + JSON.stringify(error, undefined, 4));
                    });
                }

            };

            this.createProviderWithRole = function (providerWithRole) {
                return $http.get(CONSTANTS.URLS.PROVIDERMANAGEMENT_ROLE
                    + "?person=" + providerWithRole.person
                    + "&identifier=" + providerWithRole.identifier
                    + "&providerRole=" + providerWithRole.providerRole).then(function(resp) {
                    if (resp.status == 200) {
                        return resp.data;
                    } else {
                        return null;
                    }
                }, function (error) {
                    console.log(JSON.stringify(error, undefined, 4));
                });
            };

            this.addProviderAttribute = function(provider, type, value) {
                if (provider && type && value) {
                    var attribute = {
                        attributeType: type,
                        value: value
                    };
                    var url = CONSTANTS.URLS.PROVIDER + "/" + provider.uuid + "/attribute";
                    return $http.post(url, attribute).then(function(resp) {
                        if (resp.status == 201) {
                            // provider attribute has been created
                            return resp.data;
                        } else {
                            return null;
                        }
                    }, function (error) {
                        console.log("failed to create provider attribute: "
                            + "type =" + type + ", value = " + value  + JSON.stringify(error, undefined, 4));
                    });
                }

            };

            this.addHealthFacility = function (provider, chw) {
                if (provider && chw.healthCenter) {
                    var location = locationsMap.get(chw.healthCenter);
                    if (location) {
                        return this.addProviderAttribute(provider, CONSTANTS.PROVIDER_ATTRIBUTES.HEALTH_FACILITY, location.uuid);
                    } else {
                        return new Promise(function (resolve, reject) {
                            resolve(chw);
                        });
                    }
                }
            };

            this.addCadre = function (chw) {
                if (chw.cadre) {
                    var cadre = cadreMap.get(chw.cadre);
                    if (cadre) {
                        return this.addProviderAttribute(chw, CONSTANTS.PROVIDER_ATTRIBUTES.CADRE, cadre.uuid);
                    } else {
                        return new Promise(function (resolve, reject) {
                            resolve(chw);
                        });
                    }
                }
            };

            this.addPhoneNumber = function (chw) {
                if (chw.phoneNumber) {
                    if (chw.phoneNumber) {
                        var attribute = {
                            attributeType: CONSTANTS.PROVIDER_ATTRIBUTES.PHONE_NUMBER,
                            value: chw.phoneNumber
                        };
                        var url = CONSTANTS.URLS.PROVIDER + "/" + chw.uuid + "/attribute";
                        return $http.post(url, attribute).then(function(resp) {
                            if (resp.status == 201) {
                                // provider attribute has been created
                                return resp.data;
                            } else {
                                return null;
                            }
                        }, function (error) {
                            console.log("failed to create provider attribute: "
                                + chw.phoneNumber + JSON.stringify(error, undefined, 4));
                        });
                    }
                }
            };

            this.getProvider = function (chw) {

                var query = chw.identifier ? (chw.identifier):(chw.firstName + " " + chw.lastName);
                 var url = CONSTANTS.URLS.PROVIDER + "?"
                 + CONSTANTS.PROVIDER_CUSTOM_REP + '&q='
                 + query;

                return $http.get(url).then(function(resp) {
                    if (resp.status == 200) {
                        return resp.data;
                    } else {
                        return null;
                    }
                }, function (error) {
                    console.log(JSON.stringify(error, undefined, 4));
                });
            };
            
            this.createPerson = function (chw) {
                var person = {
                    gender: chw.gender ? chw.gender : "UNKNOWN",
                    //age: chw.age, not reliable information at this time
                    names: [{
                        givenName: chw.firstName,
                        familyName: chw.lastName
                    }]
                };

                if (chw.district && chw.ta && chw.village) {
                    person.addresses = [{
                        preferred: true,
                        stateProvince: chw.district,
                        countyDistrict: chw.ta,
                        cityVillage: chw.village
                    }];

                }

                return $http.post(CONSTANTS.URLS.PERSON, person).then(function(resp) {
                    if (resp.status == 201) {
                        // person created
                        return resp.data;
                    } else {
                        return null;
                    }
                }, function (error) {
                    console.log("failed to create person: " + chw.firstName + " " + chw.lastName + JSON.stringify(error, undefined, 4));
                });
            };

            this.getPersonId = function (uuid) {
                return $http.get(CONSTANTS.URLS.PERSON + "/" + uuid + "?"
                    + CONSTANTS.PERSON_CUSTOM_REP ).then(function(resp) {
                    if (resp.status == 200) {
                        return resp.data;
                    } else {
                        return null;
                    }
                }, function (error) {
                    console.log(JSON.stringify(error, undefined, 4));
                });
            };

            this.createProvider = function (provider) {

                return $http.post(CONSTANTS.URLS.PROVIDER, provider).then(function(resp) {
                    if (resp.status == 201) {
                        // provider created
                        return resp.data;
                    } else {
                        return null;
                    }
                }, function (error) {
                    console.log("failed to create provider: " + provider.person.display + JSON.stringify(error, undefined, 4));
                });
            };

        }])
    .controller('ImportChwController', ['$q', '$scope', 'ImportChwService', 'ngDialog',
        function($q, $scope, ImportChwService, ngDialog) {

            $scope.content = null;
            $scope.providerPage = ImportChwService.CONSTANTS.URLS.PROVIDER_PAGE;
            $scope.errorMessage = null;
            $scope.chwContent = null;
            $scope.headerList = null;
            $scope.pendingImportChws = null;
            $scope.chwList = [];



            // This will parse a delimited string into an array of
            // arrays. The default delimiter is the comma, but this
            // can be overriden in the second argument.
            function CSVToArray (strData, strDelimiter) {

                            // Check to see if the delimiter is defined. If not,
                            // then default to comma.
                                            strDelimiter = (strDelimiter || ",");
                            // Create a regular expression to parse the CSV values.
                                            var objPattern = new RegExp(
                                                (
                            // Delimiters.
                                                    "(\\" + strDelimiter + "|\\r?\\n|\\r|^)" +
                            // Quoted fields.
                                                    "(?:\"([^\"]*(?:\"\"[^\"]*)*)\"|" +
                            // Standard fields.
                                                    "([^\"\\" + strDelimiter + "\\r\\n]*))"
                                                ),
                                                "gi"
                                            );
                            // Create an array to hold our data. Give the array
                            // a default empty first row.
                                            var arrData = [[]];
                            // Create an array to hold our individual pattern
                            // matching groups.
                                            var arrMatches = null;
                            // Keep looping over the regular expression matches
                            // until we can no longer find a match.
                                            while (arrMatches = objPattern.exec( strData )){
                            // Get the delimiter that was found.
                                                var strMatchedDelimiter = arrMatches[ 1 ];
                            // Check to see if the given delimiter has a length
                            // (is not the start of string) and if it matches
                            // field delimiter. If id does not, then we know
                            // that this delimiter is a row delimiter.
                                                if (
                                                    strMatchedDelimiter.length &&
                                                    (strMatchedDelimiter != strDelimiter)
                                                ){
                            // Since we have reached a new row of data,
                            // add an empty row to our data array.
                                                    arrData.push( [] );
                                                }
                            // Now that we have our delimiter out of the way,
                            // let's check to see which kind of value we
                            // captured (quoted or unquoted).
                                                if (arrMatches[ 2 ]){
                            // We found a quoted value. When we capture
                            // this value, unescape any double quotes.
                        var strMatchedValue = arrMatches[ 2 ].replace(
                            new RegExp( "\"\"", "g" ),
                            "\""
                        );
                    } else {
                        // We found a non-quoted value.
                        var strMatchedValue = arrMatches[ 3 ];
                    }
                        // Now that we have our value string, let's add
                        // it to the data array.
                        arrData[ arrData.length - 1 ].push( strMatchedValue );
                }
                    // Return the parsed data.
                    return( arrData );
            };

            function importChwRecord(chw) {

                var deferred = $q.defer();
                
                var newProvider ={};
                newProvider.person = null;
                newProvider.identifier = null;
                newProvider.providerRole =  ImportChwService.PROVIDER_ROLES_MAP.get(chw.role).uuid;

                ImportChwService.getProvider(chw).then( function (provider) {
                    if (provider.results.length == 0 ) {
                        //no provider found
                        // create person
                        ImportChwService.createPerson(chw).then( function (person) {
                            if (person) {
                                newProvider.person = person.uuid;
                            }
                            ImportChwService.getPersonId(person.uuid).then( function(personId) {
                                if(personId) {
                                    chw.personId = personId.personId;
                                }

                                ImportChwService.getIdentifierSource().then( function (identifierSource) {
                                    if (identifierSource){
                                        ImportChwService.getNextIdentifier(chw, identifierSource).then( function (identifier) {
                                            if (identifier ) {
                                                //create provider record
                                                newProvider.identifier = identifier;
                                                ImportChwService.createProviderWithRole(newProvider).then( function (respProvider) {
                                                    if (respProvider && respProvider.success === "true") {
                                                        console.log("newProvider has been created = " + respProvider);
                                                        chw.identifier = respProvider.identifier;
                                                        chw.uuid = respProvider.uuid;
                                                        ImportChwService.addHealthFacility(respProvider, chw).then(function (providerHC) {
                                                            console.log("Health Facility has been added to the provider");
                                                            ImportChwService.addPhoneNumber(chw).then(function (providerPhone){
                                                                if (chw.cadre) {
                                                                    ImportChwService.addCadre(chw).then( function(providerCadre){
                                                                        deferred.resolve(newProvider);
                                                                    }, function(errorCadre) {
                                                                        console.log("failed to add Cadre attribute to provider" + JSON.stringify(errorCadre, undefined, 4));
                                                                        deferred.reject(errorCadre);
                                                                    });
                                                                }
                                                            }, function (errorPhone) {
                                                                console.log("failed to add Phone Number attribute to provider" + JSON.stringify(errorPhone, undefined, 4));
                                                                deferred.reject(errorPhone);
                                                            });
                                                        }, function(errorHC) {
                                                            console.log("failed to add Health Facility attribute to provider" + JSON.stringify(errorHC, undefined, 4));
                                                            deferred.reject(errorHC);
                                                        });
                                                    } else {
                                                        console.log("new provider not created:" + JSON.stringify(respProvider, undefined, 4));
                                                        deferred.reject(respProvider);
                                                    }
                                                }, function (providerError) {
                                                    console.log("failed to create provider record");
                                                    deferred.reject(providerError);
                                                });
                                            } else {
                                                console.log("failed to generate identifier");
                                                deferred.reject("failed to generate identifier");
                                            }
                                        }, function(identifierError) {
                                            console.log("failed to generate Identifier");
                                            deferred.reject(identifierError);
                                        } );
                                    } else {
                                        deferred.reject("failed to find an identifier source for CHW");
                                    }

                                }, function(identifierSourceError){
                                    deferred.reject(identifierSourceError);
                                });

                            }, function(personIdError){
                                deferred.reject(personIdError);
                            })
                        }, function (personError) {
                            console.log("failed to create person");
                            deferred.reject(personError);
                        })
                    } else {
                        var omrsProvider = provider.results[0];
                        console.log("provider already present in the system: " + omrsProvider.identifier);
                        newProvider.identifier = omrsProvider.identifier;
                        chw.identifier = newProvider.identifier;
                        chw.personId = omrsProvider.person.personId;
                        deferred.resolve(newProvider);
                    }
                }, function (error) {
                    console.log("failed to find provider");
                    deferred.reject("search provider REST call failed");
                });

                return deferred.promise;
            };

            $scope.importChw = function(chw, showDialog){
                importChwRecord(chw);
            };

            $scope.importAllChw = function(chw, showDialog){

                if (angular.isDefined($scope.chwList) && $scope.chwList.length > 0) {
                    var importedChws = [];

                    $scope.chwList.reduce(function(p, val) {
                        return p.then(function() {
                            return importChwRecord(val).then(function(chwRecord) {
                                importedChws.push(chwRecord);
                            });
                        });
                    }, $q.when(true)).then(function(finalResult) {
                        $scope.content = null;
                    }, function(error) {
                        $scope.content = null;
                        $scope.errorMessage = JSON.stringify(error, undefined, 4);
                    });
                }

            };

            $scope.goToProviderPage = function(chw) {
                if (chw.personId) {
                    window.location.href = $scope.providerPage + chw.personId;
                }
            };

            $scope.showContent = function(fileContent){
                $scope.errorMessage = null;
                $scope.chwContent = fileContent;
                $scope.content = $scope.chwContent;
                var arrayOfData = CSVToArray($scope.chwContent);
                if (arrayOfData.length > 0 ){
                    $scope.headerList = arrayOfData[0];
                    $scope.pendingImportChws = arrayOfData.slice(1);
                }
                for (i = 0; i < $scope.pendingImportChws.length; i++) {
                    var chwValues = $scope.pendingImportChws[i];
                    if (chwValues.length >  7) {
                        var chwObj = {};
                        chwObj.id = chwValues[0];
                        chwObj.identifier = chwValues[1];
                        chwObj.firstName = chwValues[2];
                        chwObj.lastName = chwValues[3];
                        chwObj.healthCenter = chwValues[4];
                        chwObj.role = chwValues[5];
                        chwObj.phoneNumber = chwValues[6];
                        chwObj.cadre = chwValues[7];
                        chwObj.personId = 0;
                        $scope.chwList.push(chwObj);
                    }
                }
            };
            
        }])
    .directive('onReadFile', function ($parse) {
        return {
            restrict: 'A',
            scope: false,
            link: function(scope, element, attrs) {
                var fn = $parse(attrs.onReadFile);

                element.on('change', function(onChangeEvent) {
                    var reader = new FileReader();

                    reader.onload = function(onLoadEvent) {
                        scope.$apply(function() {
                            fn(scope, {fileContent:onLoadEvent.target.result});
                        });
                    };
                    reader.readAsText((onChangeEvent.srcElement || onChangeEvent.target).files[0]);
                });
            }
        }
    });