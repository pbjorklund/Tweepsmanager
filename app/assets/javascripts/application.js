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
$(document).ready(function(){
	$('.dropdown-toggle').dropdown()
});

function initPopover() {
    $("a[rel=popover]")
        .popover({
					offset: 10, live: true
        })
        .click(function(e) {
            e.preventDefault()
        })
};

//Google analytics
var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-28190889-2']);
_gaq.push(['_trackPageview']);

(function() {
	var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();

function loadUsers(path, user, page) {
  $.ajax({ 
    url: path,
    type: 'get',
    dataType:'script',
    data: "user=" + user + "&page=" + page,
    timeout: 15000,
    error: function(){
      $("#main").prepend('<div class="alert alert-error">Something went wrong.</div>');
      $(".hero-unit").html("<h1 id=\"loading\">Could not load users</h1>");
    },
    success: function() {
      initPopover();
    }
  });
};

//Pagination
//Adds a pagination div
//userPage = current page, numOfPages = total number of pages, path = current path, user = username
function addPagination(userPage, numOfPages, path, user) {
  if(numOfPages > 0) {
    if(userPage > 0) {
      $("div .pagination ul").append('<li id="previous"><a href="#">Prev</a></li>');
    }

    for (i = 0;i<= numOfPages;i++) { 
      if(userPage === i) {
        $("div .pagination ul").append('<li class="active page" data-value="' + i + '"><a href="#">' + (i+1) + '</a></li>'); 
      } else {
        $("div .pagination ul").append('<li class="page" data-value="' + i + '"><a href="#">' + (i+1) + '</a></li>'); 
      }
    }

    if(numOfPages > userPage) {
      $("div .pagination ul").append('<li id="next"><a href="#">Next</a></li>');
    }

    $(".page").click( function () { 
      $("#user-table").html('<div class="hero-unit"> <h1 id="loading">Loading users...</h1> </div>');
      loadUsers(path, user, $(this).data().value);
      $('input[type=button]').attr('disabled', true);
    });

    $("#next").click( function () { 
      $("#user-table").html('<div class="hero-unit"> <h1 id="loading">Loading users...</h1> </div>');
      loadUsers(path, user, (userPage + 1));
      $('input[type=button]').attr('disabled', true);
    });

    $("#previous").click( function () { 
      $("#user-table").html('<div class="hero-unit"> <h1 id="loading">Loading users...</h1> </div>');
      loadUsers(path, user, (userPage - 1));
      $('input[type=button]').attr('disabled', true);
    });
  };
};

//Shh
function followAll() { 
    $(":submit").filter(function() { return $(this).attr("value") === "Follow"; }).click();
};
