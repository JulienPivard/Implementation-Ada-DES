package body Des_P.Etage_P is

   ---------------------------------------------------------------------------
   function Construire_Etage_Sans_Successeur return Etage_T is
      Etage : Etage_T (False);
   begin
      Etage.Filtre := null;
      return Etage;
   end Construire_Etage_Sans_Successeur;

   ---------------------------------------------------------------------------
   function Construire_Etage_Avec_Successeur
      (Successeur : not null access Etage_T)
      return Etage_T
   is
      Etage : Etage_T (True);
   begin
      Etage.Filtre := null;
      Etage.Successeur := Successeur;
      return Etage;
   end Construire_Etage_Avec_Successeur;

   ---------------------------------------------------------------------------
   procedure Ajouter_Filtre
      (
         Etage : in out Etage_T;
         Filtre : not null access Des_P.Filtre_P.Filtre_Abstrait_T'Class
      )
   is
   begin
      Etage.Filtre := Filtre;
   end Ajouter_Filtre;

   ---------------------------------------------------------------------------
   procedure Filtrer
      (
         Etage : Etage_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : in out Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class
      )
   is
   begin
      if Etage.Filtre = null then
         raise Pas_De_Filtre_E;
      end if;
      Etage.Filtre.all.Filtrer (Bloc, Clef);
   end Filtrer;

   ---------------------------------------------------------------------------
   function Possede_Successeur (Etage : Etage_T) return Boolean is
   begin
      return Etage.Avec_Successeur;
   end Possede_Successeur;

   ---------------------------------------------------------------------------
   procedure Iterer
      (
         Etage : Etage_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : in out Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class
      )
   is
   begin
      Etage.Filtrer (Bloc, Clef);
      if Etage.Possede_Successeur then
         Etage.Successeur.all.Iterer (Bloc, Clef);
      end if;
   end Iterer;

end Des_P.Etage_P;
