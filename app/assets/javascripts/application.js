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
//= require twitter/bootstrap
//= require_tree .

//Bootstrap

$(document).ready(function () {
  $('.dropdown-toggle').dropdown();
});

function initPopover() {
  $("a[rel=popover]").
    popover({ offset: 10, live: true }).
    click(function (e) {
      e.preventDefault();
    });
}

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

function loadUsers(path, user, page) {
  $("#user-table").html('<div class="hero-unit"> <h1 id="loading">Loading users...</h1> </div>');
  $('input[type=button]').attr('disabled', true);
  $.ajax({
    url: path,
    type: 'get',
    dataType: 'script',
    data: "user=" + user + "&page=" + page,
    timeout: 15000,
    //TODO Check Error/success takes params
    error: function () {
      $("#main").prepend('<div class="alert alert-error">Something went wrong.</div>');
      $(".hero-unit").html("<h1 id=\"loading\">Could not load users</h1>");
    },
    success: function () {
      initPopover();
    }
  });
}

//Pagination
//Adds a pagination div
//userPage = current page, numOfPages = total number of pages, path = current path, user = username
function addPagination(el, userPage, numOfPages, path, user) {
  var i;

  function insertPageLink(pageNumber, active) {
    if(active) {
        el.append('<li class="active page" data-value="' + i + '"><a href="#">' + (i + 1) + '</a></li>');
    } else {
        el.append('<li class="page" data-value="' + i + '"><a href="#">' + (i + 1) + '</a></li>');
    };
  }

  if (numOfPages > 0) {

    if (userPage > 0) {
      el.append('<li id="previous"><a href="#">Prev</a></li>');
    }

    if(numOfPages < 10) {
      for (i = 0; i <= numOfPages; i += 1) {
        if (userPage === i) {
          insertPageLink(i+1, true);
        } else {
          insertPageLink(i+1, false);
        }
      }
    }

    if (numOfPages > userPage) {
      el.append('<li id="next"><a href="#">Next</a></li>');
    }

    $(".container").on("click", ".page", function (event) {
      loadUsers(path, user, $(this).data().value);
    });

    $("#next").click(function () {
      var newPage = userPage + 1;
      loadUsers(path, user, newPage);
    });

    $("#previous").click(function () {
      loadUsers(path, user, (userPage - 1));
    });
  }
}
