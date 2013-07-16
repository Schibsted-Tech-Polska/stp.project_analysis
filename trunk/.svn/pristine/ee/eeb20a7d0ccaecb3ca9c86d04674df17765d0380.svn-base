mno.core.register({
    id:'widget.list.posts',
    extend:['mno.utils.rubrikk'],
    creator: function (sandbox) {
        var that = this, i = 0, callback, dataList = {}, callbackList = {};
        var $ = sandbox.$;

        callback = function(data,element, model) {
            var tmpDate,year,month,day,hours,minutes,seconds,datePartTmp,timePartTmp, itemCount;
            try{
                itemCount = parseInt(model.itemCount, 10);
            }catch(e){
                mno.core.log(1,"failed to parse itemCount in widget.list.posts");
                itemCount = 5;
            }
            window.$.each(data.response,function(i, element){
                if(i < itemCount){
                    try{
                        /* hade to parse date like this because IE was complaining */
                        datePartTmp = element.createdAt.split('T')[0];
                        timePartTmp = element.createdAt.split('T')[1];

                        year = parseInt(datePartTmp.split('-')[0],10);
                        month = parseInt(datePartTmp.split('-')[1],10);
                        day = parseInt(datePartTmp.split('-')[2],10);
                        hours = parseInt(timePartTmp.split(':')[0],10);
                        minutes = parseInt(timePartTmp.split(':')[1],10);
                        seconds = parseInt(timePartTmp.split(':')[2],10);
                        tmpDate = new Date(year,month,day,hours,minutes,seconds);
                        }catch(e){
                            mno.core.log(1,"faled to parse date! Using standard javascript date insted in widget.list.posts");
                            tmpDate = new Date();
                        }

                        element.createdAtTime = (tmpDate.getHours() < 10 ? ('0' + tmpDate.getHours()) : tmpDate.getHours()) + ':' + (tmpDate.getMinutes() < 10 ? ('0' + tmpDate.getMinutes()) : tmpDate.getMinutes());
                    }
                else{
                    delete data.response[i];    
                }
            });

            //cut responsea rray down to specified item count
            data.response = data.response.slice(0,itemCount);
            data.listHeight = model.listHeight;

            sandbox.render('widgets.list.views.posts',data,function(htmlData){
                if (element) {
                    var message = htmlData.find('.message');
                    element.append(htmlData);
                }
                element.find('.message').hover(function(e){
                        $(this).addClass("scroll");
                    },
                    function(e){
                        $(this).removeClass("scroll");
                });
            });
        };



        function init() {
            var that = this;
            try{
                if(sandbox.container !== null && sandbox.container.length > 0){
                    sandbox.container.each(function(i, element){
                        var model = sandbox.model[i],
                            jsonUrl = model.jsonUrl,
                            $this = $(this);
                        mno.callbacks.disqusLatestPosts = function(dataFromDisqus){
                            callback(dataFromDisqus,$this, model);
                        };
                        sandbox.getScript({
                            url: jsonUrl
                        });
                    });
                }
            }catch(e){
                mno.core.log(3,e);
            }

        }

        function destroy() {

        }

        return  {
            init: init,
            destroy: destroy
        };
    }
});
