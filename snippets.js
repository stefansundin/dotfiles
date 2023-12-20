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

// addCommas(2056776401.50) = "2,056,776,401.50"
function addCommas(n) {
  return n.toString().replace(/(\d)(?=(\d{3})+($|,|\.))/g, '$1,');
}

function base64UrlSafeDecode(s) {
  return atob(s.replace(/_/g, '/').replace(/-/g, '+'));
}

// monitor messages received in iframe
// first focus the iframe in the Elements panel, then run this in Console
$0.addEventListener('message', () => console.log('message', arguments));

// Run eslint with a single rule:
// eslint --no-eslintrc --ignore-pattern '**/*.min.js' --env es2020 --rule "{semi: error}" src

// delete all amazon watch history on https://www.amazon.com/gp/video/settings/watch-history/
// open the page and then run this in the developer tools to click all of the buttons:
document.querySelectorAll('button').forEach(b => b.click())
