package com.nfsindustries;

import java.util.concurrent.ThreadLocalRandom;
import java.util.function.Supplier;

public abstract class Bool {
    public static final Bool TRUE = new True();
    public static final Bool FALSE = new False();
    public abstract <T> T ifTrueIfFalse(Supplier<T> fTrue, Supplier<T> fFalse);

    private static class True extends Bool {
        public <T> T ifTrueIfFalse(Supplier<T> fTrue, Supplier<T> fFalse) {
            return fTrue.get();
        }
    }

    private static class False extends Bool {
        public <T> T ifTrueIfFalse(Supplier<T> fTrue, Supplier<T> fFalse) {
            return fFalse.get();
        }
    }

    public static void main(String[] args) {
        System.out.printf("TRUE: %s\n", Bool.TRUE.ifTrueIfFalse(() -> "yes", () -> "oops"));
        System.out.printf("FALSE: %s\n", Bool.FALSE.ifTrueIfFalse(() -> "yes", () -> "oops"));

        Bool condition = ThreadLocalRandom.current().nextInt(0, 2) == 0 ? Bool.FALSE : Bool.TRUE;
        System.out.printf("%s: %s\n",
                condition.getClass().getName(),
                condition.ifTrueIfFalse(() -> "yes", () -> "oops"));

    }
}
