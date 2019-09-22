$(document).on('turbolinks:load', function () {
  return (function () {
    var replaceChildrenOptions, replaceSelectOptions;
    replaceSelectOptions = function ($select, results) {
      $select.html($('<option>'));
      return $.each(results, function () {
        var option;
        option = $('<option>').val(this.id).text(this.name);
        return $select.append(option);
      });
    };
    replaceChildrenOptions = function () {
      var $selectChildren, childrenPath;
      childrenPath = $(this).find('option:selected').data().childrenPath;
      $selectChildren = $(this).closest('form').find('.select-children');
      if (childrenPath != null) {
        return $.ajax({
          url: childrenPath,
          dataType: "json",
          success: function (results) {
            return replaceSelectOptions($selectChildren, results);
          },
          error: function (XMLHttpRequest, textStatus, errorThrown) {
            console.error("Error occurred in replaceChildrenOptions");
            console.log("XMLHttpRequest: " + XMLHttpRequest.status);
            console.log("textStatus: " + textStatus);
            return console.log("errorThrown: " + errorThrown);
          }
        });
      } else {
        return replaceSelectOptions($selectChildren, []);
      }
    };
    return $('.select-parent').on({
      'change': replaceChildrenOptions
    });
  })();
});
