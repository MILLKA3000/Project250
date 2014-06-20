//= require jquery_ujs
//= require_tree .
$(document).ready(function(){
    $( "input[type=submit], a, button" ).button()
    $( ".sort a" ).button( "destroy" );
    $( ".datepicker" ).datepicker();

    $(document).on("click",".sort a", function ( event ) {
            $.getScript(this.href);
            return false;
        });


});