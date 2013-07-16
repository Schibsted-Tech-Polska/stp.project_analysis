package no.medianorge.utils;

import javax.servlet.http.HttpServletRequest;
import java.util.Stack;

/**
 * Utilities for processing against stack items.
 *
 * Date: 29.02.12
 * Time: 07.50
 * $URL: $
 *
 * @author $Author: regearne$ (created by)
 * @version $Revision: $ $Date: $
 */
public class StackUtils {

    /**
     * Peek into the stack
     *
     * @param request the stack items are added to.
     * @param stackName name of the stack item
     * @return the object peeked from the stack.
     */
    public static Object peekStack(HttpServletRequest request, String stackName){
        Stack st = (Stack) request.getAttribute(stackName);
        if (st != null) {
            if(st.size()> 0){
                return st.peek();
            }
        }
        return null;
    }

    /**
     * Adding an item to the stack
     *
     * @param request the httpServletrequest
     * @param stackName name of the stack object
     * @param value to put onto the stack
     */
    public static void addStack(HttpServletRequest request, String stackName, Object value){
        Stack st = (Stack) request.getAttribute(stackName);
        if (st == null) {
            st = new Stack();
            request.setAttribute(stackName, st);
        }
        st.push(value);
    }

    /**
     * Pop an item of the stack
     *
     * @param request the httpServletRequest where the stack resides.
     * @param stackName name of the stack
     * @return an object poped of the stack
     */
    public static Object popStack(HttpServletRequest request, String stackName){
        Stack st = (Stack) request.getAttribute(stackName);
        if (st != null) {
            if(st.size() > 0) {
                return st.pop();
            }
        }
        return null;
    }

    public static void popStackSilent(HttpServletRequest request, String stackName){
        Stack st = (Stack) request.getAttribute(stackName);
        if (st != null) {
            if(st.size() > 0) {
                st.pop();
            }
        }
    }
}
