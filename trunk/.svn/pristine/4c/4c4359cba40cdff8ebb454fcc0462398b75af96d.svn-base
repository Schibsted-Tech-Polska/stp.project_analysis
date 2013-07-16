(function($) {

  $.fn.tweet = function(o){
    var s = {
      username: null,                   // username
      showAvatar:true,                  // show avatar image ?
      showDate:true,
      avatar_width: 48,                 // [integer] width of avatar image if displayed
      avatar_height: 48,                 // [integer] height of avatar image if displayed
      count: 5,                         // [integer]  how many tweets to display?
      loading_text: null,               // [string]   optional loading text, displayed while tweets load
      query: null                       // [string]   optional search query
    };

    if(o) $.extend(s, o);

    $.fn.extend({
      linkUrl: function() {
        var returning = [];
        var regexp = /((ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?)/gi;
        this.each(function() {
          returning.push(this.replace(regexp,"<a href=\"$1\">$1</a>"));
        });
        return $(returning);
      },
      linkUser: function() {
        var returning = [];
        var regexp = /[\@]+([A-Za-z0-9-_]+)/gi;
        this.each(function() {
          returning.push(this.replace(regexp,"<a href=\"http://twitter.com/$1\">@$1</a>"));
        });
        return $(returning);
      },
      linkHash: function() {
        var returning = [];
        var regexp = / [\#]+([A-Za-z0-9-_]+)/gi;
        this.each(function() {
          returning.push(this.replace(regexp, ' <a href="http://search.twitter.com/search?q=&tag=$1&lang=all' + (s.username ? '&from='+s.username.join("%2BOR%2B") : '') + '">#$1</a>'));
        });
        return $(returning);
      },
      capAwesome: function() {
        var returning = [];
        this.each(function() {
          returning.push(this.replace(/(a|A)wesome/gi, 'AWESOME'));
        });
        return $(returning);
      },
      capEpic: function() {
        var returning = [];
        this.each(function() {
          returning.push(this.replace(/(e|E)pic/gi, 'EPIC'));
        });
        return $(returning);
      },
      makeHeart: function() {
        var returning = [];
        this.each(function() {
          returning.push(this.replace(/(&lt;)+[3]/gi, "<tt class='heart'>&#x2665;</tt>"));
        });
        return $(returning);
      }
    });

    function relative_time(time_value) {
      var parsed_date = Date.parse(time_value);
      var relative_to = (arguments.length > 1) ? arguments[1] : new Date();
      var delta = parseInt((relative_to.getTime() - parsed_date) / 1000);
      if(delta < 60) {
      return 'less than a minute ago';
      } else if(delta < 120) {
      return 'about a minute ago';
      } else if(delta < (45*60)) {
      return (parseInt(delta / 60)).toString() + ' minutes ago';
      } else if(delta < (90*60)) {
      return 'about an hour ago';
      } else if (delta >= 90*60 && delta < 120*60) {
      return 'about 2 hours ago';
      } else if(delta < (24*60*60)) {
      return 'about ' + (parseInt(delta / 3600)).toString() + ' hours ago';
      } else if(delta < (48*60*60)) {
      return '1 day ago';
      } else {
      return (parseInt(delta / 86400)).toString() + ' days ago';
      }
    }

    return this.each(function(){
      var conentDiv = $('<div class="content">').appendTo(this);
      var loading = $('<p class="loading">'+s.loading_text+'</p>');
      if(s.username && typeof(s.username) == "string"){
        s.username = [s.username];
      }
      var query = '';
      if(s.query) {
        query += 'q='+s.query;
      }

      if (s.username) {
        query += '&q=from:'+s.username.join('%20OR%20from:');
      }
      var url = 'http://search.twitter.com/search.json?&'+query+'&rpp='+s.count+'&callback=?';
      if (s.loading_text) $(this).append(loading);
      $.getJSON(url, function(data){
        if (s.loading_text) loading.remove();
        $.each(data.results, function(i,item){
          var avatar_template = '<a href="http://twitter.com/'+ item.from_user+'"><img style="float:left; margin-right: 5px" src="'+item.profile_image_url+'" height="'+s.avatar_height+'" width="'+s.avatar_width+'" alt="'+item.from_user+'\'s avatar" title="'+item.from_user+'\'s avatar" border="0"/></a>';
          var avatar = ((s.showAvatar)? avatar_template : '');
          var author = '<h4><a target="_blank" href="http://twitter.com/'+item.from_user+'">' + item.from_user + '</a></h4>';
          var text = '<p class="feedSummary">' +$([item.text]).linkUrl().linkUser().linkHash().makeHeart().capAwesome().capEpic()[0]+ '</p>';
          var date = '<div class="dateline"><a href="http://twitter.com/'+item.from_user+'/statuses/'+item.id+'">'+relative_time(item.created_at)+'</a></div>';

          // until we create a template option, arrange the items below to alter a tweet's display.
          conentDiv.append('<div class="article">' + avatar + author + text + (s.showDate ? date : '') + '</div>');          
          conentDiv.children('div:first').addClass('first');
        });
      });

    });
  };
})(jQuery);