(function() {
  "use strict";
  var APP;

  APP = angular.module('dart', ['ui.directives']);

  APP.value('header_height', function() {
    return 400;
  });

  APP.controller('NavCtrl', function($scope) {
    return $scope.nav = {
      hide_nav: false
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

  APP.directive('ocuSvg', function() {
    var ext;
    ext = Modernizr.svg ? "svg" : "png";
    return function(scope, $el, attrs) {
      var file;
      file = attrs.ocuSvg;
      return $el.attr('src', file + '.' + ext);
    };
  });

  APP.directive('ocuLabel', function() {
    var p;
    p = Modernizr.input.placeholder;
    return function(scope, $el, attrs) {
      var label;
      label = attrs.ocuLabel;
      $el.attr('placeholder', label);
      if (!p) {
        return $el.before($("<label>" + label + "</label>"));
      }
    };
  });

  APP.directive('ocuToggle', function() {
    return function(scope, $el, attrs) {
      var method_name, speed, _ref;
      $el.hide();
      method_name = attrs.method ? "" + attrs.method + "Toggle" : "toggle";
      speed = (_ref = attrs.speed) != null ? _ref : 1000;
      return scope.$watch(attrs.ocuToggle, function(val) {
        if (val) {
          return $el[method_name](speed);
        }
      });
    };
  });

  APP.directive('ocuAnimate', function($rootScope, $timeout) {
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
    return function(scope, $el, attrs) {
      if (Modernizr.csstransforms3d && !Modernizr.touch) {
        return requestAnimationFrame(draw_background);
      } else {
        return $window.on("scroll", function() {
          return pos = $window.scrollTop();
        });
      }
    };
  });

  APP.directive('ocuCheckbox', function($compile) {
    return {
      template: "<input type='checkbox'>\n<div class=\"input-checkbox\"></div>\n<label ng-transclude></label>",
      transclude: true,
      link: function(scope, $el, attrs) {
        $el.children('input').replaceWith($compile("<input id='" + attrs.ocuCheckbox + "' ng-model='" + attrs.ocuCheckbox + "' type='checkbox'>")(scope));
        $el.children('.input-checkbox').replaceWith($compile("<div class='input-checkbox' ng-class='{checked: " + attrs.ocuCheckbox + "}'\n  ng-click='" + attrs.ocuCheckbox + " = !" + attrs.ocuCheckbox + "'></div>")(scope));
        return $el.find('label').attr('for', attrs.ocuCheckbox);
      }
    };
  });

  APP.directive('ocuScrollCollision', function($rootScope) {
    return function(scope, $el, attrs) {
      var $col, col_bottom, col_top, cross, event_name, _ref;
      event_name = attrs.ocuScrollCollision;
      cross = (_ref = attrs.collisionPoint) != null ? _ref : 0;
      if (attrs.collisionElement) {
        $col = $(attrs.collisionElement);
        col_top = $col.offset().top;
        col_bottom = $col.height() + col_top;
      }
      return $rootScope.$watch('scroll_pos', function(pos, last_pos) {
        var bottom, is_in, top, was_in, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6;
        top = $el.offset().top;
        bottom = $el.height() + top;
        if ($col) {
          is_in = ((col_top < (_ref1 = top - pos) && _ref1 <= col_bottom)) || ((top < (_ref2 = pos + col_top) && _ref2 <= bottom));
          was_in = ((col_top < (_ref3 = top - last_pos) && _ref3 <= col_bottom)) || ((top < (_ref4 = last_pos + col_top) && _ref4 <= bottom));
        } else {
          is_in = (top < (_ref5 = pos + cross) && _ref5 <= bottom);
          was_in = (top < (_ref6 = last_pos + cross) && _ref6 <= bottom);
        }
        if (is_in && !was_in) {
          $rootScope.$broadcast(event_name, true);
          $el.removeClass('before after');
        }
        if (!is_in && was_in) {
          $rootScope.$broadcast(event_name, false);
          if ((top - pos) < col_top) {
            return $el.addClass('before');
          } else {
            return $el.addClass('after');
          }
        }
      });
    };
  });

  APP.directive('ocuScrollClick', function($rootScope) {
    var scroll_to;
    scroll_to = function(target) {
      return $('body,html').stop(true, true).animate({
        scrollTop: $(target).offset().top
      }, 'slow');
    };
    return function(scope, $el, attrs) {
      var target;
      target = attrs.href;
      $rootScope.$watch('current_section', function(section_id) {
        return $el.toggleClass('current-nav-item', target === ("#" + section_id));
      });
      return $el.on("click", function(e) {
        e.preventDefault();
        return $('body,html').stop(true, true).animate({
          scrollTop: $(target).offset().top
        }, 'slow', function() {
          return $rootScope.current_section = target.slice(1);
        });
      });
    };
  });

  APP.directive('ocuScrollSection', function($rootScope) {
    return function(scope, $el, attrs) {
      var section_id;
      section_id = attrs.id;
      return $rootScope.$watch('scroll_pos', function(pos) {
        var bottom, top;
        top = $el.offset().top;
        bottom = top + $el.height();
        if ((top < pos && pos <= bottom)) {
          return $rootScope.current_section = section_id;
        }
      });
    };
  });

}).call(this);
