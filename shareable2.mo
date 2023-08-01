
actor {
    var x : Nat = 0;
    let y : Nat = 0;

    public func showX() : async Nat {  // this works, although x is var, were calling the value of x at the moment we return the function
                                        // were not allowing anyone modifying this function to modify it
        return x;
    };
}