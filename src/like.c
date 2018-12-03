#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

/**
 *  Visual Basic's Like operator in C.
 *
 *  ? matches exactly one character
 *  * matches zero or more characters
 *  # matches exactly one digit
 *
 *  @author Urs Schmidt
 */
bool like(const char *str, const char *pattern) {
    for (size_t i = 0;; i++) {
        const char sc = str[i], pc = pattern[i];
        switch (pc) {
        case 0:
            return sc == 0;
        case '?':
            if (!sc)
                return false;
            break;
        case '*':
            if (!pattern[i + 1])
                return true;
            for (size_t j = i; str[j]; j++) {
                if (like(&str[j], &pattern[i + 1]))
                    return true;
            }
            return false;
        case '#':
            if (!sc || !('0' <= sc && sc <= '9'))
                return false;
            break;
        default:
            if (sc != pc)
                return false;
        }
    }
    /* unreachable */
}

int main(int argc, char **argv) {
    if (argc < 3) {
        fprintf(stderr, "Usage: %s str pattern\n", argv[0]);
        return EXIT_FAILURE;
    }

    const char *str = argv[1];
    const char *pattern = argv[2];
    const bool retval = like(str, pattern);
    printf("%s\n", retval ? "true" : "false");

    return EXIT_SUCCESS;
}
