#! /usr/bin/perl
# NTB import
# anders.nordby@medianorge.no, 2010-03-29

use Net::FTP;
use File::Copy;
$mytime = time;

$user = "MN_nett";
$pass = "03ntbMN11";
$server = "193.75.33.35";
$minage = 300;
#$extensions = '\.(csv)$';

#$ftp = Net::FTP->new($server, Debug =>0, Passive =>0) or exit(1);
$ftp = Net::FTP->new($server, Debug =>1, Passive =>0) or exit(1);
$ftp->login($user, $pass) or exit(1);
umask(022);

sub dldir {
	# $_[0]: dir
	my $dir = shift;
	my $ddir = shift;
	my $adir = shift;

	$ftp->cwd("$dir");

#	ikke noe lokalt hierarki her
#	my $ldir = $basedir . "/" . $dir;
#	chdir $ldir;
	chdir $ddir;

	@files = $ftp->ls();
#	@files = ();
#	foreach $f ($ftp->dir()) {
#		next if (substr($f, 0 , 1) eq "d");
#		push(@files, (split(/\s+/, $f, 9))[8]);
#	}

	foreach $file (@files) {
		$mdtm = $ftp->mdtm($file);
		$age = $mytime - $mdtm;
##		print "Fil: $file mdtm=$mdtm age=$age\n";
#		if ($file !~ /$extensions/i) {
##			print "Skipping due to unknown file extension.\n";
#			next;
#		}
		if ($age >= $minage) {
			# Last ned og slett fil
			if ($ftp->binary && $ftp->get($file)) { 
				print "Binary OK, lastet ned $file.\n";
				$siz = (stat("$file"))[7];
				if ( -e $file && $siz >= 0) {
					print "Fil $file eksisterer, $siz bytes. Bra. Sletter fra remote (FTP).\n";
					$ftp->delete($file);
#					if (copy($file, "$adir/$file")) {
#						print "Kopierte $file til $adir OK.\n";
#					} else {
#						print "Fikk ikke kopiert $file til $adir.\n";
#					}
				} else {
					print "Fil $file eksisterer ikke/er tom. Kan ikke slette.\n";
				}
			} else {
				print "Fikk ikke lastet ned fil $file. Hmm, vi får prøve senere?\n";
			}
		}
	}
}

dldir("NITF","/home/mno/import/ntb/data/ntb");
#,"/home/mno/import/ntb/arkiv");

$ftp->quit;
