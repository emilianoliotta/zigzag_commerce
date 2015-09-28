// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-1.11.3.min
//= require turbolinks
//= require_tree .
//= require_bootstrap

function isNumberKey(evt)
       {
          var charCode = (evt.which) ? evt.which : evt.keyCode;
          if (charCode == 8 || charCode == 15 || charCode == 14)
          	return true;
          if (charCode < 48 || charCode > 57)
             return false;
          return true;
       }

var set_anchor_scroll = function() {

  $('a[href^="#"]').on('click', function(event) {
    var target;
    if(this.href.indexOf('/') > -1){
      target = $(this.hash);
    } else{
      target = $(this.href);
    }
    if( target.length ) {
        event.preventDefault();
        $('html, body').animate({
            scrollTop: target.offset().top - 105 //Corresponde a 70px del nav fixed más 30px para un poco de margen
        }, 1000);
        target.focus();
    }
  });

};

$(document).ready(set_anchor_scroll);
$(document).on('page:load', set_anchor_scroll);
