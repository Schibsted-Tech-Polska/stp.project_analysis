
/*
 * GET home page.
 */

exports.index = function(req, res){
  res.render('index', { title: 'Analysis Tool' });
};

exports.form = function(req, res){
res.render('linkToRepo', {
	title: 'get link'
	
	});
};