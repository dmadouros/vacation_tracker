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
//= require jquery-ui.min
//= require foundation
//= require turbolinks
//= require_tree .

$(function(){
  $(document).foundation();
  $('.datepicker').datepicker({
    dateFormat: 'dd-M-yy',
    changeYear: true,
    changeMonth: true,
    yearRange: '2013:+5',
    showMonthAfterYear: true,
    beforeShowDay: $.datepicker.noWeekends,
    constrainInput: true,
    maxDate: '+5y',
    minDate: '01-Jan-2013',
    showOn: 'focus'
  });
});
