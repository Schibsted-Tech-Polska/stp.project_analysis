#!/usr/bin/perl
use Net::SFTP::Foreign;
use FindBin qw($Bin);
use XML::Simple;
use File::Copy;
use XML::LibXSLT;
use XML::LibXML;
use warnings;

%sendfiles = (
	"fastdev1bilvertikal" => {
		"server" => "fastdev1.medianorge.no",
		"user" => "fast",
		"dir" => "/data/home/fast/feed/bilvertikal/incoming",
		"imports" => "bilvertikal0FastChannelTest",
	},
	"fast1bilvertikal" => {
		"server" => "fast1doc1.medianorge.no",
		"user" => "fast",
		"dir" => "/data/home/fast/feed/bilvertikal/incoming",
		"imports" => "bilvertikal0FastChannel",
	},
	"fast2bilvertikal" => {
		"server" => "fast2doc1.medianorge.no",
		"user" => "fast",
		"dir" => "/data/home/fast/feed/bilvertikal/incoming",
		"imports" => "bilvertikal0FastChannel",
	},
);

sub xsltprocfast {
  my $readfn = shift;
  my $writefn = shift;
  my $xslfile = "ece_fast_post.xsl";
  my $parser = XML::LibXML->new();
  my $xslt = XML::LibXSLT->new();

	unless (-f $readfn) {
		$rettxt="file not found";
		return(0);
	}
	unless (-r $readfn) {
		$rettxt="file not readable";
		return(0);
	}
	unless (-s $readfn) {
		$rettxt="file empty, file size is zero";
		return(0);
	}

	#  create xsl instance
	my $style_doc = $parser->parse_file($xslfile);
	if ($@) {
		print "Could not create an instance of the XSL processor using $xslfile:\n";
		print $@;
		return(0);
	}

	# load xml
	my $source = $parser->parse_file($readfn);
	if ($@) {
		print "Could not load XML file $readfn:\n";
		print $@;
		return(0);
	}

	# transform XML file
	my $stylesheet = $xslt->parse_stylesheet($style_doc);
	my $results = $stylesheet->transform($source);
	if ($@) {
		print "Could not transform XML file $readfn:\n";
		print $@;
		return(0);
	}

	# send to output
	print $results->toString;
	open(NEW, ">$writefn");
	print NEW $results->toString;
	close(NEW);
	return(1);
}

sub handlexsltfast {
	my $fn = shift;
	my $tmpfn = $fn . ".tmp";
	# Assumption: chdir is correct
        print "Attempting XSLT processing of $fn\n";

	if (xsltprocfast($fn, $tmpfn)) {
		print "XSLT processing worked.\n";
		copy($tmpfn, $fn);

		unlink($tmpfn);
	} else {
		print "XSLT processing failed.\n";
		mkdir("failed") unless (-d "failed");
		move($fn, "failed/$fn");
	}
}

my $filepath = "data/bilvertikal0FastChannel/post-processing";
@delarticles = glob "$filepath/*.xml";
my $f = "bilvertikal0arts.del";
foreach $fn (@delarticles) {
  handlexsltfast($fn);
  system("perl -nle 'print unless 1 .. 1' $fn >> $filepath/$f");
  unlink($fn);
}

foreach $site (keys %sendfiles) {
    $user = $sendfiles{"$site"}{"user"};
    $server = $sendfiles{"$site"}{"server"};
    $dir = $sendfiles{"$site"}{"dir"} . "/bilvertikal0FastChannel";

    if (!defined $sftp) {
      $sftp = Net::SFTP::Foreign->new("$user\@$server", timeout => 15);
    }
	
    if ($sftp->put("$filepath/$f","$dir/$f")) {
      print "Upload $f to site $site OK\n";
    } else {
      print "Upload bilvertikal0arts.del to site $site failed. Will try again.\n";
      print "ERROR: " . $sftp->error . "\n";
    }
    if (defined $sftp) {
	undef $sftp;
    }
}
my $fx = "bilvertikal0arts.del.last";
system("perl -nle 'print unless 1 .. 1' $filepath/$f >> $filepath/$fx");
unlink($f);
