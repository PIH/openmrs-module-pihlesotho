<!--
/*
author: Andrew Chi
date: 2011-APR-10

Extra Functionality:
User without en_GB locale, gets a prompt and is redirected
Patient without an Art # and isArt=true, gets a prompt and is redirected
Patient without a baseline form and isBaseline=false, gets a prompt and is redirected
Patient without Paper File #, gets a prompt and is redirected
Patient without health center, gets a prompt and is redirected
Encounter should be defaulted to patient's health center as defined by the patient attribute for HC
Providers are in sorted order
CD4 result date >= equal to the last CD4 date and must be < the encounter date

CD4 collection date must be greater than the encounter date and < 7 months past the encounter date (pre-art)
Return visit date must be greater than the encounter date and < 7 months past the encounter date (pre-art)

Refill 1 date must be greater than the encounter date and < 2 months past the encounter date (art)
Refill 2 date must be greater than the encounter date and < 3 months past the encounter date (art)
Return visit date must be greater than the encounter date and < 4 months past the encounter date (art)

When editing the form:
  All functionality above should not execute
  There should be a link to void the encounter if needed

Test Cases:
Patient with three previous CD4s, should see latest CD4
Patient with no previous CD4, should see nothing in both "Known CD4" fields
*/

function repeat(chr,count){
    var str = "";
    for(var x=0; x < count; x++) {str += chr;}
    return str;
}

String.prototype.padL = function(width,pad){
    if (!width ||width < 1)
        return this;

    if (!pad) pad=" ";
    var length = width - this.length
    if (length < 1) return this.substr(0,width);

    return (repeat(pad,length) + this).substr(0,width);
}

Date.prototype.formatDate = function(){
  var month = this.getMonth() + 1;
  var mm = month.toString().padL(2,"0");
  var yyyy = this.getFullYear().toString();
  var dd = this.getDate().toString().padL(2,"0");
  return dd + "/" + mm + "/" + yyyy;
}

function getElement(elementName){
  if(elementName){
    return document.getElementById(elementName+"-display");
  }
  return null;
}

function getElement2(elementName){
  if(elementName){
    return document.getElementById(elementName);
  }
  return null;
}

function enGbStrToDate(strDate){
  var dates = strDate.split('/', 3);
  if(dates.length != 3){
    return null;
  }

  var da = dates[0];
  var mo = dates[1] - 1;
  var ye = dates[2];
  var d = new Date(ye, mo, da, 0, 0, 0, 0);
  return d;
}

function dateCompare(date, minDate, maxDate){
  if(date <= minDate){
    return -1;
  }else if(date > maxDate){
    return 1;
  }
  return 0;
}

function checkDate(newDateInputObj, minDateInputObj, maxBaseDateInputObj, addMonths, errorDivId){
  if(!newDateInputObj || !minDateInputObj || !maxBaseDateInputObj){
    return;
  }

  //if user clears the values, turn off the warnings
  if(newDateInputObj.value == ""){
    newDateInputObj.className = 'legalValue';
    clearError(errorDivId);
  }else{
    var date = enGbStrToDate(newDateInputObj.value);
    if(!date){
      clearError(errorDivId);
      newDateInputObj.className = 'illegalValue';
      showError(errorDivId, "Please select a valid date");
      newDateInputObj.value = 'Invalid';
      return;
    }

    var minDate = enGbStrToDate(minDateInputObj.value);
    //default the minDate so that the validation passes
    if(!minDate){
      minDate = new Date(date);
      minDate.setDate(minDate.getDate()-1);
    }
    var maxDate = enGbStrToDate(maxBaseDateInputObj.value);
    if(!maxDate){
      maxDate = new Date(date);
      maxDate.setDate(maxDate.getDate()+1);
    }else{
      maxDate.setMonth(maxDate.getMonth() + addMonths);
    }

    var res = dateCompare(date, minDate, maxDate);
    if(res != 0){
      var errorMsg;
      if(res < 0){
        errorMsg = date.formatDate() + " is invalid, date must be > " + minDate.formatDate();
      }else if(res > 0){
        errorMsg = date.formatDate() + " is invalid, date must be <= " + maxDate.formatDate();
      }
      clearError(errorDivId);
      newDateInputObj.className = 'illegalValue';
      showError(errorDivId, errorMsg);
      //set the value of the date to an invalid value so the form doesn't submit
      newDateInputObj.value = 'Invalid';
    }else{
      newDateInputObj.className = 'legalValue';
      clearError(errorDivId);
    }
  }
}

function iCaseCmp (opt1, opt2) {
  // not case sensitive
  return opt1.text.toLowerCase() < opt2.text.toLowerCase() ? -1 :
    opt1.text.toLowerCase() > opt2.text.toLowerCase() ? 1 : 0;
}

function sortListBox (pListBox, start) {
  var options = new Array(pListBox.options.length);
  for(var i = 0; i < start; i++){
    options[i] = new Option ("", "");
  }

  for(var i = start; i < options.length; i++){
    options[i] =
      new Option (pListBox.options[i].text,
                  pListBox.options[i].value);
  }
  options.sort(iCaseCmp);

  for (var i = start; i < options.length; i++){
    pListBox.options[i] = options[i];
  }
}

function mainFunction () {
//don't execute if we are editing the htmlform template
if(!document.getElementById("xmlData")){

  //don't bother to proceed if we are editing or viewing the form
  if(getHttpGetParam('mode') != "EDIT" &&
     getHttpGetParam('inPopup') != "true"){

    //check whether we should have a baseline form or not
    //because we can't check encounters, check for any weight obs (since this isn't on the patient dashboard), if it exists, then we've done a baseline
    if(isBaseline){
      if(firstWeightObs || firstWeightObs != ""){
        alert('A baseline form already exists, or an observation for Weight has been entered, please complete a followup form, or edit the existing baseline form!');
        history.go(-1);
        return;
      }
    }else{
      if(!firstWeightObs || firstWeightObs == ""){
        alert('A baseline form does not exist, or an observation for Weight has not been entered, please complete a baseline form!');
        history.go(-1);
        return;
      }
    }

    //make sure the locale is correct
    if(locale != "en_GB"){
      alert('Please set your locale to English (United Kingdom) so that your date format is dd/mm/yyyy');
      history.go(-1);
      return;
    }

    //check the paper file number to make sure that it has been set
    if(!paperFile || paperFile==""){
      alert("Please set the paper file number, you'll be redirected now");
      window.location.replace('/openmrs/admin/patients/patient.form?patientId=' + patientId);
      return;
    }

    //check the health center patient attr to make sure that it has been set
    if(!healthCenter || healthCenter=="" || healthCenter=="Unknown Location"){
      alert("Please set the health center, you'll be redirected now");
      window.location.replace('/openmrs/admin/patients/patient.form?patientId=' + patientId);
      return;
    }

    //check art status based on art number to make sure that it has been set
    if(isArt){
      if(!artNum || artNum==""){
        alert("This is a ART Followup form, but the ART number hasn't been set, you'll be redirected now");
        window.location.replace('/openmrs/admin/patients/patient.form?patientId=' + patientId);
        return;
      }else{
        //we don't check the reverse because PMTCT patients will have an ART number but be pre-ART
      }
    }

    // default the enc location to the patient's health center
    var encLoc=getElement2(encounterLocationName);
    if(encLoc && encLoc.options && encLoc.options.length>0){
      for(var i = 0; i < encLoc.options.length; i++){
        if(encLoc.options[i].text == healthCenter){
          encLoc.selectedIndex = i;
          break;
        }
      }
    }

    // sort the provider listbox alphabetically
    var encProv=getElement2(encounterProviderName);
    if(encProv && encProv.options && encProv.options.length>0){
      //we skip the first select item (the "choose...")
      sortListBox(encProv, 1);
    }

    var encDateObj = getElement(encounterDateName);

    // alert the user if the cd4 date is the same or earlier as what exists
    if(newCd4DateName){
      var newCd4Date=getElement(newCd4DateName);
      if(newCd4Date){
        var oldCd4Date=document.getElementById("oldCd4Date");
        newCd4Date.onchange=function(){checkDate(newCd4Date, oldCd4Date, encDateObj, 0, "cd4ErrDivId");};
      }
    }

    //allow 7 months post encounter for the cd4 collection
    if(cd4RetName){
      var newCd4RetDate=getElement(cd4RetName);
      if(newCd4RetDate){
        newCd4RetDate.onchange=function(){checkDate(newCd4RetDate, encDateObj, encDateObj, 7, cd4RetErrDivIdName);};
      }
    }

    //allow x months post encounter for the return date
    //  x=7 for pre-art
    //  x=4 for art
    if(retVisitName){
      var newRetVisitDate=getElement(retVisitName);
      if(newRetVisitDate){
        var monthLimit = 7;
        if(isArt){
          monthLimit = 4;
        }
        newRetVisitDate.onchange=function(){checkDate(newRetVisitDate, encDateObj, encDateObj, monthLimit, retVisitErrDivIdName);};
      }
    }

    //allow 2 months post encounter for the first refill
    if(retRefill1Name){
      var newRetRefill1Date=getElement(retRefill1Name);
      if(newRetRefill1Date){
        newRetRefill1Date.onchange=function(){checkDate(newRetRefill1Date, encDateObj, encDateObj, 2, retRefill1ErrDivIdName);};
      }
    }

    //allow 3 months post encounter for the first refill
    if(retRefill2Name){
      var newRetRefill2Date=getElement(retRefill2Name);
      if(newRetRefill2Date){
        newRetRefill2Date.onchange=function(){checkDate(newRetRefill2Date, encDateObj, encDateObj, 3, retRefill2ErrDivIdName);};
      }
    }

    //since we depend on the encounter date for some of these, check appropriately after change
    encDateObj.onchange = function(){
       if(newCd4RetDate) newCd4RetDate.onchange();
       if(newRetVisitDate) newRetVisitDate.onchange();
       if(newRetRefill1Date) newRetRefill1Date.onchange();
       if(newRetRefill2Date) newRetRefill2Date.onchange();
    };

  }else if(getHttpGetParam('mode') == "EDIT"){
    // generate a url to void encounter
    document.write('<a href="/openmrs/admin/encounters/encounter.form?encounterId=' + getHttpGetParam('encounterId') + '">Void Encounter</a>');
  }
}
}

mainFunction();

//-->