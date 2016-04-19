// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.atwho
//= require jquery_ujs
//= require turbolinks
//= require_tree .


function getCaret(el) {

    if (el.selectionStart) {

        return el.selectionStart;

    } else if (document.selection) {

        el.focus();

        var r = document.selection.createRange();

        if (r == null) {

            return 0;

        }

        var re = el.createTextRange(), rc = re.duplicate();

        re.moveToBookmark(r.getBookmark());

        rc.setEndPoint('EndToStart', re);

        return rc.text.length;

    }

    return 0;

}



function checkAnyFormFieldFilled(form){
    var anyFilled = false;
    $(form).find("input[type=text], textarea, input[type=file], input[type=email], input[type=tel]").each(function(index, element) {
        if (element.value.trim() != '') {
            anyFilled = true;
        }
    });
    return anyFilled;
}


function checkAnyFormFieldFilledSubmitAndReset(e, jsObj){
  e.preventDefault();
  var form = $(jsObj).closest("form")
  anyFilled = checkAnyFormFieldFilled(form);
  if (anyFilled){
    form.submit();
    form.trigger("reset");
  }
  return false;
}



var ready;
ready = function() {
  $('.submit_on_enter').keypress(function(event) {
    if (event.keyCode == 13) {
        var content = this.value;
        var caret = getCaret(this);
        if(event.shiftKey){
            //this.value = content.substring(0, caret - 1) + "\n" + content.substring(caret, content.length);
            //event.stopPropagation();
        } else {
          this.value = content.substring(0, caret) + content.substring(caret, content.length);
          checkAnyFormFieldFilledSubmitAndReset(event, this)
        }
    }
  });

  $('#user_interests').atwho({
    at: "",
    insertTpl: "${name}, ", 
    callbacks: {
      remoteFilter: function(query, callback) {
        $.getJSON("/tags.json", {q: query}, function(data) {
          callback(data)
        });
      }
    }
  }); 
};

$(document).ready(ready);

$(document).on('page:load', ready);


