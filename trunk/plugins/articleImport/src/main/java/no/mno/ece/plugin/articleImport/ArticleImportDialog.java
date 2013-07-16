package no.mno.ece.plugin.articleImport;

import com.escenic.studio.StudioContext;
import org.apache.log4j.Logger;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

/**
 * This class represents the dialog box which is presented to the user when selecting
 * the Article Import menu item. It is responsible for creating the task which does
 * the actual import and saving.
 */
public class ArticleImportDialog extends JDialog {

    private final Logger logger = Logger.getLogger(getClass());

    private StudioContext studioContext;
    private Properties properties = new Properties();

    private JTextField queryField;
    private JComboBox publicationBox;
    private Container cp;

    private Map<String, String> publicationMap;

    private ArticleImportTask searchTask;

    public ArticleImportDialog(final StudioContext studioContext) {
        this.studioContext = studioContext;

        loadProperties();
        populatePublicationMap();

        cp = getContentPane();
        cp.setLayout(new FlowLayout());

        cp.add(new JLabel("Velg publikasjon"));

        String[] publicationNames = publicationMap.keySet().toArray(new String[0]);
        publicationBox = new JComboBox(publicationNames);
        publicationBox.setSelectedIndex(0);
        cp.add(publicationBox);

        cp.add(new JLabel("Artikkel-id"));

        queryField = new JTextField();
        queryField.setColumns(4);
        cp.add(queryField);

        JButton search = new JButton("Importer");
        search.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                String publicationName = (String) publicationBox.getSelectedItem();
                String publicationShortName = publicationMap.get(publicationName);
                String queryText = queryField.getText();

                searchTask = new ArticleImportTask(properties, publicationShortName, queryText);

                studioContext.execute(searchTask);
                dispose();
            }
        });
        cp.add(search);
        setSize(150, 150);
    }

    private void loadProperties() {
        String fileName = "articleImport.properties";
        InputStream in = getClass().getClassLoader().getResourceAsStream(fileName);
        try {
            properties.load(in);
        } catch (IOException e) {
            logger.error("Exception occurred when trying to load properties file " + fileName, e);
            throw new RuntimeException("Plugin Article Import feilet ved forsøk på innlasting av properties-fil.");
        }
    }

    private void populatePublicationMap() {
        Enumeration<Object> propertyKeys = properties.keys();
        publicationMap = new TreeMap<String, String>();

        while(propertyKeys.hasMoreElements()) {
            String key = (String) propertyKeys.nextElement();
            if(key.startsWith("publication")) {
                String[] splitKey = key.split("\\.");
                String shortName = "<feil>";
                if(splitKey.length > 1) {
                    shortName = splitKey[1];
                }
                String name = (String)properties.get(key);
                publicationMap.put(name, shortName);
            }
        }
    }

}
