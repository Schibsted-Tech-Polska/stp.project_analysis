package no.mno.ece.plugin.articleImport;

import com.escenic.studio.StudioContext;

import javax.swing.*;
import java.awt.event.ActionEvent;

/**
 * This class is responsible for creating a new dialog-box and presenting it for the user
 * when the Article import menu element is selected.
 */
public class ArticleImportAction extends AbstractAction {

    private StudioContext studioContext;

    public ArticleImportAction(String name, Icon icon, StudioContext studioContext) {
        super(name, icon);
        this.studioContext = studioContext;
    }

    /**
     * This method is called when the user selects the Article import menu element
     */
    public void actionPerformed(ActionEvent e) {
        JDialog dialog = new ArticleImportDialog(studioContext);
        dialog.setVisible(true);
    }
}
