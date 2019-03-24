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

   ---------------------------------------------------------------------------
   function Connaitre_Type_Filtre
      (F : Des_P.Filtre_P.Entree_P.Entree_Abstrait_T'Class)
      return Instance_Filtre_T
   is
      pragma Unreferenced (F);
   begin
      return Entree;
   end Connaitre_Type_Filtre;

   ---------------------------------------------------------------------------
   function Connaitre_Type_Filtre
      (F : Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class)
      return Instance_Filtre_T
   is
      pragma Unreferenced (F);
   begin
      return Corps;
   end Connaitre_Type_Filtre;

   ---------------------------------------------------------------------------
   function Connaitre_Type_Filtre
      (F : Des_P.Filtre_P.Sortie_P.Sortie_Abstrait_T'Class)
      return Instance_Filtre_T
   is
      pragma Unreferenced (F);
   begin
      return Sortie;
   end Connaitre_Type_Filtre;

end Des_P.Etage_P.Filtrage_P.Explorer_P;
