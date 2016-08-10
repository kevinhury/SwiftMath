// Copyright 2016 Stuart Carnie.
// License: https://github.com/SwiftGFX/SwiftMath#license-bsd-2-clause
//

#if !NOSIMD
import simd

public struct Vector4f {
    var d: float4
}

public extension Vector4f {
    //MARK:- initializers
    
    @inline(__always)
    public init() {
        self.d = float4()
    }
    
    @inline(__always)
    public init(_ scalar: Float) {
        self.d = float4(scalar)
    }
    
    @inline(__always)
    public init(float4 scalar4: float4) {
        self.d = scalar4
    }
    
    @inline(__always)
    public init(_ x: Float, _ y: Float, _ z: Float, _ w: Float) {
        self.d = float4(x, y, z, w)
    }
    
    @inline(__always)
    public init(x: Float, y: Float, z: Float, w: Float) {
        self.d = float4(x, y, z, w)
    }
    
    //MARK:- properties
    
    /// Length (two-norm or “Euclidean norm”) of x.
    public var length: Float {
        return simd.length(d)
    }
    
    /// Length of x, squared. This is more efficient to compute than the length,
    /// so you should use it if you only need to compare lengths to each other.
    /// I.e. instead of writing:
    ///
    /// `if (length(x) < length(y)) { … }`
    ///
    /// use:
    ///
    /// `if (length_squared(x) < length_squared(y)) { … }`
    ///
    /// Doing it this way avoids one or two square roots, which is a fairly costly operation.
    public var lengthSquared: Float {
        return simd.length_squared(d)
    }
    
    //MARK:- functions
    
    public func normalized() -> Vector4f {
        return unsafeBitCast(simd.normalize(self.d), to: Vector4f.self)
    }
    
    public func dot(x: Vector4f) -> Float {
        return simd.dot(self.d, x.d)
    }
    
    /// Linear interpolation to the target vector
    ///
    /// - note:
    ///     * when factor is 0, returns self
    ///     * when factor is 1, returns `to`
    ///
    /// - parameter to:     target vector
    /// - parameter factor: factor
    ///
    /// - returns: interpolated vector
    public func interpolated(to: Vector4f, factor: Float) -> Vector4f {
        return unsafeBitCast(simd.mix(d, to.d, t: factor), to: Vector4f.self)
    }
    
    //MARK:- operators
    
    @inline(__always)
    public static prefix func -(lhs: Vector4f) -> Vector4f {
        return unsafeBitCast(-lhs.d, to: Vector4f.self)
    }
    
    @inline(__always)
    public static func *(lhs: Vector4f, rhs: Float) -> Vector4f {
        return unsafeBitCast(lhs.d * rhs, to: Vector4f.self)
    }
    
    @inline(__always)
    public static func *(lhs: Vector4f, rhs: Vector4f) -> Vector4f {
        return unsafeBitCast(lhs.d * rhs.d, to: Vector4f.self)
    }
    
    @inline(__always)
    public static func *(lhs: Matrix4x4f, rhs: Vector4f) -> Vector4f {
        return unsafeBitCast(lhs.d * rhs.d, to: Vector4f.self)
    }
    
    @inline(__always)
    public static func *(lhs: Vector4f, rhs: Matrix4x4f) -> Vector4f {
        return unsafeBitCast(lhs.d * rhs.d, to: Vector4f.self)
    }
}

#endif
