#! /usr/bin/perl
# anders.nordby@medianorge.no, 2010-09-21
# skuffe xml-eksporter fra aipub til regionsaviser

use Net::SFTP::Foreign;
use File::Copy;
use FindBin qw($Bin);
#use Data::Dumper;

# ========== START CONFIG ==========
%sendfiles = (
	"btpub" => {
		"server" => "btpub3.medianorge.no",
		"user" => "mno",
		"dir" => "/data/import",
		"imports" => "ntb",
	},
        "sapub" => {
                "server" => "sapub3.medianorge.no",
                "user" => "mno",
                "dir" => "/data/import",
                "imports" => "ntb",
        },
);
%getfiles = (
	"ntb" => 1,
);
# ========== END CONFIG ==========

$datadir="$Bin/data";

$mytime=int(time);
$minage=30;

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
				print "DEBUG shall upload $f\n";
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
