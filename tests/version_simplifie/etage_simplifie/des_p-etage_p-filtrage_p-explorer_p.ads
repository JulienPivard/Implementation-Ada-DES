with Des_P.Filtre_P.Entree_P;
with Des_P.Filtre_P.Corps_P;
with Des_P.Filtre_P.Sortie_P;
with Des_P.Filtre_P;

package Des_P.Etage_P.Filtrage_P.Explorer_P is

   type Instance_Filtre_T is (Entree, Corps, Sortie);

   function Lire_Etage_Suivant
      (Etage : Etage_T)
      return Etage_T;

   function Lire_Filtre
      (Etage : Etage_T)
      return Des_P.Filtre_P.Filtre_Interface_T'Class;

   function Connaitre_Type_Filtre
      (F : Des_P.Filtre_P.Entree_P.Entree_Abstrait_T'Class)
      return Instance_Filtre_T;

   function Connaitre_Type_Filtre
      (F : Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class)
      return Instance_Filtre_T;

   function Connaitre_Type_Filtre
      (F : Des_P.Filtre_P.Sortie_P.Sortie_Abstrait_T'Class)
      return Instance_Filtre_T;

end Des_P.Etage_P.Filtrage_P.Explorer_P;
