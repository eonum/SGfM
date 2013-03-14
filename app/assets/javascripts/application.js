// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-1.9.1
//= require bootstrap

//SGfM Namespace
var SGfM = {}

//Sends an AJAX Request to the server and renders the matching form
SGfM.render_matching_form= function(actor_type_key){
  jQuery.ajax({
    url: '/information_types_for_actor_type',
    type: 'GET',
    data: {"actor_type_key" : actor_type_key},
    dataType: 'html',
    success: function(data) {
      jQuery('#information-types-form').html(data);
    }
  });
}
