//= require_self

setInterval(function () {
  var latest = $("#since").val();

  $.get( "/feeds/latest?since=" + latest, function( data ) {
    var $data = $(data);
    $("#since").remove();
    $data.find("input").detach().appendTo(".js-feed-table").parent();
    $data.find("tr").detach().prependTo(".js-feed-table tbody");
  });
}, 1000);
