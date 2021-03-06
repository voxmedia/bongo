// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require codemirror
//= require css

$('[data-toggle=tooltip]').tooltip();

$("#project_primary_color_hex").on('keydown', function(){
  $("#project_primary_color").val($(this).val());
});

$("#project_secondary_color_hex").on('keydown', function(){
  $("#project_secondary_color").val($(this).val());
});

if ($('#font_set_sass')) {
  var sassCodeMirror = CodeMirror.fromTextArea($('#font_set_sass')[0], {
    tabSize: 2,
    lineNumbers: true,
    mode: 'text/x-scss',
    theme: 'solarized dark'
  });
}
