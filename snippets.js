// timezone data redirect
var d = new Date();
var dst = d.getTimezoneOffset() < Math.max(new Date(d.getFullYear(),0,1).getTimezoneOffset(),new Date(d.getFullYear(),6,1).getTimezoneOffset());
window.location.replace(window.location+'&timezone='+d.getTimezoneOffset()+(dst?"&dst":""));
