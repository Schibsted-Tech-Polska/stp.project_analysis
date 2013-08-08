
/*
 * GET home page.
 */

exports.index = function(req, res){
  res.render('inputForm', { title: 'Analysis Tool' });
};

exports.form = function(req, res){
res.render('linkToRepo', {
	title: 'get link'
	});
};