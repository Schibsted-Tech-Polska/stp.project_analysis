mno.core.register({
    id:'widget.bubbles.bubblesDefault',
    require: ['mno/utils/raphael-min', 'mno/utils/raphael-svg-import'],
    creator:function(sandbox) {
        function Bubbles($container, config, paper, bubbles) {
            var pos = $container.offset(),
                settings = {
                    number:9,
                    colors: ['000000'],
                    speed:2000,
                    height:400,
                    radius:45,
                    width:980
                };

            for (var key in config) {
                if (config.hasOwnProperty(key)) {
                    settings[key] = config[key];
                }
            }

            this.bubbles = bubbles;
            this.settings = settings;
            this.paper = paper;
            this.paper.canvas.style.cursor = 'crosshair';
            this.paper.canvas.style.top = 0;
            this.paper.canvas.style.left = 0;
            this.animated = false;

            for (var i = 0;this.bubbles[i];i++) {
                this.addClick(this.bubbles[i].el);
            }
        }

        Bubbles.prototype.startAnimation = function () {
            this.animated = true;
            for (var i = 0;this.bubbles[i];i++) {
                this.animate(this.bubbles[i].el);
            }
        };

        Bubbles.prototype.stopAnimation = function() {
            var that = this;

            this.animated = false;
            for (var i = 0;this.bubbles[i];i++) {
                that.bubbles[i].el.stop();
                that.bubbles[i].el.animate({
                    cx: that.bubbles[i].orgX,
                    cy: that.bubbles[i].orgY,
                    r: that.bubbles[i].orgRadius
                }, 500, 'easeOut');
            }
        };

        Bubbles.prototype.animate = function(el) {
            var that = this,
                spd = 2000 + Math.random()* this.settings.speed,
                r = 5 + Math.random() * this.settings.radius,
                params = {
                    cx: r + Math.random()* (this.settings.width - (r*2)),
                    cy: Math.random() * this.settings.height,
                    r: r
                };

            el.animate(params, spd, 'easeOut', function () {
                if (that.animated === true) {
                    that.animate(el);
                }
            });
        };

        Bubbles.prototype.explode = function (el) {
            var r,
                x = el.attr('cx'),
                y = el.attr('cy'),
                col = el.attr('fill'),
                c,
                params;

            for (var i = Math.floor(Math.random()*5) + 3; i !== 0; i--) {
                r = 5 + Math.random() * this.settings.radius;
                c = this.paper.circle(x,y,5);
                c.attr('fill', col);
                c.attr('stroke', 'none');

                params = {
                    cx: r + Math.random()* (this.settings.width - (r*2)),
                    cy: Math.random() * this.settings.height,
                    r: r,
                    opacity: 0
                };

                c.animate(params, 250, 'easeOut', function () {
                    this.remove();
                });
            }
        };

        Bubbles.prototype.addClick = function (el) {
            var that = this;
            el.click(function () {
                that.explode(el);
                this.remove();
            });
        };

        Bubbles.prototype.createBubbles = function() {
            var c,r;
            for (var key = this.settings.number;key !== 0; key--) {
                r = Math.random() * this.settings.radius;
                c = this.paper.circle(r + Math.random()* (this.settings.width - (r*2)), Math.random() * this.settings.height, r);
                c.attr('fill', '#' + this.settings.colors[0]);
                this.settings.colors.push(this.settings.colors.shift());
                c.attr('stroke','none');
                this.addClick(c);
            }
        };

        function Particle(el) {
            el.attr('stroke', '#ffffff');
            el.attr('stroke-width', '2px');

            this.el = el;
            this.orgRadius = this.radius = el.attr('r');
            this.orgX = this.x = el.attr('cx');
            this.orgY = this.y = el.attr('cy');
            this.velX = 0;
            this.velY = 0;
        }

        function init() {
            if (sandbox.container) {
                sandbox.container.each(function(i) {
                    var $this = $(this),
                        model = sandbox.model[i],
                        bubbles = [],
                        paths = [];

                    $.ajax({
                        type: 'GET',
                        url: model.tagline,
                        dataType: 'xml',
                        success: function(svgXML) {
                            var paper = Raphael($this.get(0), $this.width(), $this.height()),
                                svg = paper.importSVG(svgXML),
                                myBubbles;

                            for (var i = 0; svg[i];i++) {
                                if (svg[i].node.nodeName === 'circle') {
                                    bubbles.push(new Particle(svg[i]));
                                } else {
                                    paths.push(svg[i]);
                                }
                            }

                            myBubbles = new Bubbles($this, {
                                width:$this.width(),
                                height:$this.height(),
                                colors: model.colors,
                                numbers: model.number
                            }, paper, bubbles);

                            $this.on('mouseenter', function () {
                                myBubbles.startAnimation();
                                for (var i = 0; paths[i]; i++) {
                                    paths[i].attr('opacity', 0);
                                }
                            }).on('mouseleave', function () {
                                myBubbles.stopAnimation();
                                setTimeout(function () {
                                    for (var i = 0; paths[i]; i++) {
                                        paths[i].animate({opacity:1}, 250, 'easeOut');
                                    }
                                }, 1000)
                            });
                            //;
                        }
                    });
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