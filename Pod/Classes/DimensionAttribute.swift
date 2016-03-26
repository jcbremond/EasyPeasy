// The MIT License (MIT) - Copyright (c) 2016 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

public class DimensionAttribute: Attribute {
    
    /**
        Establishes a relationship between the dimension attribute 
        applied to the `UIView` and the reference `UIView` passed as 
        parameter.
        
        It's also possible to link this relationship to a particular
        attribute of the `view` parameter by supplying `attribute`.
         
        - parameter view: The reference view
        - parameter attribute: The attribute of `view` we are establishing
        the relationship to
        - returns: The current `Attribute` instance
     */
    public func like(view: UIView, _ attribute: ReferenceAttribute? = nil) -> Self {
        self.referenceView = view
        self.referenceAttribute = attribute
        return self
    }
    
}

/**
    The width of the object’s alignment rectangle
 */
public class Width: DimensionAttribute { }

/**
    The height of the object’s alignment rectangle
 */
public class Height: DimensionAttribute { }

/**
    The size of the object’s rectangle
 */
public class Size: CompoundAttribute {
    
    /**
     
         - returns: the `CompoundAttribute` instance created
     */
    public override init() {
        super.init()
        self.attributes = [
            Width(),
            Height()
        ]
    }
    
    /**
     
         - parameter value: `constant` of the constraint
         - returns: the `CompoundAttribute` instance created
     */
    public override init(_ value: Double) {
        super.init()
        self.attributes = [
            Width(value),
            Height(value)
        ]
    }
    
    /**
     
         - parameter constant: `Constant` struct aggregating
         `constant`, `multiplier` and `relatedBy` properties
         - returns: the `CompoundAttribute` instance created
     */
    public override init(_ constant: Constant) {
        super.init()
        self.attributes = [
            Width(constant),
            Height(constant)
        ]
    }
    
    /**
     
     */
    public init(_ size: CGSize) {
        super.init()
        self.attributes = [
            Width(Double(size.width)),
            Height(Double(size.height))
        ]
    }
    
    /**
         Establishes a relationship between the dimension attribute
         applied to the `UIView` and the reference `UIView` passed as
         parameter.
         - parameter view: The reference view
         - returns: The current `CompoundAttribute` instance
     */
    public func like(view: UIView) -> Self {
        self.referenceView = view
        for attr in self.attributes {
            attr.referenceView = view
        }
        return self
    }
    
}
