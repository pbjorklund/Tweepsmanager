var Paginator = function(el, currentPage, totalPages) {
  this.el = el;
  this.currentPage = currentPage;
  this.totalPages = totalPages;

  this.insertPageLink = function insertPageLink(pageNumber) {
    var className = "page";
    if(pageNumber >= 0 && pageNumber <= totalPages) {
      if(currentPage === pageNumber) {
        className = "active page";
      }  
      el.append('<li class="' + className + '" data-value="' + pageNumber + '"><a href="#">' + (pageNumber + 1) + '</a></li>');
    }
  };

  this.insertBlankPageLink = function () { 
    el.append('<li class="active page"><a href="#">...</a></li>');
  };

  this.addPagination = function () {
    var i, x, z;
    var interval = 2;

    if (totalPages > 0) {

      if (currentPage > 0) {
        el.append('<li class="page" data-value="' + (currentPage - 1) + '"><a href="#">' + "Previous" + '</a></li>');
      }

      if(totalPages < 10) {
        for (i = 0; i <= totalPages; i += 1) {
          this.insertPageLink(i);
        }
      } else {

        if(currentPage > interval) {
          this.insertPageLink(0);
          this.insertBlankPageLink(el);
        }

        for(x = currentPage - interval; x < currentPage; x += 1) {
          this.insertPageLink(x);
        }

        this.insertPageLink(currentPage);

        for(z = currentPage + 1; z<= currentPage + interval; z += 1) {
          this.insertPageLink(z);
        }

        if(totalPages - currentPage > interval) {
          this.insertBlankPageLink(el);
          this.insertPageLink(totalPages);
        }
      }

      if (totalPages > currentPage) {
        el.append('<li class="page" data-value="' + (currentPage + 1) + '"><a href="#">' + "Next" + '</a></li>');
      }

    }
  };
};
