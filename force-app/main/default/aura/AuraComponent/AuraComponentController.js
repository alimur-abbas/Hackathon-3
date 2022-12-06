({
    handleSubmit : function(component, event, helper) {
        event.preventDefault();  
        var fields = event.getParam('fields');
       
       // component.set("v.isdisable", true);
            component.find('form').submit(fields);
       
       
},
handleChange : function(component, event, helper) {
    //console.log('handleChange');
  // var value= event.target.value;
  var com =event.getSource().get("v.value");
   console.log(com);
   if(com=='Delivered'){
    console.log('Delivered');
       component.set("v.isdisable",true);
   }
},
handleSuccess : function(component, event, helper) {
    var value = component.find('customer').get("v.value");
    var navEvt = $A.get("e.force:navigateToSObject");
    navEvt.setParams({
      "recordId": value,
      "slideDevName": "related"
    });
    navEvt.fire();
}

             // stop the form from submitting

    }
)
