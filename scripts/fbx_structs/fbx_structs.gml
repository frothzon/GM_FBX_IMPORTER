/// @description Defines the data structures for holding imported FBX data.

/// @function FBXModel(name)
/// @description The main container for all imported model data.
/// @param {string} name The name of the model.
function FBXModel(_name) constructor {
    name = _name;
    meshes = [];      // An array of FBXMesh structs
    rig = -1;         // A single FBXRig struct
    animations = [];  // An array of FBXAnimation structs

    /// @function destroy()
    /// @description Cleans up all associated data to prevent memory leaks.
    static destroy = function() {
        // Destroy vertex buffers held by meshes
        for (var i = 0; i < array_length(meshes); i++) {
            if (is_struct(meshes[i])) {
                meshes[i].destroy();
            }
        }
        
        // In the future, we'll destroy rig and animation data here too.
        show_debug_message("FBXModel '" + name + "' destroyed.");
    }
}

/// @function FBXMesh()
/// @description Holds data for a single mesh, including its vertex buffer.
function FBXMesh() constructor {
    name = "default_mesh";
    vertexBuffer = -1;
    vertexCount = 0;
    materialIndex = 0;
    raw_vertex_data = []; // Used for bounding box calculation
    processed_vertex_data = []; // This will hold the full {pos, nrm, uv} data for debugging

    static destroy = function() {
        if (vertex_buffer_exists(vertexBuffer)) {
            vertex_buffer_delete(vertexBuffer);
        }
    }
}

/// @function FBXRig()
/// @description Represents the entire skeleton of the model.
function FBXRig() constructor {
    bones = []; // An array of FBXBone structs
}

/// @function FBXBone()
/// @description Holds data for a single bone in the skeleton.
function FBXBone() constructor {
    fbx_id = -1; // The unique ID from the FBX file, used for parsing
    name = "default_bone";
    parentIndex = -1; // -1 indicates a root bone
    
    // Initialize inverseBindMatrix as a 2D identity matrix to prevent errors.
    inverseBindMatrix = [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
    ];
    
    localBindMatrix = [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
    ];
}

/// @function FBXAnimation()
/// @description Holds a single animation take.
function FBXAnimation() constructor {
    name = "default_animation";
    length = 0; // Length in seconds
    tracks = []; // An array of FBXAnimTrack structs
}

/// @function FBXAnimTrack()
/// @description Holds all the keyframe data for a single bone's animation channel.
function FBXAnimTrack() constructor {
    boneIndex = 0;
    translationKeys = []; // Array of { time, value: [x, y, z] }
    rotationKeys = [];    // Array of { time, value: [qx, qy, qz, qw] }
    scaleKeys = [];       // Array of { time, value: [x, y, z] }
}

/// @function fbx_model_create(name)
/// @description Factory function to create a new, empty FBXModel.
/// @param {string} name The name for the new model.
function fbx_model_create(_name) {
    return new FBXModel(_name);
}
