$(document).ready(function() {
  function init(name) {
    var nav = $('#performance-charts-nav-' + name);
    var charts = $('#performance-charts-' + name);

    $.getJSON('//public-golem.storage.googleapis.com/' + name + '_benchmarks.json',
      function(data) {
        $.each(data, function(index) {
          var benchmark = data[index];
          var linkName = benchmark['name'].replace(/ /g, '');
          $(nav).append('<li class="' +
            (index == 0 ? 'active' : '') +
            '"><a href="#' + linkName +
            '" data-toggle="tab">' + benchmark['name'] + '</a></li>');
          $(charts).append('<div class="tab-pane ' +
            (index == 0 ? 'active' : '') +
            '" id="' + linkName + '">' +
            '<iframe style="border: 0" src="//public-golem.storage.googleapis.com/' +
            benchmark['graph'] + '" ' +
            'width="900" height="440"></iframe></div>');
        });
      });
  }
  init("base");
  init("io");
});
