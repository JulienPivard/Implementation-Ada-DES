package body Des_P.Etage_P.Filtrage_P.Explorer_P is

   ---------------------------------------------------------------------------
   function Lire_Etage_Suivant (Etage : Etage_T) return Etage_T is
   begin
      return Etage_T (Etage.Successeur.Element);
   end Lire_Etage_Suivant;

   ---------------------------------------------------------------------------
   function Lire_Filtre (Etage : Etage_T)
      return Des_P.Filtre_P.Filtre_Interface_T'Class
   is
   begin
      return Etage.Filtre.Element;
   end Lire_Filtre;

end Des_P.Etage_P.Filtrage_P.Explorer_P;
