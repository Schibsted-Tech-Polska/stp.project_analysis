mno.core.register({
    id:'widget.feed.twitter',
    creator:function (sandbox) {
        function Twitter($container, config) {
            var settings = {
                showAvatar:true,
                showDate:true,
                count: 10,
                loading_text: 'Laster...',
                since_id:0,
                frequency:30000
            },
            that = this;

            for (var key in config) {
                if (config.hasOwnProperty(key)) {
                    settings[key] = config[key];
                }
            }

            this.$ul = $('<ul class="twitterFall zebra articleList"></ul>');
            this.$button = $('<button value="Oppdater">Oppdater</button>');
            this.settings = settings;
            this.timestamps = [];
            this.$items = [];

            this.$button.bind('click', function () {
                that.refresh();
            });

            $container.append(this.$ul).append(this.$button);
        }

        Twitter.prototype = function () {
            var _updateTime = function() {
                var timer;
                return function() {
                    var timestampText;
                        var that = this;

                    clearTimeout(timer);
                    if (this.settings.showDate === true) {
                        for (var j=0; this.timestamps[j];j++ ) {
                            timestampText = mno.utils.relativeTime(this.timestamps[j].timestamp);
                            if (timestampText !== this.timestamps[j].text) {
                                this.timestamps[j].text = timestampText;
                                this.$ul.find('li:eq('+j+') .createdAt').html(timestampText);
                            }
                        }
                        timer = setInterval(function () {
                            _updateTime.call(that);
                        }, 30000);
                    } else {
                        this.$ul.find('.createdAt').remove();
                    }
                }
            }();

            function _setButtonText(text) {
                this.$button.text(text);
                this.$button.val(text);
            }

            var _buttonCounter = function() {
                var timer;

                return function() {
                    var start = new Date().getTime(),
                        that = this;

                    clearInterval(timer);
                    timer = setInterval(function () {
                        var seconds = Math.round( (that.settings.frequency - ( new Date().getTime() - start ) ) /1000 );
                        seconds = seconds >= 0 ? seconds : 0;
                        _setButtonText.call(that, 'Oppdaterer om ' +  seconds );
                    }, 1000);
                }
            }();

            var refresh = function ()  {
                var timer,
                    refreshUrl;

                return function (url) {
                    var that = this;

                    url = url || refreshUrl;
                    clearTimeout(timer);
                    _setButtonText.call(this,this.settings['loading_text']);

                    sandbox.getScript({
                        url:url,
                        callbackVar : 'callback',
                        jsonP: function (data) {
                            _setButtonText.call(that,'Oppdatert');
                            _buttonCounter.call(that); // start countdown
                            _printTweets.call(that,data);
                            refreshUrl = 'http://search.twitter.com/search.json' + data['refresh_url'];

                            timer = setTimeout(function () {
                                that.refresh(refreshUrl);
                            }, that.settings.frequency);
                        }
                    });
                }
            }();

            function _escapeHTML(s) {
                return s.replace(/</g,"&lt;").replace(/>/g,"^&gt;");
            }

            function _linkReplace(match) {
                var url = (/^[a-z]+:/i).test(match) ? match : "http://"+match;
                return '<a href="'+_escapeHTML(url)+'">'+_escapeHTML(match)+'</a>';
            }

            function _printTweets(data) {
                var results = data.results,
                    that = this,
                    i = results.length;

                if (results.length !== 0) {
                    while(i--) {
                        results[i].text = mno.utils.pattern('replace', 'url', results[i].text, _linkReplace);
                        results[i].text = mno.utils.pattern('replace', 'twitterUser', results[i].text, '$1<a href="http://www.twitter.com/$2\">@$2</a>');
                        results[i].text = mno.utils.pattern('replace', 'twitterHash', results[i].text, ' <a href="http://www.twitter.com/search?q=&tag=$1&lang=all">#$1</a>');
                        this.timestamps.unshift({
                            timestamp:results[i]['created_at'],
                            text:''
                        });
                    }

                    sandbox.render('widgets.feed.views.twitterfall', results, function (html) {
                        var itemOverflow;

                        html = html.filter('li');
                        if (that.settings.showAvatar === false) {
                            html.find('img').remove();
                        }

                        that.$items = Array.prototype.slice.call(html,0).concat(that.$items); // Add new items

                        that.$ul.prepend(html);

                        if (that.$items.length >= that.settings.count) {
                            itemOverflow = that.$items.slice(that.settings.count);
                            while (itemOverflow[0]) {
                                $(itemOverflow.pop()).remove();
                            }

                            that.$items= that.$items.slice(0,that.settings.count);
                            that.timestamps = that.timestamps.slice(0,that.settings.count);
                        }
                        _updateTime.call(that);
                    });
                }
            }

            function show() {
                var query='';

                if (this.settings.hasOwnProperty('query') === true) {
                    query += 'q=' + this.settings.query;
                } else if (this.settings.username.length !== 0) {
                    query += 'q=from:'+this.settings.username.join(' OR from:');
                }

                query += '&since_id=' + this.settings.since_id;
                this.refresh('http://search.twitter.com/search.json?' + query);
            }
            return {
                show:show,
                refresh:refresh
            }
        }();

        function init() {
            sandbox.container.each(function(i) {
                var twitter = new Twitter($(this), sandbox.model[i].twitterSettings);
                twitter.show();

                var isShown = true;
                /*$(this).find('h2').append("<span style='float:right; font-size: 15px; cursor: pointer;'>skjul &#8679;</span>");

                $(this).find('header').bind('click', function () {
                    if(isShown){
                        $(this).parent().find('ul').hide(2000);
                        $(this).parent().find('button').hide();
                        $(this).parent().find('h2').find('span').html('vis &#8681;');
                        isShown = false;
                    }else{
                        $(this).parent().find('ul').show(2000);
                        $(this).parent().find('button').show();
                        $(this).parent().find('h2').find('span').html('skjul &#8679;');
                        isShown = true;
                    }
                }); */
            });
        }

        function destroy() {}

        return {
            Twitter:Twitter,
            init:init,
            destroy:destroy
        }
    }
});