//Bootstrap
$(document).ready(function () {
  $('.dropdown-toggle').dropdown();
});

//Google analytics
var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-28190889-2']);
_gaq.push(['_trackPageview']);

(function () {
  var ga, s;
  ga = document.createElement('script');
  ga.type = 'text/javascript';
  ga.async = true;
  ga.src = ('https:' === document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
  s = document.getElementsByTagName('script')[0];
  s.parentNode.insertBefore(ga, s);
}());

var loadUserRequest;
function loadUsers(path, user, page) {
  if(loadUserRequest !== undefined) {
    if(loadUserRequest.hasOwnProperty("abort")) {
      loadUserRequest.abort();
      loadUserRequest = null;
    }
  }

  $("#main").html('<div class="hero-unit"> <h1 id="loading">Loading users...</h1> </div>');
  $('input[type=button]').attr('disabled', true);
  loadUserRequest = $.ajax({
    url: path,
                  type: 'get',
                  dataType: 'script',
                  data: "user=" + user + "&page=" + page,
                  timeout: 15000,
                  error: function (xhr, ajaxOptions, thrownError) {
                    $(".hero-unit").html("<h1 id=\"loading\">Could not load users</h1>");
                  },
                  success: function () {
                  }
  });
}

bindClickEvents = function(el, path, user) {
  el.on("click", ".page", function (event) {
    loadUsers(path, user, $(this).data().value);
  });
};

