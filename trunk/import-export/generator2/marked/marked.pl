#!/usr/bin/perl
#MODULER
use XML::Simple;
use LWP::Simple;
use Net::SCP;
use FindBin;
$xml = new XML::Simple;
#VARIABLER
@URLS=('http://banner.finn.no/finn/gojsp/daily/misc/stavangeraften_127.jsp?template=templates/cacheableblanktemplate.jsp',
'http://media.orbville.no/cgi-bin/rg/view_data.cgi?event=view&id=1cf315bcad157c160b393f27158672a3&site=aftenbladet_no',
'http://ikm.easycruit.com/export/xml/vacancy/list.xml',
'http://www.finn.no/rest/stv_rest/adselection/job/result?selection=stv&irows=50',
'http://www.finn.no/rest/corridor_rest/job/fulltime/result?areaId=20012&JOB_CATEGORY/CATEGORY=5423&JOB_CATEGORY/CATEGORY=5422',
'http://www.finn.no/rest/corridor_rest/job/fulltime/result?areaId=20012',
'http://www.finn.no/rest/aftenbladetmotor_rest/adselection/car/used/result?selection=motor_aftenbladet&rows=100',
'http://images.bt.no/xml/eiendommer_aftenbladet.xml',
'http://www.finn.no/rest/bilkilden_rest/car/used/result/?rows=100');
@FILES=('finn.html','orbville.html','ikm.xml','jobbkarusell.xml','randstad1.xml','randstad2.xml','bilkarusell.xml','bolig.xml','bilkilden.xml');
@SEARCHWORDS=('<div id="finn">','<table','<Vacancy','<iad>','<iad>','<iad>','<iad>','<soap','<iad>');
my $NR=0;
my $TID = localtime(time);
@SCPHOSTS = ('sapub2.medianorge.no','sapub3.medianorge.no','saweb3.medianorge.no','saweb4.medianorge.no','satest2.medianorge.no');
my $SCPUSER = 'mno';
my $SCPDIR  = '/data/external/marked/';
my $HOSTNR=0;
my $SCRIPTDIR = $FindBin::Bin;
###################
#Looper requester
###################
foreach (@URLS){
    my $FILENAME = $FILES[$NR];
    my(@content) = get($URLS[$NR]);
    my $error = 1;
    foreach my $line (@content) {
        if($line =~ /$SEARCHWORDS[$NR]/) {
            $error = 0;
        }
    }
    if($error == 1) {
        open LOGFILE, ">>$SCRIPTDIR/import.log";
        print LOGFILE "$TID: FEIL - $URLS[$NR] ga feil resultat\n";
        close LOGFILE;
    }
    if($error == 0) {
        open FILE, ">", "$SCRIPTDIR/data/" . $FILENAME;
        foreach my $line (@content) {
            print FILE $line;
        }
        close FILE;
        $HOSTNR=0;
        foreach (@SCPHOSTS){
            $scp = Net::SCP->new( { "host"=>$SCPHOSTS[$HOSTNR], "user"=>$SCPUSER, timeout => 15 } );
            $scp->cwd($SCPDIR);
            $scp->put("$SCRIPTDIR/data/".$FILENAME) or die $scp->{errstr};
            $HOSTNR++;
        }$scp->quit;
    }
    $NR++;
}

