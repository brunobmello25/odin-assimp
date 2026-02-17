package assimp

when ODIN_OS == .Windows {
	foreign import lib "assimp-vc140-mt.lib"
} else when ODIN_OS == .Linux {
	foreign import lib "system:assimp"
} else {
	#panic("Unsupported platform for assimp bindings. Currently supports: Windows, Linux")
}

@(default_calling_convention="c")
foreign lib {
	@(link_name="aiImportFile")                import_file :: proc(pFile1:cstring, pFile2: u32) -> ^aiScene ---;
	@(link_name="aiReleaseImport")             release_import :: proc(pScene: ^aiScene) ---;
	//@(link_name="aiImportFileEx")              import_fileex :: proc(pFile:cstring,pFlags: u32,pFS: ^aiFileIO) -> ^aiScene ---;
	//@(link_name="aiGetPredefinedLogStream")    get_predefined_log_stream :: proc(pStreams: aiDefaultLogStream,file:cstring) -> aiLogStream ---;
	//@(link_name="aiAttachLogStream")           attach_log_stream :: proc(stream: ^aiLogStream) ---;
	//@(link_name="aiEnableVerboseLogging")      enable_verbose_logging :: proc(d: aiBool) ---;
	//@(link_name="aiDetachLogStream")           detach_log_stream :: proc(stream: ^aiLogStream) -> aiReturn ---;
	@(link_name="aiApplyPostProcessing")       apply_post_processing :: proc(pScene: ^aiScene,pFlags: u32) -> ^aiScene ---;
	@(link_name="aiIsExtensionSupported")      is_extension_supported :: proc(szExtension:cstring) -> aiBool ---;
	@(link_name="aiGetExtensionList")          get_extension_list :: proc(szOut: ^aiString) ---;
	@(link_name="aiGetMemoryRequirements")     get_memory_requirements :: proc(pIn: ^aiScene,info: ^aiMemoryInfo) ---;
	@(link_name="aiSetImportPropertyInteger")  set_import_property_integer :: proc(szName:cstring,value: int) ---;
	@(link_name="aiSetImportPropertyFloat")    set_import_property_float :: proc(szName:cstring,value: f64) ---;
	@(link_name="aiSetImportPropertyString")   set_import_property_string :: proc(szName:cstring,st: ^aiString) ---;
	@(link_name="aiCreateQuaternionFromMatrix")create_quaternion_from_matrix :: proc(quat: ^aiQuaternion,mat: ^aiMatrix3x3) ---;
	@(link_name="aiDecomposeMatrix")           decompose_matrix :: proc(mat: ^aiMatrix4x4,scaling: ^aiVector3D,rotation: ^aiQuaternion,position: ^aiVector3D) ---;
	@(link_name="aiTransposeMatrix4")          transpose_matrix4 :: proc(mat: ^aiMatrix4x4) ---;
	@(link_name="aiTransposeMatrix3")          transpose_matrix3 :: proc(mat: ^aiMatrix3x3) ---;
	@(link_name="aiTransformVecByMatrix3")     transform_vec_by_matrix3 :: proc(vec: ^aiVector3D,mat: ^aiMatrix3x3) ---;
	@(link_name="aiTransformVecByMatrix4")     transform_vec_by_matrix4 :: proc(vec: ^aiVector3D,mat: ^aiMatrix4x4) ---;
	@(link_name="aiMultiplyMatrix4")           multiply_matrix4 :: proc(dst: ^aiMatrix4x4,src: ^aiMatrix4x4) ---;
	@(link_name="aiMultiplyMatrix3")           multiply_matrix3 :: proc(dst: ^aiMatrix3x3,src: ^aiMatrix3x3) ---;
	@(link_name="aiIdentityMatrix3")           identity_matrix3 :: proc(mat: ^aiMatrix3x3) ---;
	@(link_name="aiIdentityMatrix4")           identity_matrix4 :: proc(mat: ^aiMatrix4x4) ---;
	@(link_name="aiGetMaterialProperty")       get_material_property :: proc(pMat: ^aiMaterial,pKey:cstring,type: u32,index: u32,pPropOut: ^^aiMaterialProperty) -> aiReturn ---;
	@(link_name="aiGetMaterialFloatArray")     get_material_floatArray :: proc(pMat: ^aiMaterial,pKey:cstring,type: u32,index: u32,pOut: ^f64,pMax: ^u32) -> aiReturn ---;
	@(link_name="aiGetMaterialIntegerArray")   get_material_integerArray :: proc(pMat: ^aiMaterial,pKey:cstring,type: u32,index: u32,pOut: ^int,pMax: ^u32) -> aiReturn ---;
	@(link_name="aiGetMaterialColor")          get_material_color :: proc(pMat: ^aiMaterial,pKey:cstring,type: u32,index: u32,pOut: ^aiColor4D) -> aiReturn ---;
	@(link_name="aiGetMaterialString")         get_material_string :: proc(pMat: ^aiMaterial,pKey:cstring,type: u32,index: u32,pOut: ^aiString) -> aiReturn ---;
	@(link_name="aiGetMaterialTextureCount")   get_material_textureCount :: proc(pMat: ^aiMaterial,type: aiTextureType) -> u32 ---;
	@(link_name="aiGetMaterialTexture")        get_material_texture :: proc(mat: ^aiMaterial,type: aiTextureType,index: u32,path: ^aiString,mapping: ^aiTextureMapping,uvindex: ^u32,blend: ^f64,op: ^aiTextureOp,mapmode: ^aiTextureMapMode) -> aiReturn ---;
}

// ============================================================================
// Primitive types
// ============================================================================

aiBool :: enum int {
	FALSE = 0,
	TRUE  = 1,
}

aiString :: struct {
	length : u32,
	data   : [1024]u8,
}

aiReturn :: enum u32 {
	SUCCESS    = 0x0,
	FAILURE    = 0x1,
	OUTOFMEMORY = 0x3,
}

aiOrigin :: enum u32 {
	SET = 0x0,
	CUR = 0x1,
	END = 0x2,
}

aiDefaultLogStream :: enum {
	FILE     = 0x1,
	STDOUT   = 0x2,
	STDERR   = 0x4,
	DEBUGGER = 0x8,
}

aiMemoryInfo :: struct {
	textures   : u32,
	materials  : u32,
	meshes     : u32,
	nodes      : u32,
	animations : u32,
	cameras    : u32,
	lights     : u32,
	total      : u32,
}

// ============================================================================
// Math types
// ============================================================================

aiVector2D :: struct {
	x : f32,
	y : f32,
}

aiVector3D :: struct {
	x : f32,
	y : f32,
	z : f32,
}

aiQuaternion :: struct {
	w : f32,
	x : f32,
	y : f32,
	z : f32,
}

aiMatrix3x3 :: struct {
	a1, a2, a3 : f32,
	b1, b2, b3 : f32,
	c1, c2, c3 : f32,
}

aiMatrix4x4 :: struct {
	a1, a2, a3, a4 : f32,
	b1, b2, b3, b4 : f32,
	c1, c2, c3, c4 : f32,
	d1, d2, d3, d4 : f32,
}

aiPlane :: struct {
	a : f32,
	b : f32,
	c : f32,
	d : f32,
}

aiRay :: struct {
	pos : aiVector3D,
	dir : aiVector3D,
}

aiColor3D :: struct {
	r : f32,
	g : f32,
	b : f32,
}

aiColor4D :: struct {
	r : f32,
	g : f32,
	b : f32,
	a : f32,
}

aiAABB :: struct {
	mMin : aiVector3D,
	mMax : aiVector3D,
}

aiUVTransform :: struct {
	mTranslation : aiVector2D,
	mScaling     : aiVector2D,
	mRotation    : f32,
}

// ============================================================================
// Mesh
// ============================================================================

AI_MAX_FACE_INDICES             :: 0x7fff
AI_MAX_BONE_WEIGHTS             :: 0x7fffffff
AI_MAX_VERTICES                 :: 0x7fffffff
AI_MAX_FACES                    :: 0x7fffffff
AI_MAX_NUMBER_OF_COLOR_SETS     :: 0x8
AI_MAX_NUMBER_OF_TEXTURECOORDS  :: 0x8

aiFace :: struct {
	mNumIndices : u32,
	mIndices    : ^u32,
}

aiVertexWeight :: struct {
	mVertexId : u32,
	mWeight   : f32,
}

// NOTE: mArmature and mNode were added in Assimp 5.x; without them mWeights
// reads as mArmature (often null) even when mNumWeights > 0.
aiBone :: struct {
	mName         : aiString,
	mNumWeights   : u32,
	mArmature     : ^aiNode,        // 5.x: owning armature node
	mNode         : ^aiNode,        // 5.x: the actual bone node
	mWeights      : ^aiVertexWeight,
	mOffsetMatrix : aiMatrix4x4,
}

aiPrimitiveType :: enum u32 {
	POINT             = 0x1,
	LINE              = 0x2,
	TRIANGLE          = 0x4,
	POLYGON           = 0x8,
	NGONEncodingFlag  = 0x10,
}

// NOTE: mName and mWeight were added in Assimp 5.x.
aiAnimMesh :: struct {
	mName          : aiString,      // 5.x
	mVertices      : ^aiVector3D,
	mNormals       : ^aiVector3D,
	mTangents      : ^aiVector3D,
	mBitangents    : ^aiVector3D,
	mColors        : [AI_MAX_NUMBER_OF_COLOR_SETS]^aiColor4D,
	mTextureCoords : [AI_MAX_NUMBER_OF_TEXTURECOORDS]^aiVector3D,
	mNumVertices   : u32,
	mWeight        : f32,           // 5.x
}

aiMorphingMethod :: enum u32 {
	UNKNOWN           = 0x0,
	VERTEX_BLEND      = 0x1,
	MORPH_NORMALIZED  = 0x2,
	MORPH_RELATIVE    = 0x3,
}

// NOTE: mAABB and mTextureCoordsNames were added in Assimp 5.x.
aiMesh :: struct {
	mPrimitiveTypes      : u32,
	mNumVertices         : u32,
	mNumFaces            : u32,
	mVertices            : ^aiVector3D,
	mNormals             : ^aiVector3D,
	mTangents            : ^aiVector3D,
	mBitangents          : ^aiVector3D,
	mColors              : [AI_MAX_NUMBER_OF_COLOR_SETS]^aiColor4D,
	mTextureCoords       : [AI_MAX_NUMBER_OF_TEXTURECOORDS]^aiVector3D,
	mNumUVComponents     : [AI_MAX_NUMBER_OF_TEXTURECOORDS]u32,
	mFaces               : ^aiFace,
	mNumBones            : u32,
	mBones               : ^^aiBone,
	mMaterialIndex       : u32,
	mName                : aiString,
	mNumAnimMeshes       : u32,
	mAnimMeshes          : ^^aiAnimMesh,
	mMethod              : aiMorphingMethod,
	mAABB                : aiAABB,          // 5.x
	mTextureCoordsNames  : ^^aiString,      // 5.x
}

// ============================================================================
// Scene graph
// ============================================================================

// Opaque; use only as a pointer.
aiMetadata :: struct {}

aiNode :: struct {
	mName           : aiString,
	mTransformation : aiMatrix4x4,
	mParent         : ^aiNode,
	mNumChildren    : u32,
	mChildren       : ^^aiNode,
	mNumMeshes      : u32,
	mMeshes         : ^u32,
	mMetaData       : ^aiMetadata, // 5.x
}

// ============================================================================
// Animation
// ============================================================================

aiVectorKey :: struct {
	mTime  : f64,
	mValue : aiVector3D,
}

aiQuatKey :: struct {
	mTime  : f64,
	mValue : aiQuaternion,
}

aiMeshKey :: struct {
	mTime  : f64,
	mValue : u32, // index into aiMesh.mAnimMeshes
}

aiMeshMorphKey :: struct {
	mTime                : f64,
	mValues              : ^u32,
	mWeights             : ^f64,
	mNumValuesAndWeights : u32,
}

aiAnimBehaviour :: enum u32 {
	DEFAULT  = 0x0,
	CONSTANT = 0x1,
	LINEAR   = 0x2,
	REPEAT   = 0x3,
}

aiNodeAnim :: struct {
	mNodeName         : aiString,
	mNumPositionKeys  : u32,
	mPositionKeys     : ^aiVectorKey,
	mNumRotationKeys  : u32,
	mRotationKeys     : ^aiQuatKey,
	mNumScalingKeys   : u32,
	mScalingKeys      : ^aiVectorKey,
	mPreState         : aiAnimBehaviour,
	mPostState        : aiAnimBehaviour,
}

aiMeshAnim :: struct {
	mName    : aiString,
	mNumKeys : u32,
	mKeys    : ^aiMeshKey,
}

aiMeshMorphAnim :: struct {
	mName    : aiString,
	mNumKeys : u32,
	mKeys    : ^aiMeshMorphKey,
}

// NOTE: mesh and morph-mesh channels were added in Assimp 5.x.
aiAnimation :: struct {
	mName                   : aiString,
	mDuration               : f64,
	mTicksPerSecond         : f64,
	mNumChannels            : u32,
	mChannels               : ^^aiNodeAnim,
	mNumMeshChannels        : u32,         // 5.x
	mMeshChannels           : ^^aiMeshAnim, // 5.x
	mNumMorphMeshChannels   : u32,         // 5.x
	mMorphMeshChannels      : ^^aiMeshMorphAnim, // 5.x
}

// ============================================================================
// Textures
// ============================================================================

// Packed BGRA8888 pixel (note: B,G,R,A byte order in memory).
aiTexel :: struct {
	b : byte,
	g : byte,
	r : byte,
	a : byte,
}

// NOTE: achFormatHint is 9 bytes (HINTMAXTEXTURELEN), not 4. mFilename added in 5.x.
aiTexture :: struct {
	mWidth        : u32,
	mHeight       : u32,
	achFormatHint : [9]u8,  // e.g. "rgba8888\0" or "jpg\0"; 0 height = compressed
	pcData        : ^aiTexel,
	mFilename     : aiString, // 5.x
}

// ============================================================================
// Materials
// ============================================================================

aiTextureOp :: enum u32 {
	Multiply  = 0x0,
	Add       = 0x1,
	Subtract  = 0x2,
	Divide    = 0x3,
	SmoothAdd = 0x4,
	SignedAdd = 0x5,
}

aiTextureMapMode :: enum u32 {
	Wrap   = 0x0,
	Clamp  = 0x1,
	Decal  = 0x3,
	Mirror = 0x2,
}

aiTextureMapping :: enum u32 {
	UV       = 0x0,
	SPHERE   = 0x1,
	CYLINDER = 0x2,
	BOX      = 0x3,
	PLANE    = 0x4,
	OTHER    = 0x5,
}

// NOTE: PBR types (BASE_COLOR=12 through TRANSMISSION=21) and corrected
// UNKNOWN=18 were added in Assimp 5.x. The old binding had UNKNOWN=12.
aiTextureType :: enum u32 {
	NONE              = 0,
	DIFFUSE           = 1,
	SPECULAR          = 2,
	AMBIENT           = 3,
	EMISSIVE          = 4,
	HEIGHT            = 5,
	NORMALS           = 6,
	SHININESS         = 7,
	OPACITY           = 8,
	DISPLACEMENT      = 9,
	LIGHTMAP          = 10,
	REFLECTION        = 11,
	BASE_COLOR        = 12, // 5.x PBR
	NORMAL_CAMERA     = 13, // 5.x PBR
	EMISSION_COLOR    = 14, // 5.x PBR
	METALNESS         = 15, // 5.x PBR
	DIFFUSE_ROUGHNESS = 16, // 5.x PBR
	AMBIENT_OCCLUSION = 17, // 5.x PBR
	UNKNOWN           = 18, // was 12 in old bindings
	SHEEN             = 19, // 5.x
	CLEARCOAT         = 20, // 5.x
	TRANSMISSION      = 21, // 5.x
}

aiShadingMode :: enum u32 {
	Flat         = 0x1,
	Gouraud      = 0x2,
	Phong        = 0x3,
	Blinn        = 0x4,
	Toon         = 0x5,
	OrenNayar    = 0x6,
	Minnaert     = 0x7,
	CookTorrance = 0x8,
	NoShading    = 0x9,
	Fresnel      = 0xa,
}

aiTextureFlags :: enum u32 {
	Invert      = 0x1,
	UseAlpha    = 0x2,
	IgnoreAlpha = 0x4,
}

aiBlendMode :: enum {
	Default  = 0x0,
	Additive = 0x1,
}

// NOTE: Double = 0x2 was missing from old bindings.
aiPropertyTypeInfo :: enum u32 {
	Float   = 0x1,
	Double  = 0x2, // 5.x
	String  = 0x3,
	Integer = 0x4,
	Buffer  = 0x5,
}

aiMaterialProperty :: struct {
	mKey        : aiString,
	mSemantic   : u32,
	mIndex      : u32,
	mDataLength : u32,
	mType       : aiPropertyTypeInfo,
	mData       : cstring,
}

aiMaterial :: struct {
	mProperties    : ^^aiMaterialProperty,
	mNumProperties : u32,
	mNumAllocated  : u32,
}

// ============================================================================
// Lights
// ============================================================================

// NOTE: AMBIENT=0x4 and AREA=0x5 were added in Assimp 5.x.
aiLightSourceType :: enum u32 {
	UNDEFINED   = 0x0,
	DIRECTIONAL = 0x1,
	POINT       = 0x2,
	SPOT        = 0x3,
	AMBIENT     = 0x4, // 5.x
	AREA        = 0x5, // 5.x
}

// NOTE: mUp (between mDirection and mAttenuationConstant) and mSize (at end)
// were added in Assimp 5.x. Without mUp, every field from mAttenuationConstant
// onward reads from the wrong offset.
aiLight :: struct {
	mName                 : aiString,
	mType                 : aiLightSourceType,
	mPosition             : aiVector3D,
	mDirection            : aiVector3D,
	mUp                   : aiVector3D,  // 5.x
	mAttenuationConstant  : f32,
	mAttenuationLinear    : f32,
	mAttenuationQuadratic : f32,
	mColorDiffuse         : aiColor3D,
	mColorSpecular        : aiColor3D,
	mColorAmbient         : aiColor3D,
	mAngleInnerCone       : f32,
	mAngleOuterCone       : f32,
	mSize                 : aiVector2D,  // 5.x (area light dimensions)
}

// ============================================================================
// Cameras
// ============================================================================

// NOTE: mOrthographicWidth was added in Assimp 5.x.
aiCamera :: struct {
	mName               : aiString,
	mPosition           : aiVector3D,
	mUp                 : aiVector3D,
	mLookAt             : aiVector3D,
	mHorizontalFOV      : f32,
	mClipPlaneNear      : f32,
	mClipPlaneFar       : f32,
	mAspect             : f32,
	mOrthographicWidth  : f32, // 5.x
}

// ============================================================================
// Scene
// ============================================================================

// Opaque; use only as a pointer.
aiSkeleton :: struct {}

// NOTE: mMetaData, mName, mNumSkeletons, mSkeletons were added in Assimp 5.x.
aiScene :: struct {
	mFlags         : u32,
	mRootNode      : ^aiNode,
	mNumMeshes     : u32,
	mMeshes        : ^^aiMesh,
	mNumMaterials  : u32,
	mMaterials     : ^^aiMaterial,
	mNumAnimations : u32,
	mAnimations    : ^^aiAnimation,
	mNumTextures   : u32,
	mTextures      : ^^aiTexture,
	mNumLights     : u32,
	mLights        : ^^aiLight,
	mNumCameras    : u32,
	mCameras       : ^^aiCamera,
	mMetaData      : ^aiMetadata,  // 5.x
	mName          : aiString,     // 5.x
	mNumSkeletons  : u32,          // 5.x
	mSkeletons     : ^^aiSkeleton, // 5.x
}

// ============================================================================
// Post-processing flags
// ============================================================================

aiSceneFlags :: enum u32 {
	INCOMPLETE         = 0x1,
	VALIDATED          = 0x2,
	VALIDATION_WARNING = 0x4,
	NON_VERBOSE_FORMAT = 0x8,
	FLAGS_TERRAIN      = 0x10,
}

aiPostProcessSteps :: enum u32 {
	CalcTangentSpace         = 0x1,
	JoinIdenticalVertices    = 0x2,
	MakeLeftHanded           = 0x4,
	Triangulate              = 0x8,
	RemoveComponent          = 0x10,
	GenNormals               = 0x20,
	GenSmoothNormals         = 0x40,
	SplitLargeMeshes         = 0x80,
	PreTransformVertices     = 0x100,
	LimitBoneWeights         = 0x200,
	ValidateDataStructure    = 0x400,
	ImproveCacheLocality     = 0x800,
	RemoveRedundantMaterials = 0x1000,
	FixInfacingNormals       = 0x2000,
	SortByPType              = 0x8000,
	FindDegenerates          = 0x10000,
	FindInvalidData          = 0x20000,
	GenUVCoords              = 0x40000,
	TransformUVCoords        = 0x80000,
	FindInstances            = 0x100000,
	OptimizeMeshes           = 0x200000,
	OptimizeGraph            = 0x400000,
	FlipUVs                  = 0x800000,
	FlipWindingOrder         = 0x1000000,
}
