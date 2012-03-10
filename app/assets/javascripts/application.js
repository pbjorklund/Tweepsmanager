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


var loadUserRequest;

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
  if(loadUserRequest !== undefined) {
    if(loadUserRequest.hasOwnProperty("abort")) {
      loadUserRequest.abort();
      loadUserRequest = null;
    }
  }

  $("#user-table").html('<div class="hero-unit"> <h1 id="loading">Loading users...</h1> </div>');
  $('input[type=button]').attr('disabled', true);
  loadUserRequest = $.ajax({
                            url: path,
                            type: 'get',
                            dataType: 'script',
                            data: "user=" + user + "&page=" + page,
                            timeout: 15000,
                            //TODO Check Error/success takes params
                            error: function (xhr, ajaxOptions, thrownError) {
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
function addPagination(el, currentPage, totalPages, path, user) {
  var i, x, z;
  var interval = 2;

  function insertPageLink(pageNumber) {
    if(pageNumber >= 0 && pageNumber <= totalPages) {
      if(currentPage === pageNumber) {
        el.append('<li class="active page" data-value="' + pageNumber + '"><a href="#">' + (pageNumber + 1) + '</a></li>');
      } else {
        el.append('<li class="page" data-value="' + pageNumber + '"><a href="#">' + (pageNumber + 1) + '</a></li>');
      }
    }
  }

  function insertBlankPageLink() { 
        el.append('<li class="active page"><a href="#">...</a></li>');
  }

  if (totalPages > 0) {

    if (currentPage > 0) {
        el.append('<li class="page" data-value="' + (currentPage - 1) + '"><a href="#">' + "Previous" + '</a></li>');
    }

    if(totalPages < 10) {
      for (i = 0; i <= totalPages; i += 1) {
          insertPageLink(i);
      }
    }
    else {
      console.log("Current page is" + currentPage);
      if(currentPage > interval) {
        insertPageLink(0);
        insertBlankPageLink();
      }
      for(x = currentPage - interval; x < currentPage; x += 1) {
        insertPageLink(x);
      }
      insertPageLink(currentPage);
      for(z = currentPage + 1; z<= currentPage + interval; z += 1) {
        insertPageLink(z);
      }
      if(totalPages - currentPage > interval) {
        insertBlankPageLink();
        insertPageLink(totalPages);
      }
    }

    if (totalPages > currentPage) {
        el.append('<li class="page" data-value="' + (currentPage + 1) + '"><a href="#">' + "Next" + '</a></li>');
    }

    $(".container").on("click", ".page", function (event) {
      loadUsers(path, user, $(this).data().value);
    });
  }
}
