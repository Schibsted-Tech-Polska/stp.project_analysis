#!/usr/bin/perl
use LWP::Simple;
use Net::SFTP::Foreign;
use Encode; # use this to encode into utf-8
################################################
my $URL = 'http://ws.tv.startsiden.no/v2/channels?site=bt&api_key=6e1e7810-3a92-11e0-9ab7-002170ad4e59&with_events=1&entries_per_channel=7&channels=NRK1&channels=TV2NORGE&channels=TV3NORGE&channels=TVNORGE&channels=TVNORGEMAX';
my $SEARCHWORD = 'result';
my $SFTPFILE = 'bt-tvguide.xml';
################################################
my $SFTPUSER = 'mno';
my $SFTPHOST = '80.91.41.41';
my $SFTPDIR  = '/data/external/tvguide';
my $ERRORFILE = 'tvguide-feilfil.xml';
my $IMPORTDIR = '/home/mno/tvguide/bt/data-test/';
################################################
my(@content) = get($URL);
my $TID = localtime(time);
my $error = 1;
foreach my $line (@content) {
    if($line =~ /$SEARCHWORD/) {
        $error = 0;
    }
}
if($error == 1) {
    open LOGFILE, ">>/home/mno/tvguide/bt/import-test.log";
    print LOGFILE "$TID: FEIL - $URL ga feil resultat\n";
    close LOGFILE;
}
if($error == 0) {
   open FILE, '>/home/mno/tvguide/bt/data-test/' . $SFTPFILE;
   foreach my $line (@content) {
       $line = decode('utf-8', $line); # this encodes to utf-8 
	print FILE $line;
    }

    $sftp = Net::SFTP::Foreign->new("$SFTPUSER\@$SFTPHOST", timeout => 15);
    if (!$sftp->error) {
        print "Connection OK.\n";
        if (!$sftp->put("$IMPORTDIR/$SFTPFILE","$SFTPDIR/$SFTPFILE")) {
            print "Upload $SFTPFILE to site $SFTPHOST failed. Will try again.\n";
            print "ERROR: " . $sftp->error . "\n";
        }
        undef $sftp;
    }

}
