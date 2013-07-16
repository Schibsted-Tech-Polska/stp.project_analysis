#!/usr/bin/perl

#MODULER
use XML::Simple;
use LWP::Simple;
use Net::SCP;

###################
#Parser ticket-feed
###################
$xml = new XML::Simple;
#VARIABLER
@URLS=('http://msxml.tenfore.com/index.php?username=AfAf03906&password=QUFGP7&instrument=240.20.USDNOKCOMP,240.20.SEKNOKCOMP,240.20.EURNOKCOMP,240.20.GBPNOKCOMP&fields=D6,D17','http://msxml.tenfore.com/index.php?username=AfAf03906&password=QUFGP7&instrument=175.10.OSEBX&fields=D2,D17','http://msxml.tenfore.com/index.php?username=AfAf03906&password=QUFGP7&instrument=30.10.!DJI&fields=D2,D17','http://msxml.tenfore.com/index.php?username=AfAf03906&password=QUFGP7&instrument=156.3.EB0Y&fields=D6,D35','http://msxml.tenfore.com/index.php?username=AfAf03906&password=QUFGP7&instrument=174.1.MSTATS_ALL&fields=D1902,D1903');
@FILES=('morningstar-key-features1.xml','morningstar-key-features2a.xml','morningstar-key-features2b.xml','morningstar-key-features3.xml','morningstar-wl-pre-request.xml');
my $NR=0;
my $SEARCHWORD = '<fld';
my $SEARCHWORD2 = '/>';
my $ERRORFILE = 'morningstar-feilfil.xml';
my $TID = localtime(time);
@SCPHOSTS = ('aipub.aftenposten.no','aiweb1.aftenposten.no','aiweb2.aftenposten.no','aiweb9.aftenposten.no','aiweb10.aftenposten.no');
my $SCPUSER = 'syncdat';
my $SCPDIR  = '/export/home/syncdat/six-i-q/';
my $HOSTNR=0;
my $WASHAWAY='xmlns=\"http:\/\/msxml.tenfore.com\" xmlns:xsi=\"http:\/\/www.w3.org\/2001\/XMLSchema-instance\" xsi:schemaLocation=\"http:\/\/msxml.tenfore.com TenforeXMLSchema.xsd\"';

###################
#Looper 3 requester
###################
foreach (@URLS){
    my $SIQFILE = $FILES[$NR];
    my(@content) = get($URLS[$NR]);
    my $error = 1;
    my $parsable = 1;

    foreach my $line (@content) {
        if($line =~ /$SEARCHWORD/) {
            $error = 0;
        }
    }
    if($error == 1) {
        open LOGFILE, ">>/home/mno/strategiske-tjenester/rubrikk/ap-spesifikt/okonomi/import.log";
        print LOGFILE "$TID: FEIL - $URLS[$NR] ga feil resultat\n";
        close LOGFILE;
    }
    if($error == 0) {

        #Hvis xml-elementet PcCh er tomt, så skal filen ikke legges over på webserverne/parses
        foreach my $line2 (@content) {
            if($line2 =~ /$SEARCHWORD2/) {
                $parsable = 0;
            }
        }
        if($parsable == 1) {
            open FILE, '>/home/mno/strategiske-tjenester/rubrikk/ap-spesifikt/okonomi/' . $SIQFILE;
            
            foreach my $line (@content) {
                print FILE $line;
            }
            close FILE;

            system("perl -pi -e 's/$WASHAWAY/ /g' /home/mno/strategiske-tjenester/rubrikk/ap-spesifikt/okonomi/$SIQFILE");
            ###############################
            #Looper 4 servere, pusher 1 fil
            ###############################
            $HOSTNR=0;
            if($NR<4){
              foreach (@SCPHOSTS){
                  $scp = Net::SCP->new( { "host"=>$SCPHOSTS[$HOSTNR], "user"=>$SCPUSER, timeout => 15 } );
                  $scp->cwd($SCPDIR);
                  $scp->put("/home/mno/strategiske-tjenester/rubrikk/ap-spesifikt/okonomi/".$SIQFILE) or die $scp->{errstr};
                  $HOSTNR++;
              }$scp->quit;
            }
        }
    }
    $NR++;
}

