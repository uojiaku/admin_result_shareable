import Nat "mo:base/Nat";

actor {

    let xArray : [Nat] = [1, 2, 3, 4, 5];
    // xArray[2] := 0;                   // get error because vars arent immutable
    let yArray : [var Nat] = [var 1, 2, 3, 4, 5];  // contains immutable vars
    yArray[2] := 0;                 // we can do this because it is an immutable array of vars

    public shared query func getArrayX() : async [Nat] {
        return xArray;
    };

 // shared function is a public function; a public function is a shared function
 // it is not necessary to add shared to a public function
 // always use shareable types in shareable functions

    public shared query func getArrayY() : async [var Nat] {   // error because non shareable type is used in a shareable function
        return yArray;
    };
}