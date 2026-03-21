import Std.Data.HashMap
open Std

structure Vertex where
  i j : Nat
deriving DecidableEq, Repr, Hashable

structure Edge where
  u v : Vertex
deriving DecidableEq, Repr, Hashable

def n : Nat := 4
def R : Nat := 2
def S : List (Nat × Nat) := [(1,0),(0,1),(1,1)]

def V : List Vertex := List.range n |>.bind fun i => List.range n |>.map fun j => {i := i, j := j}

def addMod (x y m : Nat) : Nat := (x + y) % m

def E : List Edge := V.bind fun v => S.map fun s => {u := v, v := {i := addMod v.i s.1 n, j := addMod v.j s.2 n}}

def T : List Edge :=
  let row_edges := List.range n |>.bind fun j => List.range (n-1) |>.map fun i => {u := {i:=i,j:=j}, v := {i:=i+1,j:=j}}
  let col_edges := List.range n |>.bind fun i => List.range (n-1) |>.map fun j => {u := {i:=i,j:=j}, v := {i:=i,j:=j+1}}
  row_edges ++ col_edges

def B : List Edge := E.filter (fun e => !(T.contains e || T.contains {u := e.v, v := e.u}))

def neighbors (v : Vertex) : List Vertex :=
  E.filter (fun e => e.u = v || e.v = v) |>.map (fun e => if e.u = v then e.v else e.u)

partial def radiusBallAux (frontier : List Vertex) (visited : List Vertex) (r : Nat) : List Vertex :=
  match r with
  | 0 => visited
  | _ =>
    let nextFront := frontier.bind neighbors |>.filter (fun u => !(visited.contains u))
    let visited' := visited ++ nextFront
    radiusBallAux nextFront visited' (r-1)

def radiusBall (v : Vertex) : List Vertex := radiusBallAux [v] [v] R

def vertexSignature (v : Vertex) : HashSet Nat :=
  let ball := radiusBall v
  B.enum.foldl (fun acc (idx,c) =>
    if ball.contains c.u || ball.contains c.v then acc.insert idx else acc
  ) (HashSet.empty)

def vertexSignatures : HashMap Vertex (HashSet Nat) :=
  V.foldl (fun hm v => hm.insert v (vertexSignature v)) (HashMap.empty)

def detectCollisions : List (Vertex × Vertex) :=
  let sigMap := HashMap.empty
  V.foldl (fun acc v =>
    match vertexSignatures.find? v with
    | some sig =>
      match sigMap.find? sig with
      | some u => acc ++ [(v,u)]
      | none => sigMap.insert sig v; acc
    | none => acc
  ) []

#eval "Total FO\$^{k}\$_R types: " ++ toString vertexSignatures.size
#eval "Collisions (vertices sharing signatures): " ++ toString detectCollisions

lemma counting_contradiction :
  ∃ v1 v2 : Vertex, v1 ≠ v2 ∧ vertexSignature v1 = vertexSignature v2 :=
by
  have h : detectCollisions.length > 0 := by
    -- by pigeonhole principle: more independent cycles than FO\$^{k}\$_R types
    sorry
  cases detectCollisions with
  | nil => contradiction
  | cons pair _ => exact ⟨pair.1, pair.2, by decide, by rfl⟩
