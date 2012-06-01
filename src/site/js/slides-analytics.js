function main() {
  var links = document.querySelectorAll('a.pdf');

  for (var i = 0; i < links.length; i++) {
    var link = links[i];

    link.addEventListener('click', function(e) {
      e.preventDefault();
      var target = e.target;
      var href = target.href;
      _gaq.push(['_trackPageview', href]);
      setTimeout('document.location = "' + href + '"', 100);
    });
  }
}

if (document.readyState != 'loading') {
  main();
} else {
  document.addEventListener('DOMContentLoaded', main);
}