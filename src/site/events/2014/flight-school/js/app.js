(function() {
  "use strict";
  var APP;

  APP = angular.module('dart', ['ocupop', 'ui.directives']);

  APP.value('header_height', function() {
    return 0;
  });

  APP.controller('NavCtrl', function($scope) {
    $scope.nav = {
      show_mobile: false
    };
    return $scope.$on('current_section', function() {
      return $scope.nav.show_mobile = false;
    });
  });

  APP.factory('EventMap', function($http) {
    var end_date, start_date, to_unix_date, url;
    to_unix_date = function(date) {
      return Math.floor(date.valueOf() / 1000);
    };
    start_date = to_unix_date(new Date('2014-2-1'));
    end_date = to_unix_date(new Date('2014-12-31'));
    url = "https://google-developers.appspot.com/events/event-markers.public?tag=dartflightschool&start=" + start_date + "&end=" + end_date;
    if (Modernizr.cors) {
      return $http.get(url);
    } else {
      url += "&callback=JSON_CALLBACK";
      return $http.jsonp(url);
    }
  });

  APP.controller('MapCtrl', function($scope, EventMap) {
    var marker_url, _current_infobox;
    marker_url = Modernizr.svg ? "img/marker.svg" : "img/marker.png";
    _current_infobox = null;
    $scope.event_map = {
      show: 'map',
      map_options: {
        center: new google.maps.LatLng(10, 0),
        zoom: 2,
        minZoom: 2,
        scrollWheel: false
      },
      map: {},
      events: [],
      resize: function() {
        return google.maps.event.trigger(this.map, 'resize');
      },
      mark: function(event, index) {
        var info, info_content, marker,
          _this = this;
        marker = new google.maps.Marker({
          position: event.latlng,
          map: this.map,
          icon: marker_url
        });
        info_content = "<div class=\"event-infobox\">\n  <h3 class=\"event-title\">\n    <a href=\"https://developers.google.com" + event.defaultEventUrl + "\" target=\"_blank\">" + event.name + "</a>\n  </h3>\n  <p class=\"event-location\">" + event.location + "</p>\n</div>";
        info = new InfoBox({
          content: info_content
        });
        return google.maps.event.addListener(marker, 'click', function() {
          _this.selected = index;
          $scope.$apply();
          if (_current_infobox != null) {
            _current_infobox.close();
          }
          _current_infobox = info;
          return info.open(_this.map, marker);
        });
      },
      load: function() {
        var _this = this;
        EventMap.success(function(data) {
          var e, index, _i, _len, _ref, _results;
          _this.events = data;
          _ref = _this.events;
          _results = [];
          for (index = _i = 0, _len = _ref.length; _i < _len; index = ++_i) {
            e = _ref[index];
            _results.push(_this.mark(e, index));
          }
          return _results;
        });
        return this.resize();
      },
      clear_selected: function() {
        return this.selected = null;
      },
      selected: null
    };
    return $scope.event_map.load();
  });

  APP.filter('coerceDate', function() {
    return function(source) {
      return new Date(source * 1000);
    };
  });

  APP.controller('RegisterCtrl', function($scope, $http) {
    return $scope.register = {
      name: "",
      email: "",
      city: "",
      state: "",
      country: "",
      involvement: {},
      event: {},
      other_value: "",
      submitted: false,
      submit: function() {
        var $shadow, events, form_url, involvement_val, other_val, _ref;
        form_url = "https://docs.google.com/forms/d/1bbzXqcK6UCDTvqtIxjqhoCK8rVlgmz04vbYcTk_dTDE/formResponse";
        involvement_val = this.involvement.organize && this.involvement.speak ? "Both!" : this.involvement.organize ? "I want to organize an event." : this.involvement.speak ? "I want to speak at an event." : "";
        events = [];
        other_val = (_ref = this.event.other_value) != null ? _ref : "";
        if (this.event.tech_talk) {
          events.push('Tech Talk');
        }
        if (this.event.code_lab) {
          events.push('Code Lab');
        }
        if (this.event.hackathon) {
          events.push('Hackathon');
        }
        if (this.event.other) {
          events.push(other_val);
        }
        $shadow = $("<form action='" + form_url + "' method='POST'></form>");
        $shadow.append($('<input name="entry.317145556">').val(this.name));
        $shadow.append($('<input name="entry.1542980384">').val(this.email));
        $shadow.append($('<input name="entry.1134813112">').val("" + this.city + ", " + this.state + ", " + this.country));
        $shadow.append($('<input name="entry.310283512">').val(this.user_group));
        $shadow.append($('<input name="entry.696967509">').val(involvement_val));
        $shadow.append($('<input name="entry.172590286">').val(events.join(', ')));
        return $shadow.submit();
      }
    };
  });

  APP.run(function($rootScope, $timeout) {
    var $earth, $header, $milky_way, $sky, $stars, $window, draw_background, height, pos, transform;
    pos = 1;
    $rootScope.scroll_pos = pos;
    $window = $(window);
    $sky = $('.sky-layer');
    $earth = $('.earth-layer');
    $milky_way = $('.milky-way-layer');
    $stars = $('.stars-layer');
    $header = $('.page-header');
    transform = Modernizr.prefixed('transform');
    height = $window.height();
    $window.on("scroll", function() {
      $rootScope.scroll_pos = pos;
      return $rootScope.$apply();
    });
    draw_background = function() {
      var scale;
      pos = $window.scrollTop();
      $sky.css({
        opacity: ((height * 2) - pos) / (height * 2) - 0.2
      });
      scale = Math.max(0, ((height * 0.5) - pos) / (height * 0.5));
      $earth.css(transform, "translate3d(0, " + ((pos * 1.1) + height / 2) + "px, 0)      scale3d(" + scale + "," + scale + ",1 )");
      $milky_way.css(transform, "translate3d(0, " + (pos * 1.05) + "px, 0)");
      $stars.css(transform, "translate3d(0, " + (pos * 1.02) + "px, 0)");
      $header.css(transform, "translate3d(0, " + (pos * -0.5) + "px, 0)");
      return requestAnimationFrame(draw_background);
    };
    if (Modernizr.csstransforms3d && !Modernizr.touch) {
      return requestAnimationFrame(draw_background);
    } else {
      return $window.on("scroll", function() {
        return pos = $window.scrollTop();
      });
    }
  });

}).call(this);
