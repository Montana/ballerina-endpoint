import ballerina/io;

type Relation "<"|"="|"<>";
type Proposition [Relation, Type, Type];

public function main() {
    Proposition p = tupleConstruction(intersection(unionReflexive(tupleConstruction(intDistinct()))));
    io:println(p.toJsonString());
}

function intIdentity() returns Proposition {
    SingleInt i = ["int", 1];
    return ["=", i, i];
}

function intType() returns Proposition {
    SingleInt i = ["int", 2];
    return ["<", i, Int];
}

function intDistinct() returns Proposition {
    SingleInt left = ["int", 3];
    SingleInt right = ["int", 4];
    return ["<>", left, right];
}

function tupleConstruction(Proposition p) returns Proposition {
    Tuple left = ["tuple", p[1]];
    Tuple right = ["tuple", p[2]];
    return [p[0], left, right];
}

function unionReflexive(Proposition p) returns Proposition {
    Union u = ["|", p[1], p[2]];
    return ["<", p[1], u ];
}

function intersection(Proposition p) returns Proposition {
    match p[0] {
        "<" => {
           
            Intersection t = ["&", p[1], p[2]];
            return ["=", t, p[1]];
        }
        "=" => {
            Intersection t = ["&", p[1], p[2]];
            return ["=", t, p[2]];
        }
        "<>" => {
            Intersection t = ["&", p[1], p[2]];
            return ["=", Never, t];
        }
    }
    panic error("unreachable");
}
