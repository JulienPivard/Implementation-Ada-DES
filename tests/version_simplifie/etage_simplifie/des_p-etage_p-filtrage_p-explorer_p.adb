package body Des_P.Etage_P.Filtrage_P.Explorer_P is

   ---------------------------------------------------------------------------
   function Lire_Etage_Suivant (Etage : Etage_T) return Etage_T is
   begin
      return Etage_T (Etage.Successeur.Element);
   end Lire_Etage_Suivant;

end Des_P.Etage_P.Filtrage_P.Explorer_P;
