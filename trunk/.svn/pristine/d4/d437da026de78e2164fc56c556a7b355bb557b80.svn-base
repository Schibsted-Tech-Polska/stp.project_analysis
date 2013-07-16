#! /usr/bin/perl
# anders.nordby@medianorge.no, 2010-09-21
# skuffe xml-eksporter fra aipub til regionsaviser

use Net::SFTP::Foreign;
use File::Copy;
use FindBin qw($Bin);
use XML::Simple;
#use Data::Dumper;

# ========== START CONFIG ==========
%sendfiles = (
	"mnotest1" => {
		"server" => "mnotest1.medianorge.no",
		"user" => "mno",
		"dir" => "/data/media/mno/vertikal/eceXmlImport",
		"imports" => "bilChannel",
	},
);
%getfiles = (
	"bilChannel" => {
		"user" => "resin",
		"host" => "aipub.aftenposten.no",
		"dir" => "/data/aft/eceXmlExport/bilChannel",
	},
);
# ========== END CONFIG ==========

$datadir="$Bin/data";

$mytime=int(time);
$minage=30;

sub fixdata {
	# Traverse and fix XML data
	for my $param (@_) {
		if (ref($param) eq 'ARRAY') {
			return;
#			for my $element (@{$param}) {
#				fixdata($element);
#			}
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

	my $xs = new XML::Simple(KeepRoot => 1, NoEscape => 1, NoIndent =>1, NoSort => 1, XMLDecl => '<?xml version="1.0" encoding="ISO-8859-1"?>');
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
	print "DEBUG scan $fetchuser@fetchserver:$fetchdir for files basedir=$basedir\n";

	foreach $f (@files) {
		foreach $fref (@{$f}) {
			$fn = $fref->{'filename'};
			$longname = $fref->{'longname'};

#			print "DEBUG found fn=$fn\n";

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
						if ($fn =~ /\.xml$/ && $basedir eq "jobbChannel") {
							print "DEBUG fixup xml file $fn in $wdir, basedir=$basedir\n";
							system("perl -pi -e 's/&lt;!/<!/g' $wdir/$fn");
							system("perl -pi -e 's/]&gt;/]>/g' $wdir/$fn");


#							handlexml($fn);
						} elsif ($fn =~ /\.xml$/) {
							print "DEBUG found xml file $fn, but basedir=$basedir\n";
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
				print "DEBUG shall reupload $f\n";
				push(@files, $f);
			}
			closedir(DIR);
			print "DEBUG: Antall filer = $#files\n";
			next if ($#files == -1);
			if (!defined $sftp) {
				print "DEBUG: Open connection to $user\@$server.\n";
				$sftp = Net::SFTP::Foreign->new("$user\@$server", timeout => 15);
			} else {
				print "DEBUG: Connection to $user@$server already open?\n";
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
				print "DEBUG shall reupload $f\n";
				push(@files, $f);
			}
			closedir(DIR);
			print "DEBUG: Antall filer = $#files\n";
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
						print "ERROR: " . $sftp->error . "\n";
						copy("$importdir/$f","$reimportdir/$f");
					}
				}
				undef $sftp;
			} else {
				# SFTP connection failed, copy all files for
				# retries
				$reimportdir = "$importdir/retry/$site";
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
