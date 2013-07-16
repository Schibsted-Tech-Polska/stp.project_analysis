package no.medianorge.decorator;

import com.escenic.presentation.uriresolver.RepresentationURIResolverStrategy;
import neo.xredsys.presentation.PresentationArticle;

import java.net.URI;
import java.net.URISyntaxException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Iterator;
import java.util.Map;

public class MNOURIResolverStrategy extends RepresentationURIResolverStrategy {

    private String[] mPictureHosts = null;
    private SimpleDateFormat format = new SimpleDateFormat("ddMMyyyyHHmm");

    public String[] getPictureHosts() {
        return mPictureHosts;
    }

    public void setPictureHosts(String... pPictureHosts) {
        this.mPictureHosts = pPictureHosts;
    }

    public Map<String, URI> externalURIs(PresentationArticle pArticle, String pFieldName) {
        if (mPictureHosts != null && mPictureHosts.length > 0) {
            Map<String, URI> uriMaps = super.externalURIs(new PictureURLDecorator(pArticle,mPictureHosts), pFieldName);
            Iterator<Map.Entry<String,URI>> iterator = uriMaps.entrySet().iterator();
            while(iterator.hasNext()){
                Map.Entry<String,URI> current = iterator.next();
                try{
                    current.setValue(new URI(current.getValue()+"?updated="+format.format(pArticle.getLastModifiedDateAsDate())));
                }catch(URISyntaxException ex){
                    System.out.println("could not add updated="+format.format(pArticle.getLastModifiedDateAsDate())+" to uri "+current.getValue());
                    ex.printStackTrace();
                }
            }
            return uriMaps;
        } else {
            return super.externalURIs(pArticle,pFieldName);
        }
    }
}
