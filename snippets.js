// get object keys
Object.keys(this.props);
Object.keys(this.props).map(key => [key, this.props[key]])

// timezone data redirect
var d = new Date();
var dst = d.getTimezoneOffset() < Math.max(new Date(d.getFullYear(),0,1).getTimezoneOffset(),new Date(d.getFullYear(),6,1).getTimezoneOffset());
window.location.replace(window.location+'&timezone='+d.getTimezoneOffset()+(dst?"&dst":""));

// convert query string to object
function toObject(arr) {
  var obj = {};
  arr.forEach(function(e) {
    obj[e[0]] = e[1];
  });
  return obj;
}
var args = toObject(window.location.search.substr(1).split("&").map(function(arg){ return arg.split("="); }));

// pad(2) = "02"
function pad(n) {
  return ("0"+n).slice(-2);
}

// delete all amazon watch history on https://www.amazon.com/gp/video/settings/watch-history/
// open the page and then run this in the developer tools to click all of the buttons:
document.querySelectorAll('button').forEach(b => b.click())
