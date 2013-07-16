mno.core.register({
    id:'widget.tip.form',
    creator: function(sandbox) {

        function Form($container, type) {
            this.$form = false;
            this.$container = $container;
            this.get();
            this.dialog = false;
            this.type = (type === undefined || type === 'modal') ? mno.utils.dialog : mno.utils.dropdown;
        }

        Form.prototype.get = function (params) {
            params = params || {};
            var that = this;
            $.ajax({
                type:'post',
                data:params,
                dataType:'json',
                url: '/?service=loadWidgets&widget=tip&contentId=' + that.$container.attr('data-widget-id') + '&ajax=true',
                success:function (data) {
                    if (that.$form !== false) {
                        that.$form.remove();
                    }
                    that.$form = $(data.html);
                    that.$form.bind('submit', function (e) {
                        that.get($(this).serialize());
                        that.dialog = false;
                        e.preventDefault();
                    });

                    that.$form.find('dt').bind('click', function () {
                        window.location.href = $(this).next('dd').find('a').attr('href');
                    });

                    that.$form.find('dd').bind('click', function () {
                        window.location.href = $(this).find('a').attr('href');
                    });

                    that.show();
                },
                error: function (e, status, txt) {
                    mno.core.log(1, txt);
                }
            });
        };

        Form.prototype.show = function() {
            var that = this,
                $clone = this.$form.clone(true);
            if (this.dialog === false) {
                this.dialog = this.type({
                    span:5,
                    autoOpen: true,
                    trigger:that.$container,
                    content: $clone,
                    onClose:function () {

                    },
                    onOpen: function () {
                        mno.utils.form.slidingLabels($clone);
                    }
                });
            } else {
                this.dialog.update($clone);
            }
        };

        function init() {
            if (sandbox.container !== null) {
                sandbox.container.each(function (i) {
                    var $this = $(this),
                        oForm = false;
                    (function (type) {
                        $this.bind('click', function (e) {
                            e.preventDefault();
                            if (oForm === false) {
                                oForm = new Form($this, type);
                            } else {
                                if (type === 'modal') {
                                    oForm.show();
                                } else {
                                    oForm.dialog.toggle();
                                }
                            }
                            return false;
                        });
                    }(sandbox.model[i].apperance));
                });
            }
        }

        function destroy() {}
        return {
            init:init,
            destroy:destroy
        }
    }
});