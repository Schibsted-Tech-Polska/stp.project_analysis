package no.mno.ece.plugin.articleImport;

import com.escenic.studio.StudioContext;
import com.escenic.studio.plugins.StudioPlugin;
import com.escenic.studio.plugins.spi.StudioPluginSpi;

/**
 * Responsible for creating instances of the plugin
 */
public class ArticleImportPluginSpi extends StudioPluginSpi{

    public ArticleImportPluginSpi() {
        super("Article Import Plugin", "0.1", "MNO");
    }

    @Override
    public StudioPlugin createStudioPlugin(final String pid, StudioContext studioContext) {
        return new ArticleImportPlugin(this, studioContext);
    }
}
