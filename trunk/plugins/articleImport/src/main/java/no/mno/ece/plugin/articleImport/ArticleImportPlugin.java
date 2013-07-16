package no.mno.ece.plugin.articleImport;

import com.escenic.studio.StudioContext;
import com.escenic.studio.plugins.StudioPlugin;
import com.escenic.studio.plugins.spi.StudioPluginSpi;

import javax.swing.*;
import java.net.URL;

/**
 * The ArticleImportPlugin enables the user to import a given article from another publication.
 * This class is the entry point of the plugin.
 */
public class ArticleImportPlugin extends StudioPlugin {

    protected ArticleImportPlugin(final StudioPluginSpi provider, final StudioContext context) {
        super(provider, context);
    }

    /**
     * This method creates an action and adds it to the edit menu
     */
    public void initialize() {
        Icon icon = createImageIcon("/icon.png");
        Action action = new ArticleImportAction("Article Import", icon, getContext());
        getDeclaredActions().addAction(action);
    }

    private ImageIcon createImageIcon(String path) {
        URL imgUrl = getClass().getResource(path);
        if(imgUrl != null) {
            return new ImageIcon(imgUrl);
        } else {
            return null;
        }
    }
}
