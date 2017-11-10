public class Like {

    /**
     * Visual Basic's Like operator in Java.<br />
     * <br />
     * <code>?</code> matches exactly one character<br />
     * <code>*</code> matches zero or more characters<br />
     * <code>#</code> matches exactly one digit<br />
     * 
     * @author Urs Schmidt
     */
    public static boolean like(String str, String pattern) {
        final int sl = str.length();
        final int pl = pattern.length();
        for (int i = 0; i < pl; i++) {
            final char pc = pattern.charAt(i);
            if (pc != '*' && i == sl)
                return false;
            switch (pc) {
            case '?':
                /* always matches */
                break;
            case '*':
                if (i + 1 == pl)
                    return true;
                final String ps = pattern.substring(i + 1);
                for (int j = i; j < sl; j++) {
                    if (like(str.substring(j), ps))
                        return true;
                }
                return false;
            case '#':
                if (!Character.isDigit(str.charAt(i)))
                    return false;
                break;
            default:
                if (pc != str.charAt(i))
                    return false;
            }
        }
        return sl == pl;
    }

    public static void main(String[] args) {
        if (args.length < 2) {
            System.err.println("Usage: java Like str pattern");
            return;
        }

        final String str = args[0];
        final String pattern = args[1];
        final boolean retval = like(str, pattern);
        System.out.println(retval ? "true" : "false");
    }

}
