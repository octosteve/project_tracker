console.log('here!')

var system = require('system');
var page = require('webpage').create();

console.log(page);
console.log(system.args)



page.onError = function(msg, trace) {

  var msgStack = ['ERROR: ' + msg];

  if (trace && trace.length) {
    msgStack.push('TRACE:');
    trace.forEach(function(t) {
      msgStack.push(' -> ' + t.file + ': ' + t.line + (t.function ? ' (in function "' + t.function +'")' : ''));
    });
  }

  console.error(msgStack.join('\n'));

};

page.open(system.args[1], function(status) {
  console.log('Status: ' + status);
  console.log(system.args[2]);
  page.render(system.args[2] + ".png");
  phantom.exit();
});

page.open();
