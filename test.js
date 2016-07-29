var phantom = require('phantom-render-stream');
var render = phantom();

render('http://www.google.com --ignore-ssl-errors=true')
  .on('log', function(log) {
    console.log(log)
    // {type: 'error', data: {msg: 'ReferenceError: Can\'t find variable: a', trace: [..]}} 
  })
  .on('data', function(data) {
    console.log(data)
  })
  // .pipe(res);