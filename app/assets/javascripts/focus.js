// Give focus to the first input field or textarea on a page
Event.observe(window, 'load', function() {
  var e = $A(document.getElementsByTagName('*')).find(function(e) {
    return (e.tagName.toUpperCase() == 'INPUT' && (e.type == 'text' || e.type == 'password'))
        || e.tagName.toUpperCase() == 'TEXTAREA' || e.tagName.toUpperCase() == 'SELECT';
  });
  if (e) e.focus();
});
