// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require unpoly
//= require unpoly-bootstrap3
//= require clockpicker/dist/bootstrap-clockpicker
//= require Chart.min
//= require_self
//= require_tree .


// Define $.unobtrusive() to register new element activation callbacks
$.unobtrusive = function(callback) {
    $(document).on('activate-unobtrusive-javascript', function(event, root) {
        $(root).each(callback);
    });
}

// Define a function for all jQuery collections to manually run activation callbacks on that element
$.fn.activateUnobtrusiveJavascript = function() {
    this.each(function() {
        $(document).trigger('activate-unobtrusive-javascript', this);
    });
}

// Activate the entire DOM on initial page load
$(function() {
    $(document).activateUnobtrusiveJavascript();
});