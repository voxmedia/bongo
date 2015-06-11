var BNG = BNG || {};

BNG.App = (function($) {
  
  var opts = {
    $next : $('.js-next'),
    $prev : $('.js-prev'),
    $current : $('.js-current'),
    $total : $('.js-total'),
    $edit : $('.js-edit'),
    $ce : $('.js-ce'),
    $body : $('body'),
    $info : $('.js-info'),
    info_modal : '.js-font-info'
  };

  var contentEditableOn = function () {
    $('.m-row').contents().find("[contenteditable]").each(function() {
      opts.$ce.toggleClass('active');
      var value = $(this).attr('contenteditable');

      if (value == 'false') {
        $(this).attr('contenteditable','true');
        opts.$ce.attr('title', 'Disable Editable Content')
      }
      else {
        $(this).attr('contenteditable','false');
        opts.$ce.attr('title', 'Enable Editable Content')
      }
    });
    event.preventDefault();
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
    opts.$body.removeAttr('class').addClass('project-' + BNG.FontSets.slug).addClass('fontset-' + font_set.slug);
    $(opts.info_modal).remove();
    if (typeof window.history !== 'undefined') {
      window.history.replaceState(null, null, font_set.url);
    }
  }

  var loadFontInfo = function () {
    var current, font_set, url;
    if ($(opts.info_modal).length > 0) {
      $(opts.info_modal).remove();
    } else {
      current = BNG.FontSets.current;
      font_set = BNG.FontSets.font_sets[current];
      url = font_set.info_url;
      $.get(url, function (data) {
        opts.$body.append(data);
      });
    }
    return false;
  };
  
  var init = function (options) {
    $.extend(opts, options);
    var current = BNG.FontSets.current;
    opts.$next.on('click', goToNextFontSet);
    opts.$prev.on('click', goToPrevFontSet);
    opts.$ce.on('click', contentEditableOn);
    opts.$current.text(BNG.FontSets.current + 1);
    opts.$total.text(BNG.FontSets.total);
    opts.$edit.attr({ 'href' : BNG.FontSets.font_sets[current].edit_url });
    opts.$info.on('click', loadFontInfo);
  };

  return {
    init : init
  };

})(jQuery);

BNG.App.init();