/// @function _matrix_flatten(matrix_2d)
/// @description Converts a 2D matrix array to a 1D, 16-element array. (Internal use)
/// @param {array} matrix_2d The 2D [4][4] matrix array.
function _matrix_flatten(m2d) {
    var m1d = array_create(16);
    // Convert from [row][col] to column-major 1D array
    for (var col = 0; col < 4; col++) {
        for (var row = 0; row < 4; row++) {
            m1d[col * 4 + row] = m2d[row][col];
        }
    }
    return m1d;
}

/// @function _matrix_unflatten(matrix_1d)
/// @description Converts a 1D, 16-element matrix array to a 2D [4][4] array. (Internal use)
/// @param {array} matrix_1d The 1D matrix array.
function _matrix_unflatten(m1d) {
    var m2d = array_create(4);
    for (var row = 0; row < 4; row++) {
        m2d[row] = array_create(4);
    }
    // Convert from column-major 1D array to [row][col]
    for (var col = 0; col < 4; col++) {
        for (var row = 0; row < 4; row++) {
            m2d[row][col] = m1d[col * 4 + row];
        }
    }
    return m2d;
}

/// @function matrix_invert(source_matrix_2d)
/// @description Calculates the inverse of a 4x4 matrix array.
/// @param {array} source_matrix_2d The 2D [4][4] matrix array to invert.
function matrix_invert(m_2d) {
    // Flatten the 2D array to a 1D array for the built-in function.
    var m_1d = _matrix_flatten(m_2d);
    
    // Use the built-in function to get the inverse as a 1D array.
    var inv_1d = matrix_inverse(m_1d);
    
    // Un-flatten the result back to a 2D array.
    return _matrix_unflatten(inv_1d);
}

/// @function matrix_get_translation_x(matrix_2d)
function matrix_get_translation_x(mat) {
    // Translation is stored in the 4th column of a column-major matrix.
    // Access is mat[row][column].
    return mat[0][3];
}

/// @function matrix_get_translation_y(matrix_2d)
function matrix_get_translation_y(mat) {
    // Translation is stored in the 4th column of a column-major matrix.
    // Access is mat[row][column].
    return mat[1][3];
}

/// @function matrix_get_translation_z(matrix_2d)
function matrix_get_translation_z(mat) {
    // Translation is stored in the 4th column of a column-major matrix.
    // Access is mat[row][column].
    return mat[2][3];
}
