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
    $edit_fontset_toggle: $('.edit_fontset_toggle'),
    $edit_project_toggle: $('.edit_project_toggle'),
    $closeModal: $('.close-modal')
  };

  var contentEditableOn = function () {
    $('.m-row').contents().find("[contenteditable]").each(function() {
      opts.$ce.toggleClass('active');
      opts.$body.toggleClass('ce_active');
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

  var submitForms = function() {
    $.each($('form'), function(i, form) {
      serializeAndSubmit(form);
    });
  }

  var serializeAndSubmit = function(form) {

    var valuesToSubmit = $(form).serialize();
    var csrf = $('meta[name="csrf-token"]').attr('content');

    $.ajax({
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', csrf)
      },
      type: "POST",
      data:  valuesToSubmit,
      url: $(form).attr('action'),
    }).success(function(json){
      console.log("success", json);
    }).error(function(err){
      console.log("error", err);
    })

    return false;
  }

  var editFontset = function() {
    $('.fontset-forms').toggle();
    $('.project-form').hide();
  };

  var editProject = function() {
    $('.project-form').toggle();
    $('.fontset-forms').hide();
  };

  var closeModal = function() {
    $('.project-form').hide();
    $('.fontset-forms').hide();
  };

  var attachGenericFormEvents = function() {
    // global event, emit this anywhere, all forms present will save.
    $(document).on("formChange", function(form){
      submitForms();
    });

    // incase we want the "save" button functionality
    $("input[type=submit]").on('click', function(e){
      e.preventDefault();
      $(document).trigger("formChange");
    });
  }

  var init = function (options) {
    $.extend(opts, options);
    var current = BNG.FontSets.current;
    opts.$next.on('click', goToNextFontSet);
    opts.$prev.on('click', goToPrevFontSet);
    opts.$ce.on('click', contentEditableOn);
    opts.$current.text(BNG.FontSets.current + 1);
    opts.$total.text(BNG.FontSets.total);
    opts.$edit.attr({ 'href' : BNG.FontSets.font_sets[current].edit_url });
    opts.$edit_fontset_toggle.on('click', editFontset);
    opts.$edit_project_toggle.on('click', editProject);
    opts.$closeModal.on('click', closeModal);

    attachGenericFormEvents();
  };

  return {
    init : init
  };

})(jQuery);

BNG.App.init();