var BNG = BNG || {};

BNG.App = (function($) {
  
  var opts = {
    $next : $('.js-next'),
    $prev : $('.js-prev'),
    $current : $('.js-current'),
    $total : $('.js-total'),
    $edit : $('.js-edit'),
    $body : $('body')
  };

  var goToNextFontSet = function () {
    goToIndex(BNG.FontSets.current + 1);
    return false;
  };

  var goToPrevFontSet = function () {
    goToIndex(BNG.FontSets.current - 1);
    return false;
  };

  var goToIndex = function (i) {
    var font_set;
    if (i === BNG.FontSets.total) {
      i = 0;
    } else if (i < 0) {
      i = BNG.FontSets.total - 1;
    }
    BNG.FontSets.current = i;
    font_set = BNG.FontSets.font_sets[i];
    opts.$current.text(i + 1);
    opts.$edit.attr({ 'href' : font_set.edit_url });
    opts.$body.attr({ 'class' : font_set.slug });
    if (typeof window.history !== 'undefined') {
      window.history.replaceState(null, null, font_set.url);
    }
  }
  
  var init = function (options) {
    $.extend(opts, options);
    var current = BNG.FontSets.current;
    opts.$next.on('click', goToNextFontSet);
    opts.$prev.on('click', goToPrevFontSet);
    opts.$current.text(BNG.FontSets.current + 1);
    opts.$total.text(BNG.FontSets.total);
    opts.$edit.attr({ 'href' : BNG.FontSets.font_sets[current].edit_url });
  };

  return {
    init : init
  };

})(jQuery);

BNG.App.init();