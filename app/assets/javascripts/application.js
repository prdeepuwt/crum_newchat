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
//= require moment
//= require fullcalendar
//= require fullcalendar/gcal
//= require jquery-fileupload/basic
//= require bootstrap-modal
//= require bootstrap-modalmanager
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



function open_event_modal(event_id){
  var $modal_event = $('#event_modal');
  //create the backdrop and wait for next modal to be triggered
  $('body').modalmanager('loading');
  setTimeout(function(){
    $modal_event.load('/time_tables/' + event_id + '.js', '', function(){
      $modal_event.modal();
    });
  }, 1000);
}

function notifyMe(title, msg) {
  if (!Notification) {
    alert('Desktop notifications not available in your browser. Try Chromium.'); 
    return;
  }

  if (Notification.permission !== "granted")
    Notification.requestPermission();
  else {
    var notification = new Notification('New message from ' + msg.sender_user_name + ' ' + title, {
      icon: 'http://xpirits.com/images/q-logo.png',
      body: msg.body,
    });

    notification.onclick = function () {
      var a = window.open(msg.link, "crumchat");
      a.focus();
    };
    
  }

}

$(document).ready( function() {
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

  $('#search_tag').atwho({
    at: "",
    insertTpl: "${name}", 
    callbacks: {
      remoteFilter: function(query, callback) {
        $.getJSON("/tags.json", {q: query}, function(data) {
          callback(data)
        });
      }
    }
  });

  $('.search_user').atwho({
    at: "",
    insertTpl: "${email},", 
    callbacks: {
      remoteFilter: function(query, callback) {
        $.getJSON("/users.json", {q: query}, function(data) {
          callback(data)
        });
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

  document.addEventListener('DOMContentLoaded', function () {
    if (Notification.permission !== "granted")
      Notification.requestPermission();
  });



  $('#event_calendar_full').fullCalendar({

    header:{
        left: 'prev,next,today',
        center: 'title',
        right: 'month,agendaDay,agendaWeek'
    },
    events: '/time_tables.json',
    eventRender: function (event, element) {
        element.attr('href', 'javascript:void(0);');
        element.attr('onclick', 'open_event_modal("' + event.id + '");');
        element.attr('title', 'By: ' + event.user.name + '\n' + event.title + '\n\n' + event.description);
        $(element).html('<img class="event_user_img" src="'+ event.user.avatar +'" width="30px" height="30px" /> ' + event.user.name + $(element).html())
    },
    title: {
      month: 'MMM YY', // September 2009
      week: "MMM D YY", // Sep 13 2009
      day: 'MMM D YY'  // September 8 2009    
    },
displayEventEnd: true,
  });

  $('#event_calendar_small').fullCalendar({

    header: {
        left: 'prev,next,today',
        center: 'title',
        right: 'month,agendaDay,agendaWeek'
    },
    events: '/time_tables.json?user_id=' + $('#event_calendar_small').data('user-id'),
    eventRender: function (event, element) {
        element.attr('href', 'javascript:void(0);');
        element.attr('onclick', 'open_event_modal("' + event.id + '");');
        element.attr('title', 'By: ' + event.user.name + '\n' + event.title + '\n\n' + event.description);
        $(element).html('<img class="event_user_img" src="'+ event.user.avatar +'" width="30px" height="30px" /> ' + event.user.name + $(element).html())
    },
    displayEventEnd: true,
  });

  $('#message_attatchments_attributes_0_file').fileupload({
      dataType: 'json',
      add: function (e, data) {
          
          data.context = $('<p/>').text('Uploading...').appendTo(document.body);
          data.submit();
      },
      progressall: function (e, data) {
          var progress = parseInt(data.loaded / data.total * 100, 10);
          $('#progress .bar').css(
              'width',
              progress + '%'
          );
      },
      done: function (e, data) {
          console.log('ff')
          console.log(data._response.result.message)
          socket.emit('message', { conversation_id: data._response.result.conversation_id, conversation_name: 'hhh', conversation_kind: 'direct', sender_user_id: 1, sender_user_name: 'vvv', message: data._response.result.message, link: '/', body: 'jjjjjjj'});
          //$.each(data.result.files, function (index, file) {
          //    $('<p/>').text(file.name).appendTo(document.body);
          //});
          //data.context.text('Upload finished.');
      },
  });
  
  
  $('#attatchment_file').fileupload({
      dataType: 'json',
      add: function (e, data) {
          
          data.context = $('<p/>').text('Uploading...').appendTo(document.body);
          data.submit();
      },
      progressall: function (e, data) {
          var progress = parseInt(data.loaded / data.total * 100, 10);
          $('#progress .bar').css(
              'width',
              progress + '%'
          );
      },
      done: function (e, data) {
          console.log(data)
          //$.each(data.result.files, function (index, file) {
          //    $('<p/>').text(file.name).appendTo(document.body);
          //});
          //data.context.text('Upload finished.');
      },
  });
  
  
      $('#attatchment_file1').fileupload({
        dataType: 'json',
        add: function (e, data) {
            data.context = $('<button/>').text('Upload')
                .appendTo(document.body)
                   {
                    data.context = $('<p/>').text('Uploading...').replaceAll($(this));
                    data.submit();
                };
        },
        done: function (e, data) {
            data.context.text('Upload finished.');
        }
    });
  
  
  
  
});
