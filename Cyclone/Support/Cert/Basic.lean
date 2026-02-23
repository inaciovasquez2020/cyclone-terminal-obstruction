import Std

set_option autoImplicit false

open Std

namespace Cyclone.Support.Cert

/--
A certificate is a closed, checkable witness that a finite configuration
satisfies a stated property.
-/
structure Certificate where
  name        : String
  description : String
  verified    : Bool

/--
Basic validity predicate.
-/
def Certificate.valid (c : Certificate) : Prop :=
  c.verified = true

/--
Minimal bootstrap certificate.
-/
def bootstrapCertificate : Certificate :=
{
  name        := "bootstrap"
  description := "Std-safe bootstrap certificate (no legacy dependencies)"
  verified    := true
}

/--
Sanity check: the bootstrap certificate is valid.
-/
theorem bootstrapCertificate_valid :
  Certificate.valid bootstrapCertificate :=
by
  rfl

end Cyclone.Support.Cert
