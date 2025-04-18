// Implement generic method to get the minvalue from an array. The type has to be a subtype of Number, and implements Comparable
private static <T extends Number & Comparable<? super T>> T min(T[] values) {
    if (values == null || values.length == 0) return null;
    T min = values[0];
    for (int i = 1; i < values.length; i++) {
        if (min.compareTo(values[i]) > 0) min = values[i];
    }
    return min;
}

//use Arrays.copyof to copy arrays
