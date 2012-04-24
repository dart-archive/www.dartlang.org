function main() {
  var links = document.querySelectorAll('#toc a');
  for (var i = 0; i < links.length; i++) {
    var link = links[i];

    link.addEventListener('click', function(e) {
      var target = e.target;
      var section = target.href.substring(1);
      _gaq.push(['_trackPageview', '/language-tour/' + section]);
    });
  }
}

if (document.readyState != 'loading') {
  main();
} else {
  document.addEventListener('DOMContentLoaded', main);
}
