$(document).ready(function(){
  $( "#target" ).submit(function( event ) {
    var name = $(this).find('#username').val();
    // alert( username );
    $.ajax({
      type: "GET",
      url : "/newtweets",
      data: { username: name },
      beforeSend: function(){
        $('.loading').html('<img src="/images/ajax-loader.gif"/>');
      },
      success:function(data){
        // console.log(data);
        $('.loading').hide();
        $("#result").html(data);
        // $(".tweets").html(data);
      }
    });

    event.preventDefault();
  });
});


