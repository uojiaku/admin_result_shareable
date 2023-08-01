import Buffer "mo:base/Buffer";
import Array "mo:base/Array";
import Principal "mo:base/Principal";
import Result "mo:base/Result";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
actor SecretActor {

  let secretsData = Buffer.Buffer<Text>(0);

  var admins : [Principal] = [Principal.fromText("3d2nx-ua5fj-rdpp6-5hbyf-gxkvf-yd2gh-ltlqf-is7w5-wkwtm-dz5rp-4ae")];

  // Returns true if the principal p is an admin and false otherwise
  private func _isAdmin(p : Principal) : Bool {
    for(admin in admins.vals()) {
      if (admin == p) {
        return true;
      };
    };
    return false;
  };

  // Part 1
  public shared ({ caller }) func addAdmin(p : Principal) : async Result.Result<(),Text> {
    if(not (_isAdmin(caller))) {
      return #err("You are not an admin");
    } else {
      admins := Array.append<Principal>(admins, [p]);
      return #ok();
    }
  };

  public query func seeAdmins() : async [Principal] {
    return admins;
  };

  public shared ({ caller }) func removeAdmin(p : Principal) : async Result.Result<(),Text> {
    if(not (_isAdmin(caller))) {
      return #err("You are not an admin");
    };
    if(not (_isAdmin(p))){
      return #err("This principal is not an admin");
    };
    admins := Array.filter<Principal>(admins, func(x: Principal) {x != p});
      return #ok();
  };

// dfx canister call secretInformations addAdmin '(principal "5ydpr-qm2aj-dehqu-3um6t-hqjds-t5liq-e26fg-7er7c-havza-jhesp-uqe")' --> adds admin and produces ok variant


  // Part 2

  public func addSecret(t : Text) : async () {
    secretsData.add(t);
  };

  public shared query ({ caller }) func seeSecret(id : Nat) : async Result.Result<Text, Text> {
    if(not (_isAdmin(caller))) {
      return #err("You are not an admin");
    };
    switch(secretsData.getOpt(id)) {
      case(null){
        return #err("No secret with this id : " # Nat.toText(id));
      };
      case(? secret) {
        return #ok(secret);
      }
    };
  };
}

// dfx canister call secretInformations addSecret '("123456")'  --> returns ()
// dfx canister call secretInformations seeSecret '(0)'  --> returns ok variant or err variant "You are not an admin"


