package com.escenic.framework.util;

import java.util.HashMap;

/**
 * Created by IntelliJ IDEA.
 * User: okr
 * Date: May 12, 2010
 * Time: 3:36:05 PM
 * To change this template use File | Settings | File Templates.
 */

public class WidgetMap<K, V> extends HashMap<K,V> {

  public V get(Object key) {

      if (key != null && key instanceof String) {
        key = ((String) key).toUpperCase();
      }
      return super.get(key);
  }

  public V put(K key, V value) {

    if (key != null && key instanceof String) {
      key = (K)((String) key).toUpperCase();
    }
    return super.put(key, value);
  }
}