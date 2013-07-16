#! /usr/bin/perl
# anders.nordby@medianorge.no, 2010-09-21
# skuffe xml-eksporter fra aipub til regionsaviser
# modifisert versjon: replace-funksjonalitet, andreas Blaaflot
# modifisert versjon: xsl transformasjonsrutiner, a. nordby
# modifisert versjon: xsl- og xml-objekter og article state detection, k-r gule

use Net::SFTP::Foreign;
use File::Copy;
use FindBin qw($Bin);
use XML::Simple;
use XML::XSLT;
use XML::LibXSLT;
use XML::LibXML;
#use Data::Dumper;

$datadir="$Bin/data";

$mytime=int(time);
$minage=30;

my $SEARCHWORD1 = 'articlestatepublished';
my $SEARCHWORD2 = 'articlestatedeleted';

sub fixdata {
	# Traverse and fix XML data
	for my $param (@_) {
		if (ref($param) eq 'ARRAY') {
			return;
		} elsif (ref($param) eq 'HASH') {
			for my $val (values %{$param}) {
				fixdata($val);
			}
		} elsif (ref($param) eq 'CODE') {
			return;
		} elsif (!ref($param)) {
			$param = '<![CDATA[' . $param . ']]>';
		}
	}
}


sub xsltprocfast {
	my $readfn = shift;
	my $writefn = shift;
	my $xslfile = "$Bin/ece_export_to_fast.xsl";
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
	#my $xslt = eval { XML::XSLT->new($xslfile, warnings => 1, debug => 0) };
	my $style_doc = eval { $parser->parse_file($xslfile) };
	if ($@) {
		print "Could not parse XSL file $xslfile:\n";
		print $@;
		return(0);
	}

	# load xml
	#eval { $xslt->open_xml($readfn) };
	my $source = eval { $parser->parse_file($readfn) };
	if ($@) {
		print "Could not parse XML file $readfn:\n";
		print $@;
		# free up some memory
		#$xslt->dispose();
		return(0);
	}

	my $stylesheet = eval { $xslt->parse_stylesheet($style_doc) };
	if ($@) {
		print "Could not parse stylesheet:\n";
		print $@;
		return(0);
	}

	# transform XML file
	#eval { $xslt->process(debug => 0) };
	my $results = eval { $stylesheet->transform($source) };
	if ($@) {
		print "Could not transform XML file $readfn:\n";
		print $@;
		# free up some memory
		#$xslt->dispose();
		return(0);
	}

	# send to output
	#print $xslt->toString;
	print $results->toString;
	open(NEW, ">$writefn");
	#print NEW $xslt->toString;
	print NEW $results->toString;
	close(NEW);
	# free up some memory
	#$results->dispose();
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

sub encxml {
	my $readfn = shift;
	my $writefn = shift;

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

	my $xs = new XML::Simple(KeepRoot => 1, NoEscape => 1, NoIndent =>1, NoSort => 1, XMLDecl => '<?xml version="1.0" encoding="UTF-8"?>');
	my $ref = eval { $xs->XMLin($opt_f) };
	# $rettxt er global
	$rettxt = scalar($@);
	$rettxt =~ s@\n@@g;

	if($@) {
		return(0);
	} else {
		#print Dumper($ref);
		fixdata($ref);
		my $xml = $xs->XMLout($ref);
		open(NEW, ">$writefn");
		print NEW $xml;
		close(NEW);
		return(1);
	}
}

sub handlexml {
	my $fn = shift;
	my $tmpfn = $fn . ".tmp";
	# Assumption: chdir is correct
	print "Attempting CDATA encoding of $fn\n";

	if (encxml($fn, $tmpfn)) {
		print "CDATA encoding worked.\n";
		copy($tmpfn, $fn);
		unlink($tmpfn);
	} else {
		print "CDATA encoding failed.\n";
		mkdir("failed") unless (-d "failed");
		move($fn, "failed/$fn");
	}
}

sub xxprocessxml {
	my $fn = shift;
	my $dir = shift;

	my $ppdir = "$dir/post-processing";

	my $statetest = 0;		
	open(MYINPUTFILE, "<$dir/$fn");
	my(@lines) = <MYINPUTFILE>;
	@lines = sort(@lines);
	my($line);
	foreach $line (@lines) {
	 	if ($line =~ /$SEARCHWORD1/) {
	        	$statetest = 1;
		}
		if($line =~ /$SEARCHWORD2/) {
	        	$statetest = 2;
		}
	}
	close(MYINPUTFILE);

	if($statetest == 1){	
		system("perl -pi -e 's/&lt;!/<!/g' $dir/$fn");
		system("perl -pi -e 's/]&gt;/]>/g' $dir/$fn");
	}
	elsif($statetest == 2){
		print "Article state: deleted, move to post-processing dir $ppdir.\n";
		mkdir ($ppdir) unless (-d $ppdir);
		move("$dir/$fn","$ppdir/$fn");
	}
  else {
  unlink($fn);
  }
}

%sendfiles = (
	"fastdev1bt" => {
		"server" => "fastdev1.medianorge.no",
		"user" => "fast",
		"dir" => "/data/home/fast/feed/bt/incoming",
		"imports" => "bt0FastChannelTest",
	},
	"fast1bt" => {
		"server" => "fast1doc1.medianorge.no",
		"user" => "fast",
		"dir" => "/data/home/fast/feed/bt/incoming",
		"imports" => "bt0FastChannel",
	},
	"fast2bt" => {
		"server" => "fast2doc1.medianorge.no",
		"user" => "fast",
		"dir" => "/data/home/fast/feed/bt/incoming",
		"imports" => "bt0FastChannel",
	},
	"fastdev1sa" => {
		"server" => "fastdev1.medianorge.no",
		"user" => "fast",
		"dir" => "/data/home/fast/feed/sa/incoming",
		"imports" => "sa0FastChannelTest",
	},
	"fast1sa" => {
		"server" => "fast1doc1.medianorge.no",
		"user" => "fast",
		"dir" => "/data/home/fast/feed/sa/incoming",
		"imports" => "sa0FastChannel",
	},
	"fast2sa" => {
		"server" => "fast2doc1.medianorge.no",
		"user" => "fast",
		"dir" => "/data/home/fast/feed/sa/incoming",
		"imports" => "sa0FastChannel",
	},
	"fastdev1bilvertikal" => {
		"server" => "fastdev1.medianorge.no",
		"user" => "fast",
		"dir" => "/data/home/fast/feed/bilvertikal/incoming",
		"imports" => "bilvertikal0FastChannelTest",
	},
);
%getfiles = (
	"bt0FastChannelTest" => {
		"user" => "mno",
		"host" => "bttest2.medianorge.no",
		"dir" => "/data/export/fast",
	},
	"bt0FastChannel" => {
		"user" => "mno",
		"host" => "btpub2.medianorge.no",
		"dir" => "/data/export/fast",
	},
	"sa0FastChannelTest" => {
		"user" => "mno",
		"host" => "satest2.medianorge.no",
		"dir" => "/data/export/fast",
	},
	"sa0FastChannel" => {
		"user" => "mno",
		"host" => "sapub2.medianorge.no",
		"dir" => "/data/export/fast",
	},
	"bilvertikal0FastChannelTest" => {
		"user" => "mno",
		"host" => "mnotest1.medianorge.no",
		"dir" => "/data/export/fast/bil",
	},
);

sub getimportdir {
	# Get xml and jpg for import
	my $fetchuser = shift;
	my $fetchserver = shift;
	my $fetchdir = shift;
	my $basedir = shift;
	my $wdir = "$datadir/$basedir";

	mkdir ($wdir) unless (-d $wdir);
	if (! chdir($wdir)) {
		print "ERROR: Can not chdir to local dir $wdir for writing data files. Could not get import files.\n";
		return 0;
	}

	$sftp = Net::SFTP::Foreign->new("$fetchuser\@$fetchserver", timeout => 15)
	or return(0);

	@files = $sftp->ls($fetchdir);

	foreach $f (@files) {
		foreach $fref (@{$f}) {
			$fn = $fref->{'filename'};
			$longname = $fref->{'longname'};

			# Skip current/parrent directory
			next if ($fn eq "." || $fn eq "..");
			# Skip directories
			next if ($lognname =~ /^d/);
			$mtime = $fref->{'a'}->mtime;
			$size = $fref->{'a'}->size;
#			$flags = $fref->{'a'}->flags;
			$age = $mytime-$mtime;

			# Skip old files
			next if ($age <= $minage);

			if ($fn =~ /(\.xml|a\.jpg)$/) {
				# Download and erase *.xml and *a.jpg
				print "Download $fn\n";
				if ($sftp->get("$fetchdir/$fn", $fn)) {
					if ($size == (stat($fn))[7]) {
						print "Download OK for $fn. Delete on remote server.\n";
						$sftp->remove("$fetchdir/$fn");

						# Process/handle files here
						if ($fn =~ /\.xml$/) {
							handlexsltfast($fn);
							xxprocessxml($fn,$wdir);
						}
					} else {
						print "Wrong file size for $fn. Delete.\n";
						unlink($fn);
					}
				} elsif ( -f $fn ) {
					print "Could not properly download $fn. Delete.\n";
					unlink($fn);
				}
			} elsif ($fn =~ /\.jpg$/) {
				# Erase other jpg
				print "Delete remote file $fn, only keep a pics.\n";
				$sftp->remove("$fetchdir/$fn");
			}

#			print "Fil: $fn age=$age size=$size\n";
		}
	}
	undef $sftp;
}


foreach $getimport (keys %getfiles) {
	getimportdir($getfiles{"$getimport"}{"user"},$getfiles{"$getimport"}{"host"},$getfiles{"$getimport"}{"dir"},$getimport);
}

# Retry uploads
foreach $site (keys %sendfiles) {
	@siteimports = split(/\s+/, $sendfiles{"$site"}{"imports"});
	$user = $sendfiles{"$site"}{"user"};
	$server = $sendfiles{"$site"}{"server"};

	foreach $import (@siteimports) {
		$dir = $sendfiles{"$site"}{"dir"} . "/$import";
		$reimportdir = "$datadir/$import/retry/$site";
		if (-d $reimportdir) {
			@files = ();
			opendir(DIR, $reimportdir);
			while ($f = readdir(DIR)) {
				next if ($f eq "." || $f eq "..");
				next if (-d "$reimportdir/$f");
#				print "DEBUG shall reupload $f\n";
				push(@files, $f);
			}
			closedir(DIR);
#			print "DEBUG: Antall filer = $#files\n";
			next if ($#files == -1);
			if (!defined $sftp) {
#				print "DEBUG: Open connection to $user\@$server.\n";
				$sftp = Net::SFTP::Foreign->new("$user\@$server", timeout => 15);
#			} else {
#				print "DEBUG: Connection to $user@$server already open?\n";
			}
			foreach $f (@files) {
				# Ingen prosessering av filer her! -Anders
				if ($sftp->put("$reimportdir/$f","$dir/$f")) {
					print "Reupload $f to site $site OK. Removing.\n";
					unlink("$reimportdir/$f");
				} else {
					print "Reupload $f to site $site failed. Will try again.\n";
					print "ERROR: " . $sftp->error . "\n";
				}
			}
		}
	}
	if (defined $sftp) {
		undef $sftp;
	}
}


# Initial uploads
foreach $site (keys %sendfiles) {
	@siteimports = split(/\s+/, $sendfiles{"$site"}{"imports"});
	$user = $sendfiles{"$site"}{"user"};
	$server = $sendfiles{"$site"}{"server"};

	foreach $import (@siteimports) {
		$dir = $sendfiles{"$site"}{"dir"} . "/$import";
		$importdir = "$datadir/$import";
		if (-d $importdir) {
			@files = ();
			opendir(DIR, $importdir);
			while ($f = readdir(DIR)) {
				next if ($f eq "." || $f eq "..");
				next if (-d "$importdir/$f");
#				print "DEBUG shall reupload $f\n";
				push(@files, $f);
			}
			closedir(DIR);
#			print "DEBUG: Antall filer = $#files\n";
			next if ($#files == -1);

			print "Upload $importdir from $datadir to site $site ($server).\n";
			$reimportdir = "$importdir/retry/$site";
			mkdir ("$importdir/retry") unless (-d "$importdir/retry");
			mkdir ($reimportdir) unless (-d $reimportdir);
			$sftp = Net::SFTP::Foreign->new("$user\@$server", timeout => 15);
			if (!$sftp->error) {
				print "Connection OK.\n";
				
				foreach $f (@files) {
					# IKKE legg inn prosessering av filer
					# her -Anders. Se lenger opp i
					# getimportdir().
					if (!$sftp->put("$importdir/$f","$dir/$f")) {
						print "Upload $f to site $site failed. Will try again.\n";
						mkdir ($reimportdir) unless (-d $reimportdir);
						copy("$importdir/$f","$reimportdir/$f");	
					}				
						
				}
				
				undef $sftp;
			} else {
				# SFTP connection failed, copy all files for
				# retries
				print "Connection failed, copy to retry dir $reimportdir.\n";
				foreach $f (@files) {
					copy("$importdir/$f","$reimportdir/$f");
				}
			}
		}
	}
}

# Move files to archive
foreach $import (keys %getfiles) {
	$importdir = "$datadir/$import";
	mkdir("$importdir/archive") unless (-d "$importdir/archive");
	opendir(DIR, $importdir);
	while ($f = readdir(DIR)) {
		next if ($f eq "." || $f eq "..");
		next if (-d "$importdir/$f");

		move("$importdir/$f","$importdir/archive/$f");
	}
	closedir(DIR);
}
