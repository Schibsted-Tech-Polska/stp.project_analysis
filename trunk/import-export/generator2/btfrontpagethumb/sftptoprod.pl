#!/usr/bin/perl
use LWP::Simple;
use Net::SFTP::Foreign;
use Encode; # use this to encode into utf-8
################################################
my $SFTPUSER = 'mno';
my $SFTPHOST = '192.168.120.127';
my $SFTPDIR  = '/data/external/btfrontthumb';
my $ERRORFILE = 'feilfil.xml';
my $IMPORTDIR = '/home/mno/btfrontpagethumb/data';
################################################

my $TID = localtime(time);
my $error = 0;

if($error == 0) {
    $sftp = Net::SFTP::Foreign->new("$SFTPUSER\@$SFTPHOST", timeout => 15);
    if (!$sftp->error) {

        if (!$sftp->put("$IMPORTDIR/small_bt.png","$SFTPDIR/small_bt.png")) {
            print "Upload small_bt.png to site $SFTPHOST failed. Will try again.\n";
            print "ERROR: " . $sftp->error . "\n";
        }

        if (!$sftp->put("$IMPORTDIR/large_bt.png","$SFTPDIR/large_bt.png")) {
            print "Upload small_bt.png to site $SFTPHOST failed. Will try again.\n";
            print "ERROR: " . $sftp->error . "\n";
        }

        if (!$sftp->put("$IMPORTDIR/full_bt.png","$SFTPDIR/full_bt.png")) {
            print "Upload small_bt.png to site $SFTPHOST failed. Will try again.\n";
            print "ERROR: " . $sftp->error . "\n";
        }

        undef $sftp;
    }

}
